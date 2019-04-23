Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1366AC10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 11:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD98B21738
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 11:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="5JI1mbEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfDWLAj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:00:39 -0400
Received: from mail-eopbgr730059.outbound.protection.outlook.com ([40.107.73.59]:26304
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726150AbfDWLAj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Apr 2019 07:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uT5nmQ39ZIzYf1VzA+8ek/it+6XQ4D9frvCBKIPw8IA=;
 b=5JI1mbEKbD+WMFpLTvo3MTWj319adlpAchmDLMwdsJmz4LCsD1tP+Bft1vARfgmL900x07S6lDUHLpSatNGKX0Rd8NjwUmpgQvbAH7ZHX2G9uJCNVic0ZUwgFD1oQeHn1OgzwtRVbTcHOcChYwCO8s2ewFAbGL6w30SBxXBKtWY=
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3326.namprd12.prod.outlook.com (20.178.242.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Tue, 23 Apr 2019 11:00:35 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1955:d41f:be8c:7c86]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1955:d41f:be8c:7c86%5]) with mapi id 15.20.1813.017; Tue, 23 Apr 2019
 11:00:35 +0000
From:   Sanjay R Mehta <sanmehta@amd.com>
To:     "epilmore@gigaio.com" <epilmore@gigaio.com>,
        S Taylor <staylor@gigaio.com>, D Meyer <dmeyer@gigaio.com>,
        linux-ntb <linux-ntb@googlegroups.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Fwd: AMD IO_PAGE_FAULT w/NTB on Write ops?
Thread-Topic: Fwd: AMD IO_PAGE_FAULT w/NTB on Write ops?
Thread-Index: AQHU+b6baOHYIBGar06lNCt1pbE4FaZJlASA
Date:   Tue, 23 Apr 2019 11:00:35 +0000
Message-ID: <cdcd00e9-056b-3364-cfbc-5bcb5bcff91e@amd.com>
References: <CAOQPn8sX2G-Db-ZiFpP2SMKbkQnPyk63UZijAY0we+DoZsmDtQ@mail.gmail.com>
 <CAADLhr49ke_3s25gW11qZ+H-Jjje-E00WMHiMDbKU=mcCQtb3g@mail.gmail.com>
