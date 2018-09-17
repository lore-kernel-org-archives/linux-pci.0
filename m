Return-Path: <SRS0=obOR=L7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437D7ECE563
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 17:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C996214DC
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 17:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="pitao1WL";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="To6C80kV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C996214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeIQWcS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:32:18 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:44584 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726894AbeIQWcS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Sep 2018 18:32:18 -0400
X-Greylist: delayed 4098 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2018 18:32:18 EDT
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8HFspGN027930;
        Mon, 17 Sep 2018 08:55:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=rX/pHb08LjHS3C0pTiODYnxS5S/aTC5GGBn3RoElCnw=;
 b=pitao1WLHCCE2CXMBXXrs2JJy+D3mPbbPSr8ZBTXmjYA67T/qFLOL1hGi97jha1m4QM9
 /CEoZWgQYpR/Z4e5OqG+KkcdE9Hic7lJOl9OWheLc06jpPjObt5+PprVhhwdeAIxi6YJ
 3IpGh0XZZfrNFLLbGVOT1/hjR+55Vh7Wcf1veaaU2KGvsFdTIFVd4vhim26Ca0TtcPwG
 eGIgVIs2u4RfXYrlzuzkWbBDC5yfKSrzeUOS/KGuz8VjeCHOwzSZDBMiIYVzB2D/6D5z
 xYOLHSULBZHrDrz9+EAPryxYOYVefWE/cenfREp0AgkZMVwSatiuAvKjbw8zObuYMXk1 KA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp0184.outbound.protection.outlook.com [216.32.181.184])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2mgwnv22kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 17 Sep 2018 08:55:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rX/pHb08LjHS3C0pTiODYnxS5S/aTC5GGBn3RoElCnw=;
 b=To6C80kVugobVJg1G0tALwEEcSa5prhLgc4KujBU1JkGftJyRrMqL79WNB3lE8EYGwIaek5WMKiXkXDS8u2HLBy8FHOZz8vlGFSRDW4BMX1Nkqn7cZFzRKsZhZ4Wo/CaoamyU6frbW7AAVW4dSe5jDLKA9hlWwQAaIRcdBxjTQg=
Received: from MWHPR07MB3502.namprd07.prod.outlook.com (10.164.192.29) by
 MWHPR07MB2911.namprd07.prod.outlook.com (10.169.231.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Mon, 17 Sep 2018 15:55:51 +0000
Received: from MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::5d19:3d62:16c3:8811]) by MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::5d19:3d62:16c3:8811%3]) with mapi id 15.20.1143.014; Mon, 17 Sep 2018
 15:55:50 +0000
From:   Alan Douglas <adouglas@cadence.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "cyrille.pitchen@bootlin.com" <cyrille.pitchen@bootlin.com>,
        Scott Telford <stelford@cadence.com>
Subject: RE: [PATCH v2 5/5] PCI: cadence: Add MSI-X capability to EP driver
Thread-Topic: [PATCH v2 5/5] PCI: cadence: Add MSI-X capability to EP driver
Thread-Index: AQHUNJ7Fl4LIKbgG4Eq3e3WbKVQlXqTfqwIAgABMfvCAFNS+AIAABo/Q
Date:   Mon, 17 Sep 2018 15:55:49 +0000
Message-ID:
 <MWHPR07MB3502D6EF11136AF4D0EA03A9D81E0@MWHPR07MB3502.namprd07.prod.outlook.com>
