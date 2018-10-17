Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BDEECDE35
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 09:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9C621527
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 09:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="hkY000PL";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="c2SPVXpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE9C621527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeJQRpM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:45:12 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:53194 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726904AbeJQRpL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 13:45:11 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9H9fjHS005206;
        Wed, 17 Oct 2018 02:50:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=h8kPfztGXPGwKLLKIlZDUVzzMS7y67yHOnADkiS0JSc=;
 b=hkY000PLThBdGxpTTrdum6HR7XyxlfaGQZtlo8k9mcWgl613S+NJ35eF20HaeEMfY454
 Ht33Vj0wQ2syNuf4NL86GXOSye6JblZLOeX7yErUaIifkt5K4iTLQVxPTiSf0D/eEfuy
 XVPQakN2OM8k+64o2foL7aDeWVzR7nf00+6p90VysMkIYTc/mjGZZE86IbMX6db0D1H8
 Y9xqRelefXoiPJM2Hg4PKszs6rxFK+37VSIT2bO3+Jd3v4ydjm5TFa1HN8yBZiG28JnT
 G9v+cCKdc8glwagyg1uDmTmVfzZ/sDcww09ZuDPvPFV1AWhkRmsdpo37ivDWKVGIqQwU uQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp0177.outbound.protection.outlook.com [216.32.180.177])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2n61ecgbvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Oct 2018 02:50:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8kPfztGXPGwKLLKIlZDUVzzMS7y67yHOnADkiS0JSc=;
 b=c2SPVXpjQsw5zDhWXx60c3EcItZW6Gtot1KlzRwv5gHOcoyHHQTczza4x88azGJT6EAAF/0Y0fWtyg0LAC1JNTUjfTALNoL+0kaCuav0P5m/OPftn/xkBxj1+xMAaYM3WmOX5JLFuLTnbKYXHSltDnP6qV4tOA+93/RxEwKX5NM=
Received: from MWHPR07MB3502.namprd07.prod.outlook.com (10.164.192.29) by
 MWHPR07MB2845.namprd07.prod.outlook.com (10.169.230.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20; Wed, 17 Oct 2018 09:50:01 +0000
Received: from MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::807b:c33e:bee7:ecd9]) by MWHPR07MB3502.namprd07.prod.outlook.com
 ([fe80::807b:c33e:bee7:ecd9%4]) with mapi id 15.20.1228.032; Wed, 17 Oct 2018
 09:50:01 +0000
From:   Alan Douglas <adouglas@cadence.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "cyrille.pitchen@bootlin.com" <cyrille.pitchen@bootlin.com>
Subject: RE: [PATCH v4 3/4] PCI: cadence: Check whether MSI is masked before
 sending it
Thread-Topic: [PATCH v4 3/4] PCI: cadence: Check whether MSI is masked before
 sending it
