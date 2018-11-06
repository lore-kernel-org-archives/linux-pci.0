Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FACC32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABF120869
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 13:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CR1jwQM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABF120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbeKFWoU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:44:20 -0500
Received: from mail-ve1eur01on0085.outbound.protection.outlook.com ([104.47.1.85]:26496
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729728AbeKFWoU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 17:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xhke7sgr8C1YyqIOUhT1gCbedwmSstsFwRr+DDhukrQ=;
 b=CR1jwQM6I6KPmggOgtprC8reGQMUUJpWVqsDRnKM5GDNiBpBYO+8i+Qlb9r1hfFJVhNRDHnlnFKJpTw1Sbvs6iNJZ6jRCwKQL3Maik4JP/JCiSiWBeb1OUX0JFkFJBRQSL7TV0sJpk8qSTbSZXpnHwcZrHmwOvoEmnXkBjkgnvI=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB0984.eurprd04.prod.outlook.com (10.161.196.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Tue, 6 Nov 2018 13:19:03 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1273.035; Tue, 6 Nov 2018
 13:19:03 +0000
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
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCH 00/23] PCI: refactor the Mobiveil driver and add PCIe support
 for NXP LX SoCs
Thread-Topic: [PATCH 00/23] PCI: refactor the Mobiveil driver and add PCIe
 support for NXP LX SoCs
Thread-Index: AQHUddNJ+rvIvxvt8E65Px/kcnc2Yw==
Date:   Tue, 6 Nov 2018 13:19:03 +0000
Message-ID: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:203:2e::20) To DB5PR04MB1221.eurprd04.prod.outlook.com
 (2a01:111:e400:51c2::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR04MB0984;6:XoE1WKw/G2dd8Oo7Ls7E/NwqRq3eq8TaMe1MLD70KSzbRqOr48BGUD1bQKIb3bwoZctRHeCMRaAUIZoRAPkGvGW+dc3756IY8Hy5228uTYeoi8kgJWjpivn1vrnwj3vXtRiLBV5wZSXo5ARfvYIfbkSiNRTVZHia4RH2ITu/hRfOBmcitT4SFZj79UeehK9beSsJ/cCXxsIwplmuZuqeQONabcGnjzLZdcNm3Q76phAWfdnsb9cuhCEMpLyZaF22OHaeThV+E6CYxc7ocksWH55oUwqvhWRYqem0JnAYxEJsG+efFNQSN2FHsZCyF1XmCIpMb286cuhhrIyFZcuiGoylcbTYTaKTkXhRljDAIpyGaqsdRaWG0ijKlLuGWTmaokMsoc7I/mXEK8EX9gqUZT4jiUXvmNPDWV7FwWbdJ/KrItpjuwkMqwrvOihufuM3sJTHt6w0y9HQMVoQLmt3nw==;5:hvrCD/sX2xoliD+cZS5MUc/1mQavQUZ3YidFu67HxsuNaZSPe60cSakxihACl6XzyGp16yhd7f9l1WRYQHTtsx7KqVnv+Rvu20UnvhOhQadVrD5AB7hY38KM7dGISKB+14SAcK/mnsBRuUsa1lVX8uf3vBFlaa3CAkQKQnb//Ts=;7:GRnFlLn9f5BvNy3+hdk/2aezjnxVd7eN2akAkksuVWqbuO4C3Rs4zftbBFXlW2LJ7Og6tnKDlYEtLHyIse/QRK0qN3cz4+LeL5ZaM2UzBvbPeiee9dhemRpzgQThoXqu5sXt30Fx9qUBoHeCcQ0WZA==
x-ms-office365-filtering-correlation-id: 492a5134-c58a-4a46-b1ec-08d643ea6bc1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB0984;
x-ms-traffictypediagnostic: DB5PR04MB0984:
x-microsoft-antispam-prvs: <DB5PR04MB098491A3ADAD318657F0AA9484CB0@DB5PR04MB0984.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB0984;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB0984;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(376002)(346002)(39860400002)(366004)(136003)(396003)(199004)(189003)(68736007)(486006)(386003)(8936002)(3846002)(99286004)(71190400001)(81156014)(71200400001)(81166006)(53936002)(8676002)(105586002)(110136005)(54906003)(5660300001)(2616005)(66066001)(97736004)(305945005)(7416002)(476003)(2900100001)(7736002)(106356001)(14444005)(2201001)(4326008)(2501003)(25786009)(1076002)(186003)(6486002)(26005)(2906002)(256004)(6512007)(36756003)(6116002)(6436002)(316002)(102836004)(52116002)(6506007)(86362001)(14454004)(478600001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB0984;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 07x0hmaCEty1di3jQCBkn/9YBakQ5QB+lDJtxW1PIcwg3ONpgbyxG1t3MP3E+C2F9ui+U89qEXHM+ybTFf1jrYo9u6OIcSFXWQeNfClMjte4m3Pcif6d/SXFjQ0zftQYeyOoxfKYpUMudM3VOuyXI665HCqnGFEP/yzzjVHY5L1A/5re91PhOkneDG2d02V4BWphLQs8QIF4wvzjkEahehPO3XWyvf/M7Rwg7H9fTV8EcPF6oBUtxi1V+C8LDr0GJWNmpfmeJLGuuAcfgH2aasG+u1MBinew5zsNVAVHQPY9R+mC9+22Juy0dYJPf0mB30uFyj0xBGh5mY0WXSy4YSTbqOfRAyjkXfwEdksWCbU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <49EC5FCA622C5144B1E825412F41A7AD@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492a5134-c58a-4a46-b1ec-08d643ea6bc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 13:19:03.5904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB0984
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg0KVGhpcyBwYXRjaCBz
ZXQgaXMgYWltIHRvIHJlZmFjdG9yIHRoZSBNb2JpdmVpbCBkcml2ZXIgYW5kIGFkZA0KUENJZSBz
dXBwb3J0IGZvciBOWFAgTFggc2VyaWVzIFNvQ3MuDQoNCkhvdSBaaGlxaWFuZyAoMjMpOg0KICBQ
Q0k6IG1vYml2ZWlsOiB1bmlmb3JtIHRoZSByZWdpc3RlciBhY2Nlc3NvcnMNCiAgUENJOiBtb2Jp
dmVpbDogZm9ybWF0IHRoZSBjb2RlIHdpdGhvdXQgZnVuY3Rpb24gY2hhbmdlDQogIFBDSTogbW9i
aXZlaWw6IGNvcnJlY3QgdGhlIHJldHVybmVkIGVycm9yIG51bWJlcg0KICBQQ0k6IG1vYml2ZWls
OiByZW1vdmUgZmxhZyBNU0lfRkxBR19NVUxUSV9QQ0lfTVNJDQogIFBDSTogbW9iaXZlaWw6IGNv
cnJlY3QgUENJIGJhc2UgYWRkcmVzcyBpbiBNRU0vSU8gb3V0Ym91bmQgd2luZG93cw0KICBQQ0k6
IG1vYml2ZWlsOiByZXBsYWNlIHRoZSByZXNvdXJjZSBsaXN0IGl0ZXJhdGlvbiBmdW5jdGlvbg0K
ICBQQ0k6IG1vYml2ZWlsOiB1c2UgV0lOX05VTV8wIGV4cGxpY2l0bHkgZm9yIENGRyBvdXRib3Vu
ZCB3aW5kb3cNCiAgUENJOiBtb2JpdmVpbDogdXNlIHRoZSAxc3QgaW5ib3VuZCB3aW5kb3cgZm9y
IE1FTSBpbmJvdW5kIHRyYW5zYWN0aW9ucw0KICBQQ0k6IG1vYml2ZWlsOiBjb3JyZWN0IHRoZSBp
bmJvdW5kL291dGJvdW5kIHdpbmRvdyBzZXR1cCByb3V0aW5lDQogIFBDSTogbW9iaXZlaWw6IGZp
eCB0aGUgSU5UeCBwcm9jZXNzIGVycm9yDQogIFBDSTogbW9iaXZlaWw6IG9ubHkgZml4dXAgdGhl
IENsYXNzIENvZGUgZmllbGQNCiAgUENJOiBtb2JpdmVpbDogbW92ZSBvdXQgdGhlIGxpbmsgdXAg
d2FpdGluZyBmcm9tIG1vYml2ZWlsX2hvc3RfaW5pdA0KICBQQ0k6IG1vYml2ZWlsOiBtb3ZlIGly
cSBjaGFpbmVkIGhhbmRsZXIgc2V0dXAgb3V0IG9mIERUIHBhcnNlDQogIFBDSTogbW9iaXZlaWw6
IGluaXRpYWxpemUgUHJpbWFyeS9TZWNvbmRhcnkvU3Vib3JkaW5hdGUgYnVzIG51bWJlcg0KICBk
dC1iaW5kaW5nczogcGNpOiBtb2JpdmVpbDogY2hhbmdlIGdwaW9fc2xhdmUgYW5kIGFwYl9jc3Ig
dG8gb3B0aW9uYWwNCiAgUENJOiBtb2JpdmVpbDogcmVmYWN0b3IgdGhlIE1vYml2ZWlsIGRyaXZl
cg0KICBQQ0k6IG1vYml2ZWlsOiBjb250aW51ZSB0byBpbml0aWFsaXplIHRoZSBob3N0IHVwb24g
bm8gUENJZSBsaW5rDQogIFBDSTogbW9iaXZlaWw6IGRpc2FibGVkIElCIGFuZCBPQiB3aW5kb3dz
IHNldCBieSBib290bG9hZGVyDQogIFBDSTogbW9iaXZlaWw6IGFkZCBCeXRlIGFuZCBIYWxmLVdv
cmQgd2lkdGggcmVnaXN0ZXIgYWNjZXNzb3JzDQogIFBDSTogbW9iaXZlaWw6IGNoYW5nZSBwcm90
b3R5cGUgb2YgZnVuY3Rpb24gbW9iaXZlaWxfaG9zdF9pbml0DQogIGR0LWJpbmRpbmdzOiBwY2k6
IEFkZCBOWFAgTFggU29DcyBQQ0llIGNvbnRyb2xsZXINCiAgUENJOiBtb2JpdmVpbDogYWRkIFBD
SWUgUkMgZHJpdmVyIGZvciBOWFAgTFggc2VyaWVzIFNvQ3MNCiAgYXJtNjQ6IGR0czogZnJlZXNj
YWxlOiBseDIxNjBhOiBhZGQgcGNpZSBEVCBub2Rlcw0KDQogLi4uL2RldmljZXRyZWUvYmluZGlu
Z3MvcGNpL2x4LXBjaS50eHQgICAgICAgIHwgIDUyICsrDQogLi4uL2RldmljZXRyZWUvYmluZGlu
Z3MvcGNpL21vYml2ZWlsLXBjaWUudHh0IHwgICAyICsNCiBNQUlOVEFJTkVSUyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTAgKy0NCiAuLi4vYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kgfCAxNTcgKysrKw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvS2NvbmZpZyAgICAgICAgICAgICAgICB8ICAxMSArLQ0KIGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvTWFrZWZpbGUgICAgICAgICAgICAgICB8ICAgMiArLQ0KIGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvbW9iaXZlaWwvS2NvbmZpZyAgICAgICB8ICAzNCArDQogZHJpdmVycy9wY2kvY29udHJvbGxl
ci9tb2JpdmVpbC9NYWtlZmlsZSAgICAgIHwgICA1ICsNCiBkcml2ZXJzL3BjaS9jb250cm9sbGVy
L21vYml2ZWlsL3BjaS1seC5jICAgICAgfCAyMjIgKysrKysNCiAuLi4vY29udHJvbGxlci9tb2Jp
dmVpbC9wY2llLW1vYml2ZWlsLWhvc3QuYyAgfCA2MjIgKysrKysrKysrKysrKw0KIC4uLi9jb250
cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwtcGxhdC5jICB8ICA1NCArKw0KIC4uLi9wY2kv
Y29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmMgICB8IDI0NSArKysrKw0KIC4uLi9w
Y2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmggICB8IDIyMSArKysrKw0KIGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jICAgICAgICB8IDg2MSAtLS0tLS0t
LS0tLS0tLS0tLS0NCiAxNCBmaWxlcyBjaGFuZ2VkLCAxNjI1IGluc2VydGlvbnMoKyksIDg3MyBk
ZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BjaS9seC1wY2kudHh0DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvbW9iaXZlaWwvS2NvbmZpZw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL21vYml2ZWlsL01ha2VmaWxlDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpLWx4LmMNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLWhvc3QuYw0K
IGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUt
bW9iaXZlaWwtcGxhdC5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5oDQogZGVsZXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQoNCi0tIA0KMi4xNy4x
DQoNCg==
