Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE97C282DF
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5EC222ED
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VBsYSl1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfDSSS7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:18:59 -0400
Received: from mail-eopbgr710040.outbound.protection.outlook.com ([40.107.71.40]:60190
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727607AbfDSSS7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Apr 2019 14:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEmvhGGYii9VAui1zrLt5RsxOckCbj/fQMA6NqfKxzM=;
 b=VBsYSl1t2CAnn83LrFmXj4QLrZf6uft3OLl8M6dqtrhZW7oqYFihNLeSC71XvNug3llNyTshEpjLXIZrB2Wqm5H0I7IlTfRfD1HmKcH6JSSovp4jQZpQRDBb4uGFBKmyUB1/ZbM6Do76u27/RRMWBIZGrND6PatQ5RA8iLlYsUU=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB2389.namprd12.prod.outlook.com (52.132.141.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Fri, 19 Apr 2019 14:24:18 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::70fc:f26c:1e22:73ba]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::70fc:f26c:1e22:73ba%10]) with mapi id 15.20.1813.013; Fri, 19 Apr
 2019 14:24:18 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
CC:     "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/P2PDMA: start with a whitelist for root complexes
Thread-Topic: [PATCH] PCI/P2PDMA: start with a whitelist for root complexes
Thread-Index: AQHU9ruQB79gWsc7QUWtpCuUp1ew9w==
Date:   Fri, 19 Apr 2019 14:24:18 +0000
Message-ID: <ef5839af-4ddb-2e68-ebf3-f11fa01b0403@amd.com>
References: <20190418115859.2394-1-christian.koenig@amd.com>
 <20190418163347.GA213349@google.com>
 <22b686f0-572b-d083-915f-5c46c89dfbc3@deltatee.com>
 <20190418172426.GB213349@google.com>
