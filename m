Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F15FC282C7
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2022177E
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 08:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eM2adenx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfA2IId (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:08:33 -0500
Received: from mail-eopbgr30055.outbound.protection.outlook.com ([40.107.3.55]:14400
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbfA2IIc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 03:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPPBhB/PEqxZaqY5vkmcIdTM6symstCZ4vRv7rDGd6o=;
 b=eM2adenxW36oQKGozF8V4JJFYAuBQeZ+TrKFFNNYI5fWRckyGPBbW4/QSwchugexsBO6tvxh7OYXzuu0djpt0UUdu2jWu0Y+wu7lyP4rQTLB2ofSaKuztWkFQEvEqvkw9kYWUWjp2wvKCHfBIvdCt+RYZTUK40nMmKZz4O0xTV4=
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com (20.179.3.19) by
 AM6PR04MB5847.eurprd04.prod.outlook.com (20.179.3.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Tue, 29 Jan 2019 08:08:28 +0000
Received: from AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504]) by AM6PR04MB5781.eurprd04.prod.outlook.com
 ([fe80::9c0:e3aa:b41f:9504%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:08:28 +0000
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
Subject: [PATCHv3 00/27] PCI: refactor Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Topic: [PATCHv3 00/27] PCI: refactor Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Index: AQHUt6nQIKafKgn6QEuhQ0P6HOWTOw==
Date:   Tue, 29 Jan 2019 08:08:28 +0000
Message-ID: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:36::20) To AM6PR04MB5781.eurprd04.prod.outlook.com
 (2603:10a6:20b:ad::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5847;6:U/uzNn17v3Ts8Nw2LkXlfq9FZAZECR/W4g0O3BPebRNYZpr/Ey7dDGSBTYRxJqxrmeINh1wQxNCcn81eF4tAEB/Cj62PLprzKBhTYOrTPuYUKA2tcMvU+bIouIw8O/q2awQDWAoXjo9XvV1xZZ0Q6u1OtEazZGHn9lD39y32hETZOSZN9x6bWATmK+lcDA7ajC2RpKqjsocdEsg9ZETRP0bQrTm4WMJ2WeeXKa+XQYf/C2rWb1VBLsTEEaj/tF2w0gXm09t7d3ZeTxMvfcMalUE8qOj2joAbrD7Vw/r8BQ6yt5CMGfHhhSE233N8kteGuAR2zQAeqbFkls9UDevkadOTDSNYsSJk+g6Ir+4mQCFu4lf2FD74i4e5FFRVdp4WX9m0N6OiUDH0Q4NgUEbQLbGIX75DLecX34QppBZBPpoRYp9Z32BCvu8cwDJzyN09pitqh+T6QTqWmN0u88WfQw==;5:zkX9dJysNEVq2isolr6NbT6XNlqCNPPgoD+9qrA3kczSxs6owSVzjPZl40BWL3t2RTIRzHWYS1SzDNZsh5HiFw11NjVwuMI6PwgZ4fdsy4JunNMamt6gXcDp4evgmVLOeLaVx5AjqxdSTIob35gGlYEmJhSqrmYfOEQ3VoxrPcsCXnhu99cZ/hIJA9YI6QytMDxVHjS9/L9Ee7zIcc2/rg==;7:tXAIJaYpcQw2flBfczYrZOW/9OOKbZQVJ5pWsF8OC6i9ittpsjzOfCiPQCKkd66Oeu/jrM/b/JB+4DYl1qztjAiP/mNLEsW9+Uu1W+kZVGod1/v7PuGInA3n+1JVBcx8BryhFbcrakAge33pL6IZyw==
x-ms-office365-filtering-correlation-id: 68ff47de-c64d-4b64-8885-08d685c0f33e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5847;
x-ms-traffictypediagnostic: AM6PR04MB5847:
x-microsoft-antispam-prvs: <AM6PR04MB5847A224B25D0D01E8F539E484970@AM6PR04MB5847.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(39860400002)(396003)(346002)(366004)(376002)(136003)(199004)(189003)(14444005)(14454004)(66066001)(478600001)(2616005)(6436002)(71200400001)(486006)(54906003)(476003)(99286004)(110136005)(52116002)(256004)(6486002)(36756003)(6506007)(386003)(316002)(97736004)(26005)(102836004)(71190400001)(186003)(81156014)(81166006)(7736002)(8676002)(3846002)(50226002)(305945005)(4326008)(7416002)(25786009)(1076003)(2906002)(53936002)(6116002)(86362001)(2201001)(105586002)(106356001)(8936002)(2501003)(68736007)(6512007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5847;H:AM6PR04MB5781.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /FCZdVJJqKkPid9cVjqd/kAhBvfkELSaDBWv8t60wmv3IoNxSsbbAlsmK0J02LJr+ljVojt0s+BAwDGumDpKm1z0wErVJ7eJOzPkszgV2asfm8chi1JwkN3dPr0yLrBwbWBLlHr1Nu60a8e8Pl2RoZ7B4zA+xCSUcNODdMzsBBSECg9WAnWfU9LjbIZfGfvlRE/Dbhw8JjxOQHxW6zDn8JT8D5Vnr4/E+XE877tBEFvrTckKs21Saui9zp46VYa9L2X+6yHLYwOtmSocXLilKDHZdBPyPor0hqHQvRb6dEMMt/XkkAHx1xotPrhUsSxDTQteNHXx7MLuTx9bhYvuxcyPgup3STlsmWubwyrIzHDHSs+EgsCe0tWEO2RruuPq3+pgHFVSwqJOaDRb5lGICqPm4dVC8UVW9zS7UsG2jbg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EB28B97FCD6E348AA7971A9D134AA44@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ff47de-c64d-4b64-8885-08d685c0f33e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:08:22.4742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5847
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KVGhpcyBwYXRjaCBz
ZXQgaXMgYWltIHRvIHJlZmFjdG9yIHRoZSBNb2JpdmVpbCBkcml2ZXIgYW5kIGFkZA0KUENJZSBz
dXBwb3J0IGZvciBOWFAgTGF5ZXJzY2FwZSBzZXJpZXMgU29DcyBpbnRlZ3JhdGVkIE1vYml2ZWls
J3MNClBDSWUgR2VuNCBjb250cm9sbGVyLg0KDQpIb3UgWmhpcWlhbmcgKDI3KToNCiAgUENJOiBt
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
U29Dcw0KICBQQ0k6IG1vYml2ZWlsOiBsc19wY2llX2c0OiBhZGQgV29ya2Fyb3VuZCBmb3IgQS0w
MTE1NzcNCiAgUENJOiBtb2JpdmVpbDogbHNfcGNpZV9nNDogYWRkIFdvcmthcm91bmQgZm9yIEEt
MDExNDUxDQogIGFybTY0OiBkdHM6IGZyZWVzY2FsZTogbHgyMTYwYTogYWRkIHBjaWUgRFQgbm9k
ZXMNCiAgYXJtNjQ6IGRlZmNvbmZpZzogRW5hYmxlIENPTkZJR19QQ0lfTEFZRVJTQ0FQRV9HRU40
DQoNCiAuLi4vYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpLWdlbjQudHh0ICAgICAgfCAgNTIg
KysNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbW9iaXZlaWwtcGNpZS50eHQgfCAgIDIg
Kw0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMCAr
LQ0KIC4uLi9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaSB8IDE2MyAr
KysrDQogYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyAgICAgICAgICAgICAgICAgIHwgICAx
ICsNCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL0tjb25maWcgICAgICAgICAgICAgICAgfCAgMTEg
Ky0NCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL01ha2VmaWxlICAgICAgICAgICAgICAgfCAgIDIg
Ky0NCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL0tjb25maWcgICAgICAgfCAgMzQg
Kw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvTWFrZWZpbGUgICAgICB8ICAgNSAr
DQogLi4uL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpLWxheWVyc2NhcGUtZ2VuNC5jIHwgMzA2ICsr
KysrKysNCiAuLi4vY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLWhvc3QuYyAgfCA2
NDAgKysrKysrKysrKysrKw0KIC4uLi9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwt
cGxhdC5jICB8ICA1NCArKw0KIC4uLi9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2
ZWlsLmMgICB8IDI0NiArKysrKw0KIC4uLi9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1v
Yml2ZWlsLmggICB8IDIyOSArKysrKw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2Jp
dmVpbC5jICAgICAgICB8IDg2MSAtLS0tLS0tLS0tLS0tLS0tLS0NCiAxNSBmaWxlcyBjaGFuZ2Vk
LCAxNzQzIGluc2VydGlvbnMoKyksIDg3MyBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9sYXllcnNjYXBlLXBjaS1n
ZW40LnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2
ZWlsL0tjb25maWcNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9t
b2JpdmVpbC9NYWtlZmlsZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BjaS9jb250cm9s
bGVyL21vYml2ZWlsL3BjaS1sYXllcnNjYXBlLWdlbjQuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwtaG9zdC5jDQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2Jp
dmVpbC1wbGF0LmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9t
b2JpdmVpbC9wY2llLW1vYml2ZWlsLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kv
Y29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmgNCiBkZWxldGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCg0KLS0gDQoyLjE3LjENCg0K
