Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E066C43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 18:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2016D2133F
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 18:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="CVKqnoaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2016D2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbeK1FwT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:52:19 -0500
Received: from mail-eopbgr700115.outbound.protection.outlook.com ([40.107.70.115]:55616
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730447AbeK1FwT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Nov 2018 00:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeMMelTINFPG+G94hbYHKSkjNBfA8W314QUVGHbyot4=;
 b=CVKqnoaGlrd6QjonfHZ7zswTHzwUtpQL4ytF5GB/tH2Adg5VCBZ+X8YmLRDxoRtuykmavg38FBtPXf2lX3luLIUBqa8wz5TWiOoBuPADUZZS7y0nUxVgqs0SOjkQAsvgx01QaTSXe7ONj6lttrooBzWGPC4DxhR9p13gmNiysQA=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3785.namprd06.prod.outlook.com (10.167.236.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.20; Tue, 27 Nov 2018 18:53:25 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c0f3:ea8f:48ba:a5d7%4]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 18:53:25 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        "hancock@sedsystems.ca" <hancock@sedsystems.ca>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>
Subject: Re: iMX6 PCIe MSI issues
Thread-Topic: iMX6 PCIe MSI issues
Thread-Index: AQHUhaWJBRIzlENaBEOJ27/P3prKvaViSkqAgAAluQCAAYmlgA==
Date:   Tue, 27 Nov 2018 18:53:25 +0000
Message-ID: <1543344805.18519.71.camel@impinj.com>
References: <aad42775-52b6-6086-60a8-e45a17d50960@sedsystems.ca>
         <CAOMZO5DuZ4ZWk03tnsTx=Vpd8AbnCADMgyyKRuL0F6N3ZmN6qw@mail.gmail.com>
         <1543252169.18519.49.camel@impinj.com>
         <4a582df8-f7dc-3ad5-42d7-33924eb57b0a@sedsystems.ca>
In-Reply-To: <4a582df8-f7dc-3ad5-42d7-33924eb57b0a@sedsystems.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3785;6:DJoA2RQ0f5K/JB5QIpRWB3HbXxWTZSEw1ftbLk5A81izV099lY/4/xnW5p9Qj6Jx2em3uQQV0ZWHD+hklZ28A0m97n7UNokhkQBj1T2ZEMlLd34ZItURbMqioPfYjAB8GCzEzd4YbtJpW+W+Mg+LNBz0Z64HZI86h1bCtp/rkWogU+8eugPZ14s4CWqWVENU+oV0+5SM19e5R3xNHun/855A/grFVWf/m5NRG+Y0vVbM+uRb1sV2DbJPh0oWyDN3APGIeYXx702gqDKUjhQu7dwPCG+5H59EcEVBS3MFhpSeUAovT3B7ZjUUJIQR3n2cKEeQZigrDArv1E+75qAfyBB9OEXKc6U1xcVzkJ+dPwdIYG2hcFQCpFAOV7RC9GeQ/LdrO9NUqvJ5E1iZ/37orwe8LjkQB/EKRm1H298jh/nnsw0FtOOD5dw2q+IRWxw7vwfLkcIBFTYaBXLUosaaew==;5:CZZMqZ5A+Fhy9Bm8DfUYseIsDdyOY16+LZK91Coi4REf2ZPXwubAngAq4wWN766k/fWZ3AMgf8Hc97Uq+cSRbvXmLx9zoXmQRqyzvrCIKsb55MUTLGycKp2LsKWAirZdU7edde6Z+vgjncScVtvrf9LwKpP61SlciAMu6cEt9ak=;7:EajbHZawwrGo482TYSG1Xq2Tuv/2Wv/5l7JJjiHEwo4hPDdg8v/VhJutjcTNymyIrVIEGRpTOzzgWT0oQGnPC9fujboxRn5GsJtmDv4L3fRFF7FxVM+ffDi/edov7C63SM5Ml0uZ49pIYQcQ/LJKZA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 26cf0fb9-db2a-4102-dd8e-08d654999cc7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3785;
x-ms-traffictypediagnostic: MWHPR0601MB3785:
x-microsoft-antispam-prvs: <MWHPR0601MB378517C5BD33BF204EDB1169D3D00@MWHPR0601MB3785.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231443)(944501410)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3785;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3785;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(39850400004)(136003)(189003)(199004)(4326008)(68736007)(446003)(11346002)(14444005)(256004)(53936002)(486006)(86362001)(106356001)(2906002)(3846002)(6512007)(6116002)(6246003)(2201001)(476003)(39060400002)(2616005)(105586002)(6436002)(71190400001)(71200400001)(103116003)(36756003)(229853002)(76176011)(14454004)(6486002)(99286004)(2501003)(26005)(186003)(478600001)(6506007)(316002)(102836004)(54906003)(110136005)(4001150100001)(97736004)(81166006)(93886005)(8676002)(81156014)(8936002)(25786009)(5660300001)(305945005)(7736002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3785;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: m2jk7cJUgKzFNIQF1+C36kkXaVGsyVEf9ekcBmEHVPRwFRJzyQvVOBhT7ODPt92vV3y7SyyNknflg4nSJC5A3ckzICRDgNMGjhZoZpl9fstKvBKjOx1AbormR80io1GrbaJhnVrj8G7M7fhfX5uS48avgxTf2bK8LyWUw2skUS8/jb5ibQxEYQuYi6ifAb2zC3yydtUIMaqAzv6aenx8+6zsidZQ8x8YNFlzBckAs4DINRnpG8J/ze1s3dysur6qZmSbcPbO6irI5nfsltE6PtZGRwReShrY0rgFxqRWGzu9mZLwpvm6cojl1bvaRAbYwa2CBjOTL2LnXwwaQyWE+SwfWeylrcXX2GaLXKfQheM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5370CDF0337A349A55CA6F89B6AF27C@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cf0fb9-db2a-4102-dd8e-08d654999cc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 18:53:25.5796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3785
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDE4LTExLTI2IGF0IDEzOjI0IC0wNjAwLCBSb2JlcnQgSGFuY29jayB3cm90ZToN
Cj4gDQo+ID4gQWxzbywgSSB0aGluayB0aGUgbmV3IGlycSBkb21haW4gc3R1ZmYgaW4gNC4xNyBi
cmVha3MgaXJxIGFjY291bnRpbmcgdG8NCj4gPiB0aGUgR0lDIGNoYWluIGludGVycnVwdCAoMTUy
KSB0byB0aGUgZHdjIG1zaSBkb21haW4uICBJdCdsbCBhbHdheXMgc2hvdw0KPiA+IGFzIHplcm8g
aW4gL3Byb2MvaW50ZXJydXB0cy4gIEJ1dCBJJ3ZlIG1vc3RseSBiZWVuIHdvcmtpbmcgaW4gNC4x
NiBzbw0KPiA+IEknbSBub3Qgc3VyZSBhYm91dCB0aGUgcHJlY2lzZSBpbnRlcmFjdGlvbiBvZiBp
cnEgZG9tYWlucyBhbmQNCj4gPiAvcHJvYy9pbnRlcnJ1cHRzIHlldC4NCj4gDQo+IEknbSBub3Qg
YWN0dWFsbHkgc2VlaW5nIHRoZSBNU0kgaW50ZXJydXB0IHNob3dpbmcgdXAgaW4gL3Byb2MvaW50
ZXJydXB0cw0KPiBhdCBhbGwgaW4gNC4xOS4gRnJvbSBhZGRpbmcgc29tZSBkZWJ1ZyBvdXRwdXQg
aW50byB0aGUgZHdjIFBDSWUgY29kZSwgaXQNCj4gYXBwZWFycyBpdCdzIHVzaW5nIExpbnV4IElS
USAyNCBhcyB0aGUgY2hhaW5pbmcgaW50ZXJydXB0LCBidXQgdGhlcmUncw0KPiBubyBlbnRyeSBp
biAvcHJvYy9pbnRlcnJ1cHRzIGZvciBlaXRoZXIgTGludXggSVJRIDI0IG9yIEdJQyB2ZWN0b3Ig
MTUyLg0KPiBOb3Qgc3VyZSBpZiB0aGVyZSBpcyBzdXBwb3NlZCB0byBiZSBvciBub3QuIEl0IGRv
ZXMgYXBwZWFyIHRoYXQgdGhlDQo+IHZlY3RvciBpc24ndCBtYXNrZWQgaW4gdGhlIEdJQyBpbiBh
bnkgY2FzZSwgaG93ZXZlciwgYW5kIHdoZW4gSSBmb3JjZQ0KPiB0aGUgaW50ZXJydXB0IGludG8g
dGhlIEdJQyBwZW5kaW5nIHJlZ2lzdGVyLCB0aGluZ3Mgc2VlbSB0byBoYXBwZW4NCj4gcHJvcGVy
bHkgYWZ0ZXIgdGhhdC4NCg0KSW4gNC4xNiwgdGhlIE1TSSBjaGFpbmluZyBpbnRlcnJ1cHQgZG9l
cyBzaG93IHVwIGluIC9wcm9jL2ludGVycnVwdHMNCmFuZCBkb2VzIGluY3JlbWVudC4gIEFsc28g
c2hvd3MgdXAgYXMgdHJhY2UgZXZlbnRzIHRvby4NCg0KSW4gNC4xNywgaXQgbm8gbG9uZ2VyIGFw
cGVhcnMgaW4gL3Byb2MvaW50ZXJydXB0cy4gIEZpbmRpbmcgdGhlIExpbnV4DQppcnEgbnVtYmVy
IGlzIG5vbi1vYnZpb3VzLCBhcyB5b3UndmUgc2Vlbi4gIEl0IHdpbGwgc2hvdyB1cCBpbg0KL3N5
cy9rZXJuZWwvaXJxIGFuZCAvc3lzL2tlcm5lbC9kZWJ1Zy9pcnEvaXJxcywgYnV0IHRoZSBjb3Vu
dCBpcyBhbHdheXMNCnplcm8uICBJTUhPLCBub3QgYW4gaW1wcm92ZW1lbnQuDQoNClNvIGlmIHlv
dSdyZSB1c2luZyB0aGF0IGNvdW50IGluIC9zeXMgdG8gZGV0ZXJtaW5lIHRoYXQgdGhlIEdJQyBp
cnENCm5ldmVyIGZpcmVkLCB0aGVuIGl0J3Mgbm90IGNvbmNsdXNpdmUuICBJdCBhbHdheXMgcmVh
ZHMgemVyby4NCg0KQnV0IHRoZSBzYW1lIHByb2JsZW0gMjAxNCB3b3VsZCBvYnZpb3VzbHkgcHJl
ZGF0ZSB0aGUgNC4xNyBrZXJuZWwu
