Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286933D51A;
	Mon, 16 Mar 2026 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627626; cv=none; b=CaxCOnJ2+XM3EsfKYWkYcNarzF9pEBU0UhYSi9o0CCkZl+PUZ89mLBB3OQS5seX4Pc03WXntT3UOoDpEtH1dHB9gR+InBOZbK9TWTLXfZGxJcvu6Ch7kU0Y536IGekm9vMM/66Zv1T9iJe7mMXABvwl1xfWOORk7CTg0T9jNqE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627626; c=relaxed/simple;
	bh=DrvRluairLhniPPZ5QmA8UH6inj+yy17uhIkbEVb3Lg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WSP27wr2hxac4DTn+NiFQmMc5XW9jVtUwiLmr1xMFJY4QPavdBioDQ5byDgbtBvVnRMQh1uqzUJEgvzk/l1OrDkUFYT/XJXS6W5OgnoPjZpKBGqxrL0PaUa9CTorc4Y6Xnbw1kpLvh2WDl0yE8rBvKhxoyOmc14yAGdJdS6mVyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing(ACG CCN)" <lirongqing@baidu.com>
To: =?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kw@linux.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFJlOiBbUEFUQ0hdIFBDSTogc3lzZnM6IFN1cHByZXNz?=
 =?gb2312?B?IEZXX0JVRyB3YXJuaW5nIHdoZW4gTlVNQSBub2RlIGFscmVhZHkgbWF0Y2hl?=
 =?gb2312?Q?s?=
Thread-Topic: [????] Re: [PATCH] PCI: sysfs: Suppress FW_BUG warning when NUMA
 node already matches
Thread-Index: AQHcsqeUwXofzAJvQkSKAMZW1b70/rWt/fqAgAJtzWA=
Date: Mon, 16 Mar 2026 02:20:03 +0000
Message-ID: <d1dd98ddd0a948e9b785844479712162@baidu.com>
References: <20260313050826.2126-1-lirongqing@baidu.com>
 <20260314205407.GB672783@rocinante>
In-Reply-To: <20260314205407.GB672783@rocinante>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.50.45
X-FE-Policy-ID: 52:10:53:SYSTEM

DQo+IA0KPiBIZWxsbywNCj4gDQo+ID4gVGhlIG51bWFfbm9kZSBzeXNmcyBpbnRlcmZhY2UgYWxs
b3dzIHVzZXJzIHRvIG1hbnVhbGx5IG92ZXJyaWRlIGEgUENJDQo+ID4gZGV2aWNlJ3MgTlVNQSBu
b2RlIGFzc2lnbm1lbnQuIEN1cnJlbnRseSwgZXZlcnkgd3JpdGUgdHJpZ2dlcnMgYQ0KPiA+IEZX
X0JVRyB3YXJuaW5nIGFuZCB0YWludHMgdGhlIGtlcm5lbCwgZXZlbiB3aGVuIHdyaXRpbmcgdGhl
IHNhbWUgdmFsdWUNCj4gPiB0aGF0IGlzIGFscmVhZHkgc2V0Lg0KPiANCj4gU28sIHRoaXMgd29y
a3MgYXMgaW50ZW5kZWQsIHRoZW4/DQo+IA0KDQpJIGRvbid0IGtub3cgaWYgdGhpcyBpcyBpbnRl
bmRlZCwgYnV0IGl0IGZlZWxzIHVucmVhc29uYWJsZaGqd3JpdGluZyB0aGUgc2FtZSB2YWx1ZSBz
dGlsbCB0cmlnZ2VycyBhIEZXX0JVRyB3YXJuaW5nLg0KDQo+IFdoYXQgbWFrZXMgbXVsdGlwbGUg
d3JpdGVzIHRvIHRoaXMgc3lzZnMgYXR0cmlidXRlLCBpZiB5b3UgZG9uJ3QgbWluZCBtZQ0KPiBh
c2tpbmc/ICBEbyB5b3UgaGF2ZSBzb21lIHRvb2wgdGhhdCBkb2VzIHRoaXM/ICBTb21lIGF1dG9t
YXRpb24/DQo+IA0KDQpJIGhhdmUgYSB0b29sIHRoYXQgdHJpZ2dlcmVkIHRoaXMgd2FybmluZywg
YW5kIEkgd2lsbCBmaXggbXkgdG9vbC4NCg0KPiBFc3BlY2lhbGx5LCB0aGF0IHlvdSBzZWVtIHRv
IGJlIHdyaXRpbmcgdGhlIHNhbWUgdmFsdWUgb3ZlciBhbmQgb3Zlci4NCj4gDQpOb3QgLCBidXQg
YSB1c2VyIGlzIGFsbG93ZWQgdG8gd3JpdGUgdG8gdGhpcyBmaWxlLCAgYW5kIHN1YnNlcXVlbnRs
eSB3aWxsIGdlbmVyYXRlIGEgbWFzc2l2ZSBhbW91bnQgb2Yga2VybmVsIGxvZ3OhqmlzIHRoaXMg
Y29uc2lkZXJlZCB1bnJlYXNvbmFibGU/IFNob3VsZCB3ZSBhZGQgc29tZSByYXRlIGxpbWl0Pw0K
DQoNCj4gPiAgCWlmIChub2RlICE9IE5VTUFfTk9fTk9ERSAmJiAhbm9kZV9vbmxpbmUobm9kZSkp
DQo+ID4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ID4NCj4gPiAtCWFkZF90YWludChUQUlOVF9GSVJN
V0FSRV9XT1JLQVJPVU5ELCBMT0NLREVQX1NUSUxMX09LKTsNCj4gPiAtCXBjaV9hbGVydChwZGV2
LCBGV19CVUcgIk92ZXJyaWRpbmcgTlVNQSBub2RlIHRvICVkLiAgQ29udGFjdCB5b3VyDQo+IHZl
bmRvciBmb3IgdXBkYXRlcy4iLA0KPiA+IC0JCSAgbm9kZSk7DQo+ID4gKwlpZiAobm9kZSAhPSBk
ZXYtPm51bWFfbm9kZSkgew0KPiA+ICsJCWFkZF90YWludChUQUlOVF9GSVJNV0FSRV9XT1JLQVJP
VU5ELCBMT0NLREVQX1NUSUxMX09LKTsNCj4gPiArCQlwY2lfYWxlcnQocGRldiwgRldfQlVHICJP
dmVycmlkaW5nIE5VTUEgbm9kZSB0byAlZC4gIENvbnRhY3QNCj4geW91ciB2ZW5kb3IgZm9yIHVw
ZGF0ZXMuIiwNCj4gPiArCQkJICBub2RlKTsNCj4gPiArCQlkZXYtPm51bWFfbm9kZSA9IG5vZGU7
DQo+ID4gKwl9DQo+IA0KPiBZb3UgY291bGQgaW52ZXJ0IHRoZSBjaGVjayBhbmQgbWFrZSBpdCBh
biBlYXJseSByZXR1cm4gd2hlcmUgeW91IGp1c3QgcmV0dXJuDQo+IGNvdW50LiAgV291bGQgc2F2
ZSBvbiB0aGUgbmV3IGluZGVudCBsZXZlbC4NCj4gDQoNCkdvb2QgaWRsZSwgSSB3aWxsIGZpeCB0
aGlzIGluIHYyDQoNClRoYW5rcw0KDQpbTGksUm9uZ3FpbmddIA0KDQo+IFRoYW5rIHlvdSENCj4g
DQo+IAlLcnp5c3p0b2YNCg==