References: <1534340948-24093-1-git-send-email-adouglas@cadence.com>
 <daa340ff-1860-dec4-a814-a0ba63227748@ti.com>
 <MWHPR07MB3502C39FD5E4455C2E89CAC0D8030@MWHPR07MB3502.namprd07.prod.outlook.com>
 <20180917152602.GI7239@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180917152602.GI7239@e107981-ln.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0xYjAyYzdmZS1iYTkyLTExZTgtYWI4OS1hNDRjYzg0ZTk5NTlcYW1lLXRlc3RcMWIwMmM4MDAtYmE5Mi0xMWU4LWFiODktYTQ0Y2M4NGU5OTU5Ym9keS50eHQiIHN6PSI0MjIyIiB0PSIxMzE4MTY3MzMzMjYxMTUwNDAiIGg9IkM1RG9LdStCUkIvRE5yUFIrUHJRME9YVlNkRT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR07MB2911;20:n6Sj+khnVqb8DNuL6Ky4D2dqRdw0Kvux4nVa2jn0WKAD3kOVTP3bnovmPlGjRYmgvPuHLroQP2lwNC056a6yYczrBkJPlv5rW4SiooofEx5v884LTGScL2oLtLzY1rLM6kVDZ0ea/lHWirIGDvpFRQZB6oqKPFwmsQh9tUU92swRqCs0SB6sTlwwq5yAdKBVhH7GIr58eOuMh1H4dj7ugntFsxm8Cl8mfCS5IawXzdq4j+c3cV4NMz6o+3wodIRq
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(366004)(199004)(36092001)(189003)(14444005)(478600001)(102836004)(8936002)(76176011)(6506007)(53546011)(476003)(68736007)(11346002)(97736004)(86362001)(26005)(5660300001)(575784001)(8676002)(256004)(99286004)(2900100001)(105586002)(106356001)(74316002)(446003)(6436002)(107886003)(7696005)(14454004)(53936002)(5250100002)(186003)(93886005)(54906003)(9686003)(25786009)(55016002)(4326008)(229853002)(3846002)(6116002)(2906002)(66066001)(316002)(6246003)(6916009)(305945005)(486006)(81156014)(81166006)(7736002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB2911;H:MWHPR07MB3502.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 49436621-78ff-4e42-a53f-08d61cb60a2f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR07MB2911;
x-ms-traffictypediagnostic: MWHPR07MB2911:
x-microsoft-antispam-prvs: <MWHPR07MB2911A46E3876BBDD825B9120D81E0@MWHPR07MB2911.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699050);SRVR:MWHPR07MB2911;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB2911;
x-forefront-prvs: 0798146F16
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sjT63yBa16fJuo5k4SsG+KkKX4VgAo5iKMS5Rh0bwTFtklskIimR54GvdGJ87tNFW+eDPByqCe9INSZUna2HJ5EZdPRqppsa5yuqR/SlgpqsmzLrNsQOtO8aLDSDEWhv2X8DvlfE9Cau51Hje/Vy0180bILgcsE0Eza3UrgWijtCnPIS8yUsZRsz1cFC5/kanFkhhwE9kBKRIAhT6fWBiUrfZFdd2SXNH8qBwbvbTI5mKUlhNRpz46xhVAHbsdDbC1DWvt5snSvfG67VPbIHdoXmJNdorXRVrT7XmCjZru6gu/bAKp4fOliy3LVU9ppVN/tbRIMheZitlg733xlr3eJM2fwhLrbgNgucjFcAO28=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49436621-78ff-4e42-a53f-08d61cb60a2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 15:55:49.8774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB2911
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-17_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809170160
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180917155549.bXiCH7LBsFliephZ6uXBOL0xNE2SeTlXKM0N-2WX0zk@z>

