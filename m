Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E0B30F7E8
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 02:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782095957; cv=none; b=RWcV2S2EEvT2QZ7gcvx/Xb10h2ncujMbWj1ca3UYaGR4vwz8rO4YniMcvVPOwrAy86Dl8IWKcqo886iQYBqkkIha1dxDLPGcF2mWpmGr2ly0xiFGbqZmD83c957P7vlE1om8N6Rku7vCTEa1e4fZEs9Y6/Eh4limDLaHEt/XEEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782095957; c=relaxed/simple;
	bh=kST6cNQY/Z4RZsGmpcL/Cg/PoIO/OZIt7dsgmi8gQH4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f+Mh+7oiDZQ6SsrY9JCUQlHxN8YYhJ/vbvn1eOkb0+MJfCy3Q8jEii81XsjmWynAFlTxOmyKo68XzSliWgtIZyyM3UXcoEOcJ6JcatwRfhFEUrIsDwZ+swwAJe3BUWUKkI80EDu5fon4vYBHfdQ0Q7nleyoVXf7gQHglOrG7uqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=VN2Aw4qo; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="VN2Aw4qo"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kST6cNQY/Z4RZsGmpcL/Cg/PoIO/OZIt7dsgmi8gQH4=;
	b=VN2Aw4qo5EOZ+TMR1pcKYZIGqjge06nUmkyxg+qKN/gGMO3tFIM7l9vG0nbolpU6nQxuFYH9s
	WxfJcAdSzK+5dCWPdz0rZBQuHftGQJyhfsDROfz1jroMNUBFFjhQN4m0BD0kL4De6CE/H4wYQYv
	RvVPzYTo94cbhgDd0E7cRis=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gkBxM2kqQz1K9CG;
	Mon, 22 Jun 2026 10:29:59 +0800 (CST)
Received: from dggpemf500001.china.huawei.com (unknown [7.185.36.173])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A16E40563;
	Mon, 22 Jun 2026 10:39:02 +0800 (CST)
