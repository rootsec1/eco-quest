import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

const htmlData = r"""
<div>
  <script>
    _recollect_config = {
      area: "DurhamNC",
      name: "calendar",
      tab: 1,
      page: "tabbed_widget",
    };
  </script>
  <script src="https://recollect.net/api/widget.js?" charset="UTF-8"></script>
  <div
    id="rCw"
    class="rCw"
    style="width: 100%"
    lang="en-US"
    data-widget-layout="pills"
  >
    <div class="widget-box">
      <div class="widget-header">
        <div class="widget-toolbar-buttons">
          <div class="widget-toolbar">
            <button
              class="rClocale btn btn-xs btn-link dropdown-toggle"
              id="locale-menubutton"
              aria-haspopup="true"
              aria-controls="menu1"
              aria-expanded="false"
              data-toggle="dropdown"
            >
              <span class="ri ri-l10n ri-white"></span>
              English
              <span class="ri ri-caret-down ri-white"></span>
            </button>
            <div
              class="dropdown-menu-right dropdown-menu dropdown-caret dropdown-close"
            >
              <div class="dropdown-wrapper" style="margin-left: 10px">
                <h5 style="color: #333333">Language selection</h5>
                <ul
                  class="list-unstyled"
                  id="menu1"
                  role="menu"
                  aria-labelledby="locale-menubutton"
                >
                  <li role="none">
                    <a
                      role="menuitem"
                      href="#"
                      data-ga-event-cat="locale"
                      data-ga-event="en-US"
                      data-locale="en-US"
                    >
                      <span lang="en-US">English</span>
                    </a>
                  </li>

                  <li role="none">
                    <a
                      role="menuitem"
                      href="#"
                      data-ga-event-cat="locale"
                      data-ga-event="es"
                      data-locale="es"
                    >
                      <span lang="es">Español</span>
                    </a>
                  </li>

                  <li role="none">
                    <a
                      role="menuitem"
                      href="#"
                      data-ga-event-cat="locale"
                      data-ga-event="ko"
                      data-locale="ko"
                    >
                      <span lang="ko">한국어</span>
                    </a>
                  </li>

                  <li role="none">
                    <a
                      role="menuitem"
                      href="#"
                      data-ga-event-cat="locale"
                      data-ga-event="zh-Hans"
                      data-locale="zh-Hans"
                    >
                      <span lang="zh-Hans">简体中文</span>
                    </a>
                  </li>

                  <li role="none">
                    <a
                      role="menuitem"
                      href="#"
                      data-ga-event-cat="locale"
                      data-ga-event="ja"
                      data-locale="ja"
                    >
                      <span lang="ja">日本語</span>

                      <img
                        alt="Translate"
                        class="pull-right"
                        style="width: 20px; height: 20px"
                        src="https://recollect-images.global.ssl.fastly.net/api/image/widget.google_translate.svg"
                      />
                    </a>
                  </li>

                  <li role="none">
                    <a
                      role="menuitem"
                      href="#"
                      data-ga-event-cat="locale"
                      data-ga-event="fr"
                      data-locale="fr"
                    >
                      <span lang="fr">Français</span>
                    </a>
                  </li>

                  <li role="none">
                    <a
                      role="menuitem"
                      href="#"
                      data-ga-event-cat="locale"
                      data-ga-event="de"
                      data-locale="de"
                    >
                      <span lang="de">Deutsch</span>

                      <img
                        alt="Translate"
                        class="pull-right"
                        style="width: 20px; height: 20px"
                        src="https://recollect-images.global.ssl.fastly.net/api/image/widget.google_translate.svg"
                      />
                    </a>
                  </li>

                  <li role="none">
                    <a
                      role="menuitem"
                      href="#"
                      data-ga-event-cat="locale"
                      data-ga-event="ru"
                      data-locale="ru"
                    >
                      <span lang="ru">русский</span>

                      <img
                        alt="Translate"
                        class="pull-right"
                        style="width: 20px; height: 20px"
                        src="https://recollect-images.global.ssl.fastly.net/api/image/widget.google_translate.svg"
                      />
                    </a>
                  </li>
                </ul>
              </div>
            </div>
          </div>

          <div
            id="recollect-social"
            class="widget-toolbar"
            style="display: block"
          >
            <button
              class="rCsocial btn btn-xs btn-link dropdown-toggle"
              id="social-menubutton"
              aria-haspopup="true"
              aria-controls="menu1"
              aria-label="Share"
              data-toggle="dropdown"
            >
              <span class="ri ri-share ri-white"></span>
              Share
              <span class="ri ri-caret-down ri-white"></span>
            </button>
            <ul
              class="dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close"
              id="menu1"
              role="menu"
              aria-labelledby="social-menubutton"
            >
              <li role="none">
                <a
                  role="menuitem"
                  href="#"
                  data-page="wizard_search"
                  data-share="wizard"
                >
                  This Tool
                </a>
              </li>
            </ul>
          </div>
        </div>
        <h2 id="rCw-title" class="widget-title smaller">Waste Wizard</h2>
      </div>

      <div class="widget-body">
        <div role="navigation">
          <ul
            style="display: none"
            class="widget-nav nav nav-pills nav-justified"
          >
            <div
              class="nav-scroll-btn"
              id="widget-scroll-right"
              style="display: none; margin-left: 728px"
            >
              <i
                ><img
                  src="https://recollect-images.global.ssl.fastly.net/api/image/fa-chevron-right.svg"
                  alt="Right Scroll"
                  width="25"
                  height="25"
              /></i>
            </div>
            <div
              class="nav-scroll-btn"
              id="widget-scroll-left"
              style="display: none"
            >
              <i
                ><img
                  src="https://recollect-images.global.ssl.fastly.net/api/image/fa-chevron-left.svg"
                  alt="Left Scroll"
                  width="25"
                  height="25"
              /></i>
            </div>

            <li>
              <a
                data-header-title=""
                data-title="Calendar"
                class="text-center"
                href="#"
                data-tab-page="place_calendar"
              >
                <!-- WCAG 2.0: This is a supplemental icon (See Section 4.8.1.1.4) -->
                <img
                  height="35"
                  width="35"
                  alt=""
                  src="https://recollect-images.global.ssl.fastly.net/api/image/60x60/51,51,51/calendar.svg"
                />

                <div class="tab-name">Calendar</div>
              </a>
            </li>

            <li class="active" style="">
              <a
                data-header-title=""
                data-title="Waste Wizard"
                class="text-center"
                href="#"
                data-tab-page="wizard_search"
              >
                <!-- WCAG 2.0: This is a supplemental icon (See Section 4.8.1.1.4) -->
                <img
                  height="35"
                  width="35"
                  alt=""
                  src="https://recollect-images.global.ssl.fastly.net/api/image/60x60/51,51,51/waste_wizard.svg"
                />

                <div class="tab-name">Waste Wizard</div>
              </a>
            </li>

            <li>
              <a
                data-header-title="Bulky Item Collection"
                data-title="Bulky Items"
                class="text-center"
                href="#"
                data-tab-page='bic_tab_start:{"process":"Schedule_a_Bulky_Collection"}'
              >
                <!-- WCAG 2.0: This is a supplemental icon (See Section 4.8.1.1.4) -->
                <img
                  height="35"
                  width="35"
                  alt=""
                  src="https://recollect-images.global.ssl.fastly.net/api/image/60x60/0,0,0/chair.svg"
                />

                <div class="tab-name">Bulky Items</div>
              </a>
            </li>

            <li>
              <a
                data-header-title=""
                data-title="Game"
                class="text-center"
                href="#"
                data-tab-page="waste_sorting_game"
              >
                <!-- WCAG 2.0: This is a supplemental icon (See Section 4.8.1.1.4) -->
                <img
                  height="35"
                  width="35"
                  alt=""
                  src="https://recollect-images.global.ssl.fastly.net/api/image/60x60/0,0,0/game.svg"
                />

                <div class="tab-name">Game</div>
              </a>
            </li>

            <li>
              <a
                data-header-title=""
                data-title="Need help?"
                class="text-center"
                href="#"
                data-tab-page="feedback"
              >
                <!-- WCAG 2.0: This is a supplemental icon (See Section 4.8.1.1.4) -->
                <img
                  height="35"
                  width="35"
                  alt=""
                  src="https://recollect-images.global.ssl.fastly.net/api/image/60x60/51,51,51/info.svg"
                />

                <div class="tab-name">Need help?</div>
              </a>
            </li>
          </ul>
        </div>

        <style>
          #rCw #auth-controls {
            background: #fffbc2;
            border: 1px solid #dddddd;
          }
        </style>
        <div id="auth-controls" class="hidden"></div>

        <div id="place-manager" class="hidden"></div>

        <div style="" class="recollect_content recollect_form">
          <div data-page_type="widget">
            <div
              id="rCpage-wizard_search"
              class="rCpage"
              data-page_type="widget"
              data-has_img="false"
              data-widget-layout="default"
            >
              <div class="page-section no-title">
                <div class="page-section-rows">
                  <div class="page-row borderless">
                    <div class="page-row-content" data-type="search">
                      <div
                        class="alert alert-danger"
                        style="display: none"
                        role="alert"
                        aria-atomic="true"
                      ></div>
                      <label for="row-input-0"
                        >Type the name of a waste item and we'll tell you how to
                        recycle or dispose of it.</label
                      >
                      <div
                        class="rCsearch form-inline"
                        data-type="Material"
                        data-set-filter="default"
                        data-count=""
                      >
                        <div style="width: 100%" class="form-group">
                          <input
                            type="search"
                            style="font-weight: 400"
                            id="row-input-0"
                            class="form-control"
                            autocomplete="off"
                            aria-owns="row-input-0_list"
                            aria-autocomplete="both"
                            aria-activedescendant=""
                          />

                          <a id="rCbtn-search" href="#" class="btn btn-success"
                            >Search</a
                          >
                        </div>
                        <div class="clearfix"></div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div class="popularSearches page-section">
                <h3 class="page-section-title">Popular Searches</h3>

                <div class="page-section-rows">
                  <div class="page-row page-row-image-content">
                    <div class="page-row-content" data-type="page">
                      <a href="" data-page="224121" target="_top">
                        <div
                          class="circle-border-imgs"
                          style="
                            background-image: url(https://recollect-images.global.ssl.fastly.net/api/image/500/material.default.furniture.svg);
                          "
                        ></div>

                        <div class="img-caption">Furniture</div>
                      </a>
                    </div>
                  </div>

                  <div class="page-row page-row-image-content">
                    <div class="page-row-content" data-type="page">
                      <a href="" data-page="224319" target="_top">
                        <div
                          class="circle-border-imgs"
                          style="
                            background-image: url(https://recollect-images.global.ssl.fastly.net/api/image/500/material.default.clothes.svg);
                          "
                        ></div>

                        <div class="img-caption">Textiles</div>
                      </a>
                    </div>
                  </div>

                  <div class="page-row page-row-image-content">
                    <div class="page-row-content" data-type="page">
                      <a href="" data-page="224122" target="_top">
                        <div
                          class="circle-border-imgs"
                          style="
                            background-image: url(https://recollect-images.global.ssl.fastly.net/api/image/500/material.default.mattress.svg);
                          "
                        ></div>

                        <div class="img-caption">Mattress</div>
                      </a>
                    </div>
                  </div>

                  <div class="page-row page-row-image-content">
                    <div class="page-row-content" data-type="page">
                      <a href="" data-page="224159" target="_top">
                        <div
                          class="circle-border-imgs"
                          style="
                            background-image: url(https://recollect-images.global.ssl.fastly.net/api/image/500/material.default.battery_disposable.svg);
                          "
                        ></div>

                        <div class="img-caption">Battery (disposable)</div>
                      </a>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="clearfix"></div>
          </div>
        </div>
        <div class="recollect_content recollect_frame" style="display: none">
          <div class="recollect_loading" style="display: none">
            <img
              height="32"
              width="32"
              alt="Loading"
              src="https://recollect.a.ssl.fastly.net/0.11.1694112288/images/loading.gif"
              class="image-actual"
            />
          </div>
          <iframe
            name="recollect"
            title="Waste Wizard"
            id="recollect-frame"
            noresize="noresize"
            frameborder="0"
            cellspacing="0"
            marginwidth="0"
            marginheight="0"
            allowtransparency="true"
            scrolling="no"
            style="width: 100%; height: 0px !important"
            src="https://api.recollect.net/w/start?area=DurhamNC&amp;design=logan&amp;service_id=665&amp;api_host=https://api.recollect.net&amp;js_host=https://api.recollect.net&amp;css_host=undefined&amp;service=waste&amp;root_page=tabbed_widget&amp;parent_url=https%3A%2F%2Fwww.durhamnc.gov%2F862%2FRecycling&amp;locale=en-US&amp;support_mode=false&amp;name=undefined&amp;api_key=&amp;widget_config=%7B%22area%22%3A%22DurhamNC%22%2C%22name%22%3A%22calendar%22%2C%22tab%22%3A1%2C%22page%22%3A%22tabbed_widget%22%2C%22base%22%3A%22https%3A%2F%2Frecollect.net%22%2C%22third_party_cookie_enabled%22%3Anull%7D&amp;widget_layout=pills&amp;cookie=recollect-place&amp;env=prod-us&amp;version=0.11.1694112288"
          ></iframe>
        </div>
        <div class="rC-inside-footer" style="display: none">
          <span class="rC-terms pull-right">
            <a href="#" data-page="privacy">Privacy</a>
            |

            <a href="#" data-page="terms_of_service">Terms of Service</a>
            |

            <a href="#" data-page="cookie_policy">Cookie Policy</a>
          </span>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>

    <div class="rC-footer">
      <div class="rC-mat-pow">
        <div id="rC-material-list" class="rC-left-link">
          <a
            href="https://www.durhamnc.gov/862/Recycling#!rc-cpage=wizard_material_list"
            data-original-href="#!rc-cpage=wizard_material_list"
          >
            List of Materials
          </a>
        </div>

        <div class="text-right">
          <div class="rC-powered">
            Powered by
            <a
              href="https://learn.recollect.net/help/"
              target="_blank"
              rel="noopener"
              ><img
                class="recollect logo"
                src="https://recollect-images.global.ssl.fastly.net/api/image/widget.recollect_green.svg"
                alt="ReCollect"
                width="60"
                height="11"
            /></a>
          </div>
        </div>
      </div>

      <div class="clearfix"></div>

      <div class="app-button-links">
        <div>
          <span>
            <a
              target="_blank"
              href="https://api.recollect.net/app/DurhamNC/waste/android?direct=1&amp;from=widget_footer"
              rel="noopener"
              ><img
                width="120"
                height="40"
                alt="Download the Durham Rollout app for Android from the Google Play Store"
                src="https://recollect-images.global.ssl.fastly.net/api/image/240x80/widget.google-button.svg"
            /></a>
          </span>
          <span>
            <a
              target="_blank"
              href="https://api.recollect.net/app/DurhamNC/waste/ios?direct=1&amp;from=widget_footer"
              rel="noopener"
              ><img
                width="120"
                height="40"
                alt="Download the Durham Rollout app for iOS from the Apple App Store"
                src="https://recollect-images.global.ssl.fastly.net/api/image/240x80/widget.apple-button.svg"
            /></a>
          </span>
          <span>
            <img class="widget-optional-image" style="display: none" />
          </span>
          <div class="clearfix"></div>
        </div>
      </div>
    </div>
  </div>
</div>
""";

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final WebViewController webViewController = WebViewController();

  @override
  void initState() {
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController
        .loadRequest(Uri.parse("https://www.durhamnc.gov/862/Recycling"));
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: WebViewWidget(controller: webViewController),
        ),
      ),
    );
  }
}
