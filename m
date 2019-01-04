Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C10C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 22:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2382173B
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 22:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="KKX8X4MK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfADWp5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 17:45:57 -0500
Received: from mail-eopbgr700122.outbound.protection.outlook.com ([40.107.70.122]:8016
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726094AbfADWp5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jan 2019 17:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nwuf/bB8vy99hh5guggIvNdDWHx/NwhFTur82ZNxymI=;
 b=KKX8X4MKhlv4HDP3P2OWNMYrpdTGiCCqxzRoVZHaTyVK0cnWZr+iHIsKoHIR9JHtf31uy2ImTIiJZeb7iOFYEYBr4me2h68xNP7JEafY/y30vToSlscjRjufOIUTSVyAM56JSnEVHyS7BrFbfeU7Md6pk1R1wDG/JSTpW25ToJY=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3786.namprd06.prod.outlook.com (10.167.236.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Fri, 4 Jan 2019 22:45:50 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c067:6414:a064:fa37]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c067:6414:a064:fa37%4]) with mapi id 15.20.1495.005; Fri, 4 Jan 2019
 22:45:50 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     "jpinto@synopsys.com" <jpinto@synopsys.com>,
        "marex@denx.de" <marex@denx.de>,
        "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
        "pratyush.anand@st.com" <pratyush.anand@st.com>,
        "jg1.han@samsung.com" <jg1.han@samsung.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "swarren@nvidia.com" <swarren@nvidia.com>,
        "m.mann@arkona-technologies.de" <m.mann@arkona-technologies.de>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "mohit.kumar@st.com" <mohit.kumar@st.com>,
        "xobs@kosagi.com" <xobs@kosagi.com>,
        "siva.kallam@samsung.com" <siva.kallam@samsung.com>,
        "hrhaan@gmail.com" <hrhaan@gmail.com>,
        "jbe@pengutronix.de" <jbe@pengutronix.de>,
        "hong-xing.zhu@freescale.com" <hong-xing.zhu@freescale.com>,
        "ts.srikanth@samsung.com" <ts.srikanth@samsung.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH] PCI: dwc: fix MSI IRQ handler ordering
