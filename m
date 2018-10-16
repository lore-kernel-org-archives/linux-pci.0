Return-Path: <SRS0=JYfi=M4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2853C04EBD
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 14:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBF8205C9
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 14:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="cmpzMzFD";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="HKyJWh3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CBF8205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeJPVwE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:52:04 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:42414 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726986AbeJPVwE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Oct 2018 17:52:04 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9GDwcwM027205;
        Tue, 16 Oct 2018 07:01:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=R8X1+W3ziNGSkx2VJcq4Q7ccmwnWhYKm7tmQUWsAG6s=;
 b=cmpzMzFDu50juYZnjkwQ00w0k83OYtIlDWijBzgp8FiXteK1a2RNdcz/uXfZNpywq1kj
 clVEvu3HDzX8gUElDBAUMzhRjjjxLxc9H2CacIU4mIOv/YzPJgLpzUBaVGjocBXStrHf
 3VHgCrj55yMo8S0wUoE4hW6eAPkREnnnfiZmrNm4BJTquJt+511pA9ukYhrz5GOhXCgi
 3XG2SnTE1he6o+Qnlkv+6Fc7bNTLwkHl5OG0SBsxzAC1hCQh1pa4N8qlkcPjAwUdNPj+
 w/NJ+C3f9hUPFWmbRQ2KYvTOYaDUiiPT3UyRkK+jy5Dm6jICdSZoCd0QqkD7HUFeo0bv LQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp0115.outbound.protection.outlook.com [207.46.163.115])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2n4xcgvf74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 16 Oct 2018 07:01:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8X1+W3ziNGSkx2VJcq4Q7ccmwnWhYKm7tmQUWsAG6s=;
 b=HKyJWh3jdFTb4k8ay4sluD9GsNg0D3+Q3SrqYNBuv1BPuqrqKDup/SRWnASXeS/IWR9Fzekk/OaOfDVDde+cz1aRHmoQeqK5/7pdlxDGvYe3sOITzhlybKUbx7q4XORjP1JErIh3sv9ibREnOKkQ0BDikqT4jNiuB/UpulRczuM=
Received: from MWHPR07MB3502.namprd07.prod.outlook.com (10.164.192.29) by
 MWHPR07MB3101.namprd07.prod.outlook.com (10.172.95.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Tue, 16 Oct 2018 14:01:02 +0000
Received: from MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::807b:c33e:bee7:ecd9]) by MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::807b:c33e:bee7:ecd9%4]) with mapi id 15.20.1228.027; Tue, 16 Oct 2018
 14:01:02 +0000
From:   Alan Douglas <adouglas@cadence.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "cyrille.pitchen@bootlin.com" <cyrille.pitchen@bootlin.com>
Subject: RE: [PATCH v4 4/4] PCI: cadence: Check link is up before sending IRQ
 from EP
Thread-Topic: [PATCH v4 4/4] PCI: cadence: Check link is up before sending IRQ
 from EP
