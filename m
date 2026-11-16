Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794798322;
	b=wqmdQiNOFHKJk57xbD1vVSiIHDEGnfOjtmw3grl6hJoXdeQ/nZLl3lg2kstUGzUStULK
	 4VL1KTAyBnZZyBWUqoeBwA/ffGR3tOXr992eplbPAbGz/jI7NNSQzY0YuE0yxJ5hRIsNB
	 unZ1bYzn7l/5f2qRwShoEy3i4ySV0kp40enn+viQUEKG1le4aD8sqaq7+CfHgJudSYkQ1
	 JL0UAswiSPEy16doyrguiBpvbe9cyk/w8JQb1pJwRSDWg2Wm24ecfOWFMC2H6ZaD/nmOo
	 cqjzbnrJGlTZnbD+lklqwnILn+JDm5n1ReveeQlCXbbnndcXIFNmIkWzldZ51dP5tEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798322;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 DKIM-Signature;
	bh=3h/hJhe2m7bMzYPZBQs2LlpH/xz1SgYRRDuDOQgzgJU=;
	b=dZVYd4YK19xuWupZipt2KTK/cFFO8DTCWvCITn9a9pjYK6nGrbsEoOvvoLJobVianW85
	 Y7BQD/GxvOX4waWVVobiawyj2JHM+i271Fr00XQECrjegMrB1wXgwDM7iUQQXBbvZIZxL
	 UpOHgixzOLWQP5d5V0mLMbPNxc7UVzbOMY4Q1b5VfgXXgZaWOOLNyk+bfpl1fXQl/mKFb
	 Fv6bzb+CkbCDjxtyURhpA+p4XVtdHwP5NVQDwSXdmysGVHkHsshaMl4lKYftjHdFhTFRv
	 hEiG2QMqBdKp1KiG0tteztX1Em5ReVz8k7SEBMKe7T0jOcz8sVEYO8sqWNMDMY4tlXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=BOHm6Nro;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 37D39606A337;
	Mon, 16 Nov 2026 03:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37D39606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=BOHm6Nro
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.3.14
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIIHYyXSBQQ0kvQUNQ?=
 =?utf-8?B?STogQ2hlY2sgdGhlIGZvdW5kIGhhbmRsZSBpbiBhY3BpX2dldF9yY19yZXNv?=
 =?utf-8?Q?urces()?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSCB2Ml0gUENJL0FDUEk6IENoZWNr?=
 =?utf-8?B?IHRoZSBmb3VuZCBoYW5kbGUgaW4gYWNwaV9nZXRfcmNfcmVzb3VyY2VzKCk=?=
Thread-Index: AQHddOFxtRU/PxmmZk61qzZICDwANLcu14WAgAEtJ2A=
Date: Mon, 16 Nov 2026 03:05:07 +0000
Message-ID: <0b5ce94eb1bf496781dd89c12295d229@baidu.com>
References: <20261115091221.2217-1-lirongqing@baidu.com>
 <CAJZ5v0hBVwOksptV2ThK9iCpHbSZDh0Z+R3dtojCtkze4_0eQg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hBVwOksptV2ThK9iCpHbSZDh0Z+R3dtojCtkze4_0eQg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1794798310;
	bh=3h/hJhe2m7bMzYPZBQs2LlpH/xz1SgYRRDuDOQgzgJU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=BOHm6NroPpLdqm5zBykgI6UseH1BCSOxS9Ah024JoVRHZy4uQkJsrXIzhx8cImx4S
	 Kg7BHWNpYyIuTtDwVdL4gZjGs3lgt5zTYCrdUMNR/4gWaAciqwE74PH5QWTDfXlG/Q
	 dc2Rb5+EXZhmUf8Z7fHX3WfPtuU1jYtZp3VrCKoNVv+HUYT6p3VypEF9ITb5zLKQYR
	 1S67aRGmj+AvnB0SI4ZiY4uSomd2eD6WEJDDEFUGC3J/owl3LJI5wdx8Vlm76eWVbW
	 MNwo9Vs/pFyMC0SCBxZMr/SMQVNhm+PNBElgttXLSr9Efmvnm2PibaoAWEzBYJAbiB
	 rRGiLIQCLmI/w==

