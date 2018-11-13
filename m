Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542D9C43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 14:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD20214F1
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 14:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4HjXtxaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD20214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbeKNAkD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:40:03 -0500
Received: from mail-eopbgr770084.outbound.protection.outlook.com ([40.107.77.84]:29472
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726846AbeKNAkD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Nov 2018 19:40:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsgRUzM2rHCv6G6kwOM1i2Rwxgpot+gNzjnIhh58BE0=;
 b=4HjXtxaYeEfdp+HjxhgL3s20NMBk335N6VIkxijIVEEBUBOAngNwL4S4Da6YlkwpvPkif2ydE0yvKpmw8xB+ccIQ41FJsNTvtJnNgTbHLp1hCcqG6vJUMVZFw8KXRHZMEzrxIb8Z0fV6o+BhcHXTeWgDRcKSZTzTANrvJvRWhjk=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB2365.namprd12.prod.outlook.com (52.132.194.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 13 Nov 2018 14:41:33 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::54ff:b1c7:a4b9:28f1]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::54ff:b1c7:a4b9:28f1%3]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 14:41:33 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [GIT PULL] PCI changes for v4.20
Thread-Topic: [GIT PULL] PCI changes for v4.20
Thread-Index: AQHUavdlFGMh646FBEGB1msSKmfQHqVNa9wAgAAzFwCAAEkNgA==
Date:   Tue, 13 Nov 2018 14:41:33 +0000
Message-ID: <c963b647-6428-c89b-37ab-9b9587e56de0@amd.com>
References: <20181023173934.GA14918@bhelgaas-glaptop.roam.corp.google.com>
 <20181113071712.GA2353@gmail.com> <20181113102004.GC10502@zn.tnic>
In-Reply-To: <20181113102004.GC10502@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0046.namprd04.prod.outlook.com
 (2603:10b6:803:2a::32) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB2365;20:KXAZvjEuNpfmhyaJ5foVmCTQWObBgVvBfRzGv6h4XzalRLQd87dQLr/9bZCxk/NqGwhrumHH1lhe11mjGmg0ja91aP2w5WwYJkWu7cP49Q+IN1I2Jv/wLMcc0uRnK9q0dD52B7mj/WiMtw5ZQ7HrM9AlDJU+DF9OHQncAaXmEG3838yYqWZRUmi1qsDxeF4k+PkUqz7OTv14A2DB4R2D458zK5FT72tz08Z/O1Xm2B9hGQYFxVpOBExroCftRSpp
