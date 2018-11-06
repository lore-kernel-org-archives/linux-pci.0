Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2D7C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 19:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E183F20862
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 19:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="m/0FYVeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E183F20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbeKGEfE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:35:04 -0500
Received: from mail-eopbgr710101.outbound.protection.outlook.com ([40.107.71.101]:54252
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730520AbeKGEfE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 23:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toOneOpqsRY8Dxlbc6e6F5uHhFem/+KxHNtBGmsP4fg=;
 b=m/0FYVeZ7NHmQaVD01qEZtc+wqqt+B2iI23lRBcUfuM9BmldBp37wtxXdENKPslS27d+zzI+d4L1tA1Z6D8TQT8Q9wpeMk157x/9p3tLMrPa0eaPz/PcgRQnuOXkQsPsSJ+KUNiKIMqeZj2r4tzLzCgSuePpxx2OhVyuiV74DWI=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3689.namprd06.prod.outlook.com (10.167.236.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Tue, 6 Nov 2018 18:59:15 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::f51a:d8dd:1aad:3bf9%3]) with mapi id 15.20.1294.034; Tue, 6 Nov 2018
 18:59:15 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "jpinto@synopsys.com" <jpinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>
Subject: Re: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Thread-Topic: [PATCH] PCI: dwc: Fix interrupt race in when handling MSI
Thread-Index: AQHUbYgjUY6vVpEq1Ees3VO0f7sjeaVC5fqAgABElAA=
Date:   Tue, 6 Nov 2018 18:59:15 +0000
Message-ID: <1541530754.30311.254.camel@impinj.com>
References: <20181027000028.21343-1-tpiepho@impinj.com>
         <20181106145347.GB19060@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181106145347.GB19060@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3689;6:1oqp+f7xVsiFkz8L4PwS1PFaJqybO8q7rdc5/MLJiIg5AZ5aICaLxWdLe3K9vNxmpXeArCMG5ee11ZIV35WkatW5GTR58WqCALo26KZIsvURH/K4KZsYdmlN2KfRxS5XXeTQwFr71Hzo9GsbOhxlZGQBXEiO+dbNpDRh0GxsAgu9Ha1Bp2mXyocopVwR4ZTBj3rOrOxIjMDSZHK2HMM51yP09GseJzAR1NhvXk94gw0bjxYUtPEwdlgckEiQmoPzr0z3GoFan5dXZWzaTa8PTee0k2qGiNL3mnKlLXnp/bJvSOA2BI3jNbhNOntvMnZW3RFfT4V/5hMjixEdutgZVnEAzYnoxTRW2gGzv0qu0+CTwLw04nI0RBcjKDuWJAkSgr9YnSVOPux3WPqHjPEhbRdzeTIn3cdraHSGgzapimP/H5E87SFSbi+xjwLdLPAM5NfKV0vl5JKygfs4ynqIkA==;5:SVw98UIiu271BG+x/8f5NmzAg4xXXwgq25yrt7ZQMih6QwDjqAuhztVbAzscDjyJ7BAwf4ppFBlHHlYwHCy6KQuIotN/WiQF+dfekcYAUgbQ7Z0KhKP22PhBRysDlWU9hOs8TwWU7Xkt2WNcJ60aBuYXHk54ucm0JUVvrRdfTcY=;7:LjzOnsB35I32sivSFQ/sJa0vtCqtqbW5ZRwLGtBIw7HcOIeOkpy8ByDglO1e8qAiBhysry8bT99AzTGS5IBz9jBcuSuu1S/bFjCyuy6CNGblwpx8bgCXh+vFkbcbyOdWVc90/v/cGKcT0RTdyGHI7g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f2a7e262-f8ab-4b55-6ef0-08d64419f290
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3689;
x-ms-traffictypediagnostic: MWHPR0601MB3689:
x-microsoft-antispam-prvs: <MWHPR0601MB3689517974B1278ABA625F96D3CB0@MWHPR0601MB3689.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR0601MB3689;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3689;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39850400004)(396003)(346002)(136003)(366004)(199004)(189003)(4326008)(6916009)(316002)(39060400002)(81166006)(103116003)(25786009)(81156014)(6246003)(5660300001)(7416002)(36756003)(66066001)(305945005)(7736002)(71200400001)(256004)(26005)(2906002)(71190400001)(6116002)(14444005)(186003)(86362001)(53936002)(6306002)(6512007)(97736004)(54906003)(478600001)(446003)(76176011)(105586002)(106356001)(14454004)(966005)(229853002)(3846002)(2616005)(102836004)(8936002)(2900100001)(68736007)(6436002)(11346002)(476003)(486006)(5640700003)(8676002)(6486002)(2501003)(99286004)(2351001)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3689;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2U+UJz08iSLASjufx9q6vHQIwH+BZIUBFeD7tPHUkc+E7DyFQOVTCMlRRH0whVqf/ZtVVQSfKvnKJigySHPYQ1LxRtrq/HRO2GDe/92xPjyrfQeV+yuXLr59tHs7/A2H43LhrWnhn/cLzOSdTXLdTHUlgYKs6VeFN+MIKRwQh2H0rtojiuoL+/UdUafpOzQWdCwd8y+d+Wcu6dDszwOY62NyEC+CLYVyOe8BoH1bnrmM6r5yBFK6WOZxYl6r45vAhg4TADVbDdbRuUo/JtGy3/Wc9FwOio4mVqSJkMenBYWfBCG4crDM8P5/fg25xFsdi9R5bxCyfAzgFmP++7W6p67QxZFNuv2zw9PLfwQnk6s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <881D332E3D451848878B0E1001E6ABFB@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a7e262-f8ab-4b55-6ef0-08d64419f290
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 18:59:15.2235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3689
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE4LTExLTA2IGF0IDE0OjUzICswMDAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gDQo+IA0KPiBOb3Qgc3VyZSB3aHkgKDUpIGlzIG5vdCB1c2VkIGluIHlvdXIgbGlzdHMs
IEkgYXNzdW1lIGJlY2F1c2UgeW91IHdhbnQNCj4gdG8gaGlnaGxpZ2h0IHRoZSByYWNlIGNvbmRp
dGlvbiB3aXRoIHRoZSBqdW1wIGZyb20gNCB0byA2IChvciBtYXliZQ0KPiB5b3UgZG8gbm90IGxp
a2UgbnVtYmVyIDUgOiksIGp1c3QgY3VyaW91cykuDQoNCkl0J3MgYmVjYXVzZSBJIHJlbW92ZWQg
YSBzdGVwIGFuZCBJJ20gdXNlZCB0byByc3QgZG9jcyB3aGVyZSBpdA0KcmVudW1iZXJzIGF1dG9t
YXRpY2FsbHkuDQoNCj4gDQo+ID4gVGhlIG9ic2VydmFudCB3aWxsIG5vdGljZSB0aGF0IHBvaW50
IDQgcHJlc2VudCB0aGUgb3Bwb3J0dW5pdHkgZm9yIHRoZQ0KPiA+IFNvQydzIGludGVycnVwdCBj
b250cm9sbGVyIHRvIGxvc2UgdGhlIGludGVycnVwdCBpbiB0aGUgc2FtZSBtYW5uZXIgYXMNCj4g
PiB0aGUgYnVnIGluIHRoaXMgZHJpdmVyLiAgVGhlIGRyaXZlciBmb3IgdGhhdCBpbnRlcnJ1cHQg
Y29udHJvbGxlciB3aWxsDQo+ID4gYmUgd3JpdHRlbiB0byBwcm9wZXJseSBkZWFsIHdpdGggdGhp
cy4gIEluIHNvbWUgY2FzZXMgdGhlIGhhcmR3YXJlDQo+ID4gc3VwcG9ydHMgYW4gRU9JIGNvbmNl
cHQsIHdoZXJlIHRoZSAybmQgSVJRIGlzIG1hc2tlZCBhbmQgaW50ZXJuYWxseQ0KPiA+IHF1ZXVl
ZCBpbiB0aGUgaGFyZHdhcmUsIHRvIGJlIHJlLXJhaXNlZCBhdCBFT0kgaW4gc3RlcCA3LiAgSW4g
b3RoZXINCj4gPiBjYXNlcyB0aGUgSVJRIHdpbGwgYmUgdW5tYXNrZWQgYW5kIHJlLXJhaXNlZCBh
dCBzdGVwIDQsIGJ1dCB0aGUga2VybmVsDQo+ID4gd2lsbCBzZWUgdGhlIGhhbmRsZXIgaXMgSU5Q
Uk9HUkVTUyBhbmQgbm90IHJlLWludm9rZSBpdCwgYW5kIGluc3RlYWQgc2V0DQo+ID4gYSBQRU5E
SU5HIGZsYWcsIHdoaWNoIGNhdXNlcyB0aGUgaGFuZGxlciB0byByZS1ydW4gYXQgc3RlcCA3Lg0K
PiA+IA0KPiA+IFsxXSANCj4gPiANCj4gPiBGaXhlczogOGM5MzQwOTVmYTJmICgiUENJOiBkd2M6
IENsZWFyIE1TSSBpbnRlcnJ1cHQgc3RhdHVzIGFmdGVyIGl0IGlzIGhhbmRsZWQsIG5vdCBiZWZv
cmUiKQ0KPiANCj4gSSBoYXZlIHR3byBxdWVzdGlvbnM6DQo+IA0KPiAtIENvbW1pdCA4YzkzNDA5
NWZhMmYgaGFzIGJlZW4gaW4gdGhlIGtlcm5lbCBmb3IgYSB5ZWFyIGFuZCBubw0KPiAgIHJlZ3Jl
c3Npb24gd2FzIHJlcG9ydGVkLiBJdCB3YXMgYXNzdW1lZCB0byBmaXggYSBwcm9ibGVtIHNvIGJl
Zm9yZQ0KPiAgIHJldmVydGluZyBpdCBJIHdhbnQgdG8gbWFrZSBzdXJlIHdlIGFyZSBub3QgYnJl
YWtpbmcgYW55dGhpbmcgZWxzZS4NCg0KVGhlcmUgaGF2ZSBiZWVuIHJlcG9ydHMuICBWaWduZXNo
IHJlcG9ydGVkIHRoaXMgc29tZSB0aW1lIGFnby4gIEFsc28NCnNlZSBodHRwczovL2xrbWwub3Jn
L2xrbWwvMjAxOC8xMS8yLzU1LCB0aGUgYXV0aG9yIGluZGljYXRlZCB0byBtZSB0aGF0DQppdCB3
YXMgdGhlIGNhdXNlZCBieSB0aGlzIHByb2JsZW0gYWZ0ZXIgSSBwb2ludGVkIGhpbSB0byBteSBw
YXRjaC4gIEFuZA0KSSd2ZSByZXBvcnRlZCBpdCBub3cgdG9vLiAgDQoNCldlIG9ubHkgdXBkYXRl
ZCB0byBhIGtlcm5lbCB3aXRoIHRoZSByZWdyZXNzaW9uIGEgZmV3IG1vbnRocyBhZ28uICBJDQp0
aGluayBpbXg2Lzcgc3lzdGVtcyBkb24ndCB1cGRhdGUgdGhlaXIga2VybmVscyB0aGF0IHF1aWNr
bHkuICBVc3VhbGx5DQpub3QgcnVubmluZyBhIG1haW5zdHJlYW0gZGlzdHJvIHdpdGggYXV0b21h
dGljIHVwZGF0ZXMuICBBbmQgdGhlcmUgYXJlDQpwcm9iYWJseSBhIGxvdCBvZiBwZW9wbGUgdXNp
bmcgdGhlIE5YUCB2ZW5kb3Iga2VybmVsLCB3aGljaCBoYXMgYSB0b24NCm9mIHVubWVyZ2VkIHBh
dGNoZXMsIGFuZCBzbyB0aGV5IGRvbid0IHNlZSB0aGlzIHJlZ3Jlc3Npb24geWV0Lg0KDQo+IC0g
WW91ciByZWFzb25pbmcgc2VlbXMgY29ycmVjdCBidXQgSSB3b3VsZCBwaWNrIE1hcmMncyBicmFp
biBvbiB0aGlzDQo+ICAgYmVjYXVzZSBJIHdhbnQgdG8gdW5kZXJzdGFuZCBpZiB3aGF0IHRoaXMg
cGF0Y2ggZG9lcyBpcyB3aGF0IElSUSBjb3JlDQo+ICAgZXhwZWN0cyBpdCB0byBkbywgZXNwZWNp
YWxseSBpbiByZWxhdGlvbiB0byB0aGUgSVJRIGNoYWluaW5nIHlvdQ0KPiAgIGFyZSBtZW50aW9u
aW5nLg0KDQpJJ3ZlIHRyYWNlZCB0aGlzIHRocm91Z2ggdGhlIEFSTSBhcmNoIGNvZGUgYW5kIHVz
ZWQgb3VyIGN1c3RvbSBQQ0kNCmRldmljZSB0byBnZW5lcmF0ZSBpbnRlcnJ1cHRzIGluIGFsbCB0
aGUgcmFjZSB3aW5kb3dzLiAgSXQgZG9lcyB3b3JrIGFzDQpJIHNheSwgdGhvdWdoIEkgY2FuJ3Qg
c2F5IHRoaXMgaXQgaG93IGl0J3Mgc3VwcG9zZWQgdG8gd29yay4NCg==
