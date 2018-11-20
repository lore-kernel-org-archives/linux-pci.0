Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522F6C43610
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110F82075B
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 09:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nf/edX+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110F82075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbeKTTxt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:53:49 -0500
Received: from mail-eopbgr150055.outbound.protection.outlook.com ([40.107.15.55]:5488
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727008AbeKTTxs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 14:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0x/a/C1xrqSPW8jXEM0kO85Dfq2DE5CHesRGrOy+TRs=;
 b=nf/edX+tUu0mXT8QGudFwRpWlkV4Y7Mk2cSNfaVIcwhqqDfH41joxsqHSDNdKKRqJvZjltDOIhDHSqj0WJGBN17pqqAxD8rDfUSDVWmVRVpOkLGQf7a6Vk9QtJ98clmndlYrHhRDcSc62N5UvOUJfhRG8l2DpyEPm/IaWvktrQ4=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.2.80) by
 AM6PR04MB4951.eurprd04.prod.outlook.com (20.177.33.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.24; Tue, 20 Nov 2018 09:25:35 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::29b5:b3ed:3854:cf1c%4]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 09:25:35 +0000
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
Subject: [PATCHv2 00/25] PCI: refactor Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Topic: [PATCHv2 00/25] PCI: refactor Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Index: AQHUgLL+3haSNWHwCUuT1m1UFMihrw==
Date:   Tue, 20 Nov 2018 09:25:35 +0000
Message-ID: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR03CA0050.apcprd03.prod.outlook.com
 (2603:1096:202:17::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4951;6:YSkODMLjaXWqbylcqdNtQMIEiwwggXcFEMfUDXfo9Legqb4Yq4xDwtuQNmMC03gOAFp086DIhblvbx8N8/8C9wfOpes/tV33ciV4JEeUBdwCxAIbI7ZHPebC8vmEWrBtvo2C43+M3ksN/azZoVT5rnpg2Ioh6PcznLJ5lfc1Bh2AdrpCrrO2M5fq/+YQHYzpKtPnpgK4vtdX95tBxv0j/Q2pLfUU1Xj/1dfvebOBAyzaOJZPzOy0U90Dq7pFsSNJxByU9+RSybpkHaA2PyTqwZHcZcidVN70HVnhviLJAF0b/bQGYeZCHNjiMBS5bRP+tpKAYBEG7JEXqdLSUeWmRtGlZGjOVX89UNwXzOnKUnHPnAT4KdOaPLHny513acu1naKc0XTqmpk10ZlItuimQmSPWhA+lO+GCfeqlM3xubt5cfxNo3JFE+KLU423V7P3ATUvaI6BcH/3/Y+vUXFMQw==;5:qe/I9oVh4X+aN6AdmQx9LaXkVrQjqO9zfO8D08gVNVTyCm+Af0/7V8TjpzcAGwtB5dJBZm2nDciHHaesy7N/bskJyhe4NXPWQTLHkE774DITySOta5TtlJIvZrbqsh0/qq9TvHg5ear4mj0xKFTd7lCf8UjfRRkMWwKXRTtMV/s=;7:odIaNqVvewTCcb/Z8qf6J7qQ50q6XQfPJxlexYFfGHrd+HgdwPZeFLEsELsKShrRpKN6M0TzqH/HMvkpmAiHwKSFAUgkRVIU4Kp7LzsTg9JnYivqQESsA4J8oHwM/ZAHqNHL3LT5qv76rBzN2m7pMw==
x-ms-office365-filtering-correlation-id: 8ba2b1c5-d655-4cbb-75a5-08d64eca204c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4951;
x-ms-traffictypediagnostic: AM6PR04MB4951:
x-microsoft-antispam-prvs: <AM6PR04MB495119440F59FBE9B7EAD60584D90@AM6PR04MB4951.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(10201501046)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4951;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4951;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(366004)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(6486002)(2501003)(25786009)(1076002)(6116002)(97736004)(3846002)(71200400001)(14444005)(71190400001)(2201001)(386003)(26005)(86362001)(478600001)(4326008)(52116002)(256004)(6506007)(99286004)(186003)(14454004)(106356001)(7736002)(6512007)(105586002)(81166006)(102836004)(6436002)(7416002)(5660300001)(8676002)(2906002)(8936002)(81156014)(36756003)(2900100001)(68736007)(486006)(316002)(305945005)(54906003)(476003)(2616005)(110136005)(53936002)(66066001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4951;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: akVm7cxR5v4Vwe9jts/s/AkPYo0NxvpXC5T0DBhQwN/705IshsaFsk0sOl1skFiVadpxDW00iAgvr+9FpAgz7YgtoVFfiIrW1wcmofEwACUJpKA1c/vrewVEI2iIpHd1uTD+mO/T3WBnyOQXXfbRQpeRlr7yuujyc8IqX5t/O+aYzxzxOCtIaGSmvDVVFEPv9p4G0ElyUcJo070xYeotSPncPE9qnWic7yUrQBANRvZ8fvAegO1x8OgxKXkF/zn6ck+QqaqJHjyhSKxpj2iffwxSGkBOwk8Nopnj3ORNDf7SDNFj93fac7jE0B14BdAY2t2jNZaE5T9VXVbEhSxnkPgvU8UovBUKCRSYxjpeTWs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <271BC4ECABA03944A8CB21D6BE095D7C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba2b1c5-d655-4cbb-75a5-08d64eca204c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 09:25:35.5652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4951
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KVGhpcyBwYXRjaCBz
ZXQgaXMgYWltIHRvIHJlZmFjdG9yIHRoZSBNb2JpdmVpbCBkcml2ZXIgYW5kIGFkZA0KUENJZSBz
dXBwb3J0IGZvciBOWFAgTGF5ZXJzY2FwZSBzZXJpZXMgU29DcyBpbnRlZ3JhdGVkIE1vYml2ZWls
J3MNClBDSWUgR2VuNCBjb250cm9sbGVyLg0KDQpIb3UgWmhpcWlhbmcgKDI1KToNCiAgUENJOiBt
b2JpdmVpbDogdW5pZm9ybSB0aGUgcmVnaXN0ZXIgYWNjZXNzb3JzDQogIFBDSTogbW9iaXZlaWw6
IGZvcm1hdCB0aGUgY29kZSB3aXRob3V0IGZ1bmN0aW9uIGNoYW5nZQ0KICBQQ0k6IG1vYml2ZWls
OiBjb3JyZWN0IHRoZSByZXR1cm5lZCBlcnJvciBudW1iZXINCiAgUENJOiBtb2JpdmVpbDogcmVt
b3ZlIGZsYWcgTVNJX0ZMQUdfTVVMVElfUENJX01TSQ0KICBQQ0k6IG1vYml2ZWlsOiBjb3JyZWN0
IFBDSSBiYXNlIGFkZHJlc3MgaW4gTUVNL0lPIG91dGJvdW5kIHdpbmRvd3MNCiAgUENJOiBtb2Jp
dmVpbDogcmVwbGFjZSB0aGUgcmVzb3VyY2UgbGlzdCBpdGVyYXRpb24gZnVuY3Rpb24NCiAgUENJ
OiBtb2JpdmVpbDogdXNlIFdJTl9OVU1fMCBleHBsaWNpdGx5IGZvciBDRkcgb3V0Ym91bmQgd2lu
ZG93DQogIFBDSTogbW9iaXZlaWw6IHVzZSB0aGUgMXN0IGluYm91bmQgd2luZG93IGZvciBNRU0g
aW5ib3VuZCB0cmFuc2FjdGlvbnMNCiAgUENJOiBtb2JpdmVpbDogY29ycmVjdCBpbmJvdW5kL291
dGJvdW5kIHdpbmRvdyBzZXR1cCByb3V0aW5lcw0KICBQQ0k6IG1vYml2ZWlsOiBmaXggdGhlIElO
VHggcHJvY2VzcyBlcnJvcg0KICBQQ0k6IG1vYml2ZWlsOiBvbmx5IGZpeCB1cCB0aGUgQ2xhc3Mg
Q29kZSBmaWVsZA0KICBQQ0k6IG1vYml2ZWlsOiBtb3ZlIG91dCB0aGUgbGluayB1cCB3YWl0aW5n
IGZyb20gbW9iaXZlaWxfaG9zdF9pbml0DQogIFBDSTogbW9iaXZlaWw6IG1vdmUgaXJxIGNoYWlu
ZWQgaGFuZGxlciBzZXR1cCBvdXQgb2YgRFQgcGFyc2UNCiAgUENJOiBtb2JpdmVpbDogaW5pdGlh
bGl6ZSBQcmltYXJ5L1NlY29uZGFyeS9TdWJvcmRpbmF0ZSBidXMgbnVtYmVyDQogIGR0LWJpbmRp
bmdzOiBwY2k6IG1vYml2ZWlsOiBjaGFuZ2UgZ3Bpb19zbGF2ZSBhbmQgYXBiX2NzciB0byBvcHRp
b25hbA0KICBQQ0k6IG1vYml2ZWlsOiByZWZhY3RvciBNb2JpdmVpbCBQQ0llIEhvc3QgQnJpZGdl
IElQIGRyaXZlcg0KICBQQ0k6IG1vYml2ZWlsOiBmaXggdGhlIGNoZWNraW5nIG9mIHZhbGlkIGRl
dmljZQ0KICBQQ0k6IG1vYml2ZWlsOiBjb250aW51ZSB0byBpbml0aWFsaXplIHRoZSBob3N0IHVw
b24gbm8gUENJZSBsaW5rDQogIFBDSTogbW9iaXZlaWw6IGRpc2FibGVkIElCIGFuZCBPQiB3aW5k
b3dzIHNldCBieSBib290bG9hZGVyDQogIFBDSTogbW9iaXZlaWw6IGFkZCBCeXRlIGFuZCBIYWxm
LVdvcmQgd2lkdGggcmVnaXN0ZXIgYWNjZXNzb3JzDQogIFBDSTogbW9iaXZlaWw6IG1ha2UgbW9i
aXZlaWxfaG9zdF9pbml0IGNhbiBiZSB1c2VkIHRvIHJlLWluaXQgaG9zdA0KICBkdC1iaW5kaW5n
czogcGNpOiBBZGQgTlhQIExheWVyc2NhcGUgU29DcyBQQ0llIEdlbjQgY29udHJvbGxlcg0KICBQ
Q0k6IG1vYml2ZWlsOiBhZGQgUENJZSBHZW40IFJDIGRyaXZlciBmb3IgTlhQIExheWVyc2NhcGUg
U29Dcw0KICBhcm02NDogZHRzOiBmcmVlc2NhbGU6IGx4MjE2MGE6IGFkZCBwY2llIERUIG5vZGVz
DQogIGFybTY0OiBkZWZjb25maWc6IEVuYWJsZSBDT05GSUdfUENJX0xBWUVSU0NBUEVfR0VONA0K
DQogLi4uL2JpbmRpbmdzL3BjaS9sYXllcnNjYXBlLXBjaS50eHQgICAgICAgICAgIHwgIDU3ICsr
DQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21vYml2ZWlsLXBjaWUudHh0IHwgICAyICsN
CiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTAgKy0N
CiAuLi4vYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kgfCAxNjMgKysr
Kw0KIGFyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcgICAgICAgICAgICAgICAgICB8ICAgMSAr
DQogZHJpdmVycy9wY2kvY29udHJvbGxlci9LY29uZmlnICAgICAgICAgICAgICAgIHwgIDExICst
DQogZHJpdmVycy9wY2kvY29udHJvbGxlci9NYWtlZmlsZSAgICAgICAgICAgICAgIHwgICAyICst
DQogZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9LY29uZmlnICAgICAgIHwgIDM0ICsN
CiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL01ha2VmaWxlICAgICAgfCAgIDUgKw0K
IC4uLi9jb250cm9sbGVyL21vYml2ZWlsL3BjaS1sYXllcnNjYXBlLWdlbjQuYyB8IDI1NCArKysr
KysNCiAuLi4vY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLWhvc3QuYyAgfCA2Mjgg
KysrKysrKysrKysrKw0KIC4uLi9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwtcGxh
dC5jICB8ICA1NCArKw0KIC4uLi9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWls
LmMgICB8IDI0NiArKysrKw0KIC4uLi9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2
ZWlsLmggICB8IDIyMiArKysrKw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVp
bC5jICAgICAgICB8IDg2MSAtLS0tLS0tLS0tLS0tLS0tLS0NCiAxNSBmaWxlcyBjaGFuZ2VkLCAx
Njc3IGluc2VydGlvbnMoKyksIDg3MyBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9LY29uZmlnDQogY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvTWFrZWZpbGUNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2ktbGF5ZXJzY2FwZS1n
ZW40LmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVp
bC9wY2llLW1vYml2ZWlsLWhvc3QuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BjaS9j
b250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwtcGxhdC5jDQogY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5jDQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2Jp
dmVpbC5oDQogZGVsZXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1t
b2JpdmVpbC5jDQoNCi0tIA0KMi4xNy4xDQoNCg==
