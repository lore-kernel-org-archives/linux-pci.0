Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db5eur01on0082.outbound.protection.outlook.com ([104.47.2.82]:54592
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751942AbdHDDqo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 23:46:44 -0400
From: "Z.q. Hou" <zhiqiang.hou@nxp.com>
To: Roy Zang <roy.zang@nxp.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Minghuan Lian" <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>
Subject: RE: [PATCH] PCI: layerscape: Add support for ls2088a and ls1088a
Date: Fri, 4 Aug 2017 03:46:39 +0000
Message-ID: <AM5PR0402MB27716C990B0A0BF8DA807F3A84B60@AM5PR0402MB2771.eurprd04.prod.outlook.com>
References: <1499333984-17668-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <20170802212942.GA7667@bhelgaas-glaptop.roam.corp.google.com>
 <AM5PR0402MB2771BBF476E6A3DEFADE43F484B10@AM5PR0402MB2771.eurprd04.prod.outlook.com>
 <DB6PR04MB2949CCDAADC03863B80852108BB10@DB6PR04MB2949.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR04MB2949CCDAADC03863B80852108BB10@DB6PR04MB2949.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SGkgUm95LA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgY29tbWVudHMhDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm95IFphbmcNCj4gU2VudDogMjAxN8TqONTCNMjV
IDI6MjMNCj4gVG86IFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT47IEJqb3JuIEhlbGdh
YXMgPGhlbGdhYXNAa2VybmVsLm9yZz4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gYmhlbGdhYXNAZ29vZ2xl
LmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOyBNaW5naHVhbiBMaWFuDQo+IDxtaW5naHVhbi5MaWFu
QGZyZWVzY2FsZS5jb20+OyBNaW5na2FpIEh1IDxtaW5na2FpLmh1QGZyZWVzY2FsZS5jb20+Ow0K
PiBSb3kgWmFuZyA8dGllLWZlaS56YW5nQGZyZWVzY2FsZS5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIFBDSTogbGF5ZXJzY2FwZTogQWRkIHN1cHBvcnQgZm9yIGxzMjA4OGEgYW5kIGxzMTA4
OGENCj4gDQo+IE9uIDA4LzAyLzIwMTcgMTA6MzYgUE0sIFoucS4gSG91IHdyb3RlOg0KPiA+IGFk
ZCAiZnNsLGxzMTA4OGEtcGNpZSIgdG8gbHNfcGNpZV9vZl9tYXRjaFtdLCB0aGVuIGxzMTA4OGEg
cGNpZSBEVCBub2RlcyB1c2UNCj4gdGhlIGNvbXBhdGlibGUgc3RyaW5nICJmc2wsbHMxMDg4YS1w
Y2llIj8NCj4gDQo+IEknZCBzdWdnZXN0IGdvaW5nIHRoaXMgd2F5Lg0KDQpZZXMsIHRoYW5rcyBm
b3IgdGhlIHN1Z2dlc3Rpb24uDQoNClRoYW5rcywNClpoaXFpYW5nDQoNCg==