In-Reply-To: <CAADLhr49ke_3s25gW11qZ+H-Jjje-E00WMHiMDbKU=mcCQtb3g@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::27) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.157.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 014559c8-930b-4096-552a-08d6c7dae984
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR12MB3326;
x-ms-traffictypediagnostic: MN2PR12MB3326:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <MN2PR12MB3326C2289CE12E75DAF8A3B4E5230@MN2PR12MB3326.namprd12.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(396003)(346002)(39860400002)(189003)(199004)(2906002)(316002)(97736004)(386003)(102836004)(53546011)(68736007)(14444005)(6506007)(26005)(186003)(5660300002)(25786009)(305945005)(478600001)(6512007)(73956011)(256004)(966005)(53386004)(6306002)(53936002)(36756003)(72206003)(6246003)(76176011)(229853002)(7736002)(71200400001)(64756008)(476003)(52116002)(66476007)(66446008)(486006)(6436002)(3846002)(66556008)(99286004)(6116002)(2616005)(6486002)(2501003)(71190400001)(31696002)(66066001)(110136005)(11346002)(446003)(81166006)(14454004)(81156014)(31686004)(8676002)(8936002)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3326;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uytuXC3eHj02M8cBxUWHCKAE0fSd7jko1Va0j9FHsNvU81+kF9uNseRJhYuiTHsVyhLqysjf/wqaWc93XclRlF+qiDit9t6J6yOVzO0e2xKjG3XFMkiB1DWcUpH1dUUDaGOOEbwJB6Eys0P/iklnzaWut2ZIfEwgq+RuwDDa7LU3btYHSXEjG6RcrXuUhdGlf/sQtfT3LiO2rUqfu5QdjguJdYny10Sf6+rqe1Dj4kRf9usmLq55d6x96T9UaxYz8o9N4bSjATteSKDmwGVAVOzLKsbhDipZP+eQyv96ZwSbHt8hdr+R7MmxYvCcZUwtXKHtpoKJBeicv6doSiunjVDbpi8TzCDLoDJtevyXHZaD9zLWRKCpEm7wBygyRvpsb7buOOoOI1MGrQAygpqEEmXOvogT1vSaG6V7btwowS8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <761C8483CD5C47449A9CB655B1A2ED35@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014559c8-930b-4096-552a-08d6c7dae984
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 11:00:35.6777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3326
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IEZyb206ICpFcmljIFBpbG1vcmUqIDxlcGlsbW9yZUBnaWdhaW8uY29tIDxtYWlsdG86ZXBp
bG1vcmVAZ2lnYWlvLmNvbT4+DQo+IERhdGU6IFNhdCwgQXByIDIwLCAyMDE5IGF0IDI6MzYgUE0N
Cj4gU3ViamVjdDogQU1EIElPX1BBR0VfRkFVTFQgdy9OVEIgb24gV3JpdGUgb3BzPw0KPiBUbzog
bGludXgtbnRiIDxsaW51eC1udGJAZ29vZ2xlZ3JvdXBzLmNvbSA8bWFpbHRvOmxpbnV4LW50YkBn
b29nbGVncm91cHMuY29tPj4sIDxsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIDxtYWlsdG86bGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZz4+DQo+IENjOiBTIFRheWxvciA8c3RheWxvckBnaWdhaW8u
Y29tIDxtYWlsdG86c3RheWxvckBnaWdhaW8uY29tPj4sIEQgTWV5ZXIgPGRtZXllckBnaWdhaW8u
Y29tIDxtYWlsdG86ZG1leWVyQGdpZ2Fpby5jb20+Pg0KPg0KPg0KPiBIaSBGb2xrcywNCj4NCj4g
QmVmb3JlIEkgYXNrIG15IHF1ZXN0aW9ucywgaGVyZSBpcyBhIGxpdHRsZSBiYWNrZ3JvdW5kIG9u
IHRoZQ0KPiBlbnZpcm9ubWVudCBJIGhhdmU6DQo+IC0gMiBob3N0czogMSBYZW9uIGJhc2VkIChJ
bnRlbChSKSBYZW9uKFIpIEdvbGQgNTExNSBDUFUgQCAyLjQwR0h6KSwNCj4gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgMSBBTUQgYmFzZWQgKEFNRCBFUFlDIDc0MDEgMjQtQ29yZSBQcm9jZXNzb3Ip
DQo+IC0gRWFjaCBob3N0IGlzIGludGVyY29ubmVjdGVkIHZpYSBhbiBleHRlcm5hbCBQQ0ktZSAo
c3dpdGNodGVjKSBzd2l0Y2guDQo+IC0gVGhlIHR3byBob3N0cyBhcmUgZXhwb3J0aW5nIG1lbW9y
eSB0byBlYWNoIG90aGVyIHZpYSBOVEIuDQo+IC0gSU9NTVUgaXMgZW5hYmxlZCBpbiBib3RoIGhv
c3RzLiBUaGUgWGVvbiBwbGF0Zm9ybSByZXF1aXJlcyBzb21lIEJJT1MNCj4gc2V0dGluZ3MgYW5k
IGEga2VybmVsIHBhcmFtZXRlciAoaW50ZWxfaW9tbXU9b24pLCBob3dldmVyIGFzIGZhciBhcyBJ
DQo+IGhhdmUgYmVlbiBhYmxlIHRvIGRldGVybWluZSwgdGhlIEFNRCBvbmx5IHJlcXVpcmVzIHRo
ZSBJT01NVSBCSU9TDQo+IHNldHRpbmcgdG8gYmUgZW5hYmxlZCBhbmQgbm8gc3BlY2lhbCBrZXJu
ZWwgYm9vdCBwYXJhbWV0ZXJzLiBEb2VzIHRoYXQNCj4gc291bmQgcmlnaHQgZm9yIEFNRD8NClll
cy4geW91IGFyZSBjb3JyZWN0IEVyaWMuDQo+IC0gUmVnaW9uIG9mIG1lbW9yeSBleHBvcnRlZCB0
byBlYWNoIGhvc3QgaXMgYWNxdWlyZWQvbWFwcGVkIHZpYQ0KPiBkbWFfYWxsb2NfY29oZXJlbnQo
KSB1c2luZyB0aGUgImRldmljZSIgb2YgdGhlIHJlc3BlY3RpdmUgZXh0ZXJuYWwNCj4gUENJLWUg
c3dpdGNoLg0KPiAtIFRoZSBkbWFfYWRkciByZXR1cm5lZCBmcm9tIHRoZSBkbWFfYWxsb2NfY29o
ZXJlbnQgaXMgcmVsYXllZCB0byB0aGUNCj4gcGVlciBob3N0IHdobyB0aGVuIGFkZHMgdGhhdCB2
YWx1ZSAoaS5lLiBJT1ZBIG9mZnNldCkgdG8gaXQncyBsb2NhbA0KPiBQQ0kgQkFSIHJlcHJlc2Vu
dGluZyB0aGUgc3dpdGNoLCBhbmQgdGhlbiBpb3JlbWFwKCkncyB0aGF0IHJlc3VsdGluZw0KPiBh
ZGRyZXNzIHRvIGdldCBhIENQVSB2aXJ0dWFsIGFkZHJlc3MgdG8gd2hpY2ggaXQgY2FuIG5vdyBw
ZXJmb3JtDQo+IGlvcmVhZC9pb3dyaXRlIG9wZXJhdGlvbnMuDQo+DQo+IFdoYXQgd2UgaGF2ZSBm
b3VuZCBpcyB0aGF0IHRoZSBYZW9uIGJhc2VkIGhvc3QgY2FuIHN1Y2Nlc3NmdWxseSBpb3JlYWQN
Cj4gdG8gdGhpcyBtYXBwZWQgc2hhcmVkIGJ1ZmZlciwgYnV0IHdoZW5ldmVyIGl0IGF0dGVtcHRz
IGFuIGlvd3JpdGUgdG8NCj4gdGhpcyByZWdpb24sIGl0IHJlc3VsdHMgaW4gYW4gSU9fUEFHRV9G
QVVMVCBvbiB0aGUgQU1EIGJhc2VkIGhvc3Q6DQo+DQo+IEFNRC1WaTogRXZlbnQgbG9nZ2VkIFtJ
T19QQUdFX0ZBVUxUIGRldmljZT0yMzowMS4yIGRvbWFpbj0weDAwMDANCj4gYWRkcmVzcz0weDAw
MDAwMDAwZmRlMWMxOGMgZmxhZ3M9MHgwMDcwXQ0KDQp0aGUgYWRkcmVzcyBpbiB0aGUgYWJvdmUg
bG9nIGxvb2tzIHRvIGJlIHBoeXNpY2FsIGFkZHJlc3Mgb2YgbWVtb3J5IHdpbmRvdy4gQW0gSSBS
aWdodD8NCg0KSWYgeWVzIHRoZW4sIHRoZSBmaXJzdCBwYXJhbWV0ZXIgb2YgZG1hX2FsbG9jX2Nv
aGVyZW50KCkgdG8gYmUgcGFzc2VkIGFzIGJlbG93LA0KDQpkbWFfYWxsb2NfY29oZXJlbnQoJm50
Yi0+cGRldi0+ZGV2LCAuLi4paW5zdGVhZCBvZiBkbWFfYWxsb2NfY29oZXJlbnQoJm50Yi0+ZGV2
LCAuLi4pLg0KDQpIb3BlIHRoaXMgc2hvdWxkIHNvbHZlIHlvdXIgcHJvYmxlbS4NCg0KPg0KPiBH
b2luZyBpbiB0aGUgb3Bwb3NpdGUgZGlyZWN0aW9uIHRoZXJlIGFyZSBubyBpc3N1ZXMsIGkuZS4g
dGhlIEFNRA0KPiBiYXNlZCBob3N0IGNhbiBzdWNjZXNzZnVsbHkgaW9yZWFkL2lvd3JpdGUgdG8g
dGhlIG1hcHBlZCBpbiBidWZmZXINCj4gZXhwb3J0ZWQgYnkgdGhlIFhlb24gaG9zdC7CoCBPciBp
ZiBib3RoIGhvc3RzIGFyZSBYZW9uJ3MsIHRoZW4NCj4gZXZlcnl0aGluZyB3b3JrcyBmaW5lIGFs
c28uDQo+DQo+IEkgaGF2ZSBsb29rZWQgaGlnaCBhbmQgbG93LCBhbmQgaGF2ZSBub3QgYmVlbiBh
YmxlIHRvIGludGVycHJldCB3aGF0DQo+IHRoZSAiZmxhZ3M9MHgwMDcwIiByZXByZXNlbnQuIEkg
YXNzdW1lIHRoZXkgYXJlIGluZGljYXRpbmcgc29tZSB3cml0ZQ0KPiBwZXJtaXNzaW9uIGVycm9y
LCBidXQgd2FzIHdvbmRlcmluZyBpZiBhbnlib2R5IGhlcmUgbWlnaHQga25vdz8NCj4NCj4gTW9y
ZSBpbXBvcnRhbnRseSwgZG9lcyBhbnlib2R5IGtub3cgd2h5IHRoZSBBTUQgSU9NTVUgbWlnaHQg
c2VlbWluZ2x5DQo+IGRlZmF1bHQgdG8gbm90IGFsbG93IFdyaXRlIG9wZXJhdGlvbnMgdG8gdGhl
IGV4cG9ydGVkIG1lbW9yeT8gSXMgdGhlcmUNCj4gc29tZSBhZGRpdGlvbmFsIEJJT1Mgb3Iga2Vy
bmVsIGJvb3QgcGFyYW1ldGVyIHNldHRpbmcgdGhhdCBuZWVkcyB0byBiZQ0KPiBzZXQ/DQo+DQo+
IGxzcGNpIG9uIHRoZSBBTUQgaG9zdHMgb2YgdGhlIGV4dGVybmFsIFBDSS1lIHN3aXRjaDoNCj4g
wqAgwqAyMzowMC4wIFBDSSBicmlkZ2U6IFBNQy1TaWVycmEgSW5jLiBEZXZpY2UgODUzNg0KPiDC
oCDCoDIzOjAwLjEgQnJpZGdlOiBQTUMtU2llcnJhIEluYy4gRGV2aWNlIDg1MzYNCj4NCj4gVGhl
IDIzOjAwLjEgQkRGIGlzIHRoZSBOVEIgYnJpZGdlLiBUaGUgQkRGICgyMzowMS4yKSBpbiB0aGUg
ZXJyb3INCj4gbWVzc2FnZSByZXByZXNlbnRzIHRoZSAiTlRCIHRyYW5zbGF0ZWQiIEJERiBvZiB0
aGUgcmVxdWVzdCB0aGF0IGNhbWUNCj4gZnJvbSB0aGUgcGVlciwgaS5lLiB0aGUgMDEuMiBpcyB0
aGUgcHJveHktaWQuIElzIHRoZXJlIGEgY2hhbmNlIHRoYXQNCj4gdGhpcyBwcm94eS1pZCBpcyBj
YXVzaW5nIHNvbWUgY29uZnVzaW9uIGZvciB0aGUgQU1EIElPTU1VPw0KPg0KPiBXb3VsZCBncmVh
dGx5IGFwcHJlY2lhdGUgYW55IGFzc2lzdGFuY2UhDQo+DQo+IFRoYW5rcyENCj4NCj4gLS0gDQo+
IEVyaWMgUGlsbW9yZQ0KPiBlcGlsbW9yZUBnaWdhaW8uY29tIDxtYWlsdG86ZXBpbG1vcmVAZ2ln
YWlvLmNvbT4NCj4gaHR0cDovL2dpZ2Fpby5jb20NCj4gUGhvbmU6ICg4NTgpIDc3NSAyNTE0DQo+
DQo+IFRoaXMgZS1tYWlsIG1lc3NhZ2UgaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIGluZGl2aWR1
YWwocykgdG8gd2hvbSBpdA0KPiBpcyBhZGRyZXNzZWQgYW5kDQo+IG1heSBjb250YWluIGluZm9y
bWF0aW9uIHRoYXQgaXMgcHJpdmlsZWdlZCwgY29uZmlkZW50aWFsLCBwcm9wcmlldGFyeSwNCj4g
b3Igb3RoZXJ3aXNlIGV4ZW1wdA0KPiBmcm9tIGRpc2Nsb3N1cmUgdW5kZXIgYXBwbGljYWJsZSBs
YXcuIElmIHlvdSBiZWxpZXZlIHlvdSBoYXZlIHJlY2VpdmVkDQo+IHRoaXMgbWVzc2FnZSBpbg0K
PiBlcnJvciwgcGxlYXNlIGFkdmlzZSB0aGUgc2VuZGVyIGJ5IHJldHVybiBlLW1haWwgYW5kIGRl
bGV0ZSBpdCBmcm9tDQo+IHlvdXIgbWFpbGJveC4NCj4gVGhhbmsgeW91Lg0KPg0KPiAtLSANCj4g
WW91IHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBiZWNhdXNlIHlvdSBhcmUgc3Vic2NyaWJlZCB0byB0
aGUgR29vZ2xlIEdyb3VwcyAibGludXgtbnRiIiBncm91cC4NCj4gVG8gdW5zdWJzY3JpYmUgZnJv
bSB0aGlzIGdyb3VwIGFuZCBzdG9wIHJlY2VpdmluZyBlbWFpbHMgZnJvbSBpdCwgc2VuZCBhbiBl
bWFpbCB0byBsaW51eC1udGIrdW5zdWJzY3JpYmVAZ29vZ2xlZ3JvdXBzLmNvbSA8bWFpbHRvOmxp
bnV4LW50YiUyQnVuc3Vic2NyaWJlQGdvb2dsZWdyb3Vwcy5jb20+Lg0KPiBUbyBwb3N0IHRvIHRo
aXMgZ3JvdXAsIHNlbmQgZW1haWwgdG8gbGludXgtbnRiQGdvb2dsZWdyb3Vwcy5jb20gPG1haWx0
bzpsaW51eC1udGJAZ29vZ2xlZ3JvdXBzLmNvbT4uDQo+IFRvIHZpZXcgdGhpcyBkaXNjdXNzaW9u
IG9uIHRoZSB3ZWIgdmlzaXQgaHR0cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS9kL21zZ2lkL2xpbnV4
LW50Yi9DQU9RUG44c1gyRy1EYi1aaUZwUDJTTUtia1FuUHlrNjNVWmlqQVkwd2UlMkJEb1pzbUR0
USU0MG1haWwuZ21haWwuY29tLg0KPiBGb3IgbW9yZSBvcHRpb25zLCB2aXNpdCBodHRwczovL2dy
b3Vwcy5nb29nbGUuY29tL2Qvb3B0b3V0Lg0K