PiA+IEZyb206IExpIFJvbmdRaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4NCj4gPg0KPiA+IGFj
cGlfZ2V0X2RldmljZXMoKSByZXR1cm5zIEFFX09LIGV2ZW4gd2hlbiB0aGUgbmFtZXNwYWNlIHdh
bGsgZmluaXNoZXMNCj4gPiB3aXRob3V0IGEgbWF0Y2gsIGluIHdoaWNoIGNhc2UgdGhlIHJldHVy
bl92YWx1ZSBhcmd1bWVudCBpcyBub3Qgd3JpdHRlbi4NCj4gPiBUaGUgY2FsbGVyIHBhc3NlcyBh
biB1bmluaXRpYWxpemVkIGFjcGlfaGFuZGxlIGFuZCBoYW5kcyBpdCB0bw0KPiA+IGFjcGlfZmV0
Y2hfYWNwaV9kZXYoKSwgd2hpY2ggZGVyZWZlcmVuY2VzIGl0IGFzIGFuIEFDUEkgbm9kZS4NCj4g
Pg0KPiA+IEluaXRpYWxpemUgdGhlIGhhbmRsZSBhbmQgcmVqZWN0IGEgbWlzc2luZyBtYXRjaC4N
Cj4gPg0KPiA+IEZpeGVzOiAxNjlkZTk2OWMwMTggKCJQQ0kvQUNQSTogUHJvdmlkZSBhY3BpX2dl
dF9yY19yZXNvdXJjZXMoKSBmb3INCj4gPiBBUk02NCBwbGF0Zm9ybSIpDQo+ID4gU2lnbmVkLW9m
Zi1ieTogTGkgUm9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiA+IC0tLQ0KPiA+IERp
ZmYgd2l0aCB2MTogYWRkIGZpeGVzIHRhZw0KPiA+DQo+ID4gIGRyaXZlcnMvcGNpL3BjaS1hY3Bp
LmMgfCA1ICsrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2ktYWNwaS5jIGIv
ZHJpdmVycy9wY2kvcGNpLWFjcGkuYyBpbmRleA0KPiA+IGUyNjAwODkuLmU5MGU3NDkgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvcGNpLWFjcGkuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNp
L3BjaS1hY3BpLmMNCj4gPiBAQCAtODIsNyArODIsNyBAQCBpbnQgYWNwaV9nZXRfcmNfcmVzb3Vy
Y2VzKHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3QNCj4gPiBjaGFyICpoaWQsIHUxNiBzZWdtZW50
LCAgew0KPiA+ICAgICAgICAgc3RydWN0IGFjcGlfZGV2aWNlICphZGV2Ow0KPiA+ICAgICAgICAg
YWNwaV9zdGF0dXMgc3RhdHVzOw0KPiA+IC0gICAgICAgYWNwaV9oYW5kbGUgaGFuZGxlOw0KPiA+
ICsgICAgICAgYWNwaV9oYW5kbGUgaGFuZGxlID0gTlVMTDsNCj4gPiAgICAgICAgIGludCByZXQ7
DQo+ID4NCj4gPiAgICAgICAgIHN0YXR1cyA9IGFjcGlfZ2V0X2RldmljZXMoaGlkLCBhY3BpX21h
dGNoX3JjLCAmc2VnbWVudCwNCj4gPiAmaGFuZGxlKTsgQEAgLTkyLDYgKzkyLDkgQEAgaW50IGFj
cGlfZ2V0X3JjX3Jlc291cmNlcyhzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYsIGNvbnN0IGNoYXIgKmhp
ZCwgdTE2IHNlZ21lbnQsDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOw0KPiA+
ICAgICAgICAgfQ0KPiA+DQo+ID4gKyAgICAgICBpZiAoIWhhbmRsZSkNCj4gPiArICAgICAgICAg
ICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+IA0KPiBhY3BpX2ZldGNoX2FjcGlfZGV2KCkgd2lsbCBy
ZXR1cm4gTlVMTCBpZiBoYW5kbGUgaXMgTlVMTCwgd29uJ3QgaXQ/DQo+IA0KDQpBZ3JlZWQgdGhh
dCBhY3BpX2ZldGNoX2FjcGlfZGV2KE5VTEwpIGlzIHNhZmUgdG9kYXkg4oCUIGFjcGlfZ2V0X2Rh
dGFfZnVsbCgpIHJlamVjdHMgTlVMTCB1cCBmcm9udC4gQnV0IHRoYXQgc2FmZXR5IGlzIGluY2lk
ZW50YWwsIG5vdCBjb250cmFjdHVhbDogdGhlIGhhbmRsZSBsYXllciBkb2Vzbid0IHVuaWZvcm1s
eSByZWplY3QgTlVMTCAoYWNwaV9uc192YWxpZGF0ZV9oYW5kbGUoKSBldmVuIG1hcHMgaXQgdG8g
dGhlIHJvb3Qgbm9kZSksIHNvIHJlbHlpbmcgb24gaXQgbWFrZXMgdGhlIGZpeCBmcmFnaWxlIHRv
IGZ1dHVyZSBjaGFuZ2VzLiBUaGUgZXhwbGljaXQgY2hlY2sgc3RhdGVzIHRoZSAibm8gbWF0Y2gg
4oeSIC1FTk9ERVYiIGludGVudCBkaXJlY3RseSBhbmQgY29zdHMgMyBsaW5lcy4gSWYgeW91IHBy
ZWZlciB0aGUgbWluaW1hbCBkaWZmLCBJIGNhbiBkcm9wIGl0IOKAlCB0aGUgaW5pdGlhbGl6YXRp
b24gYWxvbmUgaXMgYWxzbyBjb3JyZWN0LiANCg0KVGhhbmtzDQoNCg0KW0xpLFJvbmdxaW5nXSAN
Cg0KDQo+ID4gKw0KPiA+ICAgICAgICAgYWRldiA9IGFjcGlfZmV0Y2hfYWNwaV9kZXYoaGFuZGxl
KTsNCj4gPiAgICAgICAgIGlmICghYWRldikNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1F
Tk9ERVY7DQo+ID4gLS0NCg==