SGkgTG9yZW56bywNCg0KT24gMTcgU2VwdGVtYmVyIDIwMTggMTY6MjYgTG9yZW56byBQaWVyYWxp
c2kgd3JvdGU6DQo+IE9uIFR1ZSwgU2VwIDA0LCAyMDE4IGF0IDA5OjMyOjU2QU0gKzAwMDAsIEFs
YW4gRG91Z2xhcyB3cm90ZToNCj4gPiBIaSwNCj4gPiBPbiAwNCBTZXB0ZW1iZXIgMjAxOCAwNTo0
NiwgS2lzaG9uIFZpamF5IEFicmFoYW0gSSB3cm90ZToNCj4gPiA+IE9uIFdlZG5lc2RheSAxNSBB
dWd1c3QgMjAxOCAwNzoxOSBQTSwgQWxhbiBEb3VnbGFzIHdyb3RlOg0KPiA+ID4gPiBBZGQgc2V0
X21zaXggYW5kIGdldF9tc2l4IGZ1bmN0aW9ucyB0byBkcml2ZXIsIGFuZCBoYW5kbGUNCj4gPiA+
ID4gUENJX0VQQ19JUlFfTVNJWCByZXF1ZXN0IGluIHJhaXNlX2lycS4gIEJBUjUgaXMgdXNlZCBm
b3INCj4gPiA+ID4gdGhlIE1TSS1YIHZlY3RvcnMuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEFsYW4gRG91Z2xhcyA8YWRvdWdsYXNAY2FkZW5jZS5jb20+DQo+ID4gPiA+IC0tLQ0K
PiA+ID4gPiAgIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1jYWRlbmNlLWVwLmMgfCAxMDcg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ID4gPiAgIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpZS1jYWRlbmNlLmggICAgfCAgIDEgKw0KPiA+ID4gPiAgIDIgZmlsZXMgY2hh
bmdlZCwgMTA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4NCj4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1jYWRlbmNlLWVwLmMgYi9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtY2FkZW5jZS1lcC5jDQo+ID4gPiA+IGluZGV4IDEy
NDhkNzUuLjI1OWI5YTYgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvcGNpZS1jYWRlbmNlLWVwLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9wY2llLWNhZGVuY2UtZXAuYw0KPiA+ID4gPiBAQCAtMTYsNiArMTYsNyBAQA0KPiA+ID4gPiAg
ICNkZWZpbmUgQ0ROU19QQ0lFX0VQX01JTl9BUEVSVFVSRQkJMTI4CS8qIDEyOCBieXRlcyAqLw0K
PiA+ID4gPiAgICNkZWZpbmUgQ0ROU19QQ0lFX0VQX0lSUV9QQ0lfQUREUl9OT05FCQkweDENCj4g
PiA+ID4gICAjZGVmaW5lIENETlNfUENJRV9FUF9JUlFfUENJX0FERFJfTEVHQUNZCTB4Mw0KPiA+
ID4gPiArI2RlZmluZSBDRE5TX1BDSUVfRVBfTVNJWF9CQVIJCQkweDUNCj4gPiA+ID4NCj4gPiA+
ID4gICAvKioNCj4gPiA+ID4gICAgKiBzdHJ1Y3QgY2Ruc19wY2llX2VwIC0gcHJpdmF0ZSBkYXRh
IGZvciB0aGlzIFBDSWUgZW5kcG9pbnQgY29udHJvbGxlciBkcml2ZXINCj4gPiA+ID4gQEAgLTI1
NSw2ICsyNTYsNDMgQEAgc3RhdGljIGludCBjZG5zX3BjaWVfZXBfZ2V0X21zaShzdHJ1Y3QgcGNp
X2VwYyAqZXBjLCB1OCBmbikNCj4gPiA+ID4gICAJcmV0dXJuIG1tZTsNCj4gPiA+ID4gICB9DQo+
ID4gPiA+DQo+ID4gPiA+ICtzdGF0aWMgaW50IGNkbnNfcGNpZV9lcF9nZXRfbXNpeChzdHJ1Y3Qg
cGNpX2VwYyAqZXBjLCB1OCBmdW5jX25vKQ0KPiA+ID4gPiArew0KPiA+ID4gPiArCXN0cnVjdCBj
ZG5zX3BjaWVfZXAgKmVwID0gZXBjX2dldF9kcnZkYXRhKGVwYyk7DQo+ID4gPiA+ICsJc3RydWN0
IGNkbnNfcGNpZSAqcGNpZSA9ICZlcC0+cGNpZTsNCj4gPiA+ID4gKwl1MzIgY2FwID0gQ0ROU19Q
Q0lFX0VQX0ZVTkNfTVNJWF9DQVBfT0ZGU0VUOw0KPiA+ID4gPiArCXUzMiB2YWwsIHJlZzsNCj4g
PiA+ID4gKw0KPiA+ID4gPiArCXJlZyA9IGNhcCArIFBDSV9NU0lYX0ZMQUdTOw0KPiA+ID4gPiAr
CXZhbCA9IGNkbnNfcGNpZV9lcF9mbl9yZWFkdyhwY2llLCBmdW5jX25vLCByZWcpOw0KPiA+ID4g
PiArCWlmICghKHZhbCAmIFBDSV9NU0lYX0ZMQUdTX0VOQUJMRSkpDQo+ID4gPiA+ICsJCXJldHVy
biAtRUlOVkFMOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJdmFsICY9IFBDSV9NU0lYX0ZMQUdTX1FT
SVpFOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJcmV0dXJuIHZhbDsNCj4gPiA+ID4gK30NCj4gPiA+
ID4gKw0KPiA+ID4gPiArc3RhdGljIGludCBjZG5zX3BjaWVfZXBfc2V0X21zaXgoc3RydWN0IHBj
aV9lcGMgKmVwYywgdTggZm4sIHUxNiBpbnRlcnJ1cHRzKQ0KPiA+ID4gPiArew0KPiA+ID4gPiAr
CXN0cnVjdCBjZG5zX3BjaWVfZXAgKmVwID0gZXBjX2dldF9kcnZkYXRhKGVwYyk7DQo+ID4gPiA+
ICsJc3RydWN0IGNkbnNfcGNpZSAqcGNpZSA9ICZlcC0+cGNpZTsNCj4gPiA+ID4gKwl1MzIgY2Fw
ID0gQ0ROU19QQ0lFX0VQX0ZVTkNfTVNJWF9DQVBfT0ZGU0VUOw0KPiA+ID4gPiArCXUzMiB2YWws
IHJlZzsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCXJlZyA9IGNhcCArIFBDSV9NU0lYX0ZMQUdTOw0K
PiA+ID4gPiArCXZhbCA9IGNkbnNfcGNpZV9lcF9mbl9yZWFkdyhwY2llLCBmbiwgcmVnKTsNCj4g
PiA+ID4gKwl2YWwgJj0gflBDSV9NU0lYX0ZMQUdTX1FTSVpFOw0KPiA+ID4gPiArCXZhbCB8PSBp
bnRlcnJ1cHRzOw0KPiA+ID4gPiArCWNkbnNfcGNpZV9lcF9mbl93cml0ZXcocGNpZSwgZm4sIHJl
ZywgdmFsKTsNCj4gPiA+ID4gKwkvKiBTZXQgTVNJWCBCQVIgYW5kIG9mZnNldCAqLw0KPiA+ID4g
PiArCWNkbnNfcGNpZV9lcF9mbl93cml0ZWwocGNpZSwgZm4sIDB4YjQsIENETlNfUENJRV9FUF9N
U0lYX0JBUik7DQo+ID4gPg0KPiA+ID4gUGxlYXNlIGFkZCBhIG1hY3JvIGZvciBNU0lYIHRhYmxl
IG9mZnNldC4NCj4gPiA+IEkgdGhpbmsgaXQgcmVsaWVzIG9uIGVuZHBvaW50IGZ1bmN0aW9uIGRy
aXZlciB0byBpbnZva2Ugc2V0X2JhciBmb3INCj4gPiA+IEJBUjU/IEl0J3MgcG9zc2libGUgYSBm
dW5jdGlvbiBkcml2ZXIgY2FuIGludm9rZSBzZXRfbXNpeCB3aXRob3V0IHNldF9iYXIuDQo+ID4g
Pg0KPiA+IEknbGwgYWRkIGEgbWFjcm8gZm9yIE1TSVggdGFibGUgb2Zmc2V0Lg0KPiA+IFllcywg
aXQgcmVsaWVzIG9uIHRoZSBCQVIgYmVpbmcgc2V0IHVwIGFscmVhZHkuICBJJ2xsIGFkZCBjb2Rl
IHRvIGNoZWNrIEJBUg0KPiA+IGV4aXN0cyBhbmQgaXMgbGFyZ2UgZW5vdWdoLCBhbmQgY3JlYXRl
IGl0IGlmIG5vdC4NCj4gPg0KPiA+ID4gPiArCS8qIFNldCBQQkEgQkFSIGFuZCBvZmZzZXQuICBC
QVIgbXVzdCBtYXRjaCBNU0lYIEJBUiAqLw0KPiA+ID4gPiArCWNkbnNfcGNpZV9lcF9mbl93cml0
ZWwocGNpZSwgZm4sIDB4YjgsIDB4MTAwMDAgfCBDRE5TX1BDSUVfRVBfTVNJWF9CQVIpOw0KPiA+
ID4NCj4gPiA+IEhlcmUgdG9vIGFkZCBhIG1hY3JvIGZvciBQQkEuDQo+ID4gPiBIb3cgZGlkIHlv
dSBnZXQgdGhlIDB4MTAwMDA/DQo+ID4gSSdsbCBhZGQgYSBtYWNybyBmb3IgUEJBLg0KPiA+IFRo
ZSAweDEwMDAwICgzMioyMDQ4KSBpcyB0byBhbGxvdyBzcGFjZSBpbiB0aGUgQkFSIGZvciAyMDQ4
IE1TSS1YIHZlY3RvcnMgYmVuZWF0aA0KPiA+IHRoZSBQQkEuIEFjdHVhbGx5LCBJIGNvdWxkIGNo
YW5nZSB0aGlzIHRvIDMyKmludGVycnVwdHMgc28gdGhhdCB0aGUgQkFSIHNpemUgY2FuIGJlDQo+
ID4gbWluaW1pemVkIGRlcGVuZGluZyBvbiB0aGUgbnVtYmVyIG9mIE1TSS1YIHByb2dyYW1tZWQu
DQo+ID4NCj4gPiBUaGFua3MgZm9yIHlvdXIgY29tbWVudHMsDQo+ID4gQWxhbg0KPiANCj4gSGkg
QWxhbiwNCj4gDQo+IHNob3VsZCBJIGV4cGVjdCBhIHYzIGZvciB0aGlzIHNlcmllcyB0byBhZGRy
ZXNzIEtpc2hvbidzIGNvbW1lbnRzID8NCj4gUGxlYXNlIGxldCBtZSBrbm93LCB0aGUgcHJldmlv
dXMgZml4ZXMgbG9vayBPSyB0byBtZS4NCj4gDQpJJ20gcHJlcGFyaW5nIGEgdjMgd2hpY2ggd2ls
bCBjaGVjayB0aGF0IHRoZSBCQVIgdG8gYmUgdXNlZCBmb3IgTVNJLVgNCmhhcyBiZWVuIHNldCB1
cCwgYW5kIHdpbGwgcmV0dXJuIC1FSU5WQUwgaWYgbm90LiAgSSBjb3VsZG4ndCBmaW5kIGENCnN1
aXRhYmxlIHdheSB0byBhbGxvY2F0ZSB0aGUgQkFSIGluc2lkZSB0aGUgc2V0X21zaXggZnVuY3Rp
b24uDQpJdCB3aWxsIGFsc28gYWRkcmVzcyBLaXNob24ncyBvdGhlciBjb21tZW50cy4NCg0KSSBl
eHBlY3QgdG8gc2VuZCBpdCB0b21vcnJvdywganVzdCBiYWNrIGZyb20gaG9saWRheSB0b2RheS4N
Cg0KUmVnYXJkcywNCkFsYW4NCiANCg==
