Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:45745 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbbDCOGp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Apr 2015 10:06:45 -0400
From: "Li, Zhen-Hua" <zhen-hual@hp.com>
To: Dave Young <dyoung@redhat.com>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"indou.takao@jp.fujitsu.com" <indou.takao@jp.fujitsu.com>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"vgoyal@redhat.com" <vgoyal@redhat.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"ddutile@redhat.com" <ddutile@redhat.com>,
	"ishii.hironobu@jp.fujitsu.com" <ishii.hironobu@jp.fujitsu.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Hatch, Douglas B (HPS Linux PM)" <doug.hatch@hp.com>,
	"Hoemann, Jerry" <jerry.hoemann@hp.com>,
	"Vaden, Tom (HP Server OS Architecture)" <tom.vaden@hp.com>,
	"Zhang, Li (Zoe@HPservers-Core-OE-PSC)" <li.zhang6@hp.com>,
	"Mitchell, Lisa (MCLinux in Fort Collins)" <lisa.mitchell@hp.com>,
	"billsumnerlinux@gmail.com" <billsumnerlinux@gmail.com>,
	"Wright, Randy (HP Servers Linux)" <rwright@hp.com>
Subject: Re: [PATCH v9 0/10] iommu/vt-d: Fix intel vt-d faults in kdump
 kernel
Date: Fri, 3 Apr 2015 14:05:36 +0000
Message-ID: <534F7596-2172-4BE1-B374-4D18D2DA5110@hp.com>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
 <20150403084031.GF22579@dhcp-128-53.nay.redhat.com>
 <551E56F6.60503@hp.com>,<20150403092111.GG22579@dhcp-128-53.nay.redhat.com>
In-Reply-To: <20150403092111.GG22579@dhcp-128-53.nay.redhat.com>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

