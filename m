Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30673C04EBF
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 19:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DEC2082B
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 19:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rrz3iCXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DEC2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbeLDTI4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:08:56 -0500
Received: from mail-eopbgr130048.outbound.protection.outlook.com ([40.107.13.48]:35088
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbeLDTIz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Dec 2018 14:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iufcb/KYH2bZGgixztfQ/3Aim0D415Z6QGznpML4mNw=;
 b=rrz3iCXYNf9rVq/p7XSctb6DbH4faNy8cskfvqW7pX8f3dBEA2khOAv/bZ/08d3oRoVoC7rT/LfzB9VOOhdwtNqvv90xp9ZBRDB9Qbz+DFmavoLydJ8YEwbBL0n2d9bCxHlW1/nYQj4a2ZgjpP1j1akJLqbUArspk6U8cz9iIgA=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5613.eurprd04.prod.outlook.com (20.178.125.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.19; Tue, 4 Dec 2018 19:08:50 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::f80a:77f3:7cbf:62b5]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::f80a:77f3:7cbf:62b5%2]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 19:08:50 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "stefan@agner.ch" <stefan@agner.ch>
CC:     Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "tpiepho@impinj.com" <tpiepho@impinj.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v4 3/3] PCI: imx6: limit DBI register length
Thread-Topic: [PATCH v4 3/3] PCI: imx6: limit DBI register length
Thread-Index: AQHUi/ItnXKkv6zAjkGaBp3fo/yZWqVu8ZwA
Date:   Tue, 4 Dec 2018 19:08:50 +0000
Message-ID: <a30b8bcb6492eadba6206ba879a6530b2a5d2db9.camel@nxp.com>
References: <20181204165528.15534-1-stefan@agner.ch>
         <20181204165528.15534-3-stefan@agner.ch>
