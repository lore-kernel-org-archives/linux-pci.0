Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Ortiz, Lance E" <lance.oritz@hp.com>
To: Borislav Petkov <bp@alien8.de>
CC: "Luck, Tony" <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lance_ortiz@hotmail.com" <lance_ortiz@hotmail.com>,
	"jiang.liu@huawei.com" <jiang.liu@huawei.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mchehab@redhat.com" <mchehab@redhat.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] aerdrv: Move cper_print_aer() call out of interrupt
 context
Date: Thu, 30 May 2013 13:58:08 +0000
Message-ID: <A961433CDFF2F640A2866803152E61F95D13A750@G9W0715.americas.hpqcorp.net>
References: <20130529190326.24171.86905.stgit@grignak.americas.hpqcorp.net>
 <30463843.EmBn1xaq3I@vostro.rjw.lan>
 <3908561D78D1C84285E8C5FCA982C28F2DA70112@ORSMSX106.amr.corp.intel.com>
 <A961433CDFF2F640A2866803152E61F95D13A6F2@G9W0715.americas.hpqcorp.net>
 <20130530072849.GA20793@pd.tnic>
In-Reply-To: <20130530072849.GA20793@pd.tnic>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiBPbiBUaHUsIE1heSAzMCwgMjAxMyBhdCAwNDo1NToyMEFNICswMDAwLCBPcnRpeiwgTGFuY2Ug
RSB3cm90ZToNCj4gPiBUaGlzIFRPRE8gaXMgYSBub3RlIGZvciBmdXR1cmUgY2xlYW4tdXAgYW5k
IGlzIG5vdCBkaXJlY3RseSByZWxhdGVkDQo+IHRvDQo+ID50aGUgYnVnIGJlaW5nIGZpeGVkIHdp
dGggdGhpcyBwYXRjaC4gV2hpY2ggbGVuZHMgdG8gdGhlIGFyZ3VtZW50IG9mDQo+IHdoeQ0KPiA+
cHV0IHRoZSBUT0RPIGluIHRoaXMgcGF0Y2g/IE9wcG9ydHVuaXN0aWMuIEkgZG9u4oCZdCB0aGlu
ayB3ZSB3YW50IHRvDQo+ID5jcmVhdGUgYSBzZXBhcmF0ZSBwYXRjaCBqdXN0IGZvciBhIFRPRE8g
bm90ZS4NCj4gDQo+IFNvdW5kcyB0byBtZSwgdGhpcyBUT0RPIGl0ZW0gc2hvdWxkIGJlIG9uIHlv
dXIgVE9ETyBsaXN0IC0gbm90IGluDQo+IGtlcm5lbA0KPiBzb3VyY2VzIDotKQ0KPiAtLQ0KTWFr
ZXMgc2Vuc2UuICBJIHdpbGwgeWFuayB0aGUgVE9ETyBhbmQgcmVzdWJtaXQgdGhlIHBhdGNoLiAg
DQoNCkxhbmNlDQoNCg==
