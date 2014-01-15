Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db8lp0188.outbound.messaging.microsoft.com ([213.199.154.188]:42753
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752254AbaAOQHO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2014 11:07:14 -0500
From: Guenter Roeck <groeck@juniper.net>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Rajat Jain <rajatjain@juniper.net>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: User initiated hotplug and kernel initiated hotplug - where is
 the synchronization?
Date: Wed, 15 Jan 2014 16:07:02 +0000
Message-ID: <83e67f7228074cf2a07e2fab275f55bc@CO1PR05MB523.namprd05.prod.outlook.com>
References: <635a0ddff97142e2a06f9bd9c3428d01@DM2PR05MB671.namprd05.prod.outlook.com>
 <18064064.UldA0zYdyf@vostro.rjw.lan>
In-Reply-To: <18064064.UldA0zYdyf@vostro.rjw.lan>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DQo+IA0KPiA+IEkgaGF2ZSB0aGlzIGRvdWJ0IGxpbmdlcmluZyBvbiwgYW5kIEknZCBhcHByZWNp
YXRlIGlmIHNvbWUgb25lIGNvdWxkDQo+IHRocm93IGxpZ2h0IG9uIHRoaXM6DQo+ID4NCj4gPiBU
aGUga2VybmVsIGhvdHBsdWcgZHJpdmVyIHBjaWVocCBjYW4gaW5pdGlhdGUgaG90cGx1ZyBiYXNl
ZCBvbiB3aGF0DQo+IGl0IHNlbnNlcyBmcm9tIHRoZSBIVyAoYnV0dG9uIHByZXNzIGV0YykuDQo+
ID4NCj4gPiBUaGUgdXNlciBzcGFjZSBjYW4gYWxzbyBpbml0aWF0ZSB0aGUgc2FtZSBvcGVyYXRp
b25zIGJ5IHVzaW5nDQo+ICJyZXNjYW4iIG9yICJyZW1vdmUiIGF0dHJpYnV0ZXMgaW4gc3lzZnMu
DQo+ID4NCj4gPiBNeSBxdWVzdGlvbnM6DQo+ID4NCj4gPiAxKSBJcyBpdCBzYWZlIHRvIG1peCB0
aGUgYWJvdmUgdHdvPw0KPiANCj4gTm90IHJpZ2h0IG5vdywgYnV0IHdpdGggdGhlc2UgcGF0Y2hl
cyBhcHBsaWVkOg0KPiANCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8zNDY2
NTUxLw0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzM0NjY1ODEvDQo+IGh0
dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMzQ2NjYwMS8NCj4gaHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wYXRjaC8zNDY2NTkxLw0KPiBodHRwczovL3BhdGNod29yay5rZXJu
ZWwub3JnL3BhdGNoLzM0NjY2MzEvDQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0
Y2gvMzQ2NjY0MS8NCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8zNDY2NjUx
Lw0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzM0OTE4MTEvDQo+IGh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMzQ2NjQ5MS8NCj4gaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wYXRjaC8zNDczMzQxLw0KPiANCj4gaXQgc2hvdWxkIGJlLg0KPiANCg0K
SGkgUmFmYWVsLA0KDQphbnkgaWRlYSB3aGVuIHRob3NlIHBhdGNoZXMgd2lsbCBzaG93IHVwIGlu
IHRoZSB1cHN0cmVhbSBrZXJuZWwgPw0KDQpUaGFua3MsDQpHdWVudGVyDQoNCg==