In-Reply-To: <20190418172426.GB213349@google.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: BL0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:208:2d::30) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b241b5e-8387-4468-f47e-08d6c4d2b547
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB2389;
x-ms-traffictypediagnostic: DM5PR12MB2389:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM5PR12MB238981C40FBF59E066F6EFB083270@DM5PR12MB2389.namprd12.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(346002)(376002)(136003)(199004)(189003)(31686004)(966005)(72206003)(14454004)(6512007)(446003)(486006)(6306002)(46003)(2616005)(186003)(53936002)(6246003)(476003)(8936002)(478600001)(386003)(11346002)(4326008)(6506007)(53546011)(81166006)(7736002)(68736007)(81156014)(102836004)(8676002)(76176011)(65806001)(65826007)(65956001)(305945005)(93886005)(6116002)(97736004)(229853002)(2906002)(58126008)(99286004)(25786009)(110136005)(54906003)(66946007)(73956011)(86362001)(5024004)(256004)(14444005)(6486002)(31696002)(64126003)(66556008)(6436002)(316002)(5660300002)(36756003)(66574012)(71200400001)(71190400001)(52116002)(66476007)(66446008)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2389;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VxSNEtnX+k7Pvleg00YvkEeV/EtzI+n9/EmVnaCLwPyfBlNNy934oIxFY89cNo8bgTQ9IUHu/ogSI1UHe4Udc5uN/SV0AwKuugOLx/PWKwrjFJBw1G9GYeT28g6quPg3Q9NnJUkRTWotJgwvdHyN9GHlIa/UdBC+lJ69JCujUmWSdTRzTw7uU9Rdxl/GvU2EnbEZni/Z+PfrAEv4OL3IGjERZ1ZdDX8jUGTo4h3sgTPr6w9TxCWgPzXuhy72VH4P81Pp8pLwWd2srY1UNgPnrHu3cmVBL+3Dgp7XTvo4riPoe4hvug2zeDEtiK+zByJWXSjZediWtGhU+pd8wpZDBLMQKNiIw5ScTbQgKqwM/lmyMrrs/fSZ5taTs1eAIsgNMe0mr7NVmQzfL7n8M96GudzVXKTd9ByWazCaWmjtV+Q=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9D289760D152645B7542D34E1031E49@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b241b5e-8387-4468-f47e-08d6c4d2b547
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 14:24:18.7365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2389
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QW0gMTguMDQuMTkgdW0gMTk6MjQgc2NocmllYiBCam9ybiBIZWxnYWFzOg0KPiBPbiBUaHUsIEFw
ciAxOCwgMjAxOSBhdCAxMDo1ODo1NUFNIC0wNjAwLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6DQo+
PiBPbiAyMDE5LTA0LTE4IDEwOjMzIGEubS4sIEJqb3JuIEhlbGdhYXMgd3JvdGU6DQo+Pj4gT24g
VGh1LCBBcHIgMTgsIDIwMTkgYXQgMDE6NTg6NTlQTSArMDIwMCwgQ2hyaXN0aWFuIEvDtm5pZyB3
cm90ZToNCj4+Pj4gQSBsb3Qgb2Ygcm9vdCBjb21wbGV4ZXMgY2FuIHN0aWxsIGRvIFAyUCBldmVu
IHdoZW4gUENJIGRldmljZXMNCj4+Pj4gZG9uJ3Qgc2hhcmUgYSBjb21tb24gdXBzdHJlYW0gYnJp
ZGdlLg0KPj4+Pg0KPj4+PiBTdGFydCBhZGRpbmcgYSB3aGl0ZWxpc3QgYW5kIGFsbG93IFAyUCBp
ZiBib3RoIHBhcnRpY2lwYW50cyBhcmUNCj4+Pj4gYXR0YWNoZWQgdG8ga25vd24gZ29vZCByb290
IGNvbXBsZXguDQo+Pj4gSXMgdGhlcmUgYSBwbGFuIGZvciBhZGRyZXNzaW5nIHRoaXMgaW4gYSBn
ZW5lcmljIHdheSB0aGF0IGRvZXNuJ3QNCj4+PiByZXF1aXJlIGFuIE9TIG1vZGlmaWNhdGlvbiBm
b3IgZXZlcnkgbmV3ICJrbm93biBnb29kIHJvb3QgY29tcGxleCIsDQo+Pj4gZS5nLiwgc29tZSBQ
Q0llIG9yIEFDUEkgc3BlYyB1cGRhdGUgdGhhdCBhbGxvd3MgdGhlIE9TIHRvIGRpc2NvdmVyDQo+
Pj4gdGhpcz8NCj4+IEknbSBhd2FyZSBvZiB3b3JrIGdvaW5nIG9uIGluIHRoZSBQQ0kgU0lHIHRv
IGFkZHJlc3MgdGhpcyBbMV0uDQo+Pg0KPj4gQnV0IEkgZXhwZWN0IGl0J3MgZ29pbmcgdG8gYmUg
YSBsb25nIHRpbWUgYmVmb3JlIGFjdHVhbCBoYXJkd2FyZSBhZHZlcnRpc2VzDQo+PiB0aGlzIGNh
cGFiaWxpdHkgdG8gaW5kaWNhdGUgc3VwcG9ydC4gU28gaW4gdGhlIGludGVyaW0gd2UgZWl0aGVy
IG5lZWQgdG8gbm90DQo+PiB1c2UgcDJwZG1hIG9uIHJvb3QgY29tcGxleGVzIG9yIGNyZWF0ZSBh
IHdoaXRlIGxpc3QuIEknbSBpbiBmYXZvdXIgb2YgdGhlDQo+PiB3aGl0ZSBsaXN0IGFwcHJvYWNo
Lg0KPiBJIGFncmVlIHdlIG5lZWQgYSB3aGl0ZWxpc3Q7IEkganVzdCB3YW50IHRvIG1ha2Ugc3Vy
ZSB3ZSBhbHNvIG1ha2UNCj4gcHJvZ3Jlc3Mgb24gc29tZSB3YXkgdG8gbGltaXQgdGhlIGFtb3Vu
dCBvZiB0aW1lIHdlIG5lZWQgdG8gdXBkYXRlIGl0Lg0KDQpXZWxsIGFzIGZhciBhcyBJIGtub3cg
YXQgbGVhc3QgZm9yIEFNRCB0aGVyZSBpcyBhbHNvIGEgdmVuZG9yIHNwZWNpZmljIA0Kd2F5IHRv
IGZpZ3VyZSBvdXQgaWYgYSBjaGlwc2V0IGRvZXMgUDJQIHJvdXRpbmcgb3Igbm90LiBTbyB5b3Ug
ZG9uJ3QgDQpuZWVkIGV2ZXJ5IHBvc3NpYmxlIGNvbWJpbmF0aW9uIGxpc3RlZC4NCg0KSXQncyBw
ZXJmZWN0bHkgcG9zc2libGUgdGhhdCBJbnRlbCwgQVJNIGFuZCBQb3dlclBDIGhhdmUgc29tZXRo
aW5nIA0Kc2ltaWxhciBhbmQgd2l0aCBhbGwgdGhvc2Ugb24gYm9hcmQgeW91IGhhdmUgcHJldHR5
IG11Y2ggZXZlcnkgDQppbnRlcmVzdGluZyBjYXNlIGNvdmVyZWQuDQoNCkkgd2lsbCB0cnkgdG8g
ZGlnIHNvbWV0aGluZyB1cCBpbnRvIHRoYXQgZGlyZWN0aW9uLg0KDQpBbm90aGVyIHByb2JsZW0g
aXMgYWxzbyB0aGF0IHNvbWUgcm9vdCBjb21wbGV4ZXMgaGF2ZSB2ZXJ5IHZlcnkgc3RyYW5nZSAN
CmxpbWl0YXRpb25zIG9uIHRoZSByb3V0aW5nIHdoaWNoIGFyZSBoYXJkIHRvIGhhbmRsZS4gRm9y
IGV4YW1wbGUgc29tZSANCm9sZCBjaGlwc2V0cyBjYW4gZG8gUDJQLCBidXQgb25seSBmb3Igd3Jp
dGVzIGFuZCBub3QgcmVhZHMhDQoNCkFueXdheSBhdCBsZWFzdCBmb3IgbXkgY3VycmVudCB1c2Ug
Y2FzZSBhIHNpbXBsZSB3aGl0ZWxpc3Qgd2l0aCANCnZlbmRvci9kZXZpY2Ugc2hvdWxkIGJlIHN1
ZmZpY2llbnQsIHNvIEknbSBmaW5lIHdpdGggbWFpbnRhaW5pbmcgdGhhdCANCmZvciBub3cuIEJ1
dCBvbiB0aGUgb3RoZXIgaGFuZCBJIGFsc28gdW5kZXJzdGFuZCB0aGF0IGluIDEwKyB5ZWFycyB3
ZSANCmRvbid0IHdhbnQgYSBsaXN0IHdpdGggMjAwIGVudHJpZXMgaGVyZS4uLi4NCg0KUmVnYXJk
cywNCkNocmlzdGlhbi4NCg0KPg0KPj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LXBjaS8yMDE4MTIxMDExNTY1My4wMDAwNjE1YUBodWF3ZWkuY29tLw0KDQo=