x-ms-office365-filtering-correlation-id: 74d60b39-436d-47e9-2482-08d649761b0a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2365;
x-ms-traffictypediagnostic: SN1PR12MB2365:
x-microsoft-antispam-prvs: <SN1PR12MB2365FEAEFCFA4C384E8EA4E3ECC20@SN1PR12MB2365.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231406)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB2365;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2365;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(305945005)(6436002)(186003)(31686004)(7736002)(2900100001)(105586002)(25786009)(4326008)(7416002)(106356001)(97736004)(71200400001)(102836004)(386003)(86362001)(26005)(6486002)(476003)(31696002)(6512007)(6506007)(316002)(256004)(2616005)(68736007)(53546011)(66066001)(11346002)(446003)(110136005)(54906003)(229853002)(478600001)(36756003)(72206003)(5660300001)(53936002)(8936002)(6246003)(2906002)(81156014)(14454004)(81166006)(3846002)(76176011)(99286004)(6116002)(8676002)(71190400001)(52116002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2365;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Jpi8UGCgJWyZJ1QarEQ4jPryqbPB2pYkweLVLyuUjeyTKZwXPKoWX4E44KLLPASugbx6FT/Wuc7qvkb0nTZKgziy8gkJsTs//+0TCegBOIACGeEbTg86g0NsXh31GoL6SfWeT0oWcBFAfDbJ/94euzdSln6qM6luCoaOKutNgKz/u0KbpdIzT416ygswE/1YiOWB7eHOAfon3b13RrO2YOFm7GUpISpshlviJSqN7DH39ZFUW60cezaQfrvIaxiQT3tuzhAmbIHUgnK5LoZkztf1hTvKXv/4gUPFBkpg5n7qqMrVYxFKgvOXEOyy5BQYBPZ+DdY5aFrbPCrU0U+3aJIXFqxsw21UsIDktr5icrg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B647EB8B6A08E4780D40B5452BDB371@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d60b39-436d-47e9-2482-08d649761b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 14:41:33.3135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2365
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMTEvMTMvMjAxOCAwNDoyMCBBTSwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiBPbiBUdWUs
IE5vdiAxMywgMjAxOCBhdCAwODoxNzoxMkFNICswMTAwLCBJbmdvIE1vbG5hciB3cm90ZToNCj4+
DQo+PiAqIEJqb3JuIEhlbGdhYXMgPGhlbGdhYXNAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pg0KPj4+
IFBDSSBjaGFuZ2VzOg0KPj4+DQo+Pj4gICAtIFBheSBhdHRlbnRpb24gdG8gZGV2aWNlLXNwZWNp
ZmljIF9QWE0gbm9kZSB2YWx1ZXMgKEpvbmF0aGFuIENhbWVyb24pDQo+Pg0KPj4gVGhlcmUncyBh
IG5ldyBib290IHJlZ3Jlc3Npb24sIG15IEFNRCBUaHJlYWRSaXBwZXIgc3lzdGVtIChNU0kgWDM5
OSBTTEkgDQo+PiBQTFVTIChNUy03QjA5KSkgaGFuZ3MgZHVyaW5nIGVhcmx5IGJvb3R1cCwgYW5k
IEkgaGF2ZSBiaXNlY3RlZCBpdCBkb3duIHRvIA0KPj4gdGhpcyBjb21taXQ6DQo+Pg0KPj4gICBi
YWQ3ZGNkOTRmMzk6IEFDUEkvUENJOiBQYXkgYXR0ZW50aW9uIHRvIGRldmljZS1zcGVjaWZpYyBf
UFhNIG5vZGUgdmFsdWVzDQo+Pg0KPj4gUmV2ZXJ0aW5nIGl0IHNvbHZlcyB0aGUgaGFuZy4NCj4+
DQo+PiBVbmZvcnR1bmF0ZWx5IHRoZXJlJ3Mgbm8gY29uc29sZSBvdXRwdXQgd2hlbiBpdCBoYW5n
cywgZXZlbiB3aXRoIA0KPj4gZWFybHlwcmludGsuIEl0IGp1c3QgaGFuZ3MgYWZ0ZXIgdGhlICJs
b2FkaW5nIGluaXRyZCIgbGluZS4NCj4+DQo+PiBDb25maWcgaXMgYW4gVWJ1bnR1LWlzaCBjb25m
aWcgd2l0aCBQUk9WRV9MT0NLSU5HPXkgYW5kIGEgZmV3IG90aGVyIGRlYnVnIA0KPj4gb3B0aW9u
cy4NCj4+DQo+PiBBbGwgbXkgb3RoZXIgdGVzdHN5c3RlbXMgYm9vdCBmaW5lIHdpdGggc2ltaWxh
ciBjb25maWdzLCBzbyBpdCdzIHByb2JhYmx5IA0KPj4gc29tZXRoaW5nIHNwZWNpZmljIHRvIHRo
aXMgc3lzdGVtLg0KPiANCj4gTGVtbWUgYWRkIFRvbSwgaGUgbWlnaHQgaGF2ZSBhbiBpZGVhLg0K
DQpJJ20gbm90IHNlZWluZyBhbnkgaXNzdWVzIG9uIG15IEVQWUMgc3lzdGVtLiAgTGV0IG1lIHNl
ZSBpZiBJIGNhbiBsb2NhdGUgYQ0KVGhyZWFkcmlwcGVyIHN5c3RlbSB0byB0ZXN0IG9uLg0KDQpJ
dCBzZWVtcyB2ZXJ5IHN0cmFuZ2UgdGhhdCB0aGUgY29tbWl0IGluIHF1ZXN0aW9uIHdvdWxkIGNh
dXNlIGEgaGFuZyBzbw0KZWFybHkuIERvIHlvdSBoYXZlIGEgc2VyaWFsIGNvbnNvbGUgaG9va2Vk
IHVwIGZvciB0aGUgZWFybHlwcmludGs/IElzIHRoZQ0Kc2VyaWFsIHBvcnQgc2V0IHVwIGluIGxl
Z2FjeSBtb2RlIChlLmcuIDB4M2Y4IGFzIG9wcG9zZWQgdG8gYmVpbmcgYW4gTU1JTw0KZGV2aWNl
IHRoYXQgd291bGQgcmVxdWlyZSBhIGRyaXZlcik/DQoNCkNhbiB5b3UgZHVtcCB0aGUgQUNQSSB0
YWJsZXMgLyBydW4gdGhlbSB0aHJvdWdoIGlhc2wgdG8gc2VlIHdoYXQgdGhlIF9QWE0NCnZhbHVl
cyBhcmUgaW4gdGhlIERTRFQgdGFibGU/DQoNClRoYW5rcywNClRvbQ0KDQo+IA0K
