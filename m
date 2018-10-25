Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76B0C46475
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 09:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A18A2082E
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 09:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wYvVd8Gj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A18A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbeJYSA1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:00:27 -0400
Received: from mail-eopbgr60064.outbound.protection.outlook.com ([40.107.6.64]:8292
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726637AbeJYSAV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Oct 2018 14:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YWfKEPmxgz33nlqzU+hBaZ4eTfmhJvEP9edn5KPvf0=;
 b=wYvVd8GjuXQseqoI7bBfgcUOVj1YQBliNq1ZmrP4t/50SCS4VolFA9b+GCueI80mkH7oBDxkDmMcsQfbXQ95Kqq2xuFejH5+kASuKJP5QO1uPpuYbqwSz1Mb+eIitScYEMYtJldRYJfZS6vsQo9OjiTK2Uvpf4MHRvIJ+RwoGlI=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB0950.eurprd04.prod.outlook.com (10.161.195.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.21; Thu, 25 Oct 2018 09:27:42 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1250.028; Thu, 25 Oct 2018
 09:27:42 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: RE: [PATCH 1/4] doc/layerscape-pci: update the PCIe compatible
 strings
Thread-Topic: [PATCH 1/4] doc/layerscape-pci: update the PCIe compatible
 strings
Thread-Index: AQHUXrUp9gHDlHytmU6Ehf512d9PdaUjg64AgAxIJpA=
Date:   Thu, 25 Oct 2018 09:27:42 +0000
Message-ID: <DB5PR04MB12216556360604A225BAFC1F84F70@DB5PR04MB1221.eurprd04.prod.outlook.com>
References: <20181008031428.25293-1-Zhiqiang.Hou@nxp.com>
 <20181008031428.25293-2-Zhiqiang.Hou@nxp.com> <20181017135148.GA29469@bogus>
In-Reply-To: <20181017135148.GA29469@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR04MB0950;6:QvdkrEoiVSSsJ/WEW7nxL6oJ7DIzagm0usU6KIGR8B2fBeM3M+5xypoBJ72K5Di4CC2sCldTem/b2hx8C7nuFXP92sxR4zHChVlNG8CTQ1b7jxDRw1MzffmnSPPsasWz6L2aBEWh3Fw6G3Ms0FlsjNVl2rDw7edvF4CaYa/OsUlECf8MYAKwnB+CKSuTUA7JnI8Nqw5hLGTyJQzK3ccTtgMqmHr2Tz6Cdy6XzAYz8ATB5NSNq1Y7mORVK8zsa7jAq2LNuXrojE1ClUjjyvUotIAwKcOndETBhugvqGKojf/dxj8LsIMGBkdy8rvqby638E0f5OxPRDuAEuISP2XwLcFkQsyiHhN1WUnAqR3bA8VoYa7xIghZEUpm13VeM2mV3Gw8TZrkAj/akl8gCdY3A9kYdZ1xDUMpDKzMaSC4ODxDqa4mqpXYQ79n7Y5HWsmYc1jH/7cBAYufeNyuJoZ3yw==;5:DLqMlmbl8Dsnw/BOq6nY3rHdG2vlhsH/C4EeS8wTwcrCf2ZwOPHRMpbTUxlbYOD1+fbcd/tAL1/48WnpxjZiGQVhf1THL4s19Bm2nGuV8/ZcyGUZrcUnvaWOwmuylYvrUwRU7jmb5hAA8P8nX09wHAhkadulPEU1GIXBNAQ3WiE=;7:3t3Df0Ab3S7ANYb/UTOt6OwidNN/KrjY6EbvZZy3xUTNT5M0XoGKOL6naI/BXEXbQ85j5p2yV8GxchzjTGAAGIPWitm2j/Q/RN/grtxG02715OLv2Y04Z81cIzoGIQFINec4mOI9F0PRRO3gnqUZAg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ae7b8597-ff2e-436b-09c6-08d63a5c1db0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB0950;
x-ms-traffictypediagnostic: DB5PR04MB0950:
x-microsoft-antispam-prvs: <DB5PR04MB0950D5C76E8718D82273741684F70@DB5PR04MB0950.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055)(180628864354917)(211936372134217)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB0950;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB0950;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(13464003)(189003)(446003)(476003)(55016002)(11346002)(229853002)(7736002)(74316002)(305945005)(6436002)(2906002)(66066001)(102836004)(186003)(33656002)(81156014)(81166006)(8676002)(8936002)(26005)(5660300001)(68736007)(5250100002)(6916009)(486006)(97736004)(14444005)(256004)(2900100001)(106356001)(105586002)(15650500001)(99286004)(7696005)(316002)(25786009)(14454004)(575784001)(86362001)(6506007)(76176011)(478600001)(71200400001)(53546011)(54906003)(53936002)(71190400001)(6246003)(3846002)(6116002)(9686003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB0950;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MsW7HDmz04XTWWAFm2brLi8qA1kDYBsra27tRy4joAfOqtc1T6zxx2tK4/bKLUuxfFWArPaGWvnxBrAQTS+qogH+rvc6swvimn6zWx1RQHJiQL68BrZWenM5NGEBEiEMoJGNPdDzIUId7i7vFv8DRgltjJOcW+m3aHLjXjWyhOSCg90O29KT2fNZvmXdQ6ZIn82SW50Kyb9Fo0TOmByMi9TVILCyT6FBOMeYrL1wiGKkQoluN6/hP2McyNZJ2ZNya1J27K+xnzKdZN6zUTqz9V8xvhM2U0xIFXL5MjiFXKHXPW6xoSs8VPVMGxi2GR8RfZ5q2xqrH54aE4hO6E0SAAavJaDRwQwa8srx0qZmO4Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7b8597-ff2e-436b-09c6-08d63a5c1db0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 09:27:42.8357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB0950
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iLA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgY29tbWVudHMhDQogDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+
DQo+IFNlbnQ6IDIwMTjE6jEw1MIxN8jVIDIxOjUyDQo+IFRvOiBaLnEuIEhvdSA8emhpcWlhbmcu
aG91QG54cC5jb20+DQo+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBMZW8gTGkNCj4gPGxlb3lhbmcubGlAbnhw
LmNvbT47IHNoYXduZ3VvQGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiBiaGVs
Z2Fhc0Bnb29nbGUuY29tOyBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+OyBNLmguIExp
YW4NCj4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzRd
IGRvYy9sYXllcnNjYXBlLXBjaTogdXBkYXRlIHRoZSBQQ0llIGNvbXBhdGlibGUNCj4gc3RyaW5n
cw0KPiANCj4gT24gTW9uLCBPY3QgMDgsIDIwMTggYXQgMTE6MTQ6MjVBTSArMDgwMCwgWmhpcWlh
bmcgSG91IHdyb3RlOg0KPiA+IEZyb206IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5j
b20+DQo+ID4NCj4gPiBUaGUgcGNpZSBjb21wYXRpYmxlIHN0cmluZyBmb3IgTFMxMDQzQSB3YXMg
bG9zdCwgc28gYWRkIGl0Lg0KPiANCj4gUENJZQ0KPiANCj4gVGhlIHN1YmplY3QgY291bGQgYmUg
aW1wcm92ZWQgdG8gc2F5IGV4YWN0bHkgd2hhdCBjb21wYXRpYmxlIHN0cmluZyB5b3UgYXJlDQo+
IGFkZGluZy4gQW5kIHRoZSBzdWJqZWN0IHNob3VsZCBzdGFydCB3aXRoICJkdC1iaW5kaW5nczog
cGNpOiAuLi4iDQo+DQoNClllcywgd2lsbCBjb3JyZWN0IHRoZW0gaW4gdjIuDQogDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+
IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2Nh
cGUtcGNpLnR4dCB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNp
L2xheWVyc2NhcGUtcGNpLnR4dA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BjaS9sYXllcnNjYXBlLXBjaS50eHQNCj4gPiBpbmRleCA2NmRmMWU4MWUwYjguLjVlYjFj
MjAyOTMyZiAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcGNpL2xheWVyc2NhcGUtcGNpLnR4dA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2kudHh0DQo+ID4gQEAgLTE4LDYgKzE4LDcg
QEAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiAgICAgICAgICAiZnNsLGxzMjA4OGEtcGNpZSIN
Cj4gPiAgICAgICAgICAiZnNsLGxzMTA4OGEtcGNpZSINCj4gPiAgICAgICAgICAiZnNsLGxzMTA0
NmEtcGNpZSINCj4gPiArICAgICAgICAiZnNsLGxzMTA0M2EtcGNpZSINCj4gPiAgICAgICAgICAi
ZnNsLGxzMTAxMmEtcGNpZSINCj4gPiAgLSByZWc6IGJhc2UgYWRkcmVzc2VzIGFuZCBsZW5ndGhz
IG9mIHRoZSBQQ0llIGNvbnRyb2xsZXIgcmVnaXN0ZXIgYmxvY2tzLg0KPiA+ICAtIGludGVycnVw
dHM6IEEgbGlzdCBvZiBpbnRlcnJ1cHQgb3V0cHV0cyBvZiB0aGUgY29udHJvbGxlci4gTXVzdA0K
PiA+IGNvbnRhaW4gYW4NCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQo=