Thread-Topic: [PATCH] PCI: dwc: fix MSI IRQ handler ordering
Thread-Index: AQHUpHbL0iuIu0aFAkafyNz/nb5uN6WftYyA
Date:   Fri, 4 Jan 2019 22:45:50 +0000
Message-ID: <1546641949.14247.20.camel@impinj.com>
References: <20190104214509.16891-1-swarren@wwwdotorg.org>
In-Reply-To: <20190104214509.16891-1-swarren@wwwdotorg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3786;6:jZexoymgvrE1QjHwFDCkUfmPtpZmcxOek9oinaZL/5YJPbjHuOzEbFuGk3hYkQ0Ofw0IUx2UXIODybNZuxuQJZImSJL4h8NJnQnLEqzv1KK8IdLGgj3qXzjAsdsNNWSWCXE3R/FcUVMFrsRAjNJxEwnnjpD+BCDLcyu26o2wtODC6z+MK9BeJF5ZrGkqFsGarsHVy02b95dTyvpN9S/ovIoDQimUgugUAhxZ02ScYcp3bqlFEc1LtA2CsWuVAJ8ceKt7s4NARAN/j1Gdrke7PTdv5GpZsdXX0iqD0gByocaL95u5pT80j3tXk9SbyhmemrK+AaKqD2qz4Qp6dxAQ8kBmM9AQYuMhRaKRQCKE2QAj4DKO/2UBAnAumqyQyuTZO3REp0ecTqV/b6kpRGkOvo1fGoqjnMYcCgK9Q2J80OtpGrUIZW2GA0KOmvlq5H5oRXsXssduu7jhmt9nW/4y8A==;5:TKs08PEc8XMELOJndnYsI+HMtjv0Zoi2I1CP2v+zBDo4Vd2Zyhwukjqw4n2N1urfmJ0I0xYiEqU0SsqQQtzh6vzbLQY8Ug5Bkv/FJTfqo6EJKk2fJP6aAwaeLaLlI4RgYmpFnSSNLOEQu57K/qg7XzLCOnB9pxw/tH5ou28ZsV0iSSf0chcqlbjsTMjLmNkdy7RGGUh5vNS+/OSOxytMrw==;7:XRvccUHnK0omThnmQpliToWHVNBfloguU4W4/VShd/BiiKT5nCc0A+sbiMmD4HHQYfE+PVAwzYMaXOhyymVmwR5v6E/c4HDpZGdqc3v1QZ0TgJqDszzT4fl/5M1Th9WOqhrZabTrTHeTRAvG52RWFQ==
x-ms-office365-filtering-correlation-id: 2869a813-b995-45f8-9864-08d67296603d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3786;
x-ms-traffictypediagnostic: MWHPR0601MB3786:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-microsoft-antispam-prvs: <MWHPR0601MB37865962734CD57DBE993352D38E0@MWHPR0601MB3786.namprd06.prod.outlook.com>
x-forefront-prvs: 0907F58A24
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(39850400004)(376002)(346002)(199004)(189003)(53936002)(229853002)(305945005)(105586002)(316002)(26005)(71190400001)(54906003)(6436002)(71200400001)(66066001)(2201001)(6512007)(6486002)(110136005)(39060400002)(5660300001)(256004)(186003)(106356001)(68736007)(3846002)(6116002)(86362001)(217873002)(76176011)(2501003)(103116003)(478600001)(8676002)(14454004)(2906002)(7416002)(6246003)(14444005)(7736002)(81166006)(25786009)(11346002)(81156014)(8936002)(102836004)(4326008)(2616005)(36756003)(446003)(486006)(6506007)(99286004)(97736004)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3786;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1CzE+CUdz3xHNhR4vmWE2S8hE4WSCAIy/fLvMRi660KEGnO4refyxoyJqniyOLAzRptMT+378wVQk2oXRJWfr8Z4jvNMNjQjZpg2a8A6geB4guCzbGT7TGhnVKdznjAwz5q+OWD9RcXPRLUhSkkfaTvMWXezk06BaMgHiyiNocFAHtSUmKzmK2g8sLyJaQdBpojXoNmkgYrb1zNNrwK44bnPGgrL2++TUTpwwb/w3Y7qypBycVI55Q23mnLUDrpz45kwCdK0c/LuCPO3WyuBSEZot18e30O+xgmzzjRBzR8EfHTIru50qJVhaINaWqOs
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <19F2A17229B40248A3ACCB1F4490D027@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2869a813-b995-45f8-9864-08d67296603d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 22:45:50.3095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3786
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDE5LTAxLTA0IGF0IDE0OjQ1IC0wNzAwLCBTdGVwaGVuIFdhcnJlbiB3cm90ZToN
Cj4gRnJvbTogU3RlcGhlbiBXYXJyZW4gPHN3YXJyZW5AbnZpZGlhLmNvbT4NCj4gDQo+IFRoZSBj
dXJyZW50IGNvZGUgZG9lcyB0aGlzIHdoZW4gaGFuZGxpbmcgTVNJIElSUXM6DQo+IA0KPiBhKSBQ
cm9jZXNzIHRoZSBpcnEuDQo+IGIpIENsZWFyIHRoZSBsYXRjaGVkIElSUSBzdGF0dXMuDQo+IA0K
PiBJZiBhIG5ldyBJUlEgb2NjdXJzIGFueSB0aW1lIGFmdGVyIChhKSBoYXMgcmVhZCB0aGUgSVJR
IHN0YXR1cyBmb3IgdGhlDQo+IGxhc3QgdGltZSBhbmQgYmVmb3JlIChiKSwgaXQgd2lsbCBiZSBs
b3N0LiBGb3IgZXhhbXBsZSwgdGhpcyBvY2N1cnMgaW4NCg0KVGhlcmUgd2FzIGEgcGF0Y2ggc2Vy
aWVzIHRvIGZpeCB0aGlzIGJ1Zywgc2VudCBpbiBPY3RvYmVyLCBzdHJldGNoaW5nDQp0byBEZWNl
bWJlci4NCg0KU2VlICJQQ0k6IGR3YzogRml4IGludGVycnVwdCByYWNlIGluIHdoZW4gaGFuZGxp
bmcgTVNJIg0KDQpBbmQgIlBDSTogZGVzaWdud2FyZTogTW92ZSBpbnRlcnJ1cHQgYWNraW5nIGlu
dG8gdGhlIHByb3BlciBjYWxsYmFjayINCg0KVGhlIHJlc3VsdCB3YXMgbW9yZSBjb2RlIGNoYW5n
ZXMsIHdoaWNoIGluIHRoZSBlbmQgcHJvZHVjZSB0aGUgc2FtZQ0Kb3JkZXIgb2Ygb3BlcmF0aW9u
cyBhcyBpcyBkb25lIGhlcmUgdG8gZml4IHRoZSByYWNlLiAgQnV0IGl0IHVzZXMgdGhlDQppcnEg
ZnJhbWV3b3JrIGNvcnJlY3RseS4NCg0KSSBkbyBub3QgdGhpbmsgdGhpcyBwcm9ibGVtIHdhcyBp
bnRyb2R1Y2VkIHVudGlsIDQuMTQsIHNvIHRoZSBudmlkaWENCjQuOSBtdXN0IGhhdmUgYWRkaXRp
b25hbCBwYXRjaGVzIGlmIHRoaXMgaXMgb2JzZXJ2ZWQgdGhlcmUuICBJJ20gc3VyZQ0KaXQgd2Fz
IG5vdCBwcmVzZW50IGluIDQuMTIsIGFzIHdlIHVzZWQgdGhhdCwgYW5kIGRpZCBub3Qgc2VlIHRo
ZSBpc3N1ZQ0KdW50aWwgdXBkYXRpbmcgdG8gNC4xNi4NCg0KVGhlIGN1cnJlbnQgZml4IChmb3Ig
NC4yMT8pIGRlcGVuZHMgb24gc2lnbmlmaWNhbnQgcmVzdHJ1Y3R1cmluZyB0aGF0DQp3YXMgZG9u
ZSB0byB0aGlzIGRyaXZlciBhcm91bmQgNC4xNywgc2VlICJQQ0k6IGR3YzogTW92ZSBNU0kgSVJR
cw0KYWxsb2NhdGlvbiB0byBJUlEgZG9tYWlucyBoaWVyYXJjaGljYWwgQVBJIi4NCg0KSSB0aGlu
ayBteSBvcmlnaW5hbCBwYXRjaCAoIkZpeCBpbnRlcnJ1cHQgcmFjZSAuLiIpIG9yIHlvdXIgcGF0
Y2ggaGVyZSwNCndoaWNoIGlzIGJhc2ljYWxseSB0aGUgc2FtZSwgc2hvdWxkIGJlIHBvcnRlZCB0
byA0LjE0IHN0YWJsZS4gIEJ1dA0KdGhlcmUgYXJlIHNvbWUgb3RoZXIgb3BpbmlvbnMgb24gdGhh
dC4gIEl0J3Mgbm90IGNsZWFyIHRvIG1lIGlmIHRoZQ0KaGllcmFyY2hpY2FsIGRvbWFpbiBzdHVm
ZiB3b3VsZCBiZSBiYWNrIHBvcnRlZCB0byBzdGFibGUgc2VyaWVzLiAgSXQNCmRvZXMgbm90IHNl
ZW0gdG8gbWUgdG8gYmUgYSBnb29kIGlkZWEgdG8gZG8gc28uDQo=
