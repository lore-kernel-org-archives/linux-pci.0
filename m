Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,URI_HEX autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4973BC43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 07:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12202145D
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 07:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SJ80Ajga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12202145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbeK0SID (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:08:03 -0500
Received: from mail-eopbgr150059.outbound.protection.outlook.com ([40.107.15.59]:54912
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728170AbeK0SIC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Nov 2018 13:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsfP+WaERey53/xLX+k/0CA76NXwzBN2EW3sQmhiuDk=;
 b=SJ80AjgaztJJxk7ApUf8tiWE95HHbAyZ4FQlNlwv+Tl6E88NMrQd8a0JXvLXMf1TuOX4TVdXwoXvwYFECpmRbTXlnF6jPUxKmwrw5TqPCizTiskGRxa6RBZf6J09G2mmviT9qJdtM8NqBXQH+Ef2R+ywIi/QftNsMlE8EQaBS/c=
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (20.177.49.14) by
 VI1PR04MB4608.eurprd04.prod.outlook.com (20.177.56.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Tue, 27 Nov 2018 07:09:55 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::21f7:a45b:3d8f:d16a]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::21f7:a45b:3d8f:d16a%2]) with mapi id 15.20.1339.032; Tue, 27 Nov 2018
 07:09:55 +0000
From:   Bharat Bhushan <bharat.bhushan@nxp.com>
To:     Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "mst@redhat.com" <mst@redhat.com>
CC:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH v5 0/7] Add virtio-iommu driver
Thread-Topic: [PATCH v5 0/7] Add virtio-iommu driver
Thread-Index: AQHUgpsXeHl7ad603kCKIUR+2mj3UKVdB+mAgAYy9JA=
Date:   Tue, 27 Nov 2018 07:09:55 +0000
Message-ID: <VI1PR04MB4845EF310EAB55ACABB71E389AD00@VI1PR04MB4845.eurprd04.prod.outlook.com>
References: <20181122193801.50510-1-jean-philippe.brucker@arm.com>
 <250a38a9-e6b1-35ae-9261-eb8aab123f43@redhat.com>
