Return-Path: <SRS0=Cddw=OF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4FBC43441
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 17:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C461A20672
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 17:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="ltGANI7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C461A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbeK0EHJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:07:09 -0500
Received: from mail-eopbgr740120.outbound.protection.outlook.com ([40.107.74.120]:34368
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726355AbeK0EHJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Nov 2018 23:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhE4WJY8mddKFoN6Ti6ibAVtzhqmmWt2MtjoyuYiN9M=;
 b=ltGANI7XiL+/v4L4/lxjwuj0ztSvSfUVnO5ACEDvIx/5xuRnlRUkjMwIOqH9W/AhupnfNUhYI5xav2KyQY4gqkcxYPgI2n65ZaMXlvmym48ZKI5GLWWacpwLIQZZNixViFWQoSdVUPCr9TEu8PNhgA4kL9QN0V8klPJkb+y+LqI=
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com (52.132.101.36) by
 CY4PR0601MB3729.namprd06.prod.outlook.com (52.132.101.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Mon, 26 Nov 2018 17:09:30 +0000
Received: from CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::c090:3ad2:d81c:8407]) by CY4PR0601MB3697.namprd06.prod.outlook.com
 ([fe80::c090:3ad2:d81c:8407%6]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 17:09:29 +0000
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
Thread-Index: AQHUhaWJBRIzlENaBEOJ27/P3prKvaViSkqA
Date:   Mon, 26 Nov 2018 17:09:29 +0000
Message-ID: <1543252169.18519.49.camel@impinj.com>
References: <aad42775-52b6-6086-60a8-e45a17d50960@sedsystems.ca>
         <CAOMZO5DuZ4ZWk03tnsTx=Vpd8AbnCADMgyyKRuL0F6N3ZmN6qw@mail.gmail.com>
In-Reply-To: <CAOMZO5DuZ4ZWk03tnsTx=Vpd8AbnCADMgyyKRuL0F6N3ZmN6qw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR0601MB3729;6:U5bCOk0jAdNEA47xGbkohY6NImyEVN0McDlAumcpseew//yxi/Bo0CD9NlF0RHfDgFL36lM81Fuy3KSyKJ+UjB/fKCovpX5neZDq9Cu2KvU3xTLMJHwOeZ6O6PnE8q0BXR+O84P9KEKy+edTuXGxnZYrLDeBKfqHQQRb4b70FOfxreeMB8r3nCFKvLSdxQjSC1sFmNFKv0q31w2fVBviddzCVkoTXu/kel2rcYWgoK/XD3LxLeQyc/blXsXvpOludSzQiKqYKEnmfXnDQag9E+Z+Z6/Tol++zIQ3DWUhUQ6z5S/kQhmHbBw2Vy4uU1+3gNgyAADgFxwPkSMcjXUnRQ8/B2f1c4jFzCDO37h8R4cwSCFQkxFkLOqKBTHYgtbMYCNaNcgvpNLz/sEDi4OadXz4IoOYAVYvYexkjjmuSC+nMZgF+UfCNTFisWMcNe6aEUQ1UZi7aXJS+yka3iYwYg==;5:dGrbWagK5FPgV6WaKltPo8dNn8o1JHCVcBB7yojYUr6gDLvNJUaqFmT9G1v+1WRoYu71IOJGjSOKCfdAlc+dT9/jO5iRRp/CYwdigh1iOoiermAUd/uhNlcuRqPuxMJdtni0JgX7uo9OeC8K+DkU/agWwf7v7lg8oLqwmZv+mkE=;7:iH7ryP+dahYhetjHf94IldQiABGMDKwABDDhsTQxZXuVtqGzeBKvrebB4+4jGkgk2lGAP9ZQouV9ymn7IOj8ODvGatob752rCAD25Jdakn8UTAbV5vo/EwGGPytDUpyGMv1jnH1C8a2LzBBVedii/w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c074fadc-223b-4e53-d954-08d653c1ed8f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR0601MB3729;
x-ms-traffictypediagnostic: CY4PR0601MB3729:
x-microsoft-antispam-prvs: <CY4PR0601MB3729F778BDCBF392A6C5C4A7D3D70@CY4PR0601MB3729.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231443)(944501410)(4982022)(52105112)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CY4PR0601MB3729;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0601MB3729;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39850400004)(366004)(396003)(136003)(346002)(252514010)(189003)(199004)(6512007)(5660300001)(8936002)(97736004)(8676002)(81156014)(81166006)(68736007)(4001150100001)(256004)(14444005)(305945005)(39060400002)(53936002)(2501003)(7736002)(3846002)(6116002)(36756003)(2616005)(575784001)(86362001)(2201001)(476003)(486006)(229853002)(2906002)(106356001)(105586002)(6436002)(6486002)(66066001)(6306002)(6246003)(446003)(11346002)(4326008)(102836004)(26005)(25786009)(99286004)(6506007)(316002)(71200400001)(71190400001)(54906003)(110136005)(76176011)(53546011)(45080400002)(186003)(478600001)(966005)(14454004)(103116003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR0601MB3729;H:CY4PR0601MB3697.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4JBwp7euBfe9i3W3BnEYrZOMiNFBKMxc++w8v+M5Cu2eLmaZqICN8PC7eZEj1+Er+ctBs5wPr4JfE41zqz/YXql87Y+5p8rFh5thTSLAH/nY9k6uOAdAuGyeIF1hK38mTrcnFzvG4YtmSN4RDs4RXHX5CAH4GKosVk6/DvzOuOY7sWnJQdKT7TbKrqhbqr3QKztBmIMG2b9APRq5hK5vDRkqWwpqryQXPtHThz+szZimdqPbTs2geI57+1bNck3xtN8uCBrPKb2ROdqe0DtGXthsfv1NBCbePWn5OzjOr+tNUUpp0hIEIUplLDSxy4sWMKc/mgANS4EIw50V3AZVoQ/JTh1ARGi2H5Cx2vX7dgI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <575A6D4B07B5F74583C721D017FAAEA3@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c074fadc-223b-4e53-d954-08d653c1ed8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 17:09:29.6863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0601MB3729
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VGhlcmUgaXMgYSBidWcgdGhhdCBhcHBlYXJlZCBpbiA0LjE0IHRoYXQgd2lsbCByZXN1bHQgaW4g
YW4gTVNJIGdldHRpbmcNCmRyb3BwZWQgaWYgaXQgb2NjdXJzIGR1cmluZyBvciBzaG9ydGx5IGFm
dGVyIHRoYXQvYW5vdGhlciBNU0kgaW50ZXJydXB0DQpoYW5kbGVyIGlzIHJ1bi4gIE9idmlvdXNs
eSwgdGhlbiBtZWFucyBvbmUgbmVlZHMgdG8gZ2V0IGF0IGxlYXN0IG9uZQ0KTVNJIHRvIHdvcmsg
aW4gdGhlIGZpcnN0IHBsYWNlIHRvIHNlZSB0aGUgYnVnIQ0KDQpSb2JlcnQncyBkZXNjcmlwdGlv
biBhbHNvIGhhcyBNU0kgc3RhdHVzIHNldCBpbiBkd2MgbXNpIHN0YXR1cyByZWdpc3Rlcg0KKDB4
ODMwKSwgdGhhdCB3b3VsZCBub3QgYmUgdGhlIGNhc2UgZm9yIHRoZSBNU0kgcmFjZS4NCg0KQW4g
aW50ZXJydXB0IGlzIG9ubHkgcGFzc2VkIHVwIHRvIHRoZSBHSUMgb24gYSAwLT4xIHRyYW5zaXRp
b24gaW4gdGhlDQpkd2MgbXNpIHN0YXR1cyBiaXQuICBXZSBzZWUgaXQncyBhIDEgbm93LCBidXQg
d2FzIHRoZSBHSUMgaW50ZXJydXB0DQplbmFibGVkIHdoZW4gdGhlIHRyYW5zaXRpb24gaGFwcGVu
ZWQ/ICBJdCdzIG5vdCBzYWlkIGJlbG93IGlmIHRoYXQgd2FzDQpjaGVja2VkLg0KDQpUcnkgY2xl
YXJpbmcgdGhlIHN0YXR1cyAod3JpdGUgYSAqMSogdG8gdGhlIGJpdCBjbGVhciBpdCkgaW4gdGhl
IGR3Yw0KbXNpIHN0YXR1cyByZWdpc3RlciwgY2hlY2sgdGhhdCBpdCBpcyBub3cgemVybywgYW5k
IHRoZW4gc2VlIGlmIGFub3RoZXINCk1TSSBjYXVzZXMgaXQgdG8gYmVjb21lIHNldCwgYW5kIGRv
ZXMgdGhhdCBtYWtlIGl0IHRvIHRoZSBHSUM/DQoNCklmIGl0IGRvZXMgYmVjb21lIHNldCwgYnV0
IG5vIGlycSB0byB0aGUgR0lDLCB0aGVuIEkgaGF2ZSBubyBpZGVhIHdoYXQNCmlzIHRoZXJlIHRv
IHN0b3AgaXQuICBUaGlzIHBhcnQgb2YgdGhlIGNoaXAgaXMgbm90IGRvY3VtZW50ZWQgd2VsbC4N
Cg0KQWxzbywgSSB0aGluayB0aGUgbmV3IGlycSBkb21haW4gc3R1ZmYgaW4gNC4xNyBicmVha3Mg
aXJxIGFjY291bnRpbmcgdG8NCnRoZSBHSUMgY2hhaW4gaW50ZXJydXB0ICgxNTIpIHRvIHRoZSBk
d2MgbXNpIGRvbWFpbi4gIEl0J2xsIGFsd2F5cyBzaG93DQphcyB6ZXJvIGluIC9wcm9jL2ludGVy
cnVwdHMuICBCdXQgSSd2ZSBtb3N0bHkgYmVlbiB3b3JraW5nIGluIDQuMTYgc28NCkknbSBub3Qg
c3VyZSBhYm91dCB0aGUgcHJlY2lzZSBpbnRlcmFjdGlvbiBvZiBpcnEgZG9tYWlucyBhbmQNCi9w
cm9jL2ludGVycnVwdHMgeWV0Lg0KDQpPbiBNb24sIDIwMTgtMTEtMjYgYXQgMTQ6MzEgLTAyMDAs
IEZhYmlvIEVzdGV2YW0gd3JvdGU6DQo+IEFkZGluZyBUcmVudCBhbmQgVGltIChhcyBJIHRoaW5r
IHRoZXkgbWFuYWdlZCB0byBmaXggc29tZSBpbXg2IE1TSQ0KPiBpc3N1ZXMpDQo+IA0KPiBPbiBG
cmksIE5vdiAyMywgMjAxOCBhdCA4OjE3IFBNIFJvYmVydCBIYW5jb2NrIDxoYW5jb2NrQHNlZHN5
c3RlbXMuY2ENCj4gPiB3cm90ZToNCj4gPiANCj4gPiBJIGFtIHdvcmtpbmcgd2l0aCBhIGN1c3Rv
bSBGUEdBIFBDSSBFeHByZXNzIGVuZHBvaW50IGNvbm5lY3RlZCB0bw0KPiA+IGFuIE5YUA0KPiA+
IGlNWDZEIHByb2Nlc3NvciBydW5uaW5nIHRoZSA0LjE5LjIga2VybmVsLiBJdCBzZWVtcyBoYXBw
eSB1c2luZw0KPiA+IElOVHgNCj4gPiBpbnRlcnJ1cHRzIGJ1dCB3aGVuIHRyeWluZyB0byBlbmFi
bGUgTVNJIHRoZSBkZXZpY2UgZHJpdmVyIGlzIG5vdA0KPiA+IHJlY2VpdmluZyBhbnkgaW50ZXJy
dXB0cy4NCj4gPiANCj4gPiBGcm9tIHNvbWUgcmVnaXN0ZXIgcG9raW5nIEkgaGF2ZSBmaWd1cmVk
IG91dDoNCj4gPiAtdGhlIE1TSSBhZGRyZXNzIHNldCBvbiB0aGUgUENJZSBkZXZpY2UgaXMgY29y
cmVjdGx5IHNldCBpbiB0aGUgaU1YDQo+ID4gTVNJDQo+ID4gY29udHJvbGxlcidzIE1TSSBDb250
cm9sbGVyIEFkZHJlc3MgcmVnaXN0ZXIgKDB4MWZmYzgyMCkNCj4gPiAtdGhlIGludGVycnVwdCB2
ZWN0b3JzIGFyZSBlbmFibGVkIGluIHRoZSBNU0kgY29udHJvbGxlcidzDQo+ID4gSW50ZXJydXB0
DQo+ID4gRW5hYmxlIHJlZ2lzdGVyICgweDFmZmM4MjgpDQo+ID4gLXRoZSBpbnRlcnJ1cHQgdmVj
dG9ycyBhcmUgbm90IG1hc2tlZCBpbiB0aGUgTVNJIGNvbnRyb2xsZXIncw0KPiA+IEludGVycnVw
dA0KPiA+IE1hc2sgcmVnaXN0ZXIgKDB4MWZmYzgyYykNCj4gPiAtVGhlIE1TSSBjb250cm9sbGVy
J3MgSW50ZXJydXB0IFN0YXR1cyByZWdpc3RlciAoMHgxZmZjODMwKSBzaG93cw0KPiA+IHRoYXQN
Cj4gPiB0aGUgcmVxdWVzdGVkIGludGVycnVwdCB2ZWN0b3JzIGFyZSBwZW5kaW5nDQo+ID4gLUlu
IHRoZSBBUk0gR0lDLCB2ZWN0b3IgMTUyIChmb3IgbXNpX2N0cmxfaW50KSBpcyBlbmFibGVkIGlu
IHRoZSBJUw0KPiA+IGVuYWJsZSByZWdpc3RlciAoMHgwMGEwMTExMCksIGJ1dCBub3Qgc2V0IGlu
IHRoZSBJUyBwZW5kaW5nDQo+ID4gKDB4MDBhMDEyMTApDQo+ID4gb3IgSVMgYWN0aXZlICgweDAw
YTAxMzEwKSByZWdpc3RlcnMNCj4gPiAtVmVjdG9yIDE1MiBpcyBub3QgbWFza2VkIGluIHRoZSBH
UEMgaW50ZXJydXB0IG1hc2sgKDB4MDBhMDEzMTApDQo+ID4gLVZlY3RvciAxNTIgaXMgbm90IGFj
dGl2ZSBpbiB0aGUgR1BDIGludGVycnVwdCBzdGF0dXMgKDB4MDBhMDEzMTApDQo+ID4gDQo+ID4g
U28gaXQgYXBwZWFycyB0aGUgTVNJIGNvbnRyb2xsZXIgaXMgcmVjZWl2aW5nIGFuZCByZWNvZ25p
emluZyB0aGUNCj4gPiBNU0kNCj4gPiBmcm9tIHRoZSBkZXZpY2UsIGJ1dCB0aGUgaW50ZXJydXB0
IGlzIG5vdCBtYWtpbmcgaXQgaW50byB0aGUgR0lDDQo+ID4gZm9yDQo+ID4gc29tZSByZWFzb24u
IElmIEkgbWFudWFsbHkgc2V0IHZlY3RvciAxNTIgdG8gcGVuZGluZyBpbiB0aGUgR0lDLA0KPiA+
IHRoZQ0KPiA+IGR3X2hhbmRsZV9tc2lfaXJxIGhhbmRsZXIgaW4gcGNpLWRlc2lnbndhcmUtaG9z
dC5jIGRvZXMgZ2V0IGNhbGxlZA0KPiA+IGFsb25nDQo+ID4gd2l0aCB0aGUgaW50ZXJydXB0IGhh
bmRsZXIocykgZm9yIHRoZSBQQ0llIGRldmljZSwgc28gaXQgYXBwZWFycw0KPiA+IHRoZQ0KPiA+
IGNoYWluIGZyb20gdGhhdCBwb2ludCBvbiBpcyB3b3JraW5nOg0KPiA+IA0KPiA+ICMgZGV2bWVt
IDB4MDBhMDEyMTAgMzIgMHgxMDAwMDAwDQo+ID4gDQo+ID4gSSBmb3VuZCBzb21lb25lIGVsc2Ug
cmVwb3J0aW5nIHRoaXMgaW4gMjAxNCB3aXRoIGFuIHVua25vd24ga2VybmVsDQo+ID4gdmVyc2lv
biBvbiB0aGUgTlhQIGZvcnVtcyBoZXJlLCBidXQgd2l0aCBubyByZXNvbHV0aW9uIGxpc3RlZA0K
PiA+IHRoZXJlOg0KPiA+IA0KPiA+IGh0dHBzOi8vbmEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5v
dXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGY28NCj4gPiBtbXVuaXR5Lm54cC5jb20lMkZ0
aHJlYWQlMkYzMTgzMDcmYW1wO2RhdGE9MDIlN0MwMSU3Q3RwaWVwaG8lNDBpbXBpDQo+ID4gbmou
Y29tJTdDYjFlNGFmNGM1ODcwNDY1MWJjNGUwOGQ2NTNiY2FhYmUlN0M2ZGU3MGYwZjczNTc0NTI5
YTQxNWQ4Yw0KPiA+IGJiN2U5M2U1ZSU3QzAlN0MwJTdDNjM2Nzg4NDY3MTE5OTQ1NDI0JmFtcDtz
ZGF0YT1JMWIlMkJaMUw5OU1Fck5BNDQNCj4gPiBKbGZmVGVqcVpsRlNXaFNrTGVTRm12ODMwUmcl
M0QmYW1wO3Jlc2VydmVkPTANCj4gPiANCj4gPiBBbnkgaWRlYXMgb24gd2hhdCBtYXkgYmUgZ29p
bmcgd3Jvbmc/IE15IG5leHQgc3RlcCBtYXkgYmUgdG8gdHJ5IGFuDQo+ID4gb2xkZXIga2VybmVs
IHZlcnNpb24gdG8gc2VlIGlmIHRoaXMgZ290IGJyb2tlbiBhdCBzb21lIHBvaW50Lg0KPiA+IA0K
PiA+IC0tDQo+ID4gUm9iZXJ0IEhhbmNvY2sNCj4gPiBTZW5pb3IgU29mdHdhcmUgRGV2ZWxvcGVy
DQo+ID4gU0VEIFN5c3RlbXMNCj4gPiBFbWFpbDogaGFuY29ja0BzZWRzeXN0ZW1zLmNhDQo+ID4g
DQo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4g
PiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdA0KPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZw0KPiA+IGh0dHBzOi8vbmEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5v
dXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZsaXMNCj4gPiB0cy5pbmZyYWRlYWQub3JnJTJG
bWFpbG1hbiUyRmxpc3RpbmZvJTJGbGludXgtYXJtLQ0KPiA+IGtlcm5lbCZhbXA7ZGF0YT0wMiU3
QzAxJTdDdHBpZXBobyU0MGltcGluai5jb20lN0NiMWU0YWY0YzU4NzA0NjUxYmMNCj4gPiA0ZTA4
ZDY1M2JjYWFiZSU3QzZkZTcwZjBmNzM1NzQ1MjlhNDE1ZDhjYmI3ZTkzZTVlJTdDMCU3QzAlN0M2
MzY3ODg0DQo+ID4gNjcxMTk5NDU0MjQmYW1wO3NkYXRhPTZqbmROOHlPR3htNjB5JTJCMmZVdVdU
Wm5OdkFzOTY3UEw2S25vbmNYeWI2dw0KPiA+ICUzRCZhbXA7cmVzZXJ2ZWQ9MA==