In-Reply-To: <20181204165528.15534-3-stefan@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5613;6:Ke3NQKf9Cwgpx0ALQeESjnLPQa3km6vGsyOQp94T7i5uwdGUDJ+Y2oMW/gua66SMGufz8wGq2Mt42PZ2ROIHZptfNzA6UAjhzL/V34JfynVesSLmmctySnjOtuqMBz0vSzenzK6zecGwfr/pAXPwUru+Qt7OSCdyt/pzosqhjgn9L3aiXt58bjkbvzrjthsS6JmTjT9Yeb0DK8O2s2zgQ+wKWWgmuhcVjTvtn7LLdVS2+SIbrQFth3WEJmXbf2RC61plahD69G3adbN6b85oxz0eEjk+wflf31AI7kpn+3J3M7bHMsXaGqrRRBUw2I6uMG9Mi/8MWcKNU+l3+WeJJDPfNVF+NMRiko7T1R1rwcCnMK445GMJ/XCDy60DtVMq+qqBkBNavq/46y2+ENWNjdgdLYW/LrcOfKJXOl+PHY3rtWURdOAqNOPlS/Ps7QMu1EJ1tMKwQS5boDBasu+nNw==;5:uwr+VMvD210U6UMzxMb3cNJfSGzCuUJwfPxR3xg6qgvhcCiERXHxfdsp8GgnCUM0SHM02E0u8PQSEYJGUdtJ65PRQOSAQMxnFI74wol0tqJ7hOystZQ3W4haDG6JBgFvf9wPIhntlKwBqZhdX8MVG2/Eg1LrZzvcbkrxJ///U0c=;7:/SvJdZQqZPQ7p+wv9zS0KeYR9WD2ZB6EmZ920BS0VRHF/lXLaw1S5a5DUgrdW3ED0BFvy54OnK1jrO+IsIzMKd8hR/V4t0RspAFePaNzURuzquLsKOWcoq6/fJBTDHY4JuB05XseqYqr2PtiBXMnGQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 98c1b97c-2498-4847-2423-08d65a1bed0c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5613;
x-ms-traffictypediagnostic: VI1PR04MB5613:
x-microsoft-antispam-prvs: <VI1PR04MB561313F6C76F46BC1167619EEEAF0@VI1PR04MB5613.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5613;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5613;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(68736007)(99286004)(105586002)(71200400001)(71190400001)(305945005)(2906002)(6916009)(102836004)(106356001)(2351001)(5660300001)(7736002)(25786009)(14444005)(256004)(2501003)(186003)(97736004)(229853002)(76176011)(6486002)(14454004)(26005)(86362001)(36756003)(53936002)(54906003)(6116002)(1730700003)(44832011)(8676002)(118296001)(3846002)(4326008)(81156014)(81166006)(50226002)(478600001)(446003)(316002)(486006)(6512007)(8936002)(2616005)(6436002)(6506007)(6246003)(11346002)(5640700003)(476003)(39060400002)(66066001)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5613;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7Xrlp8Ey7CgvsFLQ/eWUtxs2hIO/UjQdwIAmhUzVJM7VsnpKxCCpW/bk8pj8GBEV3tUnUFBM0xCsEy0B/GXMR2k1nrPWV3uL9u7WFlKmK7Jk2tDuLxMz0BK4KQVk3g10kOKn2JBGmWiTG46MKPDekq6NDsOFXII79V/sFzcYEGECnBT7NQOItsC7HGm6RDa0PVEdcxP2ZqvKdE/O68dKS9i6xmiT8U2hZS14MvOkXEzbkFy7gH1yOuFOqJWTQwLdcnV606q+/1QV8wRQz54UJmfyanF1pDqRV8ZzTPPzsCekTzz+PIBKvYBUNpSu/P7ImXKYuG/ghi9d+qHYDaTBYKRDV6nvOmbmU2Z0cUDYClU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FDC838BFB74FF4081A5D9D64B995F0B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c1b97c-2498-4847-2423-08d65a1bed0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 19:08:50.6165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5613
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE4LTEyLTA0IGF0IDE3OjU1ICswMTAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IERlZmluZSB0aGUgbGVuZ3RoIG9mIHRoZSBEQkkgcmVnaXN0ZXJzLiBUaGlzIG1ha2VzIHN1cmUg
dGhhdA0KPiB0aGUga2VybmVsIGRvZXMgbm90IGFjY2VzcyByZWdpc3RlcnMgYmV5b25kIHRoYXQg
cG9pbnQsIGF2b2lkaW5nDQo+IHRoZSBmb2xsb3dpbmcgYWJvcnQgb24gYSBpLk1YIDZRdWFkOg0K
PiAgICMgY2F0IC9zeXMvZGV2aWNlcy9zb2MwL3NvYy8xZmZjMDAwLnBjaWUvcGNpMDAwMFw6MDAv
MDAwMFw6MDBcOjAwLjAvY29uZmlnDQo+ICAgWyAgMTAwLjAyMTQzM10gVW5oYW5kbGVkIGZhdWx0
OiBpbXByZWNpc2UgZXh0ZXJuYWwgYWJvcnQgKDB4MTQwNikgYXQgMHhiNmVhNzAwMA0KPiAgIC4u
Lg0KPiAgIFsgIDEwMC4wNTY0MjNdIFBDIGlzIGF0IGR3X3BjaWVfcmVhZCsweDUwLzB4ODQNCj4g
ICBbICAxMDAuMDYwNzkwXSBMUiBpcyBhdCBkd19wY2llX3JkX293bl9jb25mKzB4NDQvMHg0OA0K
PiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaW14Nl9wY2llX2RydmRhdGEgZHJ2ZGF0YVtdID0g
ew0KPiAtCVtJTVg2UV0gPSB7IC52YXJpYW50ID0gSU1YNlEgfSwNCj4gKwlbSU1YNlFdID0geyAu
dmFyaWFudCA9IElNWDZRLCAuZGJpX2xlbmd0aCA9IDB4MTVjIH0sDQo+ICAJW0lNWDZTWF0gPSB7
IC52YXJpYW50ID0gSU1YNlNYIH0sDQo+ICAJW0lNWDZRUF0gPSB7IC52YXJpYW50ID0gSU1YNlFQ
IH0sDQo+ICAJW0lNWDdEXSA9IHsgLnZhcmlhbnQgPSBJTVg3RCB9LA0KDQpBbHNvIHNlZW1zIHRv
IGFmZmVjdCBJTVg2UVAgdmFyaWFudCAoYnV0IG5vdCBvdGhlcnMpLg0KDQpMdWNhcyBzdWdnZXN0
ZWQgMHgxNWMgYmVjYXVzZSB0aGF0J3MgdGhlIGxhc3QgcmVnaXN0ZXIgZG9jdW1lbnRlZCBpbg0K
dGhlIGRhdGFzaGVldCBidXQgdGhlIHJlYWwgSFcgbGltaXQgaXMgMHgyMDAsIHdvdWxkbid0IGl0
IG1ha2UgbW9yZQ0Kc2Vuc2UgdG8gdXNlIHRoYXQ/DQoNCi0tDQpSZWdhcmRzLA0KTGVvbmFyZA0K