In-Reply-To: <250a38a9-e6b1-35ae-9261-eb8aab123f43@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4608;6:uUN3wHA7AtopyilY/j5kfdBf2mJjonBivrP2Qk/V/yLfsdF+i9tKed95sCH/0ZvDb9+0gqrDD7NiEaddT4ZgBubCL+BAR96p646r3EbtZ3jCFX74or+XTRmwROx2j5Bxed8jmcZ8JTBnPzho2uk65qvvgdif3hDVdKYXV5ckNpf38W+DxTdm7e6suJvOvFYdQue2apu9xuFbN32JshGDtoORpZNuPdcRqT5+LhJ55T3waJjo3F16+i6UUm2CO1/7gYtgJjuYnHXHOkZeTQtlOxI0au0snxZvbEoBiiCLd3oJdHSLzR/owT1xgbhUHx0BwKttvOqoHBPGBC02jUSCHs0CjPrRm2VTV9iBHb9tnmXmTkBU4H7cVCOxIZan3sIP2/h64y0zMoXb9+jjS6PUyPLPvRb5005AzfJWxsrOIBx46FwU7+VeKJd8OifpUtFmKRVV/AZBMCAQsYdh6WZGNw==;5:zbebAx0xZ6VOq2tU7RRj7uyGhSI/MAoN660wmePiefbUANGqxH2glB1yDxjgABK6Uxec7YCzmcjgfb2nBDqyroz0hMxaNc3fNvkVrbp9j5gkz1fOwcBwuqQSuBr9V1X6KKSHsVG7csbk3ied6sU4m7t7SLu+j+r8UImM+uI5QiE=;7:LyJ9oEculWWTcZPNRmgwgkAVa015yhhSlPkI2cs0mSrtTWHQ94T0rnUsUSR3kswbiVGdzFUpPCiyKYvfzrfU38VNi3xmaRMVCWIdsnE/sJAHm/V9VHGvdy3w8b+nKQwVM8LiT39NvAn6gBENOvi26Q==
x-ms-office365-filtering-correlation-id: 92726395-0011-4071-55a0-08d654375583
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4608;
x-ms-traffictypediagnostic: VI1PR04MB4608:
x-microsoft-antispam-prvs: <VI1PR04MB46085F133B56E45B84B554199AD00@VI1PR04MB4608.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231443)(944501410)(4982022)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4608;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4608;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(366004)(376002)(396003)(199004)(189003)(13464003)(55236004)(229853002)(2501003)(45080400002)(71190400001)(7416002)(44832011)(7696005)(486006)(99286004)(71200400001)(6436002)(3846002)(7736002)(53546011)(11346002)(6306002)(110136005)(9686003)(575784001)(39060400002)(446003)(78486014)(26005)(102836004)(186003)(54906003)(2201001)(86362001)(6506007)(76176011)(53936002)(4326008)(8936002)(8676002)(14444005)(256004)(81156014)(6246003)(476003)(55016002)(81166006)(68736007)(106356001)(25786009)(316002)(966005)(2906002)(33656002)(105586002)(74316002)(66066001)(305945005)(14454004)(97736004)(5660300001)(6116002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4608;H:VI1PR04MB4845.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9cbOY9IipxfgSyO6gIoyDdfqfWVpwlxHrto7DkrBJz0N7lmc/SgzlejfXPIDPehwuiLklV4ZN1PsWqXw8LVYlJXn3yc5pVUvsYfqDygJ0F8NOzk7trJWDy+xVVb+bKFp2tIM9dCVScqpTluZuECwKXkyAfjcK6jRwZeWBtAtIZfl8QIIxFZHU6XZwC1HaApIm81Ua256KDA/zTrLWU/nCLBbfh9xSqRgmRCy8bDii8v8Yel1BZgdi+zX/+ylyG2cwqOQw1POhn21jUHo12cdYDsVsT3kTrrj9i7KwNIOIQmDzNeN2DKUp6nDQr0OSWzjanLNQE9XMe5G+Fm2V3bLwITSzGfTSKXoB3TkSEoKJx8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92726395-0011-4071-55a0-08d654375583
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 07:09:55.2077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4608
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgSmVhbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBdWdlciBF
cmljIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMjMs
IDIwMTggMTo1OSBQTQ0KPiBUbzogSmVhbi1QaGlsaXBwZSBCcnVja2VyIDxqZWFuLXBoaWxpcHBl
LmJydWNrZXJAYXJtLmNvbT47DQo+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBs
aW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
dmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IHZpcnRpby0NCj4gZGV2
QGxpc3RzLm9hc2lzLW9wZW4ub3JnOyBqb3JvQDhieXRlcy5vcmc7IG1zdEByZWRoYXQuY29tDQo+
IENjOiBqYXNvd2FuZ0ByZWRoYXQuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFu
ZEBhcm0uY29tOw0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBmcm93YW5kLmxpc3RAZ21haWwuY29t
Ow0KPiBrdm1hcm1AbGlzdHMuY3MuY29sdW1iaWEuZWR1OyB0bm93aWNraUBjYXZpdW1uZXR3b3Jr
cy5jb207DQo+IGtldmluLnRpYW5AaW50ZWwuY29tOyBtYXJjLnp5bmdpZXJAYXJtLmNvbTsgcm9i
aW4ubXVycGh5QGFybS5jb207DQo+IHdpbGwuZGVhY29uQGFybS5jb207IGxvcmVuem8ucGllcmFs
aXNpQGFybS5jb207IEJoYXJhdCBCaHVzaGFuDQo+IDxiaGFyYXQuYmh1c2hhbkBueHAuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDAvN10gQWRkIHZpcnRpby1pb21tdSBkcml2ZXINCj4g
DQo+IEhpIEplYW4sDQo+IA0KPiBPbiAxMS8yMi8xOCA4OjM3IFBNLCBKZWFuLVBoaWxpcHBlIEJy
dWNrZXIgd3JvdGU6DQo+ID4gSW1wbGVtZW50IHRoZSB2aXJ0aW8taW9tbXUgZHJpdmVyLCBmb2xs
b3dpbmcgc3BlY2lmaWNhdGlvbiB2MC45IFsxXS4NCj4gPg0KPiA+IFNpbmNlIHY0IFsyXSBJIGZp
eGVkIHRoZSBpc3N1ZXMgcmVwb3J0ZWQgYnkgRXJpYywgYW5kIGFkZGVkDQo+ID4gUmV2aWV3ZWQt
YnkgZnJvbSBFcmljIGFuZCBSb2IuIFRoYW5rcyENCj4gPg0KPiA+IEkgY2hhbmdlZCB0aGUgc3Bl
Y2lmaWNhdGlvbiB0byBmaXggb25lIGluY29uc2lzdGVuY3kgZGlzY3Vzc2VkIGluIHY0Lg0KPiA+
IFRoYXQgdGhlIGRldmljZSBmaWxscyB0aGUgcHJvYmUgYnVmZmVyIHdpdGggemVyb2VzIGlzIG5v
dyBhICJTSE9VTEQiDQo+ID4gaW5zdGVhZCBvZiBhICJNQVkiLCBzaW5jZSBpdCdzIHRoZSBvbmx5
IHdheSBmb3IgdGhlIGRyaXZlciB0byBrbm93IGlmDQo+ID4gdGhlIGRldmljZSB3cm90ZSB0aGUg
c3RhdHVzLiBFeGlzdGluZyBkZXZpY2VzIGFscmVhZHkgZG8gdGhpcy4gSW4NCj4gPiBhZGRpdGlv
biB0aGUgZGV2aWNlIG5vdyBuZWVkcyB0byBmaWxsIHRoZSB0aHJlZSBwYWRkaW5nIGJ5dGVzIGF0
IHRoZQ0KPiA+IHRhaWwgd2l0aCB6ZXJvZXMuDQo+ID4NCj4gPiBZb3UgY2FuIGZpbmQgTGludXgg
ZHJpdmVyIGFuZCBrdm10b29sIGRldmljZSBvbiBicmFuY2hlcw0KPiA+IHZpcnRpby1pb21tdS92
MC45IFszXS4gSSBhbHNvIGxpZ2h0bHkgdGVzdGVkIHdpdGggRXJpYydzIGxhdGVzdCBRRU1VDQo+
ID4gZGV2aWNlIFs0XS4NCj4gPg0KPiA+IFsxXSBWaXJ0aW8taW9tbXUgc3BlY2lmaWNhdGlvbiB2
MC45LCBzb3VyY2VzLCBwZGYgYW5kIGRpZmYgZnJvbSB2MC44DQo+ID4gICAgIGdpdDovL2xpbnV4
LWFybS5vcmcvdmlydGlvLWlvbW11LmdpdCB2aXJ0aW8taW9tbXUvdjAuOQ0KPiA+DQo+IGh0dHBz
Oi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUy
RiUyRmpwYnINCj4gdWNrZXIubmV0JTJGdmlydGlvLWlvbW11JTJGc3BlYyUyRnYwLjklMkZ2aXJ0
aW8taW9tbXUtDQo+IHYwLjkucGRmJmFtcDtkYXRhPTAyJTdDMDElN0NiaGFyYXQuYmh1c2hhbiU0
MG54cC5jb20lN0M2ZTcxODBlNw0KPiBkZjhlNDE5NDNkNDEwOGQ2NTExZGI4ZWQlN0M2ODZlYTFk
M2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlDQo+IDdDMSU3QzYzNjc4NTU4NTQyNDk5MDgw
MyZhbXA7c2RhdGE9bGEwdFNUTGNPSTVIa1E2NWElMkJDSEtlSTNINWl1DQo+IHFaJTJGOHI2UTVZ
Rjh0ZnNVJTNEJmFtcDtyZXNlcnZlZD0wDQo+ID4NCj4gPg0KPiBodHRwczovL2VtZWEwMS5zYWZl
bGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZqcGJyDQo+ID4g
dWNrZXIubmV0JTJGdmlydGlvLWlvbW11JTJGc3BlYyUyRmRpZmZzJTJGdmlydGlvLWlvbW11LXBk
Zi1kaWZmLXYwLjgtDQo+IHYNCj4gPg0KPiAwLjkucGRmJmFtcDtkYXRhPTAyJTdDMDElN0NiaGFy
YXQuYmh1c2hhbiU0MG54cC5jb20lN0M2ZTcxODBlN2QNCj4gZjhlNDE5NA0KPiA+DQo+IDNkNDEw
OGQ2NTExZGI4ZWQlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MxJTdD
Ng0KPiAzNjc4NTU4DQo+ID4NCj4gNTQyNDk5MDgwMyZhbXA7c2RhdGE9QUVYRWliNGxpaGNwZkU2
TzZ3TGYlMkJNRWxQdEE3WkxHWUUybWowMjg4UFoNCj4gayUzRCYNCj4gPiBhbXA7cmVzZXJ2ZWQ9
MA0KPiA+DQo+ID4gWzJdIFtQQVRDSCB2NCAwLzddIEFkZCB2aXJ0aW8taW9tbXUgZHJpdmVyDQo+
ID4NCj4gPg0KPiBodHRwczovL2VtZWEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNv
bS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzDQo+ID4gdHMubGludXhmb3VuZGF0aW9uLm9yZyUyRnBp
cGVybWFpbCUyRmlvbW11JTJGMjAxOC0NCj4gTm92ZW1iZXIlMkYwMzEwNzQuaHQNCj4gPg0KPiBt
bCZhbXA7ZGF0YT0wMiU3QzAxJTdDYmhhcmF0LmJodXNoYW4lNDBueHAuY29tJTdDNmU3MTgwZTdk
ZjhlNA0KPiAxOTQzZDQxMA0KPiA+DQo+IDhkNjUxMWRiOGVkJTdDNjg2ZWExZDNiYzJiNGM2ZmE5
MmNkOTljNWMzMDE2MzUlN0MwJTdDMSU3QzYzNjc4NQ0KPiA1ODU0MjQ5DQo+ID4NCj4gOTA4MDMm
YW1wO3NkYXRhPW1VVVNCUSUyRmpFZVJHYWlzR0JLMjBHOVdtZlhQd2xFUktEYWVlUnFIVzQNCj4g
MDglM0QmYW1wO3INCj4gPiBlc2VydmVkPTANCj4gPg0KPiA+IFszXSBnaXQ6Ly9saW51eC1hcm0u
b3JnL2xpbnV4LWpwYi5naXQgdmlydGlvLWlvbW11L3YwLjkNCj4gPiAgICAgZ2l0Oi8vbGludXgt
YXJtLm9yZy9rdm10b29sLWpwYi5naXQgdmlydGlvLWlvbW11L3YwLjkNCj4gPg0KPiA+IFs0XSBb
UkZDIHY5IDAwLzE3XSBWSVJUSU8tSU9NTVUgZGV2aWNlDQo+ID4NCj4gPg0KPiBodHRwczovL2Vt
ZWEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJG
dw0KPiB3dw0KPiA+IC5tYWlsLWFyY2hpdmUuY29tJTJGcWVtdS0NCj4gZGV2ZWwlNDBub25nbnUu
b3JnJTJGbXNnNTc1NTc4Lmh0bWwmYW1wO2RhdGE9DQo+ID4NCj4gMDIlN0MwMSU3Q2JoYXJhdC5i
aHVzaGFuJTQwbnhwLmNvbSU3QzZlNzE4MGU3ZGY4ZTQxOTQzZDQxMDhkNjUxDQo+IDFkYjhlZCUN
Cj4gPg0KPiA3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzElN0M2MzY3
ODU1ODU0MjQ5OTA4MDMmDQo+IGFtcDtzZA0KPiA+DQo+IGF0YT1mbzlXS0UzM05tJTJGZFcyQzJY
Y1NWbXY5aXRXakV5Uk4xaXJnRVpnT1d0WkklM0QmYW1wO3Jlc2UNCj4gcnZlZD0wDQo+ID4NCj4g
PiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgKDcpOg0KPiA+ICAgZHQtYmluZGluZ3M6IHZpcnRpby1t
bWlvOiBBZGQgSU9NTVUgZGVzY3JpcHRpb24NCj4gPiAgIGR0LWJpbmRpbmdzOiB2aXJ0aW86IEFk
ZCB2aXJ0aW8tcGNpLWlvbW11IG5vZGUNCj4gPiAgIG9mOiBBbGxvdyB0aGUgaW9tbXUtbWFwIHBy
b3BlcnR5IHRvIG9taXQgdW50cmFuc2xhdGVkIGRldmljZXMNCj4gPiAgIFBDSTogT0Y6IEluaXRp
YWxpemUgZGV2LT5md25vZGUgYXBwcm9wcmlhdGVseQ0KPiA+ICAgaW9tbXU6IEFkZCB2aXJ0aW8t
aW9tbXUgZHJpdmVyDQo+ID4gICBpb21tdS92aXJ0aW86IEFkZCBwcm9iZSByZXF1ZXN0DQo+ID4g
ICBpb21tdS92aXJ0aW86IEFkZCBldmVudCBxdWV1ZQ0KPiA+DQo+ID4gIC4uLi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3ZpcnRpby9pb21tdS50eHQgICAgICB8ICAgNjYgKw0KPiA+ICAuLi4vZGV2aWNl
dHJlZS9iaW5kaW5ncy92aXJ0aW8vbW1pby50eHQgICAgICAgfCAgIDMwICsNCj4gPiAgTUFJTlRB
SU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNyArDQo+ID4gIGRy
aXZlcnMvaW9tbXUvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMTEgKw0KPiA+
ICBkcml2ZXJzL2lvbW11L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAxICsN
Cj4gPiAgZHJpdmVycy9pb21tdS92aXJ0aW8taW9tbXUuYyAgICAgICAgICAgICAgICAgIHwgMTE1
NyArKysrKysrKysrKysrKysrKw0KPiA+ICBkcml2ZXJzL29mL2Jhc2UuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDEwICstDQo+ID4gIGRyaXZlcnMvcGNpL29mLmMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgIDcgKw0KPiA+ICBpbmNsdWRlL3VhcGkvbGludXgvdmly
dGlvX2lkcy5oICAgICAgICAgICAgICAgfCAgICAxICsNCj4gPiAgaW5jbHVkZS91YXBpL2xpbnV4
L3ZpcnRpb19pb21tdS5oICAgICAgICAgICAgIHwgIDE2MSArKysNCj4gPiAgMTAgZmlsZXMgY2hh
bmdlZCwgMTQ0OCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUNCj4g
PiAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3ZpcnRpby9pb21tdS50
eHQNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaW9tbXUvdmlydGlvLWlvbW11LmMg
IGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IGluY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9faW9tbXUu
aA0KPiA+DQo+IGZvciB0aGUgd2hvbGUgc2VyaWVzDQo+IFRlc3RlZC1ieTogRXJpYyBBdWdlciA8
ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KDQpJIGhhdmUgdGVzdGVkIHRoaXMgc2VyaWVzIHdpdGgg
dmlydGlvL3ZmaW8gYm90aA0KVGVzdGVkLWJ5OiBCaGFyYXQgQmh1c2hhbiA8YmhhcmF0LmJodXNo
YW5AbnhwLmNvbT4NCg0KDQpUaGFua3MNCi1CaGFyYXQNCg0KPiANCj4gVGhhbmtzDQo+IA0KPiBF
cmljDQoNCg==
