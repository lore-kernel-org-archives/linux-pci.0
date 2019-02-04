Return-Path: <SRS0=vmzI=QL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE327C282C4
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 22:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649A620821
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 22:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="cFstsm4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfBDWmD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:42:03 -0500
Received: from mail-eopbgr710134.outbound.protection.outlook.com ([40.107.71.134]:11834
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726515AbfBDWmD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Feb 2019 17:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pxfVy5duTCEE4x8VsEy8oURJEse2wdVzvgwJ9VBKRA=;
 b=cFstsm4en/vTQyNbG8JQ7n+fNDt+jkGq3EuqZ2F5UUeIkTV1ulRCwBPwIXsNyGsC1YkMqQ0vPbR3wRbkcDiV97M3Q+RGaBBwNZCIzLLuNoURy+GY1y4mJp7GhrXi7gEStoCmkeD6TVGiyn88K0JO9NNrSxjduLxK3sqSy+bquWs=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3690.namprd06.prod.outlook.com (10.167.236.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Mon, 4 Feb 2019 22:42:00 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 22:42:00 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thinh.nguyen@synopsys.com" <thinh.nguyen@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "john.youn@synopsys.com" <john.youn@synopsys.com>
Subject: Re: [PATCH v2 2/2] PCI: Override Synopsys USB 3.x HAPS device class
Thread-Topic: [PATCH v2 2/2] PCI: Override Synopsys USB 3.x HAPS device class
Thread-Index: AQHUkNTUMps/WZ/k5UCaG/tMBlk70KXQlAQA
Date:   Mon, 4 Feb 2019 22:42:00 +0000
Message-ID: <1549320120.3075.12.camel@impinj.com>
References: <3aa06c4e54bf98a59e510d7a833934fce4b0083b.1544478969.git.thinhn@synopsys.com>
         <8994fd7d7ee2bf5c1b32ce5bca25be4beb4405b5.1544478969.git.thinhn@synopsys.com>
In-Reply-To: <8994fd7d7ee2bf5c1b32ce5bca25be4beb4405b5.1544478969.git.thinhn@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3690;6:llT6wKyejZh3icgsUEki1DVmO4pnSERPGK4c7S5EsnhbBerc898GwB/Rf4N7kwt0gHe/mGPWlQbEj1XaCVuc0WJ8ZY5yFUjjgbbcFGEXLxeNCz3jPYAb5Y+FfQENceRk08SauX+K1As6qogkAp8rfYmnElM72aRdLM7BEHkU32dTB4H/caTfeu9xB+BWWLYh6DBSGTP1ojq4CUo7sUrsVlhWYFTUA+vLNTi//3iSkS2WFGq1B7KQHc7/CNxJGwyXCldIaOSBkr6Q4kRnWYRVefzKs/TvkzrDqRq5dCQyK4xhffp5PNEVrn53gjsosnkaUxkXnuhB+JVS/kbalu3JWrp2A5uNn14p9Ya/gLzMOBCI2epQRF+WbR8ojFznaAFet87BXb7JhCn4Ol7iO5cwSnd3pqzEHCLzp6tSCKxPyTXtyaLDugifATxAgSI0q7bA32KviGr4NR612XXDBIgMgA==;5:DI2HOSoAHjer1hzD2O58nUt/d3Zw/8cnbxgldclqFf0EkM1tubHmjWkHcgWVKQMLYDbbIgK6pwpvPzDOV0hIJoYCciW2qCybL5fFGDL/LuqG0q7lAyvZN7ZZX+dzLe5vb0C2FGoE9Cyw+eA0yy3dFEgYZGt+i+NSFJJsk9swl8NyqYQ5ea87VlHxuAsRvQeU/vC8+8cvXZ2cnoXwdBAiLg==;7:BQgT7aeXAljIRciFbc7u3EYDoGiOI+Wq/I3l0dM+3PPP4/ub47bLHIsb1iLCGXz6k2r9+iMtxtpEhVb2rRyzozRwlDX3Sb95d4YwJo6LJ79k5yY/9M9Q3YzUzkT5tUWklgcHRj2prfZB/Y0DBV70CA==
x-ms-office365-filtering-correlation-id: 24cff4de-efb1-4732-8105-08d68af1fa2f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3690;
x-ms-traffictypediagnostic: MWHPR0601MB3690:
x-microsoft-antispam-prvs: <MWHPR0601MB3690FEB0A38075BBD3A8B7AAD36D0@MWHPR0601MB3690.namprd06.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(346002)(366004)(136003)(376002)(189003)(199004)(6436002)(26005)(11346002)(446003)(2616005)(476003)(66066001)(186003)(14454004)(53936002)(103116003)(478600001)(110136005)(316002)(76176011)(6512007)(71200400001)(71190400001)(8676002)(2501003)(6486002)(7736002)(81166006)(305945005)(97736004)(106356001)(105586002)(229853002)(6246003)(25786009)(4001150100001)(102836004)(5024004)(86362001)(486006)(6506007)(99286004)(36756003)(2201001)(81156014)(2906002)(4326008)(3846002)(8936002)(68736007)(6116002)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3690;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lh2EnR4yTToZU9gRq+hP9loCuIgvr0BxA/RuOYdVJS2e3+9ZwQ/6liMNj2rGXggtMdyYMjLNXVPItAmo/Y93XJRXViG2YOCyeRwrdXmSMsgVJTdB9bRuCj+EmV7ME3xSLjVBail7DEoUajrMiig3bRVFwzIRkkN4dBvFsj4iohqX1DA3hIp0/7uINDZA2mF7/z0qfMofDThmnW1bzG7PLLWbBAp1v0fhsoqtX9Dev3FI8HEj0/747+6k4yZByQN638wNGofOZM18TDwDgogz9YD8phOhmhamNI+icFMy3tkvt4/U5QJM1BZze9Pd5Ou0ud2mgzmj9k4Z1q9SGyivCRm5I+zeiTQ4zyuc2+qQy9/xCaVe5kcwbVvNqrZxlqrJDhk75QcHLJeS9qa5m5JWLedRIRB5SU2HlLmhKILle4Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2342292C5FA7D4C93107F60804044EB@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cff4de-efb1-4732-8105-08d68af1fa2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 22:42:00.6771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3690
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDE4LTEyLTEwIGF0IDE0OjA4IC0wODAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+
IFN5bm9wc3lzIFVTQiAzLnggaG9zdCBIQVBTIHBsYXRmb3JtIGhhcyBhIGNsYXNzIGNvZGUgb2YN
Cj4gUENJX0NMQVNTX1NFUklBTF9VU0JfWEhDSSwgYW5kIHhoY2kgZHJpdmVyIGNhbiBjbGFpbSBp
dC4gSG93ZXZlciwgdGhlc2UNCj4gZGV2aWNlcyBzaG91bGQgdXNlIGR3YzMtaGFwcyBkcml2ZXIu
IENoYW5nZSB0aGVzZSBkZXZpY2VzJyBjbGFzcyBjb2RlIHRvDQo+IFBDSV9DTEFTU19TRVJJQUxf
VVNCX0RFVklDRSB0byBwcmV2ZW50IHRoZSB4aGNpLXBjaSBkcml2ZXIgZnJvbSBjbGFpbWluZw0K
PiB0aGVtLg0KPiANCg0KPiArDQo+ICsJc3dpdGNoIChwZGV2LT5kZXZpY2UpIHsNCj4gKwljYXNl
IFBDSV9ERVZJQ0VfSURfU1lOT1BTWVNfSEFQU1VTQjM6DQo+ICsJY2FzZSBQQ0lfREVWSUNFX0lE
X1NZTk9QU1lTX0hBUFNVU0IzX0FYSToNCj4gKwljYXNlIFBDSV9ERVZJQ0VfSURfU1lOT1BTWVNf
SEFQU1VTQjMxOg0KPiArCQlwZGV2LT5jbGFzcyA9IFBDSV9DTEFTU19TRVJJQUxfVVNCX0RFVklD
RTsNCj4gKwkJcGNpX2luZm8ocGRldiwgIlBDSSBjbGFzcyBvdmVycmlkZGVuICglIzA4eCAtPiAl
IzA4eCkgc28gZHdjMyBkcml2ZXIgY2FuIGNsYWltIHRoaXMgaW5zdGVhZCBvZiB4aGNpXG4iLA0K
PiArCQkJIGNsYXNzLCBwZGV2LT5jbGFzcyk7DQo+ICsJCWJyZWFrOw0KPiArCWRlZmF1bHQ6DQo+
ICsJCXJldHVybjsNCj4gKwl9DQo+ICt9DQo+ICtERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJ
X1ZFTkRPUl9JRF9TWU5PUFNZUywgUENJX0FOWV9JRCwNCj4gKwkJCSBxdWlya19zeW5vcHN5c19o
YXBzKTsNCj4gKw0KDQpUaGlzIGNoYW5nZSBicmVha3MgbXkgSU1YN2QgYmFzZWQgZGV2aWNlLiAg
VGhpcyBTb0MgaGFzIGEgUENJZSBidXMNCmJhc2VkIG9uIHRoZSBTeW5vcHN5cyBEZXNpZ253YXJl
IGhvc3QgY29udHJvbGxlci4gIFRoaXMgaGFzIGEgcm9vdA0KYnJpZGdlIHRoYXQgc2hvd3MgdXAg
YXM6DQoNCjAwOjAwLjAgUENJIGJyaWRnZTogU3lub3BzeXMsIEluYy4gRGV2aWNlIGFiY2QgKHJl
diAwMSkgKHByb2ctaWYgMDAgW05vcm1hbCBkZWNvZGVdKSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIA0KMDA6MDAuMCAwNjA0OiAxNmMzOmFiY2QgKHJldiAwMSkgKHByb2ctaWYgMDAg
W05vcm1hbCBkZWNvZGVdKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgDQoNCldoaWNoIGlzIHRvIHNheSwgY2xhc3MgMHgwNjA0LCB2ZW5kb3Ig
UENJX1ZFTkRPUl9JRF9TWU5PUFNZUywgYW5kIHRoZQ0KZGV2aWNlIElEIDB4YWJjZC4NCg0KSXQg
bG9va3MgbGlrZSB0aGVyZSBoYXMgYmVlbiBhIGJpdCBvZiBzbG9wcHkgYWxsb2NhdGlvbiBvZiBQ
Q0kgZGV2aWNlDQpjb2RlcywgYXMgUENJX0RFVklDRV9JRF9TWU5PUFNZU19IQVBTVVNCMyBpcyBh
bHNvIDB4YWJjZC4NCg0KU28gdGhlIHJlc3VsdCBvZiB0aGlzIHBhdGNoIGlzIHRvIHRyeSB0byB0
dXJuIHRoZSBpbXg3ZCBQQ0llIHJvb3QNCmJyaWRnZSBpbnRvIGEgVVNCIGNvbnRyb2xsZXIuICBX
aGljaCBvZiBjb3Vyc2UgYnJlYWtzIGl0IGFuZCBwcmV2ZW50cw0KYW55dGhpbmcgYmVoaW5kIGl0
LCBpLmUuIHRoZSBlbmRwb2ludCBhdHRhY2hlZCB0byB0aGUgcGNpLWUgYnVzLCBmcm9tDQp3b3Jr
aW5nLg0KDQpTb21laG93IHRoaXMgcXVpcmsgbmVlZHMgdG8gYmUgbW9yZSB0YXJnZXRlZC4=