Received: from dggpemf100007.china.huawei.com (7.185.36.214) by
 dggpemf500001.china.huawei.com (7.185.36.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Jun 2026 10:39:01 +0800
Received: from dggpemf100007.china.huawei.com ([7.185.36.214]) by
 dggpemf100007.china.huawei.com ([7.185.36.214]) with mapi id 15.02.1544.011;
 Mon, 22 Jun 2026 10:39:01 +0800
From: Kangfenglong <kangfenglong@huawei.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Wangyu (Eric)"
	<seven.wangyu@huawei.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjJdIG52bWUtcGNpOiBmaXggQ01CIG1hcHBpbmcg?=
 =?utf-8?Q?when_CMBSZ_Size_field_is_zero?=
Thread-Topic: [PATCH v2] nvme-pci: fix CMB mapping when CMBSZ Size field is
 zero
Thread-Index: AQHdAeWAg0D0HhcTmUewKS2+ZgRXtrZJQwEAgACZoUA=
Date: Mon, 22 Jun 2026 02:39:01 +0000
Message-ID: <9dd1e67db35e463fa473203c743f5597@huawei.com>
References: <20260622012147.40600-1-kangfenglong@huawei.com>
 <20260622012841.3BD061F000E9@smtp.kernel.org>
In-Reply-To: <20260622012841.3BD061F000E9@smtp.kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

VGhhbmtzIGZvciByZXZpZXchDQoNCllvdXIgZmVlZGJhY2sgaXMgcmVhc29uYWJsZSwgYW5kIEkg
d2lsbCBmaXggaXQgaW4gdGhlIG5leHQgcGF0Y2jvvIEgDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0t
LS0NCuWPkeS7tuS6ujogc2FzaGlrby1ib3RAa2VybmVsLm9yZyBbbWFpbHRvOnNhc2hpa28tYm90
QGtlcm5lbC5vcmddIA0K5Y+R6YCB5pe26Ze0OiAyMDI25bm0NuaciDIy5pelIDk6MjkNCuaUtuS7
tuS6ujogS2FuZ2Zlbmdsb25nIDxrYW5nZmVuZ2xvbmdAaHVhd2VpLmNvbT4NCuaKhOmAgTogbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZw0K5Li76aKYOiBSZTogW1BBVENIIHYyXSBudm1lLXBjaTog
Zml4IENNQiBtYXBwaW5nIHdoZW4gQ01CU1ogU2l6ZSBmaWVsZCBpcyB6ZXJvDQoNClRoYW5rIHlv
dSBmb3IgeW91ciBjb250cmlidXRpb24hIFNhc2hpa28gQUkgcmV2aWV3IGZvdW5kIDEgcG90ZW50
aWFsIGlzc3VlKHMpIHRvIGNvbnNpZGVyOg0KLSBbSGlnaF0gUmV0dXJuaW5nIDAgZnJvbSBgbnZt
ZV9jbWJfc2l6ZV91bml0KClgIHRvIHJlamVjdCBpbnZhbGlkIFNaVSB2YWx1ZXMgZXZhbHVhdGVz
IHRvIGEgc2l6ZSBvZiAwLCBieXBhc3NpbmcgdGhlIHJlamVjdGlvbiBhbmQgdHJpZ2dlcmluZyB0
aGUgZXhhY3QgYnVnIHRoZSBwYXRjaCBhdHRlbXB0cyB0byBmaXguDQotLQ0KDQpjb21taXQgZWZj
ZDcxNzA4MDAzYzE0MDM4YTFmZGM3OWI2MjMzY2M0YjZhODE5Mg0KQXV0aG9yOiBrYW5nZmVuZ2xv
bmcgPGthbmdmZW5nbG9uZ0BodWF3ZWkuY29tPg0KDQpudm1lLXBjaTogZml4IENNQiBtYXBwaW5n
IHdoZW4gQ01CU1ogU2l6ZSBmaWVsZCBpcyB6ZXJvDQoNClRoaXMgY29tbWl0IHJlc3RvcmVzIHRo
ZSBjaGVjayBmb3IgYSB6ZXJvIFNaIGZpZWxkIGluIHRoZSBDTUJTWiByZWdpc3RlciwgbGltaXRz
IHRoZSBTaXplIFVuaXRzIChTWlUpIHRvIHZhbGlkIHZhbHVlcywgYW5kIGFkZHMgYW4gb3ZlcmZs
b3cgY2hlY2sgd2hlbiBjYWxjdWxhdGluZyB0aGUgQ01CIHNpemUgdG8gYXZvaWQgbWFwcGluZyBl
cnJvcnMuDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIGIvZHJpdmVy
cy9udm1lL2hvc3QvcGNpLmMgaW5kZXggDQo+IGU2MjY3YTZhYTM4MDEuLjI3OTQyOThhYTllNjYg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jDQo+ICsrKyBiL2RyaXZlcnMv
bnZtZS9ob3N0L3BjaS5jDQo+IEBAIC0xODE0LDYgKzE4MTQsOSBAQCBzdGF0aWMgdTY0IG52bWVf
Y21iX3NpemVfdW5pdChzdHJ1Y3QgbnZtZV9kZXYgDQo+ICpkZXYpICB7DQo+ICAJdTggc3p1ID0g
KGRldi0+Y21ic3ogPj4gTlZNRV9DTUJTWl9TWlVfU0hJRlQpICYgTlZNRV9DTUJTWl9TWlVfTUFT
SzsNCj4gIA0KPiArCWlmIChzenUgPiA2KQ0KPiArCQlyZXR1cm4gMDsNCj4gKw0KDQpbU2V2ZXJp
dHk6IEhpZ2hdDQpJZiB0aGlzIGJvdW5kYXJ5IGNoZWNrIHJldHVybnMgMCB0byByZWplY3QgYW4g
aW52YWxpZCBTWlUgdmFsdWUsIHdpbGwgdGhpcw0KMCB2YWx1ZSBiZSB1c2VkIGluIHN1YnNlcXVl
bnQgY2FsY3VsYXRpb25zIHJhdGhlciB0aGFuIHRyaWdnZXJpbmcgYW4gYWJvcnQ/DQoNCj4gIAly
ZXR1cm4gMVVMTCA8PCAoMTIgKyA0ICogc3p1KTsNCj4gIH0NCj4gIA0KPiBAQCAtMTgzOCw5ICsx
ODQxLDEyIEBAIHN0YXRpYyB2b2lkIG52bWVfbWFwX2NtYihzdHJ1Y3QgbnZtZV9kZXYgKmRldikN
Cj4gIAlkZXYtPmNtYnN6ID0gcmVhZGwoZGV2LT5iYXIgKyBOVk1FX1JFR19DTUJTWik7DQo+ICAJ
aWYgKCFkZXYtPmNtYnN6KQ0KPiAgCQlyZXR1cm47DQo+ICsJaWYgKCFudm1lX2NtYl9zaXplKGRl
dikpDQo+ICsJCXJldHVybjsNCj4gIAlkZXYtPmNtYmxvYyA9IHJlYWRsKGRldi0+YmFyICsgTlZN
RV9SRUdfQ01CTE9DKTsNCj4gIA0KPiAtCXNpemUgPSBudm1lX2NtYl9zaXplX3VuaXQoZGV2KSAq
IG52bWVfY21iX3NpemUoZGV2KTsNCj4gKwlpZiAoY2hlY2tfbXVsX292ZXJmbG93KG52bWVfY21i
X3NpemVfdW5pdChkZXYpLCBudm1lX2NtYl9zaXplKGRldiksICZzaXplKSkNCj4gKwkJcmV0dXJu
Ow0KPiAgCW9mZnNldCA9IG52bWVfY21iX3NpemVfdW5pdChkZXYpICogTlZNRV9DTUJfT0ZTVChk
ZXYtPmNtYmxvYyk7DQo+ICAJYmFyID0gTlZNRV9DTUJfQklSKGRldi0+Y21ibG9jKTsNCj4gIAli
YXJfc2l6ZSA9IHBjaV9yZXNvdXJjZV9sZW4ocGRldiwgYmFyKTsNCg0KW1NldmVyaXR5OiBIaWdo
XQ0KSWYgbnZtZV9jbWJfc2l6ZV91bml0KCkgcmV0dXJuZWQgMCwgd29uJ3QgY2hlY2tfbXVsX292
ZXJmbG93KCkgY29tcHV0ZQ0KMCAqIHN6ID0gMCwgcmV0dXJuIGZhbHNlIChubyBvdmVyZmxvdyks
IGFuZCBzZXQgc2l6ZSA9IDAgd2l0aG91dCByZXR1cm5pbmcgZWFybHk/DQoNCkJlY2F1c2Ugc2l6
ZSBldmFsdWF0ZXMgdG8gMCwgZXhlY3V0aW9uIGNvbnRpbnVlcywgYW5kIGxhdGVyIGluIHRoZSBm
dW5jdGlvbg0KcGNpX3AycGRtYV9hZGRfcmVzb3VyY2UoKSB3aWxsIGJlIGNhbGxlZCB3aXRoIHNp
emU9MCBhbmQgb2Zmc2V0PTAuDQoNCkFzIG5vdGVkIGluIHRoZSBjb21taXQgbWVzc2FnZSwgY2Fs
bGluZyBwY2lfcDJwZG1hX2FkZF9yZXNvdXJjZSgpIHdpdGggc2l6ZT0wIGNhdXNlcyB0aGUgUDJQ
RE1BIHN1YnN5c3RlbSB0byBkZWZhdWx0IHRvIG1hcHBpbmcgdGhlIGVudGlyZSByZW1haW5pbmcg
QkFSLg0KRG9lcyB0aGlzIGRlZmVhdCB0aGUgU1pVIGJvdW5kYXJ5IGNoZWNrIGFib3ZlIGFuZCBy
ZS10cmlnZ2VyIHRoZSBleGFjdCBtZW1vcnkgbWFwcGluZyB3YXJuaW5nIHRoaXMgcGF0Y2ggaXMg
YXR0ZW1wdGluZyB0byBmaXg/DQoNClNob3VsZCBudm1lX21hcF9jbWIoKSBleHBsaWNpdGx5IGNo
ZWNrIGlmIG52bWVfY21iX3NpemVfdW5pdCgpID09IDAgb3IgaWYgdGhlIHJlc3VsdGluZyBzaXpl
ID09IDAgYmVmb3JlIGNvbnRpbnVpbmc/DQoNCi0tDQpTYXNoaWtvIEFJIHJldmlldyDCtyBodHRw
czovL3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAyNjA2MjIwMTIxNDcuNDA2MDAtMS1rYW5nZmVu
Z2xvbmdAaHVhd2VpLmNvbT9wYXJ0PTENCg0K
