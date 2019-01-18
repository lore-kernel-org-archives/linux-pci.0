Return-Path: <SRS0=ljL/=P2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E08BC43387
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 14:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2413A20652
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 14:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ZfWhGoQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfAROFu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:05:50 -0500
Received: from mail-eopbgr690081.outbound.protection.outlook.com ([40.107.69.81]:39744
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727234AbfAROFu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jan 2019 09:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzYvftE8hpUI8xtRvxf804AJaB71SrbfeRDBhvBPOqo=;
 b=ZfWhGoQz60j4+ruVzcvp7+lV12+6U492kIAr5w6yHPSV9dEjnUP0EvY3hLzG7Ofzk14SacXG4+qPBQ0iJA4xQNbo3dIhm9aOJpXtY/NrlMXAVHP3NqC+/5Fjt2ucocWtkMfSHbtrUDDwyJ2uwaaELY7hLMdEreY5JfvZUQwE6Rs=
Received: from MN2PR05MB6493.namprd05.prod.outlook.com (20.178.247.24) by
 MN2PR05MB6239.namprd05.prod.outlook.com (20.178.242.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.10; Fri, 18 Jan 2019 14:05:47 +0000
Received: from MN2PR05MB6493.namprd05.prod.outlook.com
 ([fe80::608e:c582:4b94:2dc0]) by MN2PR05MB6493.namprd05.prod.outlook.com
 ([fe80::608e:c582:4b94:2dc0%3]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 14:05:47 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jork Loeser <jloeser@microsoft.com>,
        "longli@microsoft.com" <longli@microsoft.com>
Subject: Re: [PATCH 3/3] PCI: hv: Use vPCI protocol version 1.2 for v4.9
Thread-Topic: [PATCH 3/3] PCI: hv: Use vPCI protocol version 1.2 for v4.9
Thread-Index: AQHUrmMimZzh/8xuQU+C3yQiEJMSn6Wzj8kAgAHdcYA=
Date:   Fri, 18 Jan 2019 14:05:46 +0000
Message-ID: <AD2B545E-FC05-402D-80A4-FB542A6D3C06@vmware.com>
References: <1547758038-5255-1-git-send-email-akaher@vmware.com>
 <1547758038-5255-4-git-send-email-akaher@vmware.com>
 <20190117150654.GF158366@google.com>
In-Reply-To: <20190117150654.GF158366@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [103.19.212.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR05MB6239;20:I9cblD+Sbv/9wSq4UpQWsgC0ncdx4KI/GUxVfI9WG8BXeToNZRQbQCTA9JSMDO+m6zc0lK9c8hKQJEYvxXI/iq7vTdDPYroT/ZUMcRFBkQfII9hwEATrS/na69Wosb0Z7oe8wYKx2CtBIF2W3bncDDTVmVrPgd7eUOyA0Gh3COc=
x-ms-office365-filtering-correlation-id: a4d6b9e7-6afb-439f-c8c7-08d67d4e0b83
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MN2PR05MB6239;
x-ms-traffictypediagnostic: MN2PR05MB6239:
x-microsoft-antispam-prvs: <MN2PR05MB6239D0467DDF11D3ADC7C668BB9C0@MN2PR05MB6239.namprd05.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(366004)(54534003)(189003)(199004)(24433001)(3846002)(6116002)(229853002)(7736002)(305945005)(6436002)(8676002)(6486002)(68736007)(8936002)(81166006)(81156014)(105586002)(82746002)(33656002)(106356001)(4326008)(25786009)(11346002)(446003)(486006)(476003)(2616005)(6246003)(6512007)(53936002)(66066001)(478600001)(54906003)(316002)(14454004)(99286004)(256004)(14444005)(71190400001)(6916009)(5660300001)(83716004)(86362001)(36756003)(71200400001)(2906002)(97736004)(102836004)(53546011)(6506007)(6346003)(76176011)(26005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6239;H:MN2PR05MB6493.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=akaher@vmware.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /GQn0wj61vhMPw5q57Y7Zc3/M7Q6qNBQ3cWaGee4+Wmw8qX7QEkTQNew7vBhWOENC/ymHD7JB9k5TQQBu5SVz1jVwoQFrv7Al1XN/43Ld9ON7bkgvHY0LboqLQHU8UwzRGbDhwgOeUshctBgZQyum0w5oXq8mblAzpq6KA3Va5Nl05ml3EAhaLXWc2IU3g/c9nTq/rYA0mViBKdc+6ZSfwtIBZj0hrDi/tc80aWkoCSqGuw8Fj4o7YFlupfgC2x9kBth+TF37OzPYL0hSGAp8FDUgKUtcGXHcWafTUygF6r1NrFdOw7JC83tEydyC9+DUGHtWO4JbdO4o5xzrg7q1pLdYJUNPyGkUDrtCwFB5aabl2idaQWwAvrPhxh/rmLc8+PXpHzGwKoM7CpUIstwj3x3dxp3307B8H41GD4NCJ0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <917B25A484DF034BB7F206AB0EB10232@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d6b9e7-6afb-439f-c8c7-08d67d4e0b83
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 14:05:47.1769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6239
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCu+7vz4gT24gMTcvMDEvMTksIDg6MzcgUE0sICJCam9ybiBIZWxnYWFzIiA8aGVsZ2Fhc0Br
ZXJuZWwub3JnPiB3cm90ZToNCj4NCj4gPiBPbiBGcmksIEphbiAxOCwgMjAxOSBhdCAwMjoxNzox
OEFNICswNTMwLCBBamF5IEthaGVyIHdyb3RlOg0KPiA+IFVwZGF0ZSB0aGUgSHlwZXItViB2UENJ
IGRyaXZlciB0byB1c2UgdGhlIFNlcnZlci0yMDE2IHZlcnNpb24gb2YgdGhlIHZQQ0kNCj4gPiBw
cm90b2NvbCwgZml4aW5nIE1TSSBjcmVhdGlvbiBhbmQgcmV0YXJnZXRpbmcgaXNzdWVzLg0KPiA+
IA0KPiA+IFJlcGxhY2VkIGh2X3RtcF9jcHVfbnJfdG9fdnBfbnIoKSB3aXRoIHZtYnVzX2NwdV9u
dW1iZXJfdG9fdnBfbnVtYmVyKCkNCj4gPiB0byBtYWtlIHRoaXMgcGF0Y2ggY29tcGF0aWJhbGUg
Zm9yIGxpbnV4IHY0LjkuDQo+ICAgIA0KPiBzL2NvbXBhdGliYWxlIGZvci9jb21wYXRpYmxlIHdp
dGgvDQo+DQo+IFRoaXMgY2hhbmdlICh0byBtYWtlIGl0IGNvbXBhdGlibGUgd2l0aCB2NC45KSBz
b3VuZHMgbGlrZSBpdCBzaG91bGQgYmUNCj4gaW4gaXRzIG93biBzZXBhcmF0ZSBwYXRjaC4gIEkg
ZG9uJ3Qgc2VlIGFueSB1c2Ugb2YNCj4gaHZfdG1wX2NwdV9ucl90b192cF9ucigpIGJlaW5nIHJl
bW92ZWQsIHNvIHRoZSBjaGFuZ2Vsb2cgZG9lc24ndCBxdWl0ZQ0KPiBtYWtlIHNlbnNlLg0KDQpo
dl90bXBfY3B1X25yX3RvX3ZwX25yKCkgaXMgbm90IHJlbW92ZWQsIHY0LjkgZG9lc24ndCBoYXZl
IHRoaXMgQVBJLA0KYW5kIGJlY2F1c2Ugb2YgdGhpcyBmYWlsZWQgdG8gYXBwbHkgdGhlIG9yaWdp
bmFsIHBhdGNoIG9uIHY0LjkuIA0KVGhhdCdzIHRoZSByZWFzb24gdG8gdXNlIHZtYnVzX2NwdV9u
dW1iZXJfdG9fdnBfbnVtYmVyKCkgDQppbnN0ZWFkIG9mIGh2X3RtcF9jcHVfbnJfdG9fdnBfbnIo
KS4NCg0KSSB3aWxsIGNoYW5nZSB0aGUgZXhwbGFuYXRpb24gaW4gY2hhbmdlbG9nIHRvOg0KQmVj
YXVzZSB2NC45IGRvZXNuJ3QgaGF2ZSBodl90bXBfY3B1X25yX3RvX3ZwX25yKCksIA0Kc28gb3Jp
Z2luYWwgcGF0Y2ggZnJvbSB2NC4xNCBmYWlscyB0byBhcHBseSBvbiB2NC45Lg0KVG8gc29sdmUg
dGhpcywgdXNpbmcgdm1idXNfY3B1X251bWJlcl90b192cF9udW1iZXIoKSANCmluc3RlYWQgb2Yg
aHZfdG1wX2NwdV9ucl90b192cF9ucigpIGluIHRoaXMgcGF0Y2guDQoNCkhlcmUsIEkgd291bGQg
bGlrZSBtYWludGFpbmVyIG9mIEh5cGVyViB0byByZXZpZXcgdGhpcyBjaGFuZ2UgYW5kIA0KcHJv
dmlkZSB0aGVpciBmZWVkYmFjay4gVGVzdGVkIHRoZXNlIHBhdGNoZXMgb24gQXp1cmUgU2VydmVy
IHdpdGgNClZNIG9mIHNpemUgTDE2c192MiBhbmQgaXQncyB3b3JraW5nIGZpbmUuDQogICAgDQo+
ID4gU2lnbmVkLW9mZi1ieTogSm9yayBMb2VzZXIgPGpsb2VzZXJAbWljcm9zb2Z0LmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiAg
IA0KPiBJIGRpZCBub3Qgc2lnbiBvZmYgb24gdGhpczsgcGxlYXNlIHJlbW92ZS4NCg0KU29ycnks
IEkga2VwdCBhcyBpdCBpcyBmcm9tIG9yaWdpbmFsIHBhdGNoLiBJIHdpbGwgY2hhbmdlIHRoaXMg
aW4gbmV4dCB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2guDQogICAgDQo+ID4gUmV2aWV3ZWQtYnk6IEsu
IFkuIFNyaW5pdmFzYW4gPGt5c0BtaWNyb3NvZnQuY29tPg0KPiA+IEFja2VkLWJ5OiBLLiBZLiBT
cmluaXZhc2FuIDxreXNAbWljcm9zb2Z0LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBamF5IEth
aGVyIDxha2FoZXJAdm13YXJlLmNvbT4NCj4gICAgDQo+ID4gKyAqIHN0cnVjdCBodl9tc2lfZGVz
YzIgLSAxLjIgdmVyc2lvbiBvZiBodl9tc2lfZGVzYw0KPiA+ICsgKiBAdmVjdG9yOgkJSURUIGVu
dHJ5DQo+ID4gKyAqIEBkZWxpdmVyeV9tb2RlOglBcyBkZWZpbmVkIGluIEludGVsJ3MgUHJvZ3Jh
bW1lcidzDQo+ID4gKyAqCQkJUmVmZXJlbmNlIE1hbnVhbCwgVm9sdW1lIDMsIENoYXB0ZXIgOC4N
Cj4gPiArICogQHZlY3Rvcl9jb3VudDoJTnVtYmVyIG9mIGNvbnRpZ3VvdXMgZW50cmllcyBpbiB0
aGUNCj4gPiArICoJCQlJbnRlcnJ1cHQgRGVzY3JpcHRvciBUYWJsZSB0aGF0IGFyZQ0KPiA+ICsg
KgkJCW9jY3VwaWVkIGJ5IHRoaXMgTWVzc2FnZS1TaWduYWxlZA0KPiA+ICsgKgkJCUludGVycnVw
dC4gRm9yICJNU0kiLCBhcyBmaXJzdCBkZWZpbmVkDQo+ID4gKyAqCQkJaW4gUENJIDIuMiwgdGhp
cyBjYW4gYmUgYmV0d2VlbiAxIGFuZA0KPiA+ICsgKgkJCTMyLiBGb3IgIk1TSS1YLCIgYXMgZmly
c3QgZGVmaW5lZCBpbiBQQ0kNCj4gPiArICoJCQkzLjAsIHRoaXMgbXVzdCBiZSAxLCBhcyBlYWNo
IE1TSS1YIHRhYmxlDQo+ID4gKyAqCQkJZW50cnkgd291bGQgaGF2ZSBpdHMgb3duIGRlc2NyaXB0
b3IuDQo+ICANCj4gUGxlYXNlIHJlZmxvdyB0aGVzZSBkZXNjcmlwdGlvbnMgdG8gdGFrZSBhZHZh
bnRhZ2Ugb2YgYW4gODAgY29sdW1uDQo+IHdpZHRoLiAgVGhleSBhcmUgY3VycmVudGx5IHdyYXBw
ZWQgdG8gZml0IGluIDUwIGNvbHVtbnMsIHdoaWNoIGlzDQo+IHVubmVjZXNzYXJpbHkgc2hvcnQu
DQoNClRoYW5rcywgSSB3aWxsIGNoYW5nZSB0aGlzIGluIG5leHQgdmVyc2lvbiBvZiB0aGlzIHBh
dGNoLg0KICAgIA0KPiA+ICsJZGVmYXVsdDoNCj4gPiArCQkvKiBBcyB3ZSBvbmx5IG5lZ290aWF0
ZSBwcm90b2NvbCB2ZXJzaW9ucyBrbm93biB0byB0aGlzIGRyaXZlciwNCj4gPiArCQkgKiB0aGlz
IHBhdGggc2hvdWxkIG5ldmVyIGhpdC4gSG93ZXZlciwgdGhpcyBpcyBpdCBub3QgYSBob3QNCj4g
PiArCQkgKiBwYXRoIHNvIHdlIHByaW50IGEgbWVzc2FnZSB0byBhaWQgZnV0dXJlIHVwZGF0ZXMu
DQo+ID4gKwkJICovDQo+ID4gKwkJZGV2X2VycigmaGJ1cy0+aGRldi0+ZGV2aWNlLA0KPiA+ICsJ
CQkiVW5leHBlY3RlZCB2UENJIHByb3RvY29sLCB1cGRhdGUgZHJpdmVyLiIpOw0KICAgIA0KPiBJ
bmNsdWRlIHRoZSBhY3R1YWwgcHJvdG9jb2wgdmVyc2lvbiBpbiB0aGUgbWVzc2FnZT8NCg0KVGhh
bmtzLCBJIHdpbGwgdHJ5IHRvIGNoYW5nZSB0aGlzIGluIG5leHQgdmVyc2lvbi4NCg0KDQo=
