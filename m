Return-Path: <SRS0=KD5Y=CI=ACULAB.COM=David.Laight@kernel.org>
Return-Path: <SRS0=KD5Y=CI=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Vidya Sagar' <vidyas@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: "treding@nvidia.com" <treding@nvidia.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "kthota@nvidia.com" <kthota@nvidia.com>,
	"swarren@nvidia.com" <swarren@nvidia.com>, "mmaddireddy@nvidia.com"
	<mmaddireddy@nvidia.com>, Michal Simek <michal.simek@xilinx.com>,
	=?utf-8?B?U8O2cmVuIEJyaW5rbWFubg==?= <soren.brinkmann@xilinx.com>, "Simon
 Horman" <horms@verge.net.au>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH] PCI: tegra: limit MSI target address to 32-bit
Date: Fri, 10 Nov 2017 09:47:37 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD00B83D3@AcuExch.aculab.com>
References: <1509991387-15951-1-git-send-email-vidyas@nvidia.com>
 <20171108212558.GC21597@bhelgaas-glaptop.roam.corp.google.com>
 <e993e1f8-b6b3-de07-759c-a56012e06a2a@nvidia.com>
 <20171109181435.GB7629@bhelgaas-glaptop.roam.corp.google.com>
 <7727b9bc-a44b-4cbe-1839-7e4dd7c2c186@nvidia.com>
In-Reply-To: <7727b9bc-a44b-4cbe-1839-7e4dd7c2c186@nvidia.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

RnJvbTogVmlkeWEgU2FnYXINCj4gU2VudDogMDkgTm92ZW1iZXIgMjAxNyAxODo0MQ0KLi4uDQo+
ID4gQW5kIHRoaXMgY29tbWl0IFszXSBzb3VuZHMgbGlrZSBpdCBkZXNjcmliZXMgYSBzaW1pbGFy
IGhhcmR3YXJlDQo+ID4gc2l0dWF0aW9uIHdpdGggVGVncmEgd2hlcmUgdGhlIGhvc3QgYnJpZGdl
IGludGVyY2VwdHMgdGhlIE1TSSB0YXJnZXQNCj4gPiBhZGRyZXNzLCBzbyB3cml0ZXMgdG8gaXQg
bmV2ZXIgcmVhY2ggc3lzdGVtIG1lbW9yeS4gIFRoYXQgbWVhbnMgdGhhdA0KPiA+IFRlZ3JhIGRv
ZXNuJ3QgbmVlZCB0byBhbGxvY2F0ZSBzeXN0ZW0gbWVtb3J5IGF0IGFsbC4NCj4gPg0KPiA+IElz
IHlvdXIgc3lzdGVtIHNpbWlsYXI/ICBDYW4geW91IGp1c3Qgc3RhdGljYWxseSBhbGxvY2F0ZSBh
IGxpdHRsZSBidXMNCj4gPiBhZGRyZXNzIHNwYWNlLCB1c2UgdGhhdCBmb3IgdGhlIE1TSSB0YXJn
ZXQgYWRkcmVzcywgYW5kIHNraXAgdGhlDQo+ID4gX19nZXRfZnJlZV9wYWdlcygpPw0KPg0KPiBJ
dCBpcyB0aGUgc2FtZSBzeXN0ZW0gd2hlcmUgTVNJIG1lbW9yeSB3cml0ZXMgZG9uJ3QgcmVhbGx5
IG1ha2UgaXQgdG8NCj4gc3lzdGVtIG1lbW9yeS4gQnV0LCB0aGUgYWRkcmVzc2VzIG1lbnRpb25l
ZCBpbiB0aGF0IHBhdGNoIGRvbid0IHdvcmsuDQo+IHdlIGFyZSB3b3JraW5nIHdpdGggaGFyZHdh
cmUgZm9sa3Mgb24gdW5kZXJzdGFuZGluZyB0aGUgaXNzdWUgYmV0dGVyLg0KLi4uDQoNCllvdSBk
byBuZWVkIHRvIG1ha2Ugc3VyZSB0aGF0IHRoZSBhZGRyZXNzIHlvdSBwaWNrIHdpbGwgbmV2ZXIN
CmJlIHVzZWQgZm9yIGEgJ2RtYScgdHJhbnNmZXIuDQpJZiB0aGUgYWRkcmVzcyBuZWVkcyB0byBi
ZSBpbnNpZGUgdGhlIChwY2llKSBwaHlzaWNhbCBhZGRyZXNzZXMNCmZvciBzeXN0ZW0gbWVtb3J5
IHRoZW4gYWxsb2NhdGluZyBhIHBoeXNpY2FsIHBhZ2UgbWF5IGJlIHRoZQ0Kc2FmZXN0IHdheSB0
byBlbnN1cmUgdGhpcyBkb2Vzbid0IGhhcHBlbi4NCg0KCURhdmlkDQoNCg0K
