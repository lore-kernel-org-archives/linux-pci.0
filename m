Return-Path: <SRS0=ex/N=MK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE81C43382
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 15:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CDF2082C
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 15:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="LPZBl/kS";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="i/mIT10Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CDF2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbeI1V64 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:58:56 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:36190 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729124AbeI1V64 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Sep 2018 17:58:56 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SFQrBB012426;
        Fri, 28 Sep 2018 08:34:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=n9WLkQoD5o57CsaZM0Tp7yZrjo3t24pJkAtLOGdrHAk=;
 b=LPZBl/kSx8WIzC+14WgIUZFtt+csqTff5FQBWoQi544Do2X9htFUE6SLUXWoSmNP7/SL
 j3aPlBbG3VMIYmJqGdqVeQ9seV/2ILJEKvm1AxK+pOfPC41JpDOY5yEJX6UDWwj3i0Lq
 hM68QZ6hVHyZIwnUFwLboSpf69nvVrv4QCtdWABFyvPaxOStZnLp/YX14PSAYXylQRPK
 lfCkrzzQgK4mAUk1ykkO6QcnbIBFWJKPbIxrPPNwK9icUWTDSmxOwsvlKCsbWUij80wD
 vlNuA3s/MYx6FRDaTzxk9u0BpFshOyRtygPmWxA24wLNdHlmE/MT+izEXnbiqhNATChV tw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp0016.outbound.protection.outlook.com [216.32.181.16])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2msa862ver-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 28 Sep 2018 08:34:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9WLkQoD5o57CsaZM0Tp7yZrjo3t24pJkAtLOGdrHAk=;
 b=i/mIT10QVrKT9Tlmc98s65OdQGobP17qAv9MFWRk8OIm0mUbXvmB5XRr0350lsmPjxFeB6TsPKMYR21GxuWhHAiXPO9Y6PiqDcDS8zFMofOSSSJuM0Hmd2Pc2wg3IyJcliczQRVBcehM+H6bhraDj3IwH/kVeeRFz0S3DXQ4RlI=
Received: from MWHPR07MB3502.namprd07.prod.outlook.com (10.164.192.29) by
 MWHPR07MB3520.namprd07.prod.outlook.com (10.164.192.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 28 Sep 2018 15:34:23 +0000
Received: from MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::8d72:9288:d100:975b]) by MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::8d72:9288:d100:975b%2]) with mapi id 15.20.1164.024; Fri, 28 Sep 2018
 15:34:23 +0000
From:   Alan Douglas <adouglas@cadence.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "cyrille.pitchen@bootlin.com" <cyrille.pitchen@bootlin.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>
Subject: RE: [PATCH v2] PCI: cadence: Correct probe behaviour when failing to
 get PHY
Thread-Topic: [PATCH v2] PCI: cadence: Correct probe behaviour when failing to
 get PHY
