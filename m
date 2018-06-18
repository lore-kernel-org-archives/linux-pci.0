Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 18 Jun 2018 06:49:10 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 23/26] devicetree: fix a series of wrong file references
Message-ID: <20180618054910.GB31141@dell>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
 <266e5f874b36aa83f3327879d85921fab52d5461.1529079120.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
In-Reply-To: <266e5f874b36aa83f3327879d85921fab52d5461.1529079120.git.mchehab+samsung@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, linux-pci@vger.kernel.org,
 Binghui Wang <wangbinghui@hisilicon.com>, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Chen-Yu Tsai <wens@csie.org>,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Xiaowei Song <songxiaowei@hisilicon.com>,
 Mauro Carvalho Chehab <mchehab@infradead.org>, Mark Brown <broonie@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Zhou Wang <wangzhou1@hisilicon.com>,
 Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

T24gRnJpLCAxNSBKdW4gMjAxOCwgTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIHdyb3RlOgoKPiBBcyBm
aWxlcyBnb3QgcmVuYW1lZCwgdGhlaXIgcmVmZXJlbmNlcyBicm9rZS4KPiAKPiBNYW51YWxseSBm
aXggYSBzZXJpZXMgb2YgYnJva2VuIHJlZnMgYXQgdGhlIERUIGJpbmRpbmdzLgo+IAo+IFNpZ25l
ZC1vZmYtYnk6IE1hdXJvIENhcnZhbGhvIENoZWhhYiA8bWNoZWhhYitzYW1zdW5nQGtlcm5lbC5v
cmc+Cj4gLS0tCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0L3JtaTQvcm1pXzJkX3Nl
bnNvci50eHQgfCAgMiArLQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZk
L3N1bjZpLXByY20udHh0IHwgIDIgKy0KCkFja2VkLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0Bs
aW5hcm8ub3JnPgoKPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2hpc2lsaWNvbi1wY2ll
LnR4dCAgICAgICB8ICAyICstCj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
Y2kva2lyaW4tcGNpZS50eHQgfCAgMiArLQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kv
cGNpLWtleXN0b25lLnR4dCAgICAgICAgIHwgIDQgKystLQo+ICAuLi4vZGV2aWNldHJlZS9iaW5k
aW5ncy9zb3VuZC9zdCxzdG0zMi1pMnMudHh0ICAgICAgIHwgIDIgKy0KPiAgLi4uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc291bmQvc3Qsc3RtMzItc2FpLnR4dCAgICAgICB8ICAyICstCj4gIE1BSU5U
QUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMiArKysr
KystLS0tLS0KPiAgOCBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlv
bnMoLSkKCi0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KTGluYXJvIFNlcnZpY2VzIFRlY2huaWNh
bCBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwpG
b2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
