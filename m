Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF52BC10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8170421872
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 08:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RPbsEw4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfDLIhE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:37:04 -0400
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:38403
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727279AbfDLIhE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 04:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYJ9WCpyA8Tb2vN+8zCIgMdl2noAhzwvzErWOpfZhcg=;
 b=RPbsEw4cIGZ0s+j5Deo1xVWwJq24Oiu/HQE+tkjoyck/X5ixZ+iAFh6rp5mJU5vblPZnCD2bDwm2ETcWU5ZlfOQVkIkpj+5VLc0kerLc75mDGeSxGKiZhNKbbB1kvs3k+cyg+PZJ9MwYenvSaIgpeinH0Q2HNdPiAACSxvf35ZQ=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5846.eurprd04.prod.outlook.com (20.179.3.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.18; Fri, 12 Apr 2019 08:37:00 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 08:37:00 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv5 18/20] PCI: mobiveil: Disable IB and OB windows set by
 bootloader
Thread-Topic: [PATCHv5 18/20] PCI: mobiveil: Disable IB and OB windows set by
 bootloader
Thread-Index: AQHU8Qrl2X2dZdmZtkqqPC5pUtT6KA==
Date:   Fri, 12 Apr 2019 08:37:00 +0000
Message-ID: <20190412083635.33626-19-Zhiqiang.Hou@nxp.com>
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:202:2e::23) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1de61a70-4c30-48c3-756d-08d6bf220794
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5846;
x-ms-traffictypediagnostic: AM6PR04MB5846:
x-microsoft-antispam-prvs: <AM6PR04MB5846C60C1D8D2D85FBC737E584280@AM6PR04MB5846.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(486006)(478600001)(2616005)(476003)(316002)(446003)(11346002)(305945005)(7736002)(81166006)(25786009)(81156014)(256004)(14454004)(8676002)(7416002)(4326008)(186003)(50226002)(26005)(8936002)(68736007)(2906002)(53936002)(102836004)(6512007)(66066001)(86362001)(99286004)(106356001)(6116002)(3846002)(6436002)(97736004)(1076003)(6506007)(386003)(52116002)(2201001)(105586002)(6486002)(36756003)(71200400001)(110136005)(54906003)(5660300002)(2501003)(71190400001)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5846;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UTLqI3Xaa4/Sazab2LnbMbOtUZ02NZ4Kx6jHySdPKvITaAxCjFRz5dhEFVzuv29rCw8UKuW2lt8jK2u21Qim9IMW3zvsEp9U23Uvnwc+q7vm8tEt4x1ZaZDpRgbKHTJ4+lCLyikAHHE98CYrxwdtG7BL9nTCN+3tlv5G70WH4nnLwQA4zET6kFNBNPke776GFyQNnMyP+LwAsSxWLrDfkZF4blxOyJYAfKbz/seVZmRW80+d3l7kEOCJNSFwwDtRENoFNtQAulsgbHVPN2vA8Hf+dt3sP3iMff8G+/t3fRet0k4pQM6bKYdxfSSpFKuR0cxITHb/D6FzK0LOLWGUpyaN7BFtEazbcUhqrpzzrrEeSeIGVmn8TE4982gDnsQrh+kjxzZ5gA7tCbeqVs0E1B/lbyG8PG4ER3Ndgf9ygTc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de61a70-4c30-48c3-756d-08d6bf220794
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 08:37:00.0169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5846
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KRGlzYWJsZSBhbGwg
aW5ib3VuZCBhbmQgb3V0Ym91bmQgd2luZG93cyBiZWZvcmUgc2V0IHVwIHRoZSB3aW5kb3dzDQpp
biBrZXJuZWwsIGluIGNhc2UgdHJhbnNhY3Rpb25zIG1hdGNoIHRoZSB3aW5kb3cgc2V0IGJ5IGJv
b3Rsb2FkZXIuDQoNClNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54
cC5jb20+DQpSZXZpZXdlZC1ieTogTWluZ2h1YW4gTGlhbiA8TWluZ2h1YW4uTGlhbkBueHAuY29t
Pg0KUmV2aWV3ZWQtYnk6IFN1YnJhaG1hbnlhIExpbmdhcHBhIDxsLnN1YnJhaG1hbnlhQG1vYml2
ZWlsLmNvLmluPg0KLS0tDQpWNToNCiAtIE5vIGZ1bmN0aW9uYWxpdHkgY2hhbmdlLg0KDQogZHJp
dmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMgfCAyNSArKysrKysrKysrKysrKysr
KysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jIGIvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCmluZGV4IDhkYzg3YzdhNjAwZS4uNDExZTk3Nzlk
YTEyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMN
CisrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQpAQCAtNTY1LDYg
KzU2NSwyNCBAQCBzdGF0aWMgaW50IG1vYml2ZWlsX2JyaW5ndXBfbGluayhzdHJ1Y3QgbW9iaXZl
aWxfcGNpZSAqcGNpZSkNCiAJcmV0dXJuIC1FVElNRURPVVQ7DQogfQ0KIA0KK3N0YXRpYyB2b2lk
IG1vYml2ZWlsX3BjaWVfZGlzYWJsZV9pYl93aW4oc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUs
IGludCBpZHgpDQorew0KKwl1MzIgdmFsOw0KKw0KKwl2YWwgPSBjc3JfcmVhZGwocGNpZSwgUEFC
X1BFWF9BTUFQX0NUUkwoaWR4KSk7DQorCXZhbCAmPSB+KDEgPDwgQU1BUF9DVFJMX0VOX1NISUZU
KTsNCisJY3NyX3dyaXRlbChwY2llLCB2YWwsIFBBQl9QRVhfQU1BUF9DVFJMKGlkeCkpOw0KK30N
CisNCitzdGF0aWMgdm9pZCBtb2JpdmVpbF9wY2llX2Rpc2FibGVfb2Jfd2luKHN0cnVjdCBtb2Jp
dmVpbF9wY2llICpwY2llLCBpbnQgaWR4KQ0KK3sNCisJdTMyIHZhbDsNCisNCisJdmFsID0gY3Ny
X3JlYWRsKHBjaWUsIFBBQl9BWElfQU1BUF9DVFJMKGlkeCkpOw0KKwl2YWwgJj0gfigxIDw8IFdJ
Tl9FTkFCTEVfU0hJRlQpOw0KKwljc3Jfd3JpdGVsKHBjaWUsIHZhbCwgUEFCX0FYSV9BTUFQX0NU
UkwoaWR4KSk7DQorfQ0KKw0KIHN0YXRpYyB2b2lkIG1vYml2ZWlsX3BjaWVfZW5hYmxlX21zaShz
dHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSkNCiB7DQogCXBoeXNfYWRkcl90IG1zZ19hZGRyID0g
cGNpZS0+cGNpZV9yZWdfYmFzZTsNCkBAIC01ODUsNiArNjAzLDEzIEBAIHN0YXRpYyBpbnQgbW9i
aXZlaWxfaG9zdF9pbml0KHN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2llKQ0KIHsNCiAJdTMyIHZh
bHVlLCBwYWJfY3RybCwgdHlwZTsNCiAJc3RydWN0IHJlc291cmNlX2VudHJ5ICp3aW47DQorCWlu
dCBpOw0KKw0KKwkvKiBEaXNhYmxlIGFsbCBpbmJvdW5kL291dGJvdW5kIHdpbmRvd3MgKi8NCisJ
Zm9yIChpID0gMDsgaSA8IHBjaWUtPmFwaW9fd2luczsgaSsrKQ0KKwkJbW9iaXZlaWxfcGNpZV9k
aXNhYmxlX29iX3dpbihwY2llLCBpKTsNCisJZm9yIChpID0gMDsgaSA8IHBjaWUtPnBwaW9fd2lu
czsgaSsrKQ0KKwkJbW9iaXZlaWxfcGNpZV9kaXNhYmxlX2liX3dpbihwY2llLCBpKTsNCiANCiAJ
Lyogc2V0dXAgYnVzIG51bWJlcnMgKi8NCiAJdmFsdWUgPSBjc3JfcmVhZGwocGNpZSwgUENJX1BS
SU1BUllfQlVTKTsNCi0tIA0KMi4xNy4xDQoNCg==
