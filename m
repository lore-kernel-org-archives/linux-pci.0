Return-Path: <SRS0=vmzI=QL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8ADC282C4
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 23:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0B92083B
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 23:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="htXVWnJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfBDXue (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:50:34 -0500
Received: from mail-eopbgr720096.outbound.protection.outlook.com ([40.107.72.96]:10945
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726083AbfBDXue (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Feb 2019 18:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HrSE/AVWcVbPv2RZ6tADd1IunIL5WabtPrGjxXoIcE=;
 b=htXVWnJv27iSCcKJWQFywqYCMqkpbXh+wS15NDv7YHL/leqfAjGms1xDBH+AwS/nmNlvriGBz72Sd/TknXx6QXABfqkurgKmFDVCT/AemB2J1HKgpQOUVQaPYzWbdThprtcNWZqDYtdTbEwTy9lWa2ZveApxQPCe3iqmm1yuyWM=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3676.namprd06.prod.outlook.com (10.167.236.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Mon, 4 Feb 2019 23:50:31 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 23:50:31 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thinh.nguyen@synopsys.com" <thinh.nguyen@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "john.youn@synopsys.com" <john.youn@synopsys.com>
Subject: Re: [PATCH v2 2/2] PCI: Override Synopsys USB 3.x HAPS device class
Thread-Topic: [PATCH v2 2/2] PCI: Override Synopsys USB 3.x HAPS device class
Thread-Index: AQHUkNTUMps/WZ/k5UCaG/tMBlk70KXQpyeA
Date:   Mon, 4 Feb 2019 23:50:30 +0000
Message-ID: <1549324229.3075.16.camel@impinj.com>
References: <3aa06c4e54bf98a59e510d7a833934fce4b0083b.1544478969.git.thinhn@synopsys.com>
         <8994fd7d7ee2bf5c1b32ce5bca25be4beb4405b5.1544478969.git.thinhn@synopsys.com>
         <1549320120.3075.12.camel@impinj.com>
         <30102591E157244384E984126FC3CB4F639C0B41@us01wembx1.internal.synopsys.com>
In-Reply-To: <30102591E157244384E984126FC3CB4F639C0B41@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3676;6:kWjer5llUta+wpDi61G2AHdx9MWgoxi8D7Fb7t6YpkaBzl15wPsfpvi9bp8Xb63kwFlG2CQfqDTrHhRi9V3FW6kub3EZiQSghiXOvDnpwNP0w5q1fPYAx/hv6t2AKN8N5AlKgZT5j1+5bqbex+4JWuzq+QGjyzIHqc53jASdd6vM86k+tl8m8aWq2wIHD/zk1835LjLWoiWcwbYe3lglPI7RzGOUMJlOE1oQ0diDo95U8hh3fFmGSc7Rnd4LRrp+ZAzi5MXQznLPcIjDWRnTkjoC46LbglmuK1nG0UGTmbqPHb25qJkXRKRFWjAWz36WEfPDU+V7P4CKepYhUktXsYheYgXGy7HYBjFdgFylAEIz42ss9yYKbAeG+sllZk9vMBTnAbKX5MY+s4u92ehux6TuAfg/Zm1Ghojkds133k34GiOhKywTq1MnYoUIpI/qDPFAwBRYCGY/5fbgFh1rHA==;5:JtTKTN8jrCJvImsoA/ZyzF+NAi9J16t9TEw1i9QyjJ0esH95GijtfwJCUOulByzUvi9oRP0EiSn0GAna1Ha+qmq4K0vYuzbw748XMJrCBkoBVgedAGugv74x+ZcCboVyWzV/ikNgZbH6xDB1OUks6kBbhKIzm5Cjr274M2Gfe68bhzPQzYYWmoxGLV/dz4/l/bW5ytGgY3AgvT6hIvHFYw==;7:CvVHtWRBNj/jNh5F7o863aa9pqzW7v9c49oezI77WPiIfcLz5qjKT6oUosGI/SqX4eqqDDg3X8GCKy+z8YBBMBG8IZwMiKIxD5KwDfbfnLryWYgYnM5CU7Oe+sELv2NlhCiV8rRiqqhulcgn7/Qcwg==
x-ms-office365-filtering-correlation-id: 1c6dc67f-8d20-4082-0dc7-08d68afb8c1e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3676;
x-ms-traffictypediagnostic: MWHPR0601MB3676:
x-microsoft-antispam-prvs: <MWHPR0601MB3676D7AB89878BD9C5C141C6D36D0@MWHPR0601MB3676.namprd06.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(346002)(376002)(366004)(136003)(199004)(189003)(51914003)(486006)(476003)(53936002)(93886005)(8676002)(6512007)(99286004)(71190400001)(71200400001)(2501003)(6506007)(102836004)(110136005)(316002)(229853002)(103116003)(2906002)(26005)(6116002)(3846002)(66066001)(6486002)(6436002)(4326008)(36756003)(68736007)(86362001)(478600001)(6246003)(97736004)(14454004)(105586002)(7736002)(305945005)(25786009)(256004)(11346002)(186003)(76176011)(2616005)(446003)(4001150100001)(8936002)(2201001)(106356001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3676;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: icFHyFzEmS9kHP+jHVe1XQ8CUfikXHpji2QxqZsMTk0aiQwS81hr3rdCpRGRI0tVt82ojSf3CB5r1LyiIl638+T0nmFlYDn3/0GzSiPIvg0XRYSkOpWCL77C6M2UFokqdJU2WUUmmQakFzrgOtBxTxsRNumoxH1+9FLW7B0HWWih+SJr+eVWdL1UB4rVmFP1ZIImI8mal+g4ZqP5YTu3zhgDcq1l4suazu+aq+OJgmC/Bllt+bqJWEt1gwgxFTHQG2ZC1be5SAiQV1fUDSt0hvm9aATmnATCUBTdPpYA6Hr7iRKPM0+0bpJ8HwPBE1OnFW8RMEacCqfMA5ieul/mjWMqpWQt9ZX7ANcFyUnCMydXAklSYLK3GT0GCkiYZlHH5mrL5YDQROg7dkLIoAF7NV0gZRQdyI8P4/pJIpdxVek=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D6AB67846B4624C9D82703C30C83646@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6dc67f-8d20-4082-0dc7-08d68afb8c1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 23:50:31.0046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3676
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDE5LTAyLTA0IGF0IDIzOjE4ICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+
IFRyZW50IFBpZXBobyB3cm90ZToNCj4gPiBPbiBNb24sIDIwMTgtMTItMTAgYXQgMTQ6MDggLTA4
MDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+IFN5bm9wc3lzIFVTQiAzLnggaG9zdCBIQVBT
IHBsYXRmb3JtIGhhcyBhIGNsYXNzIGNvZGUgb2YNCj4gPiA+IFBDSV9DTEFTU19TRVJJQUxfVVNC
X1hIQ0ksIGFuZCB4aGNpIGRyaXZlciBjYW4gY2xhaW0gaXQuIEhvd2V2ZXIsIHRoZXNlDQo+ID4g
PiBkZXZpY2VzIHNob3VsZCB1c2UgZHdjMy1oYXBzIGRyaXZlci4gQ2hhbmdlIHRoZXNlIGRldmlj
ZXMnIGNsYXNzIGNvZGUgdG8NCj4gPiA+IFBDSV9DTEFTU19TRVJJQUxfVVNCX0RFVklDRSB0byBw
cmV2ZW50IHRoZSB4aGNpLXBjaSBkcml2ZXIgZnJvbSBjbGFpbWluZw0KPiA+ID4gdGhlbS4NCj4g
PiA+IA0KPiA+IFRoaXMgY2hhbmdlIGJyZWFrcyBteSBJTVg3ZCBiYXNlZCBkZXZpY2UuICBUaGlz
IFNvQyBoYXMgYSBQQ0llIGJ1cw0KPiA+IGJhc2VkIG9uIHRoZSBTeW5vcHN5cyBEZXNpZ253YXJl
IGhvc3QgY29udHJvbGxlci4gIFRoaXMgaGFzIGEgcm9vdA0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCj4gPiANCj4gUmlnaHQuIEx1a2FzIGFs
c28gcmVwb3J0ZWQgdGhpcy4gSXQgYXBwZWFycyB0aGF0IHRoZXJlJ3MgYSBkdXBsaWNhdGUgVklE
DQo+IFBJRCB1c2VkIGZvciB0aGUgVVNCIGNvbnRyb2xsZXIgb24gSEFQUyBwbGF0Zm9ybS4gWW91
IGNhbiByZXZpZXcgdGhlDQo+IGRpc2N1c3Npb24gc3ViamVjdCAiTGludXggS2VybmVsIFJlZ3Jl
c3Npb246IEhBUFMgcXVpcmsgYnJlYWtzIFBDSWUgb24NCj4gaS5NWDZRUCIuDQo+IA0KPiAtREVD
TEFSRV9QQ0lfRklYVVBfSEVBREVSKFBDSV9WRU5ET1JfSURfU1lOT1BTWVMsIFBDSV9BTllfSUQs
DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICBxdWlya19zeW5vcHN5c19oYXBzKTsNCj4gK0RF
Q0xBUkVfUENJX0ZJWFVQX0NMQVNTX0hFQURFUihQQ0lfVkVORE9SX0lEX1NZTk9QU1lTLCBQQ0lf
QU5ZX0lELA0KPiArICAgICAgICAgICAgICAgUENJX0NMQVNTX1NFUklBTF9VU0JfWEhDSSwgMCwg
cXVpcmtfc3lub3BzeXNfaGFwcyk7DQoNClRoYW5rcyBmb3IgdGhlIHF1aWNrIHJlc3BvbnNlLiAg
VGVzdGVkIHRoaXMgb24gaW14N2QsIGFuZCBhcyBleHBlY3RlZCwNCml0IGZpeGVzIHRoZSBwcm9i
bGVtLiAgVGhlIGhvc3QgYnJpZGdlIGhhcyBjbGFzcyBQQ0lfQ0xBU1NfQlJJREdFX1BDSQ0KbGlr
ZSBpdCBzaG91bGQgYW5kIHRoZSBxdWlyayBubyBsb25nZXIgbWF0Y2hlcy4NCg==