VGhlIGhhcmR3YXJlIHdpbGwgZG8gc29tZSB2ZXJpZmljYXRpb24sIGJ1dCBub3QgY29tcGxldGVs
eS4gIElmIHBlb3BsZSB0aGluayB0aGUgT1Mgc2hvdWxkIGFsc28gZG8gdGhpcywgdGhlbiBpdCBz
aG91bGQgYmUgYW5vdGhlciBwYXRjaHNldCwgSSB0aGluay4NCg0KVGhhbmtzDQpaaGVuaHVhIA0K
DQo+INTaIDIwMTXE6jTUwjPI1aOsMTc6MjGjrERhdmUgWW91bmcgPGR5b3VuZ0ByZWRoYXQuY29t
PiDQtLXAo7oNCj4gDQo+PiBPbiAwNC8wMy8xNSBhdCAwNTowMXBtLCBMaSwgWmhlbkh1YSB3cm90
ZToNCj4+IEhpIERhdmUsDQo+PiANCj4+IFRoZXJlIG1heSBiZSBzb21lIHBvc3NpYmlsaXRpZXMg
dGhhdCB0aGUgb2xkIGlvbW11IGRhdGEgaXMgY29ycnVwdGVkIGJ5DQo+PiBzb21lIG90aGVyIG1v
ZHVsZXMuIEN1cnJlbnRseSB3ZSBkbyBub3QgaGF2ZSBhIGJldHRlciBzb2x1dGlvbiBmb3IgdGhl
DQo+PiBkbWFyIGZhdWx0cy4NCj4+IA0KPj4gQnV0IEkgdGhpbmsgd2hlbiB0aGlzIGhhcHBlbnMs
IHdlIG5lZWQgdG8gZml4IHRoZSBtb2R1bGUgdGhhdCBjb3JydXB0ZWQNCj4+IHRoZSBvbGQgaW9t
bXUgZGF0YS4gSSBvbmNlIG1ldCBhIHNpbWlsYXIgcHJvYmxlbSBpbiBub3JtYWwga2VybmVsLCB0
aGUNCj4+IHF1ZXVlIHVzZWQgYnkgdGhlIHFpXyogZnVuY3Rpb25zIHdhcyB3cml0dGVuIGFnYWlu
IGJ5IGFub3RoZXIgbW9kdWxlLg0KPj4gVGhlIGZpeCB3YXMgaW4gdGhhdCBtb2R1bGUsIG5vdCBp
biBpb21tdSBtb2R1bGUuDQo+IA0KPiBJdCBpcyB0b28gbGF0ZSwgdGhlcmUgd2lsbCBiZSBubyBj
aGFuY2UgdG8gc2F2ZSB2bWNvcmUgdGhlbi4NCj4gDQo+IEFsc28gaWYgaXQgaXMgcG9zc2libGUg
dG8gY29udGludWUgY29ycnVwdCBvdGhlciBhcmVhIG9mIG9sZG1lbSBiZWNhdXNlDQo+IG9mIHVz
aW5nIG9sZCBpb21tdSB0YWJsZXMgdGhlbiBpdCB3aWxsIGNhdXNlIG1vcmUgcHJvYmxlbXMuDQo+
IA0KPiBTbyBJIHRoaW5rIHRoZSB0YWJsZXMgYXQgbGVhc3QgbmVlZCBzb21lIHZlcmlmeWNhdGlv
biBiZWZvcmUgYmVpbmcgdXNlZC4NCj4gDQo+PiANCj4+IA0KPj4gVGhhbmtzDQo+PiBaaGVuaHVh
DQo+PiANCj4+IE9uIDA0LzAzLzIwMTUgMDQ6NDAgUE0sIERhdmUgWW91bmcgd3JvdGU6DQo+Pj4+
IFRvIGZpeCB0aGlzIHByb2JsZW0sIHdlIG1vZGlmaWVzIHRoZSBiZWhhdmlvcnMgb2YgdGhlIGlu
dGVsIHZ0LWQgaW4gdGhlDQo+Pj4+IGNyYXNoZHVtcCBrZXJuZWw6DQo+Pj4+IA0KPj4+PiBGb3Ig
RE1BIFJlbWFwcGluZzoNCj4+Pj4gMS4gVG8gYWNjZXB0IHRoZSB2dC1kIGhhcmR3YXJlIGluIGFu
IGFjdGl2ZSBzdGF0ZSwNCj4+Pj4gMi4gRG8gbm90IGRpc2FibGUgYW5kIHJlLWVuYWJsZSB0aGUg
dHJhbnNsYXRpb24sIGtlZXAgaXQgZW5hYmxlZC4NCj4+Pj4gMy4gVXNlIHRoZSBvbGQgcm9vdCBl
bnRyeSB0YWJsZSwgZG8gbm90IHJld3JpdGUgdGhlIFJUQSByZWdpc3Rlci4NCj4+Pj4gNC4gTWFs
bG9jIGFuZCB1c2UgbmV3IGNvbnRleHQgZW50cnkgdGFibGUsIGNvcHkgZGF0YSBmcm9tIHRoZSBv
bGQgb25lcyB0aGF0DQo+Pj4+ICAgdXNlZCBieSB0aGUgb2xkIGtlcm5lbC4NCj4+PiANCj4+PiBI
YXZlIG5vdCByZWFkIGFsbCB0aGUgcGF0Y2hlcywgYnV0IEkgaGF2ZSBhIHF1ZXN0aW9uLCBub3Qg
c3VyZSB0aGlzIGhhcyBiZWVuDQo+Pj4gYW5zd2VyZWQgYmVmb3JlLiBPbGQgbWVtb3J5IGlzIG5v
dCByZWxpYWJsZSwgd2hhdCBpZiB0aGUgb2xkIG1lbW9yeSBnZXQgY29ycnVwdGVkDQo+Pj4gYmVm
b3JlIHBhbmljPyBJcyBpdCBzYWZlIHRvIGNvbnRpbnVlIHVzaW5nIGl0IGluIDJuZCBrZXJuZWws
IEkgd29ycnkgdGhhdCBpdCB3aWxsDQo+Pj4gY2F1c2UgcHJvYmxlbXMuDQo+Pj4gDQo+Pj4gSG9w
ZSBJJ20gd3JvbmcgdGhvdWdoLg0KPj4+IA0KPj4+IFRoYW5rcw0KPj4+IERhdmUNCj4+IA0K
