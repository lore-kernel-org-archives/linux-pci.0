Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA29BC10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 09:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BE820850
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 09:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tOiyCqfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfDLJxI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:53:08 -0400
Received: from mail-eopbgr10063.outbound.protection.outlook.com ([40.107.1.63]:5486
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbfDLJxH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 05:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niSVCcyvZ343FazRbY/V+8LCerHY8iZmF9F1kAfqcx0=;
 b=tOiyCqfcCKISyU+8nIhZz8tqtee1yfcUwff/xBjXFxqi7OtOHfKpcHHQPsiTGh1h/Cd+dsMmxwMBDrapbUv/MLiAFT8Y/WLaVrE/zZb23K3gtiVx0EYLlBsHuddfXG9mDrJHmGGs9oqMlycl5Ex/GQblw/+84GHIIKuITX/b8rc=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB6262.eurprd04.prod.outlook.com (20.179.7.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Fri, 12 Apr 2019 09:52:49 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::f9db:ed86:614e:460%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 09:52:49 +0000
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
Subject: [PATCHv5 2/6] PCI: mobiveil: Make mobiveil_host_init() can be used to
 re-init host
Thread-Topic: [PATCHv5 2/6] PCI: mobiveil: Make mobiveil_host_init() can be
 used to re-init host
Thread-Index: AQHU8RV1khI4cxiNjkCCaSmPXzhcmg==
Date:   Fri, 12 Apr 2019 09:52:36 +0000
Message-ID: <20190412095332.41370-3-Zhiqiang.Hou@nxp.com>
References: <20190412095332.41370-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190412095332.41370-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0210.apcprd02.prod.outlook.com
 (2603:1096:201:20::22) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7fbed1a7-a606-47f4-bf34-08d6bf2c9755
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB6262;
x-ms-traffictypediagnostic: AM6PR04MB6262:
x-microsoft-antispam-prvs: <AM6PR04MB6262DED310A5D077AD8018EA84280@AM6PR04MB6262.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(376002)(396003)(39860400002)(199004)(189003)(68736007)(81156014)(3846002)(66066001)(26005)(76176011)(81166006)(86362001)(2201001)(102836004)(186003)(386003)(7736002)(50226002)(7416002)(8676002)(2906002)(6506007)(8936002)(305945005)(5660300002)(6116002)(14444005)(4326008)(476003)(478600001)(25786009)(486006)(256004)(2616005)(105586002)(71190400001)(446003)(110136005)(6512007)(11346002)(1076003)(53936002)(14454004)(52116002)(6436002)(6486002)(71200400001)(54906003)(2501003)(36756003)(106356001)(6666004)(316002)(99286004)(97736004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6262;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3tlS+AcOmAwVQl67KZHYSvGu/g90T/P/0VWjLkOBQ3k+zIZJtFrC5XG1xMSCxmz55Q+rZxEnysSi8g9jYJxAzVGex2eX9fvs4/WsjMcwFwZu/o4ZIqEQWeO2P3XzZJX1vI1QQqJq4Z16+KdnjO+g5DoPQ1ab2x/yFNkKaFcVJJenkThmfNixlGNN36WZ9z6ZMDa4EVJzO7g74ZAF/YelA1LmODO+qk9PhiT6l5sg795tS83RUwg920or6Pjx2+c4DYbb1F79r31k/ufLbDz+Zcj8vD3foflmyygX7T/zIuusROyaWlDwl0yqvKnOkb+o1ttdMr6MCg93UJkUuuD3wmLaOaIyi/Z3nHQW1qBVJOpW8JHvDvtbFi8wSmecII1ZVJWlNRKAg8tlvjTuxdxbhHp1RzNnqPxqrfghkq48kNI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fbed1a7-a606-47f4-bf34-08d6bf2c9755
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 09:52:36.0651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6262
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KTWFrZSB0aGUgbW9i
aXZlaWxfaG9zdF9pbml0KCkgZnVuY3Rpb24gY2FuIGJlIHVzZWQgdG8gcmUtaW5pdA0KaG9zdCBj
b250cm9sbGVyJ3MgUEFCIGFuZCBHUEVYIENTUiByZWdpc3RlciBibG9jaywgYXMgTlhQDQppbnRl
Z3JhdGVkIE1vYml2ZWlsIElQIGhhcyB0byByZXNldCBhbmQgdGhlbiByZS1pbml0IHRoZSBQQUIN
CmFuZCBHUEVYIENTUiByZWdpc3RlcnMgdXBvbiBob3QtcmVzZXQuDQoNClNpZ25lZC1vZmYtYnk6
IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQpSZXZpZXdlZC1ieTogU3VicmFo
bWFueWEgTGluZ2FwcGEgPGwuc3VicmFobWFueWFAbW9iaXZlaWwuY28uaW4+DQotLS0NClY1Og0K
IC0gQ29ycmVjdGVkIHRoZSBzdWJqZWN0Lg0KDQogLi4uL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNp
ZS1tb2JpdmVpbC1ob3N0LmMgIHwgNDEgKysrKysrKysrKy0tLS0tLS0tLQ0KIC4uLi9wY2kvY29u
dHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmggICB8ICAzICstDQogMiBmaWxlcyBjaGFu
Z2VkLCAyMyBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC1ob3N0LmMgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwtaG9zdC5jDQppbmRleCBl
YmE5MGI2YjkxYjQuLjZjZTQ5NjQ4OTA5YSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC1ob3N0LmMNCisrKyBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC1ob3N0LmMNCkBAIC0yMTksNyArMjE5LDcg
QEAgc3RhdGljIHZvaWQgbW9iaXZlaWxfcGNpZV9lbmFibGVfbXNpKHN0cnVjdCBtb2JpdmVpbF9w
Y2llICpwY2llKQ0KIAl3cml0ZWxfcmVsYXhlZCgxLCBwY2llLT5hcGJfY3NyX2Jhc2UgKyBNU0lf
RU5BQkxFX09GRlNFVCk7DQogfQ0KIA0KLXN0YXRpYyBpbnQgbW9iaXZlaWxfaG9zdF9pbml0KHN0
cnVjdCBtb2JpdmVpbF9wY2llICpwY2llKQ0KK2ludCBtb2JpdmVpbF9ob3N0X2luaXQoc3RydWN0
IG1vYml2ZWlsX3BjaWUgKnBjaWUsIGJvb2wgcmVpbml0KQ0KIHsNCiAJdTMyIHZhbHVlLCBwYWJf
Y3RybCwgdHlwZTsNCiAJc3RydWN0IHJlc291cmNlX2VudHJ5ICp3aW47DQpAQCAtMjMxLDExICsy
MzEsMTYgQEAgc3RhdGljIGludCBtb2JpdmVpbF9ob3N0X2luaXQoc3RydWN0IG1vYml2ZWlsX3Bj
aWUgKnBjaWUpDQogCWZvciAoaSA9IDA7IGkgPCBwY2llLT5wcGlvX3dpbnM7IGkrKykNCiAJCW1v
Yml2ZWlsX3BjaWVfZGlzYWJsZV9pYl93aW4ocGNpZSwgaSk7DQogDQotCS8qIHNldHVwIGJ1cyBu
dW1iZXJzICovDQotCXZhbHVlID0gY3NyX3JlYWRsKHBjaWUsIFBDSV9QUklNQVJZX0JVUyk7DQot
CXZhbHVlICY9IDB4ZmYwMDAwMDA7DQotCXZhbHVlIHw9IDB4MDBmZjAxMDA7DQotCWNzcl93cml0
ZWwocGNpZSwgdmFsdWUsIFBDSV9QUklNQVJZX0JVUyk7DQorCXBjaWUtPmliX3dpbnNfY29uZmln
dXJlZCA9IDA7DQorCXBjaWUtPm9iX3dpbnNfY29uZmlndXJlZCA9IDA7DQorDQorCWlmICghcmVp
bml0KSB7DQorCQkvKiBzZXR1cCBidXMgbnVtYmVycyAqLw0KKwkJdmFsdWUgPSBjc3JfcmVhZGwo
cGNpZSwgUENJX1BSSU1BUllfQlVTKTsNCisJCXZhbHVlICY9IDB4ZmYwMDAwMDA7DQorCQl2YWx1
ZSB8PSAweDAwZmYwMTAwOw0KKwkJY3NyX3dyaXRlbChwY2llLCB2YWx1ZSwgUENJX1BSSU1BUllf
QlVTKTsNCisJfQ0KIA0KIAkvKg0KIAkgKiBwcm9ncmFtIEJ1cyBNYXN0ZXIgRW5hYmxlIEJpdCBp
biBDb21tYW5kIFJlZ2lzdGVyIGluIFBBQiBDb25maWcNCkBAIC0yODEsNyArMjg2LDcgQEAgc3Rh
dGljIGludCBtb2JpdmVpbF9ob3N0X2luaXQoc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUpDQog
CXByb2dyYW1faWJfd2luZG93cyhwY2llLCBXSU5fTlVNXzAsIDAsIDAsIE1FTV9XSU5ET1dfVFlQ
RSwgSUJfV0lOX1NJWkUpOw0KIA0KIAkvKiBHZXQgdGhlIEkvTyBhbmQgbWVtb3J5IHJhbmdlcyBm
cm9tIERUICovDQotCXJlc291cmNlX2xpc3RfZm9yX2VhY2hfZW50cnkod2luLCAmcGNpZS0+cmVz
b3VyY2VzKSB7DQorCXJlc291cmNlX2xpc3RfZm9yX2VhY2hfZW50cnkod2luLCBwY2llLT5yZXNv
dXJjZXMpIHsNCiAJCWlmIChyZXNvdXJjZV90eXBlKHdpbi0+cmVzKSA9PSBJT1JFU09VUkNFX01F
TSkgew0KIAkJCXR5cGUgPSBNRU1fV0lORE9XX1RZUEU7DQogCQl9IGVsc2UgaWYgKHJlc291cmNl
X3R5cGUod2luLT5yZXMpID09IElPUkVTT1VSQ0VfSU8pIHsNCkBAIC01NTIsOCArNTU3LDYgQEAg
aW50IG1vYml2ZWlsX3BjaWVfaG9zdF9wcm9iZShzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSkN
CiAJcmVzb3VyY2Vfc2l6ZV90IGlvYmFzZTsNCiAJaW50IHJldDsNCiANCi0JSU5JVF9MSVNUX0hF
QUQoJnBjaWUtPnJlc291cmNlcyk7DQotDQogCXJldCA9IG1vYml2ZWlsX3BjaWVfcGFyc2VfZHQo
cGNpZSk7DQogCWlmIChyZXQpIHsNCiAJCWRldl9lcnIoZGV2LCAiUGFyc2luZyBEVCBmYWlsZWQs
IHJldDogJXhcbiIsIHJldCk7DQpAQCAtNTY3LDM0ICs1NzAsMzUgQEAgaW50IG1vYml2ZWlsX3Bj
aWVfaG9zdF9wcm9iZShzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSkNCiANCiAJLyogcGFyc2Ug
dGhlIGhvc3QgYnJpZGdlIGJhc2UgYWRkcmVzc2VzIGZyb20gdGhlIGRldmljZSB0cmVlIGZpbGUg
Ki8NCiAJcmV0ID0gZGV2bV9vZl9wY2lfZ2V0X2hvc3RfYnJpZGdlX3Jlc291cmNlcyhkZXYsIDAs
IDB4ZmYsDQotCQkJCQkJICAgICZwY2llLT5yZXNvdXJjZXMsICZpb2Jhc2UpOw0KKwkJCQkJCSAg
ICAmYnJpZGdlLT53aW5kb3dzLCAmaW9iYXNlKTsNCiAJaWYgKHJldCkgew0KIAkJZGV2X2Vycihk
ZXYsICJHZXR0aW5nIGJyaWRnZSByZXNvdXJjZXMgZmFpbGVkXG4iKTsNCiAJCXJldHVybiByZXQ7
DQogCX0NCiANCisJcGNpZS0+cmVzb3VyY2VzID0gJmJyaWRnZS0+d2luZG93czsNCisNCiAJLyoN
CiAJICogY29uZmlndXJlIGFsbCBpbmJvdW5kIGFuZCBvdXRib3VuZCB3aW5kb3dzIGFuZCBwcmVw
YXJlIHRoZSBSQyBmb3INCiAJICogY29uZmlnIGFjY2Vzcw0KIAkgKi8NCi0JcmV0ID0gbW9iaXZl
aWxfaG9zdF9pbml0KHBjaWUpOw0KKwlyZXQgPSBtb2JpdmVpbF9ob3N0X2luaXQocGNpZSwgZmFs
c2UpOw0KIAlpZiAocmV0KSB7DQogCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBpbml0aWFsaXpl
IGhvc3RcbiIpOw0KLQkJZ290byBlcnJvcjsNCisJCXJldHVybiByZXQ7DQogCX0NCiANCiAJcmV0
ID0gbW9iaXZlaWxfcGNpZV9pbnRlcnJ1cHRfaW5pdChwY2llKTsNCiAJaWYgKHJldCkgew0KIAkJ
ZGV2X2VycihkZXYsICJJbnRlcnJ1cHQgaW5pdCBmYWlsZWRcbiIpOw0KLQkJZ290byBlcnJvcjsN
CisJCXJldHVybiByZXQ7DQogCX0NCiANCi0JcmV0ID0gZGV2bV9yZXF1ZXN0X3BjaV9idXNfcmVz
b3VyY2VzKGRldiwgJnBjaWUtPnJlc291cmNlcyk7DQorCXJldCA9IGRldm1fcmVxdWVzdF9wY2lf
YnVzX3Jlc291cmNlcyhkZXYsIHBjaWUtPnJlc291cmNlcyk7DQogCWlmIChyZXQpDQotCQlnb3Rv
IGVycm9yOw0KKwkJcmV0dXJuIHJldDsNCiANCiAJLyogSW5pdGlhbGl6ZSBicmlkZ2UgKi8NCi0J
bGlzdF9zcGxpY2VfaW5pdCgmcGNpZS0+cmVzb3VyY2VzLCAmYnJpZGdlLT53aW5kb3dzKTsNCiAJ
YnJpZGdlLT5kZXYucGFyZW50ID0gZGV2Ow0KIAlicmlkZ2UtPnN5c2RhdGEgPSBwY2llOw0KIAli
cmlkZ2UtPmJ1c25yID0gcGNpZS0+cnAucm9vdF9idXNfbnI7DQpAQCAtNjA5LDcgKzYxMyw3IEBA
IGludCBtb2JpdmVpbF9wY2llX2hvc3RfcHJvYmUoc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUp
DQogCS8qIHNldHVwIHRoZSBrZXJuZWwgcmVzb3VyY2VzIGZvciB0aGUgbmV3bHkgYWRkZWQgUENJ
ZSByb290IGJ1cyAqLw0KIAlyZXQgPSBwY2lfc2Nhbl9yb290X2J1c19icmlkZ2UoYnJpZGdlKTsN
CiAJaWYgKHJldCkNCi0JCWdvdG8gZXJyb3I7DQorCQlyZXR1cm4gcmV0Ow0KIA0KIAlidXMgPSBi
cmlkZ2UtPmJ1czsNCiANCkBAIC02MTksNyArNjIzLDQgQEAgaW50IG1vYml2ZWlsX3BjaWVfaG9z
dF9wcm9iZShzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSkNCiAJcGNpX2J1c19hZGRfZGV2aWNl
cyhidXMpOw0KIA0KIAlyZXR1cm4gMDsNCi1lcnJvcjoNCi0JcGNpX2ZyZWVfcmVzb3VyY2VfbGlz
dCgmcGNpZS0+cmVzb3VyY2VzKTsNCi0JcmV0dXJuIHJldDsNCiB9DQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmggYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwuaA0KaW5kZXggNDRkNmM0ZTMwYzA5
Li41ZWVjYjJmYzAzOWQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2
ZWlsL3BjaWUtbW9iaXZlaWwuaA0KKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVp
bC9wY2llLW1vYml2ZWlsLmgNCkBAIC0xNTQsNyArMTU0LDcgQEAgc3RydWN0IG1vYml2ZWlsX3Bh
Yl9vcHMgew0KIA0KIHN0cnVjdCBtb2JpdmVpbF9wY2llIHsNCiAJc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldjsNCi0Jc3RydWN0IGxpc3RfaGVhZCByZXNvdXJjZXM7DQorCXN0cnVjdCBsaXN0
X2hlYWQgKnJlc291cmNlczsNCiAJdm9pZCBfX2lvbWVtICpjc3JfYXhpX3NsYXZlX2Jhc2U7CS8q
IFBBQiByZWdpc3RlcnMgYmFzZSAqLw0KIAlwaHlzX2FkZHJfdCBwY2llX3JlZ19iYXNlOwkvKiBQ
aHlzaWNhbCBQQ0llIENvbnRyb2xsZXIgQmFzZSAqLw0KIAl2b2lkIF9faW9tZW0gKmFwYl9jc3Jf
YmFzZTsJLyogTVNJIHJlZ2lzdGVyIGJhc2UgKi8NCkBAIC0xNjcsNiArMTY3LDcgQEAgc3RydWN0
IG1vYml2ZWlsX3BjaWUgew0KIH07DQogDQogaW50IG1vYml2ZWlsX3BjaWVfaG9zdF9wcm9iZShz
dHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSk7DQoraW50IG1vYml2ZWlsX2hvc3RfaW5pdChzdHJ1
Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSwgYm9vbCByZWluaXQpOw0KIGJvb2wgbW9iaXZlaWxfcGNp
ZV9saW5rX3VwKHN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2llKTsNCiBpbnQgbW9iaXZlaWxfYnJp
bmd1cF9saW5rKHN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2llKTsNCiB2b2lkIHByb2dyYW1fb2Jf
d2luZG93cyhzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSwgaW50IHdpbl9udW0sIHU2NCBjcHVf
YWRkciwNCi0tIA0KMi4xNy4xDQoNCg==
