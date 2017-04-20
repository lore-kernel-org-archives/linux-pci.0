Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0105.outbound.protection.outlook.com ([104.47.38.105]:6624
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S939298AbdDTShj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Apr 2017 14:37:39 -0400
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Piotr Jaroszynski <pjaroszynski@nvidia.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pci-hyperv: Use only 16 bit integer for PCI domain
Date: Thu, 20 Apr 2017 18:37:35 +0000
Message-ID: <BLUPR03MB1412F7A0A693B67685D5FE9FCA1B0@BLUPR03MB1412.namprd03.prod.outlook.com>
References: <1492706123-22913-1-git-send-email-haiyangz@exchange.microsoft.com>
 <CAErSpo4iFS05Kk3Km54fFmpMf11XCoaPmGxSzqE3QuA5P=T6=Q@mail.gmail.com>
In-Reply-To: <CAErSpo4iFS05Kk3Km54fFmpMf11XCoaPmGxSzqE3QuA5P=T6=Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIFttYWls
dG86YmhlbGdhYXNAZ29vZ2xlLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDIwLCAyMDE3
IDI6MzMgUE0NCj4gVG86IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+DQo+
IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBLWSBTcmluaXZhc2FuIDxreXNAbWljcm9z
b2Z0LmNvbT47DQo+IFN0ZXBoZW4gSGVtbWluZ2VyIDxzdGhlbW1pbkBtaWNyb3NvZnQuY29tPjsg
b2xhZkBhZXBmbGUuZGU7DQo+IHZrdXpuZXRzQHJlZGhhdC5jb207IGRyaXZlcmRldi1kZXZlbEBs
aW51eGRyaXZlcnByb2plY3Qub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBwY2ktaHlwZXJ2OiBVc2Ugb25seSAxNiBiaXQgaW50ZWdl
ciBmb3IgUENJIGRvbWFpbg0KPiANCj4gT24gVGh1LCBBcHIgMjAsIDIwMTcgYXQgMTE6MzUgQU0s
IEhhaXlhbmcgWmhhbmcNCj4gPGhhaXlhbmd6QGV4Y2hhbmdlLm1pY3Jvc29mdC5jb20+IHdyb3Rl
Og0KPiA+IEZyb206IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+DQo+ID4N
Cj4gPiBUaGlzIHBhdGNoIHVzZXMgdGhlIGxvd2VyIDE2IGJpdHMgb2YgdGhlIHNlcmlhbCBudW1i
ZXIgYXMgUENJDQo+ID4gZG9tYWluLCBvdGhlcndpc2Ugc29tZSBkcml2ZXJzIG1heSBub3QgYmUg
YWJsZSB0byBoYW5kbGUgaXQuDQo+IA0KPiBDYW4geW91IGdpdmUgYW55IG1vcmUgZGV0YWlscyBh
Ym91dCB0aGlzPyAgV2hpY2ggZHJpdmVycywgZm9yDQo+IGluc3RhbmNlPyAgV2h5IGRvIGRyaXZl
cnMgY2FyZSBhYm91dCB0aGUgZG9tYWluIGF0IGFsbD8gIENhbiB3ZSBvcg0KPiBzaG91bGQgd2Ug
bWFrZSB0aGlzIG1vcmUgZXhwbGljaXQgYW5kIGNvbnNpc3RlbnQgaW4gdGhlIFBDSSBjb3JlLA0K
PiBlLmcuLCBwY2lfZG9tYWluX25yKCkgaXMgY3VycmVudGx5IGRlZmluZWQgdG8gcmV0dXJuICJp
bnQiOyBtYXliZSBpdA0KPiBzaG91bGQgYmUgdTMyPyAgKEFsdGhvdWdoIEkgdGhpbmsgImludCIg
aXMgdGhlIHNhbWUgc2l6ZSBhcyAidTMyIiBvbg0KPiBhbGwgYXJjaGVzIGFueXdheSkuDQoNCkl0
J3MgTnZpZGlhIGRyaXZlci4NCg0KUGlvdHIsIGNvdWxkIHlvdSBleHBsYWluIHdoeSB0aGUgZHJp
dmVyIGV4cGVjdHMgMTYgYml0IGRvbWFpbiBudW1iZXI/DQoNClRoYW5rcywNCi0gSGFpeWFuZw0K
