Return-Path: <SRS0=JDZy=SI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A441CC10F06
	for <linux-pci@archiver.kernel.org>; Sat,  6 Apr 2019 19:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3E52175B
	for <linux-pci@archiver.kernel.org>; Sat,  6 Apr 2019 19:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="iVpIPueL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfDFTmb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 6 Apr 2019 15:42:31 -0400
Received: from mail-eopbgr40076.outbound.protection.outlook.com ([40.107.4.76]:44800
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbfDFTmb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 6 Apr 2019 15:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yqAc2QggMHaq10ZyhSYN6X8VZ7XTcKaoQf7E4N1nvU=;
 b=iVpIPueLqlZD/MYuBQb9Kl1q6TV3/lUF4pI4mVknQjIO3qhB05j2qOttdnMv3O4UC6l1NRKRaxUmrQSPvfjBT0InyACTUfis7Zt/P/OLGV8quxTqFTTX7tkuokhyiStDUvYkGL77eFhiV5U4CyPBZR9ey8TY4p85gxo8wAmkfAw=
Received: from DB6PR08MB2678.eurprd08.prod.outlook.com (10.170.221.155) by
 DB6PR08MB2903.eurprd08.prod.outlook.com (10.175.235.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Sat, 6 Apr 2019 19:42:27 +0000
Received: from DB6PR08MB2678.eurprd08.prod.outlook.com
 ([fe80::b4c9:2f05:c626:e634]) by DB6PR08MB2678.eurprd08.prod.outlook.com
 ([fe80::b4c9:2f05:c626:e634%4]) with mapi id 15.20.1771.014; Sat, 6 Apr 2019
 19:42:27 +0000
From:   Grant Likely <Grant.Likely@arm.com>
To:     Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>
CC:     nd <nd@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>
Subject: Re: [PATCH v2 0/2] PCI: Describe external-facing ports in device tree
Thread-Topic: [PATCH v2 0/2] PCI: Describe external-facing ports in device
 tree
Thread-Index: AQHU6Vb0d47mIKzu002oBF6sY+GHH6YvX0sA
Date:   Sat, 6 Apr 2019 19:42:27 +0000
Message-ID: <31d32816-be43-3507-ac7c-b31481e80e55@arm.com>
References: <20190402131548.41949-1-jean-philippe.brucker@arm.com>
In-Reply-To: <20190402131548.41949-1-jean-philippe.brucker@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0376.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::28) To DB6PR08MB2678.eurprd08.prod.outlook.com
 (2603:10a6:6:1b::27)
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.69.145.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e0b9107-473e-413b-4a05-08d6bac7ffd4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB6PR08MB2903;
x-ms-traffictypediagnostic: DB6PR08MB2903:
x-ms-exchange-purlcount: 3
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR08MB29034C33335A173DA023779F95520@DB6PR08MB2903.eurprd08.prod.outlook.com>
x-forefront-prvs: 0999136621
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39850400004)(396003)(136003)(346002)(199004)(189003)(65806001)(14454004)(65956001)(6636002)(44832011)(6512007)(25786009)(64126003)(6506007)(256004)(6486002)(386003)(53546011)(31686004)(966005)(72206003)(105586002)(71200400001)(71190400001)(106356001)(54906003)(229853002)(478600001)(6306002)(8676002)(2906002)(81156014)(110136005)(4326008)(2501003)(68736007)(81166006)(102836004)(53936002)(66066001)(446003)(11346002)(476003)(186003)(305945005)(52116002)(6436002)(26005)(86362001)(6246003)(316002)(7736002)(58126008)(3846002)(6116002)(65826007)(97736004)(99286004)(2616005)(36756003)(5660300002)(486006)(76176011)(31696002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR08MB2903;H:DB6PR08MB2678.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QWHrqGiZyJJfqtFAAjkjpXvn+rIqj4r5Kft8PmD+cWv895eSj3Twg1lTFvkwSMrK6FiY5SGLbULNhu07i1pFTlITKFOvI5m+xJYrjcqErjxjGsUQU7qj8RIyQqTbopCRQWB4TStu79Vct30CYQ+mQrKW0CmqTC9sl9anvmFGKGpTA6vJLlCvEJIRrE0Q9lWO42S3Q21s6xf/2xxtL7ZgT5jgxZANjLgn3tfewq7Fs3jXsfmDjEBNVaGhW3xiJm1oYr9fMsjqO38NxY1sd4sek/WWkJ7yhziDbyDsNNH9JM1MJ0YnuR0wZ87NVmO6lLZoX6Kxt97GpG5N7cluQhjQdben2jPf6zUyXo7eUeT9hivhZtQ3oGko+27yr46ZMqkrRuN92aP/VdyiPjEJ9MNDEDupGYkfDNmDdaIWM0z9BaE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8E442CF2580E84E82747BEF91D4B7BC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0b9107-473e-413b-4a05-08d6bac7ffd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2019 19:42:27.6157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2903
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMDIvMDQvMjAxOSAyMDoxNSwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOg0KPiBTaW5j
ZSB2MSBbMV0sIEkgaW1wcm92ZWQgdGhlIHdvcmRpbmcgb2YgcGF0Y2ggMS8yIGFzIHN1Z2dlc3Rl
ZCBieSBCam9ybi4NCj4gDQo+IEFkZCBhbiAiZXh0ZXJuYWwtZmFjaW5nIiBwcm9wZXJ0eSB0byBQ
Q0kgcG9ydHMgaW4gZGV2aWNlLXRyZWUsIHRvIGhlbHANCj4gaWRlbnRpZnkgdW50cnVzdGVkIGRl
dmljZXMuIFRoZSBub3Rpb24gb2YgdW50cnVzdGVkIFBDSSBkZXZpY2VzIHdhcw0KPiBhZGRlZCB0
byB0aGUgdjUuMCBrZXJuZWwgdG8gZGVzY3JpYmUgZGV2aWNlcyB0aGF0IHNob3VsZCBoYXZlIHN0
cmljdA0KPiBJT01NVSBwcm90ZWN0aW9uIFsyXSwgZm9yIGV4YW1wbGUgZGV2aWNlcyB0aGF0IGFy
ZSBwbHVnZ2VkIGluIGENCj4gVGh1bmRlcmJvbHQgcG9ydC4gQUNQSSBzeXN0ZW1zIHVzZSB0aGUg
RXh0ZXJuYWxGYWNpbmdQb3J0IHByb3BlcnR5IFszXS4NCj4gQWRkIGFuIGVxdWl2YWxlbnQgbWVj
aGFuaXNtIHRvIGRldmljZSB0cmVlLg0KPiANCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LXBjaS8yMDE5MDMxODE4MjEyNC41Mzg1OS0xLWplYW4tcGhpbGlwcGUuYnJ1Y2tlckBh
cm0uY29tLw0KPiBbMl0gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTgvMTEvMjYvNjMxDQo+IFsz
XSBodHRwczovL2RvY3MubWljcm9zb2Z0LmNvbS9lbi11cy93aW5kb3dzLWhhcmR3YXJlL2RyaXZl
cnMvcGNpL2RzZC1mb3ItcGNpZS1yb290LXBvcnRzI2lkZW50aWZ5aW5nLWV4dGVybmFsbHktZXhw
b3NlZC1wY2llLXJvb3QtcG9ydHMNCg0KRm9yIGJvdGg6DQoNClJldmlld2VkLWJ5OiBHcmFudCBM
aWtlbHkgPGdyYW50Lmxpa2VseUBhcm0uY29tPg0KDQo+IA0KPiBKZWFuLVBoaWxpcHBlIEJydWNr
ZXIgKDIpOg0KPiAgICBkdC1iaW5kaW5nczogQWRkIGV4dGVybmFsLWZhY2luZyBQQ0llIHBvcnQg
cHJvcGVydHkNCj4gICAgUENJOiBPRjogU3VwcG9ydCBleHRlcm5hbC1mYWNpbmcgcHJvcGVydHkN
Cj4gDQo+ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9wY2kudHh0IHwg
NTAgKysrKysrKysrKysrKysrKysrKw0KPiAgIGRyaXZlcnMvcGNpL29mLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAzICsrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1MyBpbnNlcnRp
b25zKCspDQo+IA0KDQo=