Thread-Index: AQHUYX3MktN9VT/crkmUUXw9E34KyqUiD+EAgAEIJLA=
Date:   Wed, 17 Oct 2018 09:50:01 +0000
Message-ID: <MWHPR07MB3502F90AAF449369E944A90AD8FF0@MWHPR07MB3502.namprd07.prod.outlook.com>
References: <1539274571-545-1-git-send-email-adouglas@cadence.com>
 <20181016160100.GC16390@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181016160100.GC16390@e107981-ln.cambridge.arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0wNWQ3MWQ2Ny1kMWYyLTExZTgtYWI4Yy1mNDk2MzQ4NmY0ZWNcYW1lLXRlc3RcMDVkNzFkNjgtZDFmMi0xMWU4LWFiOGMtZjQ5NjM0ODZmNGVjYm9keS50eHQiIHN6PSIzNDA5IiB0PSIxMzE4NDI0MzQwNTU2OTk1NzkiIGg9IjNKVXR2Q3ZZSURWZ2k4RGZjR0g1NHBiWjVIYz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR07MB2845;20:oL5bVr2cDebNMU4sTYj7xlcJLeQ3Ql1vgmOtrVaohkK6qRwHRO69SDrk1uGmAJTuMbCUhGAl5HgjYJ4Nt1c4K4agv+Muo4/8kEmKAf1S/YaEhmM9yY92f1+Qg7Crf1V4r6B1gciXNZZHmeyTWdM8suV9uEkhIbIuED5MthzlBnqYYbtynqVPsriWevE6WbtlkklGrpiWK6RcS8dIVKEm8J5zuoquxfBs7ynCnf5jmsF5LbOewwuXAjfMTAZlyPnK
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bd5a91e5-f097-41b6-44d9-08d63415e85d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR07MB2845;
x-ms-traffictypediagnostic: MWHPR07MB2845:
x-microsoft-antispam-prvs: <MWHPR07MB28457A3F2FAA57F6FADCE2C1D8FF0@MWHPR07MB2845.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR07MB2845;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB2845;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(136003)(396003)(376002)(39860400002)(346002)(199004)(189003)(36092001)(25786009)(3846002)(4326008)(7736002)(305945005)(74316002)(33656002)(6116002)(105586002)(66066001)(106356001)(102836004)(2900100001)(229853002)(6436002)(99286004)(5250100002)(7696005)(53546011)(6506007)(6246003)(76176011)(71190400001)(6916009)(71200400001)(5660300001)(81156014)(53936002)(9686003)(316002)(55016002)(2906002)(81166006)(8676002)(14454004)(8936002)(478600001)(186003)(14444005)(446003)(486006)(11346002)(26005)(476003)(86362001)(54906003)(68736007)(256004)(97736004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB2845;H:MWHPR07MB3502.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wBpKcJ5czzpEQdlSRWdMFyHlv+GbIakzlqIT9xhZzJu955jCRN/4nRlUM5WbRc4H55Bu1xJKkOeJMGBheItavw86TUNJv82Qada48z1dUEWYXV/dYlvDe6baJcdpcFAIytMw9CsbePvDIG1w6ua5TrFWHYlcdBw/qZ6Z6WGdXXNlA+amVRyf2wiWA7oQlLJL3N2+JI9uu8Gkonfo3zpDX/Xf5Z31qsJDtwcwYVNI2o9w27K/hTz/yWog2v2+vY+32/kxcjbY+dlGwvFu6lBtkmEhjL+icGgg/pxklUDHvCJuKE+xkXisHi7wI6O9CRC7JgVnAdnA4vZlVLavWdbKKh4r28223VjFhHFWmtNf/6Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5a91e5-f097-41b6-44d9-08d63415e85d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 09:50:01.5794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB2845
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810170088
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMTYgT2N0b2JlciAyMDE4IDE3OjAxLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90ZToNCj4gT24g
VGh1LCBPY3QgMTEsIDIwMTggYXQgMDU6MTY6MTFQTSArMDEwMCwgQWxhbiBEb3VnbGFzIHdyb3Rl
Og0KPiA+IFRoZSBFUCBkcml2ZXIgZGlkIG5vdCBjaGVjayB0aGUgbWFzayBiaXQgZm9yIGVhY2gg
TVNJIGJlZm9yZQ0KPiA+IHNlbmRpbmcgaXQgaW4gcmFpc2VfaXJxLiAgVGhpcyBpcyBub3cgY2hl
Y2tlZCwgYW5kIC1FSU5WQUwgaXMNCj4gPiByZXR1cm5lZCBpZiBtYXNrZWQuDQo+ID4NCj4gPiBG
aXhlczogMzdkZGRmMTRmMWFlICgiUENJOiBjYWRlbmNlOiBBZGQgRW5kUG9pbnQgQ29udHJvbGxl
ciBkcml2ZXIgZm9yIENhZGVuY2UgUENJZSBjb250cm9sbGVyIikNCj4gPiBTaWduZWQtb2ZmLWJ5
OiBBbGFuIERvdWdsYXMgPGFkb3VnbGFzQGNhZGVuY2UuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2
ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtY2FkZW5jZS1lcC5jIHwgNSArKysrKw0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9wY2llLWNhZGVuY2UtZXAuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvcGNpZS1jYWRlbmNlLWVwLmMNCj4gPiBpbmRleCBjM2EwODg5Li5iNzYyMjE0IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1jYWRlbmNlLWVwLmMNCj4gPiAr
KysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtY2FkZW5jZS1lcC5jDQo+ID4gQEAgLTMz
Miw2ICszMzIsMTEgQEAgc3RhdGljIGludCBjZG5zX3BjaWVfZXBfc2VuZF9tc2lfaXJxKHN0cnVj
dCBjZG5zX3BjaWVfZXAgKmVwLCB1OCBmbiwNCj4gPiAgCWlmICghaW50ZXJydXB0X251bSB8fCBp
bnRlcnJ1cHRfbnVtID4gbXNpX2NvdW50KQ0KPiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+DQo+
ID4gKwkvKiBDaGVjayB3aGV0aGVyIE1TSSBpcyBtYXNrZWQgKi8NCj4gPiArCWRhdGEgPSBjZG5z
X3BjaWVfZXBfZm5fcmVhZHcocGNpZSwgZm4sIGNhcCArIFBDSV9NU0lfTUFTS182NCk7DQo+ID4g
KwlpZiAoZGF0YSAmICgxIDw8IChpbnRlcnJ1cHRfbnVtIC0gMSkpKQ0KPiA+ICsJCXJldHVybiAt
RUlOVkFMOw0KPiA+ICsNCj4gDQo+IEJ5IGxvb2tpbmcgYXQgdGhpcywgSSB0aGluayB0aGlzIGlz
IHdyb25nIHRvby4gVG8gdGhlIGJlc3Qgb2YgbXkNCj4ga25vd2xlZGdlIGEgbWFza2VkIE1TSSBz
aG91bGQgYmUgc3RpbGwgZGVsaXZlcmVkIHdoZW4gdGhlIE1TSSBpcw0KPiB1bm1hc2tlZCwgb3Ro
ZXJ3aXNlIHRoZSBjb25kaXRpb24gdGhhdCB0cmlnZ2VyZWQgdGhlIE1TSSBpcyBsb3N0Lg0KPiAN
CkluIGZhY3QsIHRoZSBkcml2ZXIgY2xlYXJzIHRoZSBwZXItdmVjdG9yIG1hc2tpbmcgY2FwYWJs
ZSBiaXQgaW4gdGhlIE1lc3NhZ2UNCkNvbnRyb2wgcmVnaXN0ZXIsIHNvIHRoaXMgY2hlY2sgc2hv
dWxkIG5vdCBiZSBuZWVkZWQuICBQbGVhc2UgZHJvcCB0aGlzDQpwYXRjaCAuDQoNCkkgd2FzIHJl
dHVybmluZyAtRUlOVkFMIHNvIHRoYXQgdGhlIGNhbGxpbmcgY29kZSB3b3VsZCBiZSBhd2FyZSB0
aGF0IHRoZQ0KTVNJIHdhcyBub3QgZGVsaXZlcmVkLg0KDQo+IFRoZXJlIG11c3QgYmUgY29kZSBp
biB0aGUgRVAgc3Vic3lzdGVtIHRoYXQgcmVjb3JkcyB0aGUgInBlbmRpbmciIE1TSQ0KPiBhbmQg
ZGVsaXZlciBpdCB3aGVuIHRoZSBNU0kgaXMgYWN0dWFsbHkgdW5tYXNrZWQgKEkgYXNzdW1lZCB0
aGlzIGlzDQo+IGRvbmUgaW4gSFcgYnV0IEkgbmVlZCB5b3VyIGNsYXJpZmljYXRpb24gb24gdGhp
cykuDQo+IA0KSWYgcGVyLXZlY3RvciBtYXNraW5nIGlzIGVuYWJsZWQsIHRoZSBFUCBzaG91bGQg
c2V0IHRoZSBwZW5kaW5nIGJpdCB3aGVuDQp3aXNoaW5nIHRvIHNlbmQgYSBjdXJyZW50bHkgbWFz
a2VkIE1TSS4gIFRoZSBIVyB3aWxsIGdlbmVyYXRlIGFuDQpsb2NhbCBpbnRlcnJ1cHQgb24gYW55
IGNoYW5nZSB0byB0aGUgTVNJIG1hc2sgcmVnaXN0ZXIsIGFsbG93aW5nIHRoZQ0KZHJpdmVyIHRv
IHNlbmQgYW55IHBlbmRpbmcgTVNJIGlmIHRoZXkgYXJlIHVubWFza2VkLiAgSSB3b3VsZCBuZWVk
DQp0byBhZGQgZHJpdmVyIHN1cHBvcnQgZm9yIHRoaXMgaWYgZW5hYmxpbmcgUFZNLiAgVGhlIHF1
ZXN0aW9uIHRoZW4gaXMNCndoYXQgdG8gcmV0dXJuIGZyb20gc2VuZF9tc2lfaXJxKCksIGFuZCB3
aGV0aGVyL2hvdyB0byBsZXQgdGhlDQpjYWxsaW5nIGNvZGUga25vdyB3aGVuL2lmIHRoZSBNU0kg
d2FzIGV2ZW50dWFsbHkgZGVsaXZlcmVkLg0KDQo+IEVpdGhlciB0aGF0IG9yIHRoZSByZXR1cm4g
dmFsdWUgbXVzdCBzaWduYWwgYSBtYXNrZWQgTVNJIHNvIHRoYXQgdGhlDQo+IGNvZGUgY2FsbGlu
ZyBzZW5kX21zaV9pcnEoKSBjYW4gcmVpc3N1ZSBpdCAod2hlbiB0aG91Z2ggPykuDQo+DQpUaGUg
b25seSB3YXkgSSBzZWUgdG8gZG8gdGhpcyB3b3VsZCBiZSBjYWxsIHNlbmRfbXNpX2lycSgpIHVu
dGlsIGl0DQpzdWNjZWVkcywgdGhpcyB3b3VsZCBiZSBlZmZlY3RpdmVseSBwb2xsaW5nIHRoZSBN
U0kgbWFzayByZWdpc3Rlci4NCg0KPiBJIHdpbGwgaGF2ZSB0byBkcm9wIHRoaXMgcGF0Y2ggdG9v
IHVubGVzcyB5b3UgY29udmluY2UgbWUgSSBhbSB3cm9uZzsgSQ0KPiBzdGlsbCB3YW50IHRvIHVu
ZGVyc3RhbmQgaG93IHRoaXMgY29kZSBpcyAqY3VycmVudGx5KiB3b3JraW5nLCBJDQo+IHVuZGVy
c3RhbmQgdGhhdCBmb3IgdGhlIHRpbWUgYmVpbmcgdGhlIG9ubHkgRVAgZGV2aWNlIHdlIGhhdmUg
aXMgdGhlDQo+IHRlc3Qgb25lIGJ1dCB0aGlzIGNvZGUgcGF0aCBkb2VzIG5vdCBsb29rIHZlcnkg
c29saWQgdG8gbWUuDQo+IA0KQXMgYWJvdmUgSSBkb24ndCB3YW50IHRvIGNvbnZpbmNlIHlvdSB0
byB0YWtlIHRoaXMgcGF0Y2guICBIb3dldmVyLA0Kc2luY2UgUFZNIGlzIGN1cnJlbnRseSBkaXNh
YmxlZCBmb3IgdGhlIGRldmljZSwgdGhlIG9yaWdpbmFsIGNvZGUNCnBhdGggbG9va3MgT0sgdG8g
bWUuICBMZXQgbWUga25vdyBpZiB5b3UgaGF2ZSBvdGhlciBjb25jZXJucw0KYWJvdXQgaXQuDQoN
ClRoYW5rcywNCkFsYW4NCg0KPiBUaGFua3MsDQo+IExvcmVuem8NCj4gDQo+ID4gIAkvKiBDb21w
dXRlIHRoZSBkYXRhIHZhbHVlIHRvIGJlIHdyaXR0ZW4uICovDQo+ID4gIAlkYXRhX21hc2sgPSBt
c2lfY291bnQgLSAxOw0KPiA+ICAJZGF0YSA9IGNkbnNfcGNpZV9lcF9mbl9yZWFkdyhwY2llLCBm
biwgY2FwICsgUENJX01TSV9EQVRBXzY0KTsNCj4gPiAtLQ0KPiA+IDEuOS4wDQo+ID4NCg==
