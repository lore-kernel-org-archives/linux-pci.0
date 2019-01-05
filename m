Return-Path: <SRS0=A2IS=PN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18B4C43387
	for <linux-pci@archiver.kernel.org>; Sat,  5 Jan 2019 00:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D1A20874
	for <linux-pci@archiver.kernel.org>; Sat,  5 Jan 2019 00:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="XxAk25/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfAEAPx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 19:15:53 -0500
Received: from mail-eopbgr770113.outbound.protection.outlook.com ([40.107.77.113]:55648
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfAEAPx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jan 2019 19:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvpxUDA1k4gufndEkqXlS0BhECc+2XlfnbQuXfRl01Q=;
 b=XxAk25/pWBAom2j+CyLW2C3lYggHkyXeRhPFOSWWqNx7Ah3f0K4jNleJI59WLwnXOkqUe+UgvBZW5lr+oerFdpeUBEQRe7hFN/fyOu+PG4wl6grjnl3t/9ZQ22OCzBkOeTTIDLL6F6px6CJHyezIMHSmTaNzq8HPfjRbpZ1o1hM=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3723.namprd06.prod.outlook.com (10.167.236.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Sat, 5 Jan 2019 00:15:48 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c067:6414:a064:fa37]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c067:6414:a064:fa37%4]) with mapi id 15.20.1495.005; Sat, 5 Jan 2019
 00:15:48 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "jpinto@synopsys.com" <jpinto@synopsys.com>,
        "marex@denx.de" <marex@denx.de>,
        "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "m.mann@arkona-technologies.de" <m.mann@arkona-technologies.de>,
        "swarren@nvidia.com" <swarren@nvidia.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "xobs@kosagi.com" <xobs@kosagi.com>,
        "hrhaan@gmail.com" <hrhaan@gmail.com>,
        "jbe@pengutronix.de" <jbe@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH] PCI: dwc: fix MSI IRQ handler ordering
Thread-Topic: [PATCH] PCI: dwc: fix MSI IRQ handler ordering
Thread-Index: AQHUpHbL0iuIu0aFAkafyNz/nb5uN6WftYyAgAAELQCAAAY8gIAADrqA
Date:   Sat, 5 Jan 2019 00:15:48 +0000
Message-ID: <1546647347.14247.27.camel@impinj.com>
References: <20190104214509.16891-1-swarren@wwwdotorg.org>
         <1546641949.14247.20.camel@impinj.com>
         <1ff5138e-3de9-e7f9-38e6-feee4b8cefa7@wwwdotorg.org>
         <253b5dce-08cc-611e-1412-397b9faa5d7a@wwwdotorg.org>
