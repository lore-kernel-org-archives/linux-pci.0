Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794298303;
	b=IZPHYLOxt6PJ0Ozr6XLrTIsGvdkxhaPQ9Wkko0bvSfgMEWwrHBEm0phCKvrQqH9EF7+3
	 VqVSv0+pbpXOt511RAu2jCiLpP9doszX67pfwcE9pFuoHTDTR7Oycvhy5Fm81DNtLzoFL
	 mJFzRxjimXYOQvgdFVjg+A4CB+Qidg4oR5j9wBNVQHURwPPfzyx2pEwhaxp6muMFl494l
	 X+fO91Cm4IO6InkguPg/xueHB/sA05YIv1KDh/4/3+R0ipt2cIdvczDAW4WeVp/QQWMhr
	 u426M5SB5IIqj8DUyGL4+lCmu48VX54ogp4A60uuMZUeVRP/TJ2JQRpYfc4dR4yY3mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794298303;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 DKIM-Signature;
	bh=KI4pxAuikkCspTSZ/dEtczfsWFab+Z5NAl9UMoH1mZI=;
	b=4IFs+KrXm6vj3hulNDXxwr36gaC+WgxUxKnKGyBUtP7YgGYzpJneePaTjoEg7i7ddxIb
	 ICZQTe7wzSdIZ8MnGml+8QXX8hyax828mAxNiHcXnBDJDje5uLgAGm1kjkVeof7pCsc1Y
	 LNMqTFKalnDzGD12opeMypNYzZgsFuvbahg5yI1QyR66L7/ysIr1cCcM0M79Wqrys6YWK
	 gvdQuZ5tUHe58DOG55mTzfg+RPiDbcsWNhjeuFLagt7aPZBN1zGxaRGkWOcxLNJasRPyn
	 KHaySSuB/mRfRf1xcNHHNnhm2dfw+vFf8l61y6j5aGSTh0PevTueTayDMmatdteS6/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=JWLBkZwy;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6F987606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 08:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F987606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=JWLBkZwy
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.3.13
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXSBQQ0kvQUNQSTog?=
 =?utf-8?B?Q2hlY2sgdGhlIGZvdW5kIGhhbmRsZSBpbiBhY3BpX2dldF9yY19yZXNvdXJj?=
 =?utf-8?Q?es()?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0gUENJL0FDUEk6IENoZWNrIHRo?=
 =?utf-8?B?ZSBmb3VuZCBoYW5kbGUgaW4gYWNwaV9nZXRfcmNfcmVzb3VyY2VzKCk=?=
Thread-Index: AQHdcNUobQv5k3NCC0iG91KwaRoRgLcmRF6AgACwElA=
Date: Tue, 10 Nov 2026 08:11:35 +0000
Message-ID: <a0ce357a4abe4a64aca5cdc982e434f1@baidu.com>
References: <20261110053423.2517-1-lirongqing@baidu.com>
 <sashiko-outbox-206326@kernel.org>
