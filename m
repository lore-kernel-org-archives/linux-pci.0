Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE6FC282C2
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 18:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EFF2175B
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 18:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="MtdOJoNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfBGSph (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:45:37 -0500
Received: from mail-eopbgr790117.outbound.protection.outlook.com ([40.107.79.117]:9181
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726512AbfBGSph (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Feb 2019 13:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogK8PJCWrRmTGGLX05NwNaxXwnQRfZrQWSgqJDClqP4=;
 b=MtdOJoNuaFy+bML4wTF4sygroRbryBaNx8NrD/Z5KKxAGh+Nw0NTxL5gkFWtrNQj2y3iLah9d2Q488P0XJI/Gns4NPnCP1XF9DZAF4l/GQutfXI1qKrwjA0HVPFBzbsareBe4pPI4HnCdDxsyZ0YbhYSqsVcMnpLnLMFwwsUXQg=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3771.namprd06.prod.outlook.com (10.167.236.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 18:45:34 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 18:45:34 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "kishon@ti.com" <kishon@ti.com>,
        "m-karicheri2@ti.com" <m-karicheri2@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 8/9] PCI: dwc: Remove Keystone specific
 dw_pcie_host_ops
Thread-Topic: [PATCH v2 8/9] PCI: dwc: Remove Keystone specific
 dw_pcie_host_ops
Thread-Index: AQHUvtjusOUgN2+phkW0ohl7bu9V7qXUrOqA
Date:   Thu, 7 Feb 2019 18:45:34 +0000
Message-ID: <1549565133.3075.53.camel@impinj.com>
References: <20190207110924.30716-1-kishon@ti.com>
         <20190207110924.30716-9-kishon@ti.com>
In-Reply-To: <20190207110924.30716-9-kishon@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3771;6:4D4lrA854c7G+0dHHrT+q7ffv07cIuJCOKaew2PrejLjQY3NdUU1D3PYtk5KJ3BXFX2t7le4+zubQicNsfFWDD9g+VVivW4y9NinAQB0eIvi8K1OQ/lPOHTHn2e26vpcDkoi+sI6eWy8CT04g21y8HsJY2cUj7VE5zmR2UHLesECMxz1V+8mdSakX5uKkn16EageV/BIUtXfyIZxtvJwGyStJWMaglyKkQ7pwSUBpRsHXULl0DlEt/Iy81gsmDHZ9YEz20klHR4SQzU0b/NE4ls4q2Xnk2WvP/12PZwAL11GYz+WSIp8ZNN+Kx8OTPBo/BJn2x7fRx5C4bljLf2OTR9DYk0eSWkwnVxW4fRfpNkKK/eFonEuv9okkvpAVFALC2vUa8DHxvTktA9rMu3WfixFVakpMHqpHSizqKGqbBifEzPOhnfojRxU4rImgysqkywyQWE2r3eBGrqZ9kuY0Q==;5:AAlFoiFxmVpbn6fsOasnJuYz4z2f3FU5GvWghjvTd+Rgh2qGX0rf2RiXVY0Yd7Gt4ciws/zNEDa6uEuS42cKTJF5djywG5jFo+6mXIIac//k9KypSgsP0LPUJgvJSywhE8ZAomXYPsiT1e+Mc50o9k6eUd+oEchQcuH7FG7mJyjOkxzD9zCe7Yqq8gCGGbbZKAm9BiFYSWVIyxLshShlAA==;7:5LmJLF21U1YVL1LifBnualGmn6RK+zcHkQ1PjFfJ0+KMTiiNdJ6PdiKrc6+leyNbBolgtnZ8he8sY/NdiL6a3GOdBA+KeUykYUqEgRtIto7rm9jRm7jQ8nbcAqdrYev1f3JVW4CnSGhE2wPTs5TSIQ==
x-ms-office365-filtering-correlation-id: fd4c9f55-6da3-4f3a-7787-08d68d2c71ac
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3771;
x-ms-traffictypediagnostic: MWHPR0601MB3771:
x-microsoft-antispam-prvs: <MWHPR0601MB3771D869331D9EDDB951F9A7D3680@MWHPR0601MB3771.namprd06.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39850400004)(189003)(199004)(76176011)(486006)(305945005)(2501003)(25786009)(186003)(6512007)(71200400001)(26005)(71190400001)(99286004)(6436002)(2616005)(6246003)(476003)(446003)(11346002)(68736007)(7736002)(2201001)(53936002)(229853002)(6486002)(66066001)(4326008)(8936002)(2906002)(97736004)(54906003)(14454004)(110136005)(6506007)(3846002)(81156014)(8676002)(105586002)(102836004)(81166006)(106356001)(36756003)(6116002)(14444005)(316002)(256004)(478600001)(103116003)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3771;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PWh3C31cbKSXtYmJ9s4t0dfDjo9aPBOkzf23EPa4aQNTSI29RInAnGO/snqB75eGkfPPLUEypVXe6sGu5AM6HQwj2va7I4VYSF+1RawWt3IyMA9cK1ETbv32ub74vDkm4DpvV/E+UyKNWWGl8iuqsZyjnGl3/gQymotWabYRV42Lnha378ocgqE/y5JhTdOWEjp7MnGP0sjXbdtbroQNNGVB35npbN7dGXpgqqvfiiB1KWbAcwdkb53ehcGf3VPMnXj5Jn8hPm/2B7FSdwwehI59Si+JmF0Ow+p35ijFJRkMN5ZkXXhFmj2sWqcExMcdmiWl1DhxK7HUSba7K3/wk331dIPr3jvbEGOxyRe6z/Jue7KUfEn9xE86yetbkGvriwpWZQCYVOE1BR02PKiv+qhHDlr4YCPh5or/qydQcwI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5FC425849E5474AA3C97681FF948F57@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4c9f55-6da3-4f3a-7787-08d68d2c71ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 18:45:34.3498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3771
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE5LTAyLTA3IGF0IDE2OjM5ICswNTMwLCBLaXNob24gVmlqYXkgQWJyYWhhbSBJ
IHdyb3RlOg0KPiBOb3cgdGhhdCBLZXlzdG9uZSBzdGFydGVkIHVzaW5nIGl0J3Mgb3duIG1zaV9p
cnFfY2hpcCwgcmVtb3ZlDQo+IEtleXN0b25lIHNwZWNpZmljIGNhbGxiYWNrIGZ1bmN0aW9uIGRl
ZmluZWQgaW4gZHdfcGNpZV9ob3N0X29wcy4NCj4gDQo+IEBAIC0yMDksOSArMTk1LDYgQEAgc3Rh
dGljIHZvaWQgZHdfcGNpX2JvdHRvbV9hY2soc3RydWN0IGlycV9kYXRhICpkKQ0KPiAgDQo+ICAJ
ZHdfcGNpZV93cl9vd25fY29uZihwcCwgUENJRV9NU0lfSU5UUjBfU1RBVFVTICsgcmVzLCA0LCAx
IDw8IGJpdCk7DQo+ICANCj4gLQlpZiAocHAtPm9wcy0+bXNpX2lycV9hY2spDQo+IC0JCXBwLT5v
cHMtPm1zaV9pcnFfYWNrKGQtPmh3aXJxLCBwcCk7DQo+IC0NCj4gIAlyYXdfc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmcHAtPmxvY2ssIGZsYWdzKTsNCj4gIH0NCg0KQWZ0ZXIgdGhpcyBwYXRjaCwg
dGhlIGVudGlyZSBmdW5jdGlvbiBub3cgbG9va3MgbGlrZToNCg0KZHdfcGNpX2JvdHRvbV9hY2so
c3RydWN0IGlycV9kYXRhICpkKQ0Kew0KICAgICAgICBzdHJ1Y3QgcGNpZV9wb3J0ICpwcCAgPSBp
cnFfZGF0YV9nZXRfaXJxX2NoaXBfZGF0YShkKTsNCiAgICAgICAgdW5zaWduZWQgaW50IHJlcywg
Yml0LCBjdHJsOw0KICAgICAgICB1bnNpZ25lZCBsb25nIGZsYWdzOw0KDQogICAgICAgIGN0cmwg
PSBkLT5od2lycSAvIE1BWF9NU0lfSVJRU19QRVJfQ1RSTDsNCiAgICAgICAgcmVzID0gY3RybCAq
IE1TSV9SRUdfQ1RSTF9CTE9DS19TSVpFOw0KICAgICAgICBiaXQgPSBkLT5od2lycSAlIE1BWF9N
U0lfSVJRU19QRVJfQ1RSTDsNCg0KICAgICAgICByYXdfc3Bpbl9sb2NrX2lycXNhdmUoJnBwLT5s
b2NrLCBmbGFncyk7DQoNCiAgICAgICAgZHdfcGNpZV93cl9vd25fY29uZihwcCwgUENJRV9NU0lf
SU5UUjBfU1RBVFVTICsgcmVzLCA0LCAxIDw8IGJpdCk7DQoNCiAgICAgICAgcmF3X3NwaW5fdW5s
b2NrX2lycXJlc3RvcmUoJnBwLT5sb2NrLCBmbGFncyk7DQp9DQoNClRoZSBzcGluIGxvY2sgaXNu
J3QgbmVjZXNzYXJ5IGFueW1vcmUgc2luY2UgdGhlcmUgaXMgbm90aGluZyBidXQgYQ0Kc2luZ2xl
IHJlZ2lzdGVyIHdyaXRlIGluc2lkZSB0aGUgY3JpdGljYWwgc2VjdGlvbi4NCg0K