Thread-Index: AQHUVxlIYijAOCFUFUWDoheIINa57qUF0m+AgAAAMbA=
Date:   Fri, 28 Sep 2018 15:34:23 +0000
Message-ID: <MWHPR07MB350278CEE59B35E7CB39554CD8EC0@MWHPR07MB3502.namprd07.prod.outlook.com>
References: <1538131878-8305-1-git-send-email-adouglas@cadence.com>
 <20180928153125.GB24460@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180928153125.GB24460@e107981-ln.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1mY2EyNzA4YS1jMzMzLTExZTgtYWI4Yi1hNDRjYzhlYzVlY2RcYW1lLXRlc3RcZmNhMjcwOGMtYzMzMy0xMWU4LWFiOGItYTQ0Y2M4ZWM1ZWNkYm9keS50eHQiIHN6PSIyNDIyIiB0PSIxMzE4MjYyMjQ2OTQyMDg5MDUiIGg9InlTS0Q5YmZtMWkrTjJjMFJnM2RKemM0clNpQT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR07MB3520;20:XdKGF0BkrzDutfZUfiL+EcFszPW/VO2XWhSi1gbHnNFjTu/ywfaC7WBDQqrEIWby2fb4h87Eq7rIkb5lqC/cmbywQKSqJcoAzOi2Ttb45DsK9+JgSA35jnXWJWF6ISgWgIgFgK87PvOmNZFb48ycxrDZlKwI9oaWkQe4En8yvaUiRnoOuQzTzP+0QTBMQ+PLDPrioDy588rda2PEe6zUHhmndnaeEXiOey8o+B5TwE6mII5XMJi0CxdY20kRqkPr
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d977330d-547b-4957-dcd7-08d62557de14
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR07MB3520;
x-ms-traffictypediagnostic: MWHPR07MB3520:
x-microsoft-antispam-prvs: <MWHPR07MB35202F7582A45FFEA91A3578D8EC0@MWHPR07MB3520.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:MWHPR07MB3520;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3520;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(346002)(39850400004)(396003)(36092001)(199004)(189003)(229853002)(305945005)(7696005)(76176011)(33656002)(14454004)(2906002)(74316002)(86362001)(3846002)(6116002)(99286004)(8676002)(68736007)(316002)(55016002)(106356001)(7736002)(9686003)(478600001)(53936002)(54906003)(8936002)(6436002)(105586002)(81156014)(81166006)(6246003)(71190400001)(34290500001)(4326008)(25786009)(5660300001)(476003)(486006)(97736004)(53546011)(6506007)(5250100002)(6916009)(66066001)(11346002)(14444005)(26005)(2900100001)(186003)(102836004)(256004)(71200400001)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3520;H:MWHPR07MB3502.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8C9vtojDcSWyZHGNf/VsUP135UHhTTZDSyEkCM0rxO11e6op9WKcprsEo6YKpaCwgHsRLD/0oNEsW1k9AS/rBZS4g+IvfrT1tD8cOW89lxWG7iohLsNqnnKWTs81t/saWCw85H241q8OEG6ltZR0KfStedd7P2n535ewgl+EGWR9G0T86SzKN4IJeytAzKLTiGK5UD1jpcqjZOnKKJHX2CLoGuQjdCYvncU7140W4a3FFhscpzyBp4nnVV2APII5/5r8E2fnSR3z4ixuB+2TV/cXwY1NTscDC79iNofwt+upLK4DW3s0Y8BATc0VKFw40RdTeMCayqFjS/wH3sXx31bvwP0lkeZHKklPh5HIjCA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d977330d-547b-4957-dcd7-08d62557de14
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 15:34:23.6545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3520
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809280155
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksDQpPbiAyOCBTZXB0ZW1iZXIgMjAxOCAxNjozMSwgTG9yZW56byBQaWVyYWxpc2kgd3JvdGU6
DQo+IE9uIEZyaSwgU2VwIDI4LCAyMDE4IGF0IDExOjUxOjE4QU0gKzAxMDAsIEFsYW4gRG91Z2xh
cyB3cm90ZToNCj4gPiBUZXN0IHRoZSBjb3JyZWN0IHZhbHVlIHRvIHNlZSB3aGV0aGVyIHRoZSBQ
SFkgZ2V0IGZhaWxlZC4NCj4gPg0KPiA+IFVzZSBkZXZtX3BoeV9nZXQoKSBpbnN0ZWFkIG9mIGRl
dm1fcGh5X29wdGlvbmFsX2dldCgpLCBzaW5jZSBpdCBpcw0KPiA+IG9ubHkgY2FsbGVkIGlmIHBo
eSBuYW1lIGlzIGdpdmVuIGluIGRldmljZXRyZWUgYW5kIHNvIHNob3VsZCBleGlzdC4NCj4gPiBJ
ZiBmYWlsdXJlIHdoZW4gZ2V0dGluZyBvciBsaW5raW5nIFBIWSwgcHV0IGFueSBQSFlzIHdoaWNo
IHdlcmUNCj4gPiBhbHJlYWR5IGdvdCBhbmQgdW5saW5rIHRoZW0uDQo+ID4NCj4gPiBGaXhlczog
ZGZiODA1MzQ2OTJkZGM1YiAoIlBDSTogY2FkZW5jZTogQWRkIGdlbmVyaWMgUEhZIHN1cHBvcnQg
dG8gaG9zdCBhbmQgRVAgZHJpdmVycyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxhbiBEb3VnbGFz
IDxhZG91Z2xhc0BjYWRlbmNlLmNvbT4NCj4gPiAtLS0NCj4gPiBjaGFuZ2VzIHNpbmNlIHYxOg0K
PiA+ICAgIC0gQ29ycmVjdCBlcnJvciBpbiB3aGlsZSBsb29wIHBvaW50ZWQgb3V0IGJ5IENvbGlu
IEtpbmcNCj4gDQo+IElzIHRoZXJlIGEgcmVhc29uIHdoeSBJIHNob3VsZCBOT1QgYWRkIENvbGlu
IGFzIGEgUmVwb3J0ZWQtYnkgPw0KPiANCk5vLCBJIHNob3VsZCBoYXZlIGFkZGVkIENvbGluIGFz
IFJlcG9ydGVkLWJ5DQoNCj4gTG9yZW56bw0KPiANCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxl
ci9wY2llLWNhZGVuY2UuYyB8IDIwICsrKysrKysrKysrKy0tLS0tLS0tDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1jYWRlbmNlLmMgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL3BjaWUtY2FkZW5jZS5jDQo+ID4gaW5kZXggODZmMWIwMC4uNTg2NTUxMiAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtY2FkZW5jZS5jDQo+
ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLWNhZGVuY2UuYw0KPiA+IEBAIC0x
OTAsMTQgKzE5MCwxNiBAQCBpbnQgY2Ruc19wY2llX2luaXRfcGh5KHN0cnVjdCBkZXZpY2UgKmRl
diwgc3RydWN0IGNkbnNfcGNpZSAqcGNpZSkNCj4gPg0KPiA+ICAJZm9yIChpID0gMDsgaSA8IHBo
eV9jb3VudDsgaSsrKSB7DQo+ID4gIAkJb2ZfcHJvcGVydHlfcmVhZF9zdHJpbmdfaW5kZXgobnAs
ICJwaHktbmFtZXMiLCBpLCAmbmFtZSk7DQo+ID4gLQkJcGh5W2ldID0gZGV2bV9waHlfb3B0aW9u
YWxfZ2V0KGRldiwgbmFtZSk7DQo+ID4gLQkJaWYgKElTX0VSUihwaHkpKQ0KPiA+IC0JCQlyZXR1
cm4gUFRSX0VSUihwaHkpOw0KPiA+IC0NCj4gPiArCQlwaHlbaV0gPSBkZXZtX3BoeV9nZXQoZGV2
LCBuYW1lKTsNCj4gPiArCQlpZiAoSVNfRVJSKHBoeVtpXSkpIHsNCj4gPiArCQkJcmV0ID0gUFRS
X0VSUihwaHlbaV0pOw0KPiA+ICsJCQlnb3RvIGVycl9waHk7DQo+ID4gKwkJfQ0KPiA+ICAJCWxp
bmtbaV0gPSBkZXZpY2VfbGlua19hZGQoZGV2LCAmcGh5W2ldLT5kZXYsIERMX0ZMQUdfU1RBVEVM
RVNTKTsNCj4gPiAgCQlpZiAoIWxpbmtbaV0pIHsNCj4gPiArCQkJZGV2bV9waHlfcHV0KGRldiwg
cGh5W2ldKTsNCj4gPiAgCQkJcmV0ID0gLUVJTlZBTDsNCj4gPiAtCQkJZ290byBlcnJfbGluazsN
Cj4gPiArCQkJZ290byBlcnJfcGh5Ow0KPiA+ICAJCX0NCj4gPiAgCX0NCj4gPg0KPiA+IEBAIC0y
MDcsMTMgKzIwOSwxNSBAQCBpbnQgY2Ruc19wY2llX2luaXRfcGh5KHN0cnVjdCBkZXZpY2UgKmRl
diwgc3RydWN0IGNkbnNfcGNpZSAqcGNpZSkNCj4gPg0KPiA+ICAJcmV0ID0gIGNkbnNfcGNpZV9l
bmFibGVfcGh5KHBjaWUpOw0KPiA+ICAJaWYgKHJldCkNCj4gPiAtCQlnb3RvIGVycl9saW5rOw0K
PiA+ICsJCWdvdG8gZXJyX3BoeTsNCj4gPg0KPiA+ICAJcmV0dXJuIDA7DQo+ID4NCj4gPiAtZXJy
X2xpbms6DQo+ID4gLQl3aGlsZSAoLS1pID49IDApDQo+ID4gK2Vycl9waHk6DQo+ID4gKwl3aGls
ZSAoLS1pID49IDApIHsNCj4gPiAgCQlkZXZpY2VfbGlua19kZWwobGlua1tpXSk7DQo+ID4gKwkJ
ZGV2bV9waHlfcHV0KGRldiwgcGh5W2ldKTsNCj4gPiArCX0NCj4gPg0KPiA+ICAJcmV0dXJuIHJl
dDsNCj4gPiAgfQ0KPiA+IC0tDQo+ID4gMS45LjANCj4gPg0K