In-Reply-To: <sashiko-outbox-206326@kernel.org>
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
	s=selector1; t=1794298297;
	bh=KI4pxAuikkCspTSZ/dEtczfsWFab+Z5NAl9UMoH1mZI=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=JWLBkZwy+3oySOw6Ji0U1X7m/ctcnEoAFFqF7Q70weV0cd3yA6CHb4wb9+8ybBqJl
	 GqNdhco0J6QbvqGdHRd3Bxpfa19wRgtoW439vKHxDzETmaH4eg2QRtCQvxmX2cTp5+
	 B+wZ7jk6Vdo9p7VmuCStEr1ikNLyfPkiTdXnUL95yzi+zOywibzWntwVWlwpHW4o3E
	 VE9aZuauNY2XOv5MxqyHaRvqMlM1VlKIsfjYOhDmX9tdK46r1IxN9MCjZeOOmyiyMJ
	 17WDl4hMgV7PWqO0EZW4G3OtyJVS+eZF8ccRqju4/vbORdkmUBy+VX2Oy5EFQ0UoYB
	 I86x0ov5qnoVg==

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IHNhc2hpa28tYm90QGtl
cm5lbC5vcmcgPHNhc2hpa28tYm90QGtlcm5lbC5vcmc+DQo+IOWPkemAgeaXtumXtDogMjAyNuW5
tDEx5pyIMTDml6UgMTM6NDENCj4g5pS25Lu25Lq6OiBMaSxSb25ncWluZyA8bGlyb25ncWluZ0Bi
YWlkdS5jb20+OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnDQo+IOS4u+mimDogW+WklumDqOmC
ruS7tl0gUmU6IFtQQVRDSF0gUENJL0FDUEk6IENoZWNrIHRoZSBmb3VuZCBoYW5kbGUgaW4NCj4g
YWNwaV9nZXRfcmNfcmVzb3VyY2VzKCkNCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBjb250cmli
dXRpb24hIFNhc2hpa28gQUkgcmV2aWV3IGZvdW5kIDEgcG90ZW50aWFsIGlzc3VlIHRvDQo+IGNv
bnNpZGVyOg0KPiAtIFtMb3ddIFBDSS9BQ1BJOiBtaXNzaW5nIEZpeGVzIHRyYWlsZXIgZm9yIGFj
cGlfZ2V0X3JjX3Jlc291cmNlcygpIGZpeA0KPiAtLQ0KPiANCj4gY29tbWl0IDJkZDI2M2M4NzQx
ZGMyZjI0YTU5ZGM0OGQwZGVmOThjMzE4NzJjZTINCj4gQXV0aG9yOiBMaSBSb25nUWluZyA8bGly
b25ncWluZ0BiYWlkdS5jb20+DQo+IA0KPiA+IFBDSS9BQ1BJOiBDaGVjayB0aGUgZm91bmQgaGFu
ZGxlIGluIGFjcGlfZ2V0X3JjX3Jlc291cmNlcygpDQo+ID4NCj4gPiBhY3BpX2dldF9kZXZpY2Vz
KCkgcmV0dXJucyBBRV9PSyBldmVuIHdoZW4gdGhlIG5hbWVzcGFjZSB3YWxrIGZpbmlzaGVzDQo+
ID4gd2l0aG91dCBhIG1hdGNoLCBpbiB3aGljaCBjYXNlIHRoZSByZXR1cm5fdmFsdWUgYXJndW1l
bnQgaXMgbm90IHdyaXR0ZW4uDQo+ID4gVGhlIGNhbGxlciBwYXNzZXMgYW4gdW5pbml0aWFsaXpl
ZCBhY3BpX2hhbmRsZSBhbmQgaGFuZHMgaXQgdG8NCj4gPiBhY3BpX2ZldGNoX2FjcGlfZGV2KCks
IHdoaWNoIGRlcmVmZXJlbmNlcyBpdCBhcyBhbiBBQ1BJIG5vZGUuDQo+ID4NCj4gPiBJbml0aWFs
aXplIHRoZSBoYW5kbGUgYW5kIHJlamVjdCBhIG1pc3NpbmcgbWF0Y2guDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBMaSBSb25nUWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+IA0KPiBbU2V2
ZXJpdHk6IExvd10NCj4gU2luY2UgdGhpcyBmaXhlcyBhbiB1bmluaXRpYWxpemVkIGhhbmRsZSBk
ZXJlZmVyZW5jZSBpbg0KPiBhY3BpX2dldF9yY19yZXNvdXJjZXMoKSB3aGVuIGFjcGlfZ2V0X2Rl
dmljZXMoKSBjb21wbGV0ZXMgd2l0aG91dCBhIG1hdGNoLA0KPiBwbGVhc2UgYWRkIGEgRml4ZXMg
dGFnOg0KPiANCj4gICBGaXhlczogMTY5ZGU5NjljMDE4ICgiUENJL0FDUEk6IFByb3ZpZGUgYWNw
aV9nZXRfcmNfcmVzb3VyY2VzKCkgZm9yIEFSTTY0DQo+IHBsYXRmb3JtIikNCj4gDQoNCkkgdGhp
bmsgdGhpcyBpc3N1ZSBoYXMgbGltaXRlZCBpbXBhY3QsIHNvIEkgZGlkbid0IGFkZCBhIEZpeGVz
IHRhZy4gUGxlYXNlLCBtYWludGFpbmVyLCBjaGVjayB3aGV0aGVyIGEgRml4ZXMgdGFnIGlzIG5l
ZWRlZCB3aGVuIG1lcmdpbmcuDQoNCltMaSxSb25ncWluZ10gDQoNCj4gLS0NCj4gU2FzaGlrbyBB
SQ0KPiByZXZpZXcgwrcgaHR0cHM6Ly9zYXNoaWtvLmRldi8jL3BhdGNoc2V0LzIwMjYxMTEwMDUz
NDIzLjI1MTctMS1saXJvbmdxaW5nDQo+IEBiYWlkdS5jb20/cGFydD0xDQo=
