Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC72EC43441
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 19:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C1B223DD
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 19:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="Rg+rXxYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C1B223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbeKOFMl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:12:41 -0500
Received: from mail-eopbgr690122.outbound.protection.outlook.com ([40.107.69.122]:7344
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725791AbeKOFMl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 00:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ids8puTYeg0jwh++XmO2LBcL40So5Xg0927QZd6hVUI=;
 b=Rg+rXxYi7CyAX4l8QZcsKrO0Mzo355cirTCbrqnwIvu+wRYFDx19BZ5nGwgukmWf1ExRObuDu2K4TnPh8p6Y9L+IjCN4CNCSL7ftsDIBIAzeoYioEyKRfwBUaUOl394sxt9gL3WrK5BwBUVJCPh7qGQnSgjqMcvtqnIxyFUbyEM=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3691.namprd06.prod.outlook.com (10.167.236.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.29; Wed, 14 Nov 2018 19:08:12 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 19:08:12 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "helgaas@google.com" <helgaas@google.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH 2/3] PCI: designware: Take lock when ACKing an interrupt
Thread-Topic: [PATCH 2/3] PCI: designware: Take lock when ACKing an interrupt
Thread-Index: AQHUe6RN+6OZn8SrAkGa637jbPbnA6VPo3yA
Date:   Wed, 14 Nov 2018 19:08:12 +0000
Message-ID: <1542222491.30311.462.camel@impinj.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
         <20181113225734.8026-3-marc.zyngier@arm.com>
In-Reply-To: <20181113225734.8026-3-marc.zyngier@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3691;6:NYWp3xVYex7dTltLuesaEh1y3TyUknlrF6NAv2p/h0naiLv9MVB9W/g0pfcZP6XFbJ/RPR/j/sUg0xGaCfN3Zv81nOhkKvRvZ4q/Ez4h7MiinKTB/wP0TERzgTlptp0u7Vto7tI92Pqq6rtkaEhjO0Zv9bnqQPoxklsZeQJsf7MeMkjqz/CbH2wUuiphb+SMow89alEavsamK4QJK2bZxhJ4lTEhdWZahMHMYuxr7zvBtMqxhU65CAtQAL6FNzjFhR9FFhnVtAz74wYQkKriIeip7OJJnrf/LFXsZ3+9Qk1GNzgPKA6HO0AdOPsqyPR+ZMGFXwOhIy3Y/6/+W68GFWq5TpRy7//79IVyBEgJhfsfhjGAXnziWJ0TvKrt+M44JZ7y1bvbpmdfa+WS7RFlBeUahjJbzytb0S+D2n4PAsf2sWNQ7e+cbZA668JBSrqO0LxWNHY241t0lT++/G/c8Q==;5:BHtbhsZziprMPy/7YsBxrPEijNZrw7lSrE9u6240xjxEc/8q9hoIypFQATtDWQRtaODUV6zMW05boeGvnEy85SDIa2ku8IhQGm/vfUbP7qLi5Jpc8jCX3VepKOUiqMF+FYJR0ddaENWhFo6+6bK7kXQN9NBxEJBSo9aVg0IUGj0=;7:b124xsJlVAZ+zdmtcWrzUMVx1VebXkiamo5iVBBwgFTwf0a6gipdxioNl1SJGQNDD5ht8VT49W26TWuSf07FYF1MqpmqfIBxwzzuMAYiGxhazrmS9N1hN0S5mPUaWc/C8tBbQktB63UEZX6+6RBeiQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 499b9ce4-4872-4121-61b8-08d64a6485d5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3691;
x-ms-traffictypediagnostic: MWHPR0601MB3691:
x-microsoft-antispam-prvs: <MWHPR0601MB3691F73C798AC2BAF92DED5DD3C30@MWHPR0601MB3691.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231415)(944501410)(52105112)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3691;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3691;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(39840400004)(346002)(199004)(189003)(39060400002)(6512007)(4326008)(54906003)(486006)(81166006)(6486002)(81156014)(478600001)(97736004)(4001150100001)(76176011)(2906002)(2616005)(6436002)(99286004)(476003)(14444005)(25786009)(316002)(66066001)(110136005)(14454004)(6246003)(11346002)(8936002)(2501003)(53936002)(229853002)(256004)(6506007)(5660300001)(71200400001)(36756003)(446003)(71190400001)(8676002)(26005)(86362001)(103116003)(2201001)(7736002)(186003)(305945005)(106356001)(102836004)(68736007)(2900100001)(6116002)(3846002)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3691;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nZS/hH1BwHb1HCUg5W1E9A4DgDAF5CX9RwkpgJQWkLRYGolaOSWfVcQoEImvT7HAGc3dbgDAU9Q6gYVzp6uOY9FEmDiofvAAfm38JHfrMFrwmpmk1xc+IBKi2EdxJ6v8OA0K1/Yz8nEGulAO1v9hygrtbS50qI8zF4mjWo4JrCrw+bB7is/6aiJpYVXR8X6avAOMQ3TktvSVnPQ4AyGS346qlPvefzg4omDOiLD9q/d4BlDh4HkhINNw20P4BK7BW6gHx3En6jzZQZTeHXD7Ulrm+KcqZiffuycW1KZj37oWGjd3B5M2nO1kf+b7+NXJM0f//kt2IEWCfyuO/34exeps7bKD2Wj42/Ae2Nf8Drg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B8BD38BAACEC54288CF485539951A88@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499b9ce4-4872-4121-61b8-08d64a6485d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 19:08:12.1112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3691
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE4LTExLTEzIGF0IDIyOjU3ICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IEJpemFycmVseSwgdGhlcmUgaXMgbm8gbG9jayB0YWtlbiBpbiB0aGUgaXJxX2FjayBoZWxwZXIu
IFRoaXMNCj4gcHV0cyB0aGUgYWNrIGNhbGxiYWNrIHByb3ZpZGVkIGJ5IGEgc3BlY2lmaWMgcGxh
dGZvcm0gaW4gYSBhd2t3YXJkDQo+IHNpdHVhdGlvbiB3aGVyZSB0aGVyZSBpcyBubyBzeW5jaHJv
bml6YXRpb24gdGhhdCB3b3VsZCBiZSBleHBlY3RlZA0KPiBvbiBvdGhlciBjYWxsYmFjay4NCj4g
DQo+IEludHJvZHVjZSB0aGUgcmVxdWlyZWQgbG9jaywgZ2l2aW5nIHNvbWUgbGV2ZWwgb2YgdW5p
Zm9ybWl0eSBhbW9uZw0KPiBjYWxsYmFja3MuDQoNClRoZSBsb2NraW5nIHN0cmF0ZWd5IGhlcmUg
ZG9lcyBub3QgZW50aXJlbHkgbWFrZSBzZW5zZSB0byBtZS4NCg0KVGhlIG9ubHkgY2FsbCBwYXRo
IEkgc2VlIHRoYXQgY2FuIHJlYWNoIHRoaXMgZnVuY3Rpb24gaXMgdmlhIHRoZQ0KZ2VuZXJpY19o
YW5kbGVfaXJxKCkgY2FsbCBpbiBkd19oYW5kbGVfbXNpX2lycSgpLiAgSXMgdGhlcmUgYW5vdGhl
cg0KcGF0aCBJIG1pc3NlZD8NCg0KSWYgdGhhdCBpcyB0aGUgb25seSBwYXRoLCB0aGVuIGhvdyBj
b3VsZCB0aGlzIG1ldGhvZCBiZSBjYWxsZWQNCnJlZW50cmFudGx5IG9uIHRoZSBzYW1lIHBvcnQ/
ICBJdCB3b3VsZCByZXF1aXJlIHRoYXQNCmR3X2hhbmRsZV9tc2lfaXJxKCkgd2FzIGNhbGxlZCBy
ZWVudHJhbnRseS4gIEJ1dCBsb29rIGF0IHRoYXQgZnVuY3Rpb24sDQppdCdzIGNsZWFybHkgbm90
IHJlZW50cmFudC4gIEl0IHdpbGwgcmFjZSB3aXRoIGl0c2VsZiB0cnlpbmcgdG8gaGFuZGxlDQp0
aGUgc2FtZSBzdGF0dXMgYml0cy4NCg0KDQoNCg0KPiBAQCBzdGF0aWMgdm9pZCBkd19wY2lfYm90
dG9tX2FjayhzdHJ1Y3QgaXJxX2RhdGEgKmQpDQo+ICB7DQo+ICAJc3RydWN0IG1zaV9kZXNjICpt
c2kgPSBpcnFfZGF0YV9nZXRfbXNpX2Rlc2MoZCk7DQo+ICAJc3RydWN0IHBjaWVfcG9ydCAqcHA7
DQo+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gIA0KPiAgCXBwID0gbXNpX2Rlc2NfdG9fcGNp
X3N5c2RhdGEobXNpKTsNCj4gIA0KPiArCXJhd19zcGluX2xvY2tfaXJxc2F2ZSgmcHAtPmxvY2ss
IGZsYWdzKTsNCj4gKw0KPiAgCWlmIChwcC0+b3BzLT5tc2lfaXJxX2FjaykNCj4gIAkJcHAtPm9w
cy0+bXNpX2lycV9hY2soZC0+aHdpcnEsIHBwKTsNCj4gKw0KPiArCXJhd19zcGluX3VubG9ja19p
cnFyZXN0b3JlKCZwcC0+bG9jaywgZmxhZ3MpOw0KPiA=
