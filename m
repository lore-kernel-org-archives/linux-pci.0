Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA45EC43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844CA20657
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="yBe3rhxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfCKJaE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:30:04 -0400
Received: from mail-eopbgr130050.outbound.protection.outlook.com ([40.107.13.50]:9634
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727023AbfCKJaE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 05:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbsVTcUDE/HF9B/J7UP14luiwZIDUrxfV2IxQyjtG+M=;
 b=yBe3rhxnpUb1s36K2JMcPYpxvtwWfgndWeRqW4c3BZFkDeozETb37ltGCUbMFvRUNLPesnm+Z74O+9L089nY3RbAL9d46bhWvUBxWDkOVLPT6FFFFE/2uttmj0RY/f4xv9UuwrQjRz32YtU/EG7le1E8tZSmL28JYY/c9fOr6Bk=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5592.eurprd04.prod.outlook.com (20.178.87.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 09:29:55 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::30cc:e034:1f7a:2cc7%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 09:29:54 +0000
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
Subject: [PATCHv4 00/28] PCI: refactor Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Topic: [PATCHv4 00/28] PCI: refactor Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Index: AQHU1+z8oUtBku7HKUGEtP8v8oioHQ==
Date:   Mon, 11 Mar 2019 09:29:54 +0000
Message-ID: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:203:2e::27) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37cffe99-89f6-4b12-b703-08d6a6041ec5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5592;
x-ms-traffictypediagnostic: AM6PR04MB5592:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI1NTkyOzIzOmJWeW5oMWhDaHVJNFpESEo5U1loK2Q1TWVO?=
 =?utf-8?B?bjVidElKOWVPZUMzbEc0V1BTNmtVUVBRR3A2Y3hrRmZGOFZ5NlU5c1BGVDR1?=
 =?utf-8?B?SEFTS1JRc29qSjU0U0xYTWJMZjZLRzIwSDZOUzloM1VmTXZQRHdrK0pYZXZ3?=
 =?utf-8?B?MkVwalI3enAwZEN1K3hpVGlGWXIyQ1RVYjUrc0Y3SitWQ1E1NVNvdUxEZGhF?=
 =?utf-8?B?L3RZd3ZTRXVqWU9WQnRGQ1NOaEZpTnJlS0pSUGUxcXdxWkJ4RDZIbS93eTFw?=
 =?utf-8?B?aTRHajlFa281K3pMc210R28wZVZCZ1lrRVJKV0w4bmk1RTg1em16ek13RTlj?=
 =?utf-8?B?ZVh4MjlMYXhEUHhKMUx6LzRwSG5Ma0RvK1c4MFlEczB5Nnc1NEQrYjRpb2Ur?=
 =?utf-8?B?eDJFdG80NzFFUFlBc2lDd0JCeElLYXJqdXRQa1daWHlUSWRSSU9TNXkvb3k4?=
 =?utf-8?B?SVpnbGNVNXFKdFlRM0ZvM09XNUliRWg0djlDYjJET0RyeUVERFpJbzdndS9j?=
 =?utf-8?B?dWpCbGszaE5YQ2VqR1l4Z251NUVnOU5NSEJDdG4yNk9YREpobDNDTGtFamRB?=
 =?utf-8?B?ZzAwdE9iSSs0cEsxektHOHQxOElLRzNlRWJFeWhIUjB6a3JyNzBXam8vcXVJ?=
 =?utf-8?B?N0o2dTBwTEZWd2IwQ0FFUzNLbjlVMVJ3djAxNHFUdUF0L0NyRXp3NWN4RjJq?=
 =?utf-8?B?YXdJSXM3S3VZc2VWQVZtRjYvN1NvakpxaTlLc2F2ZGlRdC84bzdaYlRSb3FF?=
 =?utf-8?B?QTc3NkJtL3JRdnhFS3NvM0JVOVBiNmhJRUtJeHVHa0JLQXMwVHJMWHduUGwr?=
 =?utf-8?B?SWNtb0pubXdiK2tRYlJTYiszS2RNZTNjRHJsLytPMEo5UGFpS1UwSDM2Mkcw?=
 =?utf-8?B?TDVQWXJod0JCeHY1Z0p4ZHJFK2ZRRktvOWlJWDZEZmx3bGxYWnZxRXZqdWM3?=
 =?utf-8?B?cE03UHpxQTdnYWV6Qm9jY3NTMXBwY21SSitnRFdOWGNXYUZoaVpJTVdTYlYz?=
 =?utf-8?B?Qlo1YURDNlhJbG1IUTcxN0lNUSs4SUtyVlduV01xcXJCVlNIUVUraGV3clF3?=
 =?utf-8?B?aG9yM1JaaExtd01RNHdXdTFqcEJOdCtObXUvMFpTb0krTVBWeTNVQVpVVHZC?=
 =?utf-8?B?dTY4SXhUUDJieVZxam05NlIzTW5IdUFHZVhROEpKelBtZFEzVjBQcXNTYlhl?=
 =?utf-8?B?MlluMHdYTmRvRjZDN0xIMFZuRm54cVVKcVBCbzdYTjViZ0FMa2FEaXpuUWcz?=
 =?utf-8?B?RENyc3kyczVQcERidVhCRllCLzBseUFtSVR6Y0tjVTBRRVo0cnZxMlN2OXRU?=
 =?utf-8?B?M0tmYi9vRC9tVlQ3RlVIQURNTTNnM3RoUW1IN1l0OXZRcVlldW05aEhNOVJS?=
 =?utf-8?B?Vjg2NVFVb2xNU2IwbU8vZDlXMHFBM0xEdzEzS0VIY1A4Wm9JTlRiZ1VrRWRQ?=
 =?utf-8?B?UjVIMEw4bTNYZ2RtVW4vYTFYRVNrWTZ4Z2h5SVVibENmQWlMeVZkVldkbXkw?=
 =?utf-8?B?dDFZcVVneVg1WEM3ZW5aTjAyQUJmcHpWQVQyalN3N21BMUVSMnlJcVZTQ0Jh?=
 =?utf-8?B?U0pQL21WU2Y3Z3dVQjFBTDNXVnhGQlRrdDMvNTFVS1RSRmtiWUlQNEEzSWJR?=
 =?utf-8?B?VEJIY2RDeEJwYmJnc29HeGFvNHE4N0ptOW1kWmhicVdjOGVIcXI2VThYRzNk?=
 =?utf-8?B?MitVa28xUzBaSkRqTDg4dHlHWkw3MDYxL1lTZG1sc21XejBlVDJPK3B2RkpB?=
 =?utf-8?B?SEFtRlFsOFJ3YjcwejEwUT09?=
x-microsoft-antispam-prvs: <AM6PR04MB5592FC7B93422B93D98360E884480@AM6PR04MB5592.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(366004)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(5660300002)(4326008)(2201001)(8676002)(478600001)(81166006)(81156014)(14454004)(86362001)(8936002)(50226002)(7416002)(14444005)(256004)(1076003)(71200400001)(71190400001)(2616005)(476003)(486006)(186003)(305945005)(7736002)(97736004)(68736007)(66066001)(36756003)(6486002)(105586002)(106356001)(6436002)(6512007)(110136005)(54906003)(52116002)(99286004)(26005)(386003)(6506007)(3846002)(316002)(6116002)(102836004)(6346003)(25786009)(53936002)(2906002)(2501003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5592;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A0KfhN9Yq32ldXJYYEGX1FSALc1JPWcE/cNoYIiYhzyRdcsmypXHAVg7naqSuREijWRQHfUEZw5hpTQG6op5EAnADmjRn1e6vlrIBhSQSR9/zZraEP3Blw9lH7Kph3ABOeoqBNO/Lu2ZzObi/FL7EYOlFveK1gru/OiG4f+kB1GABpdlagfK9SWNqLITSIOOqkC2CAtuske0/nahYshvyWjpcS+LvIeetGujdlWxqFYTzQwmjn9RaGsNyC5So3Se2akzwfDs+DML4GmjOjg9asTkl8v0kpgvJ70W/oqzyyHm4HZHSsNZ5iusT2/ajQKmeVQl7nkDAx7TNTTCbG/kYj5f6WOJrvbWH7tRXK/6HxgK/ZViUpVQxil4GcnG17bkEZ6UGJYGMLsuxr0ouslbjAJcsc3THVCTlDKStc0Tw8M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D3492F129FB224FA85C0701CF6D2F41@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cffe99-89f6-4b12-b703-08d6a6041ec5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 09:29:54.8659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5592
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KVGhpcyBwYXRjaCBz
ZXQgaXMgYWltIHRvIHJlZmFjdG9yIHRoZSBNb2JpdmVpbCBkcml2ZXIgYW5kIGFkZA0KUENJZSBz
dXBwb3J0IGZvciBOWFAgTGF5ZXJzY2FwZSBzZXJpZXMgU29DcyBpbnRlZ3JhdGVkIE1vYml2ZWls
J3MNClBDSWUgR2VuNCBjb250cm9sbGVyLg0KDQpIb3UgWmhpcWlhbmcgKDI4KToNCiAgUENJOiBt
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
dmljZQ0KICBQQ0k6IG1vYml2ZWlsOiBhZGQgbGluayB1cCBjb25kaXRpb24gY2hlY2sNCiAgUENJ
OiBtb2JpdmVpbDogY29udGludWUgdG8gaW5pdGlhbGl6ZSB0aGUgaG9zdCB1cG9uIG5vIFBDSWUg
bGluaw0KICBQQ0k6IG1vYml2ZWlsOiBkaXNhYmxlZCBJQiBhbmQgT0Igd2luZG93cyBzZXQgYnkg
Ym9vdGxvYWRlcg0KICBQQ0k6IG1vYml2ZWlsOiBhZGQgQnl0ZSBhbmQgSGFsZi1Xb3JkIHdpZHRo
IHJlZ2lzdGVyIGFjY2Vzc29ycw0KICBQQ0k6IG1vYml2ZWlsOiBtYWtlIG1vYml2ZWlsX2hvc3Rf
aW5pdCBjYW4gYmUgdXNlZCB0byByZS1pbml0IGhvc3QNCiAgZHQtYmluZGluZ3M6IHBjaTogQWRk
IE5YUCBMYXllcnNjYXBlIFNvQ3MgUENJZSBHZW40IGNvbnRyb2xsZXINCiAgUENJOiBtb2JpdmVp
bDogYWRkIFBDSWUgR2VuNCBSQyBkcml2ZXIgZm9yIE5YUCBMYXllcnNjYXBlIFNvQ3MNCiAgUENJ
OiBtb2JpdmVpbDogbHNfcGNpZV9nNDogYWRkIFdvcmthcm91bmQgZm9yIEEtMDExNTc3DQogIFBD
STogbW9iaXZlaWw6IGxzX3BjaWVfZzQ6IGFkZCBXb3JrYXJvdW5kIGZvciBBLTAxMTQ1MQ0KICBh
cm02NDogZHRzOiBmcmVlc2NhbGU6IGx4MjE2MGE6IGFkZCBwY2llIERUIG5vZGVzDQogIGFybTY0
OiBkZWZjb25maWc6IEVuYWJsZSBDT05GSUdfUENJX0xBWUVSU0NBUEVfR0VONA0KDQogLi4uL2Jp
bmRpbmdzL3BjaS9sYXllcnNjYXBlLXBjaS1nZW40LnR4dCAgICAgIHwgIDUyICsrDQogLi4uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcGNpL21vYml2ZWlsLXBjaWUudHh0IHwgICAyICsNCiBNQUlOVEFJ
TkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTAgKy0NCiAuLi4vYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kgfCAxNjMgKysrKw0KIGFyY2gv
YXJtNjQvY29uZmlncy9kZWZjb25maWcgICAgICAgICAgICAgICAgICB8ICAgMSArDQogZHJpdmVy
cy9wY2kvY29udHJvbGxlci9LY29uZmlnICAgICAgICAgICAgICAgIHwgIDExICstDQogZHJpdmVy
cy9wY2kvY29udHJvbGxlci9NYWtlZmlsZSAgICAgICAgICAgICAgIHwgICAyICstDQogZHJpdmVy
cy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9LY29uZmlnICAgICAgIHwgIDM0ICsNCiBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL21vYml2ZWlsL01ha2VmaWxlICAgICAgfCAgIDUgKw0KIC4uLi9jb250
cm9sbGVyL21vYml2ZWlsL3BjaS1sYXllcnNjYXBlLWdlbjQuYyB8IDMwNiArKysrKysrDQogLi4u
L2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC1ob3N0LmMgIHwgNjQwICsrKysrKysr
KysrKysNCiAuLi4vY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLXBsYXQuYyAgfCAg
NTQgKysNCiAuLi4vcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5jICAgfCAy
NDYgKysrKysNCiAuLi4vcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5oICAg
fCAyMjkgKysrKysNCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYyAgICAg
ICAgfCA4NjEgLS0tLS0tLS0tLS0tLS0tLS0tDQogMTUgZmlsZXMgY2hhbmdlZCwgMTc0MyBpbnNl
cnRpb25zKCspLCA4NzMgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2ktZ2VuNC50eHQNCiBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9LY29uZmln
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvTWFr
ZWZpbGUNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVp
bC9wY2ktbGF5ZXJzY2FwZS1nZW40LmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kv
Y29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLWhvc3QuYw0KIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwtcGxhdC5j
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNp
ZS1tb2JpdmVpbC5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
bW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5oDQogZGVsZXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQoNCi0tIA0KMi4xNy4xDQoNCg==
