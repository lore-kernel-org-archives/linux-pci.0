Return-Path: <SRS0=bOp+=MB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02863C433F4
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 17:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E04821523
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 17:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4MubbLJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E04821523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732469AbeISW7B (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:59:01 -0400
Received: from mail-cys01nam02on0067.outbound.protection.outlook.com ([104.47.37.67]:17611
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728339AbeISW7B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 18:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YN+SMVr1kTXszH0v3Sd7XoZGTNp8/9D3gWOumWGa1/M=;
 b=4MubbLJVzU11cW91wCOS/OewrenbGocr0YKWI6EBNA7r4nhM4Ib5X1zVOdKLvDb+KH9iZrKZn4RUBKdhN4L7OFNNtw9eqhPD/MypBQRDYMSFm2FDRt+TQ/MGqX+1lfrxvHK1FE5OmG0pSbkxnfuiuSjmWU9aEPVefJXspE2lvLA=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0272.namprd12.prod.outlook.com (10.162.4.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 19 Sep 2018 17:20:03 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7%5]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 17:20:03 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Pu Wen <puwen@hygon.cn>, "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v6 07/16] x86/pci: Add Hygon Dhyana support to PCI and
 north bridge
Thread-Topic: [PATCH v6 07/16] x86/pci: Add Hygon Dhyana support to PCI and
 north bridge
Thread-Index: AQHUSQidyG/0fjpFbE+DxXHE+HAIzaT35+iA
Date:   Wed, 19 Sep 2018 17:20:03 +0000
Message-ID: <d05c7aa5-05ba-5ac2-c70f-414d9539925f@amd.com>
References: <cover.1536550549.git.puwen@hygon.cn>
 <035e5d0a4f2a0edf68ca0f1019e47b878eaa5da6.1536550550.git.puwen@hygon.cn>
In-Reply-To: <035e5d0a4f2a0edf68ca0f1019e47b878eaa5da6.1536550550.git.puwen@hygon.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR07CA0084.namprd07.prod.outlook.com (2603:10b6:100::52)
 To SN1PR12MB0175.namprd12.prod.outlook.com (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0272;20:d1nXApsqWI61bkFWE3ENNwaXU3U5OXbYDAdMQIZ1vtefgjiAAqtqjytNyov9zOJhDIrTiV1JcOHAw73YiyP46qDMdkBjsgdk0QB6kjWnUXfiJbvjQcUQi5zpeiYbtQajzNkxmerj+KqIijmbdXnVaFOrdYFfwQMrMzkAIaQAwhEu/7KBz+izCMKPCtXvSKD9Yzyt0w9tQ66yk/zr2s533kqO12tpw1l+svD1JQYdL5rHtte2rDxUaNdRqIeeoVWP
x-ms-office365-filtering-correlation-id: 2351fc7a-8200-4e00-a85e-08d61e542277
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0272;
x-ms-traffictypediagnostic: SN1PR12MB0272:
x-microsoft-antispam-prvs: <SN1PR12MB027252DF54CB97EB87F5094EEC1C0@SN1PR12MB0272.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231355)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:SN1PR12MB0272;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0272;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(366004)(39860400002)(396003)(199004)(189003)(54906003)(256004)(76176011)(7416002)(3846002)(7736002)(72206003)(478600001)(5250100002)(2900100001)(14454004)(2501003)(305945005)(6116002)(106356001)(2906002)(31686004)(31696002)(66066001)(86362001)(2201001)(102836004)(6436002)(105586002)(53936002)(476003)(6506007)(386003)(11346002)(6486002)(316002)(53546011)(6512007)(2616005)(26005)(446003)(486006)(186003)(6246003)(5660300001)(8936002)(4326008)(25786009)(229853002)(99286004)(68736007)(81156014)(8676002)(52116002)(110136005)(81166006)(97736004)(36756003)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0272;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eSaDUKEK1WqAbCKyw1T2NrhdltSf0mxqhzWo1T3EtVA6hz9lZvVYBekiQtoZgMIe+Og7eGyIhAzBIzDswMrA/D0Czopx9j/HJduYvPDsRU71DtL6GrPHUi5DPOSkSpmumbTzsKT3mJWEg5iSeBk24bm6uV5hHaPoiAwBa9imtg6iTOxMBBnZBxyGOhmrBP6WzFJxUCKDNJUhVCJrt5MXDKQCTo7aCo0i6Lo6yCJloqUELBPbocHT7nOvdM6ONofxAG0rxv5wNPa5sougpe8OSJChEjiUJJ9Gh7AQOS+WQsJmTNWUYhuY+8CmmNCKMSy2m9pq6UekUC48UNcWrlLpsL4fzQCBArgWODPgDm6d4f8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CE385872A948D4BB1CE146164767739@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2351fc7a-8200-4e00-a85e-08d61e542277
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 17:20:03.0732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0272
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180919172003.j9CbCO9GvOOVtrpaOYY0tczU9YAaxcbsNe8qZB5HGQM@z>

T24gMDkvMTAvMjAxOCAwODoxNyBBTSwgUHUgV2VuIHdyb3RlOg0KPiBBcyBIeWdvbiByZWdpc3Rl
cmVkIGl0cyBQQ0kgVmVuZG9yIElEIGFzIGEgbmV3IG9uZSAweDFkOTQsIGFuZCB0aGVyZQ0KPiBh
cmUgUENJIERldmljZXMgMHgxNDUwLzB4MTQ2My8weDE0NjQgZm9yIEhvc3QgYnJpZGdlIG9uIEh5
Z29uIERoeWFuYQ0KPiBwbGF0Zm9ybXMsIHNvIGFkZCBIeWdvbiBEaHlhbmEgc3VwcG9ydCB0byB0
aGUgUENJIGFuZCBub3J0aCBicmlkZ2UNCj4gc3Vic3lzdGVtIGJ5IHVzaW5nIHRoZSBjb2RlIHBh
dGggb2YgQU1EIGZhbWlseSAxN2guDQo+IA0KPiBBY2tlZC1ieTogQmpvcm4gSGVsZ2FhcyA8Ymhl
bGdhYXNAZ29vZ2xlLmNvbT4JIyBwY2lfaWRzLmgNCj4gU2lnbmVkLW9mZi1ieTogUHUgV2VuIDxw
dXdlbkBoeWdvbi5jbj4NCj4gLS0tDQo+ICBhcmNoL3g4Ni9rZXJuZWwvYW1kX25iLmMgfCA0NyAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiAgYXJjaC94
ODYvcGNpL2FtZF9idXMuYyAgIHwgIDYgKysrKy0tDQo+ICBpbmNsdWRlL2xpbnV4L3BjaV9pZHMu
aCAgfCAgMiArKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCA4IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9hbWRfbmIuYyBiL2Fy
Y2gveDg2L2tlcm5lbC9hbWRfbmIuYw0KPiBpbmRleCBiNDgxYjk1Li4zZTJlYTE4IDEwMDY0NA0K
PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvYW1kX25iLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVs
L2FtZF9uYi5jDQo+IEBAIC02MSw2ICs2MSwyMSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9k
ZXZpY2VfaWQgYW1kX25iX2xpbmtfaWRzW10gPSB7DQo+ICAJe30NCj4gIH07DQo+ICANCj4gK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBoeWdvbl9yb290X2lkc1tdID0gew0KPiAr
CXsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0hZR09OLCBQQ0lfREVWSUNFX0lEX0FNRF8xN0hf
Uk9PVCkgfSwNCj4gKwl7fQ0KPiArfTsNCj4gKw0KPiArY29uc3Qgc3RydWN0IHBjaV9kZXZpY2Vf
aWQgaHlnb25fbmJfbWlzY19pZHNbXSA9IHsNCj4gKwl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9J
RF9IWUdPTiwgUENJX0RFVklDRV9JRF9BTURfMTdIX0RGX0YzKSB9LA0KPiArCXt9DQo+ICt9Ow0K
PiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgaHlnb25fbmJfbGlua19p
ZHNbXSA9IHsNCj4gKwl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9IWUdPTiwgUENJX0RFVklD
RV9JRF9BTURfMTdIX0RGX0Y0KSB9LA0KPiArCXt9DQo+ICt9Ow0KPiArDQo+ICBjb25zdCBzdHJ1
Y3QgYW1kX25iX2J1c19kZXZfcmFuZ2UgYW1kX25iX2J1c19kZXZfcmFuZ2VzW10gX19pbml0Y29u
c3QgPSB7DQo+ICAJeyAweDAwLCAweDE4LCAweDIwIH0sDQo+ICAJeyAweGZmLCAweDAwLCAweDIw
IH0sDQo+IEBAIC0xOTcsMTIgKzIxMiwyNSBAQCBpbnQgYW1kX2NhY2hlX25vcnRoYnJpZGdlcyh2
b2lkKQ0KPiAgCXUxNiBpID0gMDsNCj4gIAlzdHJ1Y3QgYW1kX25vcnRoYnJpZGdlICpuYjsNCj4g
IAlzdHJ1Y3QgcGNpX2RldiAqcm9vdCwgKm1pc2MsICpsaW5rOw0KPiArCWNvbnN0IHN0cnVjdCBw
Y2lfZGV2aWNlX2lkICpyb290X2lkcyA9IE5VTEw7DQo+ICsJY29uc3Qgc3RydWN0IHBjaV9kZXZp
Y2VfaWQgKm1pc2NfaWRzID0gTlVMTDsNCj4gKwljb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAq
bGlua19pZHMgPSBOVUxMOw0KPiArDQo+ICsJaWYgKGJvb3RfY3B1X2RhdGEueDg2X3ZlbmRvciA9
PSBYODZfVkVORE9SX0FNRCkgew0KPiArCQlyb290X2lkcyA9IGFtZF9yb290X2lkczsNCj4gKwkJ
bWlzY19pZHMgPSBhbWRfbmJfbWlzY19pZHM7DQo+ICsJCWxpbmtfaWRzID0gYW1kX25iX2xpbmtf
aWRzOw0KPiArCX0gZWxzZSBpZiAoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yID09IFg4Nl9WRU5E
T1JfSFlHT04pIHsNCj4gKwkJcm9vdF9pZHMgPSBoeWdvbl9yb290X2lkczsNCj4gKwkJbWlzY19p
ZHMgPSBoeWdvbl9uYl9taXNjX2lkczsNCj4gKwkJbGlua19pZHMgPSBoeWdvbl9uYl9saW5rX2lk
czsNCj4gKwl9DQoNClRvIGJlIGNvbXBhdGlibGUgd2l0aCAiYmVmb3JlIHRoaXMgcGF0Y2giIHlv
dSBzaG91bGQgcHJvYmFibHkgZG86DQoNCglpZiAoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yID09
IFg4Nl9WRU5ET1JfSFlHT04pIHsNCgkJcm9vdF9pZHMgPSBoeWdvbl9yb290X2lkczsNCgkJbWlz
Y19pZHMgPSBoeWdvbl9uYl9taXNjX2lkczsNCgkJbGlua19pZHMgPSBoeWdvbl9uYl9saW5rX2lk
czsNCgl9IGVsc2Ugew0KCQlyb290X2lkcyA9IGFtZF9yb290X2lkczsNCgkJbWlzY19pZHMgPSBh
bWRfbmJfbWlzY19pZHM7DQoJCWxpbmtfaWRzID0gYW1kX25iX2xpbmtfaWRzOw0KCX0NCg0KVGhh
dCB3YXkgdGhleSBhcmUgYWx3YXlzIHRoZSBBTUQgdmFsdWVzIGlmIG5vdCB5b3VyIGNoaXAuDQoN
Cj4gIA0KPiAgCWlmIChhbWRfbm9ydGhicmlkZ2VzLm51bSkNCj4gIAkJcmV0dXJuIDA7DQo+ICAN
Cj4gIAltaXNjID0gTlVMTDsNCj4gLQl3aGlsZSAoKG1pc2MgPSBuZXh0X25vcnRoYnJpZGdlKG1p
c2MsIGFtZF9uYl9taXNjX2lkcykpICE9IE5VTEwpDQo+ICsJd2hpbGUgKChtaXNjID0gbmV4dF9u
b3J0aGJyaWRnZShtaXNjLCBtaXNjX2lkcykpICE9IE5VTEwpDQo+ICAJCWkrKzsNCj4gIA0KPiAg
CWlmICghaSkNCj4gQEAgLTIxOCwxMSArMjQ2LDExIEBAIGludCBhbWRfY2FjaGVfbm9ydGhicmlk
Z2VzKHZvaWQpDQo+ICAJbGluayA9IG1pc2MgPSByb290ID0gTlVMTDsNCj4gIAlmb3IgKGkgPSAw
OyBpICE9IGFtZF9ub3J0aGJyaWRnZXMubnVtOyBpKyspIHsNCj4gIAkJbm9kZV90b19hbWRfbmIo
aSktPnJvb3QgPSByb290ID0NCj4gLQkJCW5leHRfbm9ydGhicmlkZ2Uocm9vdCwgYW1kX3Jvb3Rf
aWRzKTsNCj4gKwkJCW5leHRfbm9ydGhicmlkZ2Uocm9vdCwgcm9vdF9pZHMpOw0KPiAgCQlub2Rl
X3RvX2FtZF9uYihpKS0+bWlzYyA9IG1pc2MgPQ0KPiAtCQkJbmV4dF9ub3J0aGJyaWRnZShtaXNj
LCBhbWRfbmJfbWlzY19pZHMpOw0KPiArCQkJbmV4dF9ub3J0aGJyaWRnZShtaXNjLCBtaXNjX2lk
cyk7DQo+ICAJCW5vZGVfdG9fYW1kX25iKGkpLT5saW5rID0gbGluayA9DQo+IC0JCQluZXh0X25v
cnRoYnJpZGdlKGxpbmssIGFtZF9uYl9saW5rX2lkcyk7DQo+ICsJCQluZXh0X25vcnRoYnJpZGdl
KGxpbmssIGxpbmtfaWRzKTsNCj4gIAl9DQo+ICANCj4gIAlpZiAoYW1kX2dhcnRfcHJlc2VudCgp
KQ0KPiBAQCAtMjYzLDkgKzI5MSwxNSBAQCBib29sIF9faW5pdCBlYXJseV9pc19hbWRfbmIodTMy
IGRldmljZSkNCj4gIHsNCj4gIAljb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQ7DQo+ICAJ
dTMyIHZlbmRvciA9IGRldmljZSAmIDB4ZmZmZjsNCj4gKwljb25zdCBzdHJ1Y3QgcGNpX2Rldmlj
ZV9pZCAqbWlzY19pZHMgPSBOVUxMOw0KPiArDQo+ICsJaWYgKGJvb3RfY3B1X2RhdGEueDg2X3Zl
bmRvciA9PSBYODZfVkVORE9SX0FNRCkNCj4gKwkJbWlzY19pZHMgPSBhbWRfbmJfbWlzY19pZHM7
DQo+ICsJZWxzZSBpZiAoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yID09IFg4Nl9WRU5ET1JfSFlH
T04pDQo+ICsJCW1pc2NfaWRzID0gaHlnb25fbmJfbWlzY19pZHM7DQoNClNhbWUgY29tbWVudCBh
cyBhYm92ZS4gIFRoaXMgd2lsbCBwcm9iYWJseSBlbGltaW5hdGUgdGhlIFBBTklDIHRoYXQNCnRo
YXQgd2FzIHJlcG9ydGVkIGJ5IExLUC4NCg0KVGhhbmtzLA0KVG9tDQoNCj4gIA0KPiAgCWRldmlj
ZSA+Pj0gMTY7DQo+IC0JZm9yIChpZCA9IGFtZF9uYl9taXNjX2lkczsgaWQtPnZlbmRvcjsgaWQr
KykNCj4gKwlmb3IgKGlkID0gbWlzY19pZHM7IGlkLT52ZW5kb3I7IGlkKyspDQo+ICAJCWlmICh2
ZW5kb3IgPT0gaWQtPnZlbmRvciAmJiBkZXZpY2UgPT0gaWQtPmRldmljZSkNCj4gIAkJCXJldHVy
biB0cnVlOw0KPiAgCXJldHVybiBmYWxzZTsNCj4gQEAgLTI3Nyw3ICszMTEsOCBAQCBzdHJ1Y3Qg
cmVzb3VyY2UgKmFtZF9nZXRfbW1jb25maWdfcmFuZ2Uoc3RydWN0IHJlc291cmNlICpyZXMpDQo+
ICAJdTY0IGJhc2UsIG1zcjsNCj4gIAl1bnNpZ25lZCBpbnQgc2Vnbl9idXNuX2JpdHM7DQo+ICAN
Cj4gLQlpZiAoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yICE9IFg4Nl9WRU5ET1JfQU1EKQ0KPiAr
CWlmIChib290X2NwdV9kYXRhLng4Nl92ZW5kb3IgIT0gWDg2X1ZFTkRPUl9BTUQgJiYNCj4gKwkg
ICAgYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yICE9IFg4Nl9WRU5ET1JfSFlHT04pDQo+ICAJCXJl
dHVybiBOVUxMOw0KPiAgDQo+ICAJLyogYXNzdW1lIGFsbCBjcHVzIGZyb20gZmFtMTBoIGhhdmUg
bW1jb25maWcgKi8NCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3BjaS9hbWRfYnVzLmMgYi9hcmNo
L3g4Ni9wY2kvYW1kX2J1cy5jDQo+IGluZGV4IDY0OWJkZGUuLmJmYTUwZTYgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gveDg2L3BjaS9hbWRfYnVzLmMNCj4gKysrIGIvYXJjaC94ODYvcGNpL2FtZF9idXMu
Yw0KPiBAQCAtOTMsNyArOTMsOCBAQCBzdGF0aWMgaW50IF9faW5pdCBlYXJseV9yb290X2luZm9f
aW5pdCh2b2lkKQ0KPiAgCQl2ZW5kb3IgPSBpZCAmIDB4ZmZmZjsNCj4gIAkJZGV2aWNlID0gKGlk
Pj4xNikgJiAweGZmZmY7DQo+ICANCj4gLQkJaWYgKHZlbmRvciAhPSBQQ0lfVkVORE9SX0lEX0FN
RCkNCj4gKwkJaWYgKHZlbmRvciAhPSBQQ0lfVkVORE9SX0lEX0FNRCAmJg0KPiArCQkgICAgdmVu
ZG9yICE9IFBDSV9WRU5ET1JfSURfSFlHT04pDQo+ICAJCQljb250aW51ZTsNCj4gIA0KPiAgCQlp
ZiAoaGJfcHJvYmVzW2ldLmRldmljZSA9PSBkZXZpY2UpIHsNCj4gQEAgLTM5MCw3ICszOTEsOCBA
QCBzdGF0aWMgaW50IF9faW5pdCBwY2lfaW9fZWNzX2luaXQodm9pZCkNCj4gIA0KPiAgc3RhdGlj
IGludCBfX2luaXQgYW1kX3Bvc3Rjb3JlX2luaXQodm9pZCkNCj4gIHsNCj4gLQlpZiAoYm9vdF9j
cHVfZGF0YS54ODZfdmVuZG9yICE9IFg4Nl9WRU5ET1JfQU1EKQ0KPiArCWlmIChib290X2NwdV9k
YXRhLng4Nl92ZW5kb3IgIT0gWDg2X1ZFTkRPUl9BTUQgJiYNCj4gKwkgICAgYm9vdF9jcHVfZGF0
YS54ODZfdmVuZG9yICE9IFg4Nl9WRU5ET1JfSFlHT04pDQo+ICAJCXJldHVybiAwOw0KPiAgDQo+
ICAJZWFybHlfcm9vdF9pbmZvX2luaXQoKTsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
cGNpX2lkcy5oIGIvaW5jbHVkZS9saW51eC9wY2lfaWRzLmgNCj4gaW5kZXggZDE1Nzk4My4uOGEw
ODQxYyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9wY2lfaWRzLmgNCj4gKysrIGIvaW5j
bHVkZS9saW51eC9wY2lfaWRzLmgNCj4gQEAgLTI1NjEsNiArMjU2MSw4IEBADQo+ICANCj4gICNk
ZWZpbmUgUENJX1ZFTkRPUl9JRF9BTUFaT04JCTB4MWQwZg0KPiAgDQo+ICsjZGVmaW5lIFBDSV9W
RU5ET1JfSURfSFlHT04JCTB4MWQ5NA0KPiArDQo+ICAjZGVmaW5lIFBDSV9WRU5ET1JfSURfVEVL
UkFNCQkweDFkZTENCj4gICNkZWZpbmUgUENJX0RFVklDRV9JRF9URUtSQU1fREMyOTAJMHhkYzI5
DQo+ICANCj4gDQo=
