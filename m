Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0065.outbound.protection.outlook.com ([104.47.37.65]:64934
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752126AbcBJFz5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 10 Feb 2016 00:55:57 -0500
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Paul Burton <paul.burton@imgtec.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	Michal Simek <michals@xilinx.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"yinghai@kernel.org" <yinghai@kernel.org>,
	"wangyijing@huawei.com" <wangyijing@huawei.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"russell.joyce@york.ac.uk" <russell.joyce@york.ac.uk>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH V3 3/5] PCI: xilinx: Modifying AXI PCIe Host Bridge
 driver to work on both  Zynq and Microblaze
Date: Wed, 10 Feb 2016 05:55:51 +0000
Message-ID: <8520D5D51A55D047800579B09414719825881780@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1455014518-8708-1-git-send-email-bharatku@xilinx.com>
 <1455014518-8708-4-git-send-email-bharatku@xilinx.com>
 <20160209161134.GA24244@NP-P-BURTON>
In-Reply-To: <20160209161134.GA24244@NP-P-BURTON>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiBPbiBUdWUsIEZlYiAwOSwgMjAxNiBhdCAwNDoxMTo1NlBNICswNTMwLCBCaGFyYXQgS3VtYXIg
R29nYWRhIHdyb3RlOg0KPiA+IE1vZGlmeWluZyBYaWxpbnggQVhJIFBDSWUgSG9zdCBCcmlkZ2Ug
U29mdCBJUCBkcml2ZXIgdG8gd29yayBvbiBib3RoDQo+ID4gWnlucSBhbmQgTWljcm9ibGF6ZSBB
cmNoaXRlY3R1cmVzLg0KPiA+IFdpdGggdGhlc2UgbW9kaWZpY2F0aW9ucyBkcml2ZXJzL3BjaS9o
b3N0L3BjaWUteGlsaW54LmMsIHdpbGwgd29yayBvbg0KPiA+IGJvdGggWnlucSBhbmQgTWljcm9i
bGF6ZSBBcmNoaXRlY3R1cmVzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmhhcmF0IEt1bWFy
IEdvZ2FkYSA8YmhhcmF0a3VAeGlsaW54LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSYXZpIEtp
cmFuIEd1bW1hbHVyaSA8cmd1bW1hbEB4aWxpbnguY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXM6
DQo+ID4gUmVtb3ZlZCB1bm5lY2Nlc3NhcnkgYXJjaGl0ZWN0dXJlIGRlcGVuZGVudCBudW1iZXIg
b2YgTVNJJ3MuDQo+ID4gQWRkZWQgI2lmZGVmIHRvIHBjaV9maXh1cF9pcnFzIHdoaWNoIGlzIEFS
TSBzcGVjaWZpYyBBUEkuDQo+IA0KPiBIaSBCaGFyYXQsDQo+IA0KPiBXaHkgZG8geW91IHNheSBw
Y2lfZml4dXBfaXJxcyBpcyBBUk0tc3BlY2lmaWM/IEl0J3MgZGVjbGFyZWQgaW4NCj4gaW5jbHVk
ZS9saW51eC9wY2kuaCwgZGVmaW5lZCBpbiBkcml2ZXJzL3BjaS9zZXR1cC1pcnEuYyAmIHVzZWQg
YnkgbXVsdGlwbGUNCj4gYXJjaGl0ZWN0dXJlcyAoYWxwaGEsIGFybSwgbTY4aywgbWlwcywgc2gs
IHNwYXJjLCB0aWxlLA0KPiB1bmljb3JlMzIgZnJvbSBhIHF1aWNrIGdyZXApLg0KPiANCj4gV2ls
bCB5b3Ugbm90IGJyZWFrIElOVFgtc3R5bGUgaW50ZXJydXB0cyBieSByZW1vdmluZyB0aGlzPw0K
PiANCkkgbWVhbnQgdG8gc2F5IEFSTSBzcGVjaWZpYyB3LnIudCBNaWNyb2JsYXplIGFyY2hpdGVj
dHVyZSwgd2hpY2ggaXMgd2hhdCB0aGlzIHBhdGNoIHNlcmllcyBhcmUgZm9yLiBUaGlzIGhhcyBi
ZWVuIGFscmVhZHkgZGlzY3Vzc2VkIGluIG15IHByZXZpb3VzIHBhdGNoIGJ5ICBBcm5kIEJlcmdt
YW5uIGFuZCBMb3JlbnpvIFBpZXJhbGlzaSAuIChodHRwczovL2xrbWwub3JnL2xrbWwvMjAxNi8x
LzEyLzcwNykNCg0KQmhhcmF0DQo=