Thread-Index: AQHUYX3awooV6FQXlE+vlT6rgGYq/6Ug2aKAgAESmACAAAAv4A==
Date:   Tue, 16 Oct 2018 14:01:01 +0000
Message-ID: <MWHPR07MB350298282E86D1DA1E757554D8FE0@MWHPR07MB3502.namprd07.prod.outlook.com>
References: <1539274617-1661-1-git-send-email-adouglas@cadence.com>
 <20181015213034.GF5906@bhelgaas-glaptop.roam.corp.google.com>
 <20181016135324.GA16390@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181016135324.GA16390@e107981-ln.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1lYzU2ZTliOS1kMTRiLTExZTgtYWI4Yy1mNDk2MzQ4NmY0ZWNcYW1lLXRlc3RcZWM1NmU5YmItZDE0Yi0xMWU4LWFiOGMtZjQ5NjM0ODZmNGVjYm9keS50eHQiIHN6PSIyMjE1IiB0PSIxMzE4NDE3MjA2NjI4Mjc1MTYiIGg9InNhU3Q3bWhVS29QZEoxZC95cWlEMDdTVldKcz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR07MB3101;20:qrdLHLuNCImnGdJn6Y+/QzwUwx2s/XYAvIBg0wz+jnd0ObJNLC6J5BKDItrFbjwpRiZDcm7zU7574bVtZDGs2XCZ09N0P8wtjMiL1S17aDwrpaUw/NoMXasxw6vgPV2qxZTW1YqiR+nC8rpM81O4fC1fCZpOid/vOfMVRBToOdcnhw9AEnMk6fpLVmcu20TvWxRiLsmoycgJD8oxqBacbabdzJ/dk/kmh0gHvJATHRb5WQ/DIU3Pn4B2XuY8q4hg
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ee0b14b7-8a66-444c-a88f-08d6336fce9f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR07MB3101;
x-ms-traffictypediagnostic: MWHPR07MB3101:
x-microsoft-antispam-prvs: <MWHPR07MB310139E4595D43A04FA3F465D8FE0@MWHPR07MB3101.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991067);SRVR:MWHPR07MB3101;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3101;
x-forefront-prvs: 0827D7ACB9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(136003)(346002)(366004)(376002)(39860400002)(199004)(189003)(36092001)(54906003)(14454004)(71200400001)(256004)(8676002)(2906002)(76176011)(99286004)(7696005)(71190400001)(5250100002)(305945005)(2900100001)(68736007)(74316002)(5660300001)(102836004)(7736002)(97736004)(81166006)(81156014)(3846002)(86362001)(6116002)(486006)(476003)(11346002)(446003)(55016002)(4326008)(186003)(26005)(8936002)(33656002)(316002)(229853002)(9686003)(110136005)(478600001)(6246003)(6436002)(105586002)(25786009)(6506007)(66066001)(106356001)(53546011)(53936002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3101;H:MWHPR07MB3502.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VPBZKp8oxlVQpFvgnarG6fV+ERS1UvBpTdarKSPAnl8CHzDuupHcwi3ffj/vekRjgfjs/HD/Klyy3do0xUSc5oxO2885Y3d1YIN2n/kchg8A08pVtdKJBnQtcU3fINWFMHSdnSYXeAAom9Ux0FKDMmeyvADLoXSHpl9iiCWj2/K5c8aSzRdqv3Jv6MpNduVlwMlTOWk1lx3LM2x8LIiZRZ2IvJr51l9Oeh33R+NYLYWg3SZc9vWvl3dy++mOxtQQGMI9IXkJmg1DXuIEFQAKXFsmI7s/Y7ZOUPIJdlRW2BIearpg4cdmIRaIkGgLnmcfurDvGZwIsvMHmiLsVb6ssvExQn1dq2+hbsta05OfeKc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0b14b7-8a66-444c-a88f-08d6336fce9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2018 14:01:01.8741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3101
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=843 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810160119
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksDQoNCk9uIDE2IE9jdG9iZXIgMjAxOCAxNDo1MywgTG9yZW56byBQaWVyYWxpc2kgPGxvcmVu
em8ucGllcmFsaXNpQGFybS5jb20+IHdyb3RlOg0KPiBPbiBNb24sIE9jdCAxNSwgMjAxOCBhdCAw
NDozMDozNVBNIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPiA+IE9uIFRodSwgT2N0IDEx
LCAyMDE4IGF0IDA1OjE2OjU3UE0gKzAxMDAsIEFsYW4gRG91Z2xhcyB3cm90ZToNCj4gPiA+IElm
IEVQIGF0dGVtcHRzIHRvIHNlbmQgYW4gSVJRIChsZWdhY3ksIE1TSSBvciBNU0ktWCkgd2hpbGUg
dGhlDQo+ID4gPiBsaW5rIGlzIG5vdCB1cCwgcmV0dXJuIC1FSU5WQUwNCj4gPiA+DQo+ID4gPiBG
aXhlczogMzdkZGRmMTRmMWFlICgiUENJOiBjYWRlbmNlOiBBZGQgRW5kUG9pbnQgQ29udHJvbGxl
ciBkcml2ZXIgZm9yIENhZGVuY2UgUENJZSBjb250cm9sbGVyIikNCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEFsYW4gRG91Z2xhcyA8YWRvdWdsYXNAY2FkZW5jZS5jb20+DQo+ID4gPiAtLS0NCj4gPiA+
ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtY2FkZW5jZS1lcC5jIHwgNiArKysrKysNCj4g
PiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1jYWRlbmNlLWVwLmMgYi9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL3BjaWUtY2FkZW5jZS1lcC5jDQo+ID4gPiBpbmRleCBiNzYyMjE0Li4z
NjY3ZDcwIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLWNh
ZGVuY2UtZXAuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLWNhZGVu
Y2UtZXAuYw0KPiA+ID4gQEAgLTM3MCw2ICszNzAsMTIgQEAgc3RhdGljIGludCBjZG5zX3BjaWVf
ZXBfcmFpc2VfaXJxKHN0cnVjdCBwY2lfZXBjICplcGMsIHU4IGZuLA0KPiA+ID4gIAkJCQkgIHUx
NiBpbnRlcnJ1cHRfbnVtKQ0KPiA+ID4gIHsNCj4gPiA+ICAJc3RydWN0IGNkbnNfcGNpZV9lcCAq
ZXAgPSBlcGNfZ2V0X2RydmRhdGEoZXBjKTsNCj4gPiA+ICsJdTMyIGxpbmtfc3RhdHVzOw0KPiA+
ID4gKw0KPiA+ID4gKwkvKiBDYW4ndCBzZW5kIGFuIElSUSBpZiB0aGUgbGluayBpcyBkb3duLiAq
Lw0KPiA+ID4gKwlsaW5rX3N0YXR1cyA9IGNkbnNfcGNpZV9yZWFkbCgmZXAtPnBjaWUsIENETlNf
UENJRV9MTV9CQVNFKTsNCj4gPiA+ICsJaWYgKCEobGlua19zdGF0dXMgJiAweDEpKQ0KPiA+ID4g
KwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4NCj4gPiBUaGlzIGxvb2tzIHJhY3kuICBXaGF0IGhhcHBl
bnMgaWYgdGhlIGxpbmsgZ29lcyBkb3duIHJpZ2h0IGFmdGVyIHRoZQ0KPiA+IENETlNfUENJRV9M
TV9CQVNFIHJlYWQsIGJ1dCBiZWZvcmUgd2UgZ2V0IGhlcmU/DQo+IA0KPiBJIGFncmVlIHdpdGgg
Qmpvcm4sIHRoaXMgY2hlY2sgZG9lcyBub3Qgc2VlbSB2ZXJ5IHVzZWZ1bCBhbmQgaG9uZXN0bHkN
Cj4gSSB0aGluayB0aGlzIHBhdGNoIHNob3VsZCBiZSBkcm9wcGVkLCBJIHNob3VsZCBub3QgaGF2
ZSBxdWV1ZWQgaXQgaW4NCj4gdGhlIGZpcnN0IHBsYWNlLg0KPiANCj4gSSB3b25kZXIgd2hldGhl
ciBzb21ldGhpbmcgY2FuIGFjdHVhbGx5IGJlIGRvbmUgaW4gdGhlIEVQIHN1YnN5c3RlbQ0KPiB0
byBoYW5kbGUgdGhpcyBpbiBhIGNsZWFuZXIgd2F5Lg0KPiANCj4gVW5sZXNzIEkgaGVhciBhIGNv
bXBlbGxpbmcgcmVhc29uIHRvIGtlZXAgaXQgaW4gdGhlIHBhdGNoIHF1ZXVlIEkNCj4gd291bGQg
ZHJvcCB0aGlzIHBhdGNoLg0KPiANCj4gTG9yZW56bw0KTWFrZXMgc2Vuc2UgdG8gbWUsIEkgd2Fz
IGp1c3QgcHJlcGFyaW5nIGEgcmVwbHkuICBJIG5lZWQgdG8gZmluZA0KYSBmaXggdGhhdCB3aWxs
IHdvcmsgZm9yIGFsbCBjYXNlcywgcG9zc2libHkgdXNpbmcgdGhlIGhhbmRzaGFrZQ0KZm9yIHRo
ZSBEMC0+RDMgQ29uZmlnIHdyaXRlIHdoaWNoIHNob3VsZCBwcmVjZWRlIHRoZSBsaW5rIGRvd24u
IEF0DQp0aGUgbW9tZW50IEkgdGhpbmsgd2UgbmVlZCB0byBpbnNpc3QgdGhhdCB0aGUgbGluayBp
cyBhbHdheXMgdXAgd2hpbGUNCnRoZSBFUCBkcml2ZXIgaXMgbG9hZGVkLg0KDQpBbGFuDQoNCg0K