In-Reply-To: <253b5dce-08cc-611e-1412-397b9faa5d7a@wwwdotorg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3723;6:/e0G7GlIqCJUU+p9cDajO8PpCIOKD7iUPjn/Pf8HMm7iISMqn2q+J+Meg01969+cxrFg64riRZihR7E7EQYPmQaqTd55phQVyC2mcxOCve5NmF0Mh5Q40UIkA0tMpM7QfYYrFOA2/jjTiUzL1RoVX0unu+dEbf0X0ZFRR5IKG151pEM/DSPb1dfI1gTnDSqw8Ktc1nM4EJYUrvnzew1owbB+hiv/RO0lBW1YDN5rmM0u9PnGhvvo0JC7NNuEK+yxlst3DLxjx144TGqVFcu3fWoP5bJK/Isa8lTcwRLwzdkaCY+DM/XhiqezCvklvaLERlxJqvtm8TvxlKSxIwwUsm7d35jyzU4g7HsTu7s9KgoeLC7hczwWvksgS4/1k0rqFGJdlxcVdXGFZQ9NZHXTs5SsOMuZmrxmA+sbtP+HzVijgdCKvTC+TrLk6/wd1c5fLNg75KyBJqJe04O+lr14FA==;5:HBfK2jYlMjXW1+eo5AnVjyeOZPcFhTm+JGTbEqQj5nXc61YZXTxP3KvayzQ0WGBGBMC2rPNJLMQ1XOpEdcSyjgpRHbZq5H0XF3rb1Rc0vOs+z+qUnZsb4PhY9LOYr/iQgUzdViZMQh0p+Z/RVtgdVy+WrA97URrc5OpezDTXn6vW7YFl1CfU/I/J+XhdMRJrOwJ8DGT8Hb/GPJiN9rEIjg==;7:F8AGJNgovWVhXtzi5u/gPCzAEoAMb4an9w6nRfuBiR5j/+cQ/6Bwlp8eyGkaOrN2rfjLSe+QOMO+UWm3kqQ40xcJ//vB8eZLBgzdrDbm8Q/T73KB2/HXB7zmsVxe5U151f1a0DUyZDDEgnK6cgAWgQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 04d65ac3-14e4-4f43-3c6f-08d672a2f1ad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3723;
x-ms-traffictypediagnostic: MWHPR0601MB3723:
x-microsoft-antispam-prvs: <MWHPR0601MB3723DED3304B92A5B3B0DD8AD38F0@MWHPR0601MB3723.namprd06.prod.outlook.com>
x-forefront-prvs: 09086FB5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39840400004)(346002)(396003)(366004)(136003)(199004)(189003)(68736007)(99286004)(102836004)(305945005)(54906003)(110136005)(36756003)(26005)(11346002)(97736004)(446003)(186003)(81156014)(93886005)(81166006)(7736002)(86362001)(478600001)(316002)(8936002)(8676002)(14454004)(25786009)(6512007)(2201001)(229853002)(5660300001)(2501003)(6486002)(4326008)(6246003)(14444005)(71190400001)(76176011)(71200400001)(6436002)(39060400002)(256004)(3846002)(7416002)(2616005)(2906002)(476003)(6116002)(106356001)(486006)(53546011)(6506007)(66066001)(53936002)(217873002)(103116003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3723;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uPksvjJ4D9zql8rxcmoJi9Exm5v9b7tFYnkBAqYuTXN4yHe+M7bBgG5d4XHhnsOA/wMMsrY4ZBYRQpbC+fyR+6bUI6pWqq9bnKFA7Wfslk82aCjXm53TgQCOEcke84OwM1q6dQnncH22Bs5sUEZzh3lNXlD+dzPPxUeclwArTifp0RFjvtg6rOS5GcmEk/11YN33Dm6ZV9ZJBgDCpYg0CGtFQG3oP9qLQaAF3wWiL78Z0jI6dVnrTlDxwR5CeGBBC0r/JwtH/CywKBf+3mxADq7nhxfkYV/xr4XpOg0mPM/xYc11EMj5OCoiIn/kRGxA
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <67D3CAA2201EBB4C8AFEDCA735CBEDCA@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d65ac3-14e4-4f43-3c6f-08d672a2f1ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2019 00:15:48.3497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3723
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDE5LTAxLTA0IGF0IDE2OjIzIC0wNzAwLCBTdGVwaGVuIFdhcnJlbiB3cm90ZToN
Cj4gT24gMS80LzE5IDQ6MDAgUE0sIFN0ZXBoZW4gV2FycmVuIHdyb3RlOg0KPiA+IA0KPiA+IA0K
PiA+IEhtbS4gV2VsbCBJIGd1ZXNzIEknbGwgZ28gZm9yIHRoZSBwYXRjaCBJIHBvc3RlZCBpbiBv
dXIgZG93bnN0cmVhbSANCj4gPiBrZXJuZWxzLCBzaW5jZSBiYWNrLXBvcnRpbmcgYSBidW5jaCBv
ZiBub3QteWV0LWF2YWlsYWJsZSByZXN0cnVjdHVyaW5nIA0KPiA+IHRvIG91ciBhbmNpZW50IGtl
cm5lbHMgZG9lc24ndCBzb3VuZCBwbGVhc2FudDotKSBCdXQgSSdsbCBnbyBhbmQgdGFrZSBhIA0K
PiA+IHF1aWNrIGxvb2sgYXQgdGhlIG90aGVyIHBhdGNoZXMgeW91IG1lbnRpb25lZCBqdXN0IGlu
IGNhc2UuIFRoYW5rcyENCj4gDQo+IFNvIEkgd2VudCBhbmQgcmVhZCB0aGUgdGhyZWFkIGZvciAi
UENJOiBkd2M6IEZpeCBpbnRlcnJ1cHQgcmFjZSBpbiB3aGVuIA0KPiBoYW5kbGluZyBNU0kiIGFu
ZCBzZWU6DQo+IA0KPiBWaWduZXNoIFIgd3JvdGU6DQo+ICA+IExvcmVuem8gUGllcmFsaXNpIHdy
b3RlOg0KPiA+ID4gQUZBSUNTOg0KPiA+ID4gDQo+ID4gPiA4YzkzNDA5NWZhMmYgKCJQQ0k6IGR3
YzogQ2xlYXIgTVNJIGludGVycnVwdCBzdGF0dXMgYWZ0ZXIgaXQgaXMgaGFuZGxlZCwNCj4gPiA+
IG5vdCBiZWZvcmUiKQ0KPiA+ID4gDQo+ID4gPiB3YXMgZml4aW5nIGEgYnVnLCBjYXVzaW5nICJ0
aW1lb3V0cyBvbiBzb21lIHdpcmVsZXNzIGxhbiBjYXJkcyIsIHdlIHdhbnQNCj4gPiA+IHRvIHVu
ZGVyc3RhbmQgd2hhdCB0aGUgcHJvYmxlbSBpcywgZml4IGl0IG9uY2UgZm9yIGFsbCBvbiBhbGwg
RFdDDQo+ID4gPiBiYXNlZCBzeXN0ZW1zLg0KPiA+ID4gDQo+IFNvIGl0IHNlZW1zIHF1aXRlIGNs
ZWFyIHRoYXQgdGhlIGNvcnJlY3QgY291cnNlIG9mIGFjdGlvbiBpcyB0byANCj4gaW1tZWRpYXRl
bHkgcmV2ZXJ0IGNvbW1pdCA4YzkzNDA5NWZhMmYgKCJQQ0k6IGR3YzogQ2xlYXIgTVNJIGludGVy
cnVwdCANCj4gc3RhdHVzIGFmdGVyIGl0IGlzIGhhbmRsZWQsIG5vdCBiZWZvcmUiKSAob3IgYXBw
bHkgbXkgb3IgVHJlbnQncyBwYXRjaGVzIA0KPiB3aGljaCBhcmUgZWZmZWN0aXZlbHkgcmV2ZXJ0
cykgc2luY2UgaXQgKGEpIGF0dGVtcHRzIHRvIGZpeCBhIGJ1ZyAoaW4gDQo+IHRoZSBjb3JlIERX
QyBkcml2ZXIpIHRoYXQgZG9lc24ndCBhY3R1YWxseSBleGlzdCAodGhlIGJ1ZyBpcyBpbiB0aGUg
RFJBIA0KPiBIVyBhbmQgaXMgYmVpbmcgZml4ZWQgaW4gdGhlIERSQSB3cmFwcGVyIGRyaXZlciks
IGFuZCAoYikgaGFzIG1hbnkgDQo+IHJlcG9ydHMgdGhhdCB0aGUgY2hhbmdlIGNhdXNlcyByZWdy
ZXNzaW9uczsgSSdtIGF0IGxlYXN0IHRoZSAzcmQgb3IgNHRoIA0KPiBwZXJzb24gdG8gY29uZmly
bSB0aGlzIG5vdyAoRmFpeiBvcmlnaW5hbGx5LCB0aGVuIGxhdGVyIFRyZW50LCBWaWduZXNoLCAN
Cj4gbXlzZWxmKS4NCg0KSXQgYWxzbyBzZWVtZWQgY2xlYXIgdG8gbWUhICBCdXQgaWYgeW91IGNo
ZWNrIHRoZSB0aHJlYWQgZnVsbHksIHRoaXMNCndhcyB2ZXJ5IGZvcmNlZnVsbHkgcmVqZWN0ZWQu
DQoNCj4gTm93LCB3aGV0aGVyIHRoZXJlJ3Mgc29tZSBjbGVhbnVwIG9yIGFkZGl0aW9uYWwgZml4
ZXMgbmVlZGVkIGJleW9uZCB0aGUgDQo+IHNpbXBsZSByZXZlcnQgaXMgYW5vdGhlciBxdWVzdGlv
biBJIGN1cnJlbnRseSBoYXZlIG5vIGluc2lnaHQgaW50bywgYnV0IA0KPiBsZXQncyBhdCBsZWFz
dCBnZXQgYmFjayB0byBhIGRyaXZlciB3aXRob3V0IHRoYXQgd29ya2VkIHdlbGwgZm9yIHBlb3Bs
ZSANCj4gZm9yIHllYXJzLCBldmVuIGlmIHRoZXJlJ3MgYSB0aGVvcmV0aWNhbCBpc3N1ZSB0byBi
ZSBmaXhlZCB0aGF0IG5vYm9keSANCj4gaGl0IGluIHByYWN0aWNlLg0KDQpJIGRvIG5vdCB0aGlu
ayBhIHJlYWwgb3IgdGhlb3JldGljYWwgbWVjaGFuaXNtIGZvciBpbmNvcnJlY3QgYmVoYXZpb3IN
CndhcyBpZGVudGlmaWVkIGJleW9uZCB0aGUgcmV2ZXJ0IHdlIGtub3cgb2YuICBNb3JlIG9mIGEg
Y2FzZSBvZiBwaWVjZXMNCm5vdCBiZWluZyB3aGVyZSB0aGUgZnJhbWV3b3JrIGludGVuZGVkIHRo
ZW0gdG8gYmUu
