Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794298750;
	b=e6rvwaS3GO19vV8YJVOpKpPkZLhkADknv5UER2ARTr7VufZXUBJJWltwyxw+lYWh96kv
	 XnDMLAKazvVlnqN2oHR2gcKAnvmFccdWkZtz/0Mc3w27BEXmVgJQLMIAGqvghx835LSfv
	 JYaumlKDcUq7u+FfOgAaGMzs9spgi9xEMn5T2jwWlcu1j9ilZb+1BhTq77GWpXe5g7L0y
	 4TnxEtECnM9KMJTJqAe6/3DFllia6GyIVQ1nyccPMkgTB1Sg5d/h8u+Qw+BH1oJ1oo1jl
	 dk6+D31FhVm0h4A04IfePtTBALJjuMbk+evv5EhCY0CXAnXeUkd4pwlJnH+Lt1zyRZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794298750;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 DKIM-Signature;
	bh=slVVpL6QKglwGCeM5KqOhnZpGWwurPH+OKewiRy3Hjw=;
	b=sLzKkKGDvh4Bmr48I3ozPUBVgYqz4JafGQj/r23e0CL8IvUib//5VcFpd+1kM61KqwlR
	 2q06T255fQBG7FYdGHu37rKvqGAauQNdr3GGnLBJMTG+qFpolkTXDIok95JC7F2aHfeY/
	 K1nierxOXfh6bR9FI7vsooWLfcvzGPfhcSNELvYNRAqJaOQ3IeMpN4sjmiX/8fP7A1Grh
	 E072Cfsw6Wai08rabEBezdJQQKxcoWyM7g++nWv/ETaTowRCTzKD+junjZG+798wFVIwU
	 zO7u3+aGw4rwifWZcTIyC7HL9CTJBpWDzhgA21XXPUKerH2VfllRN2o7t8yuKNSKCLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=GMesRZ9q;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 27521606A33F
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 08:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27521606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=GMesRZ9q
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.45
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXSBQQ0k6IFNhdmUg?=
 =?utf-8?B?dGhlIFJvb3QgUG9ydCBzdGF0ZSBiZWZvcmUgYSBwbGF0Zm9ybS1zcGVjaWZp?=
 =?utf-8?Q?c_reset?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0gUENJOiBTYXZlIHRoZSBSb290?=
 =?utf-8?Q?_Port_state_before_a_platform-specific_reset?=
Thread-Index: AQHdcNUXSwuHXgAo90mXRYzcPov+C7cmSFGAgACuCeA=
Date: Tue, 10 Nov 2026 08:19:05 +0000
Message-ID: <f721aa07de544343bad01ba02b4ba247@baidu.com>
References: <20261110053348.2419-1-lirongqing@baidu.com>
 <20261110053348.2419-2-lirongqing@baidu.com>
 <sashiko-outbox-206352@kernel.org>
In-Reply-To: <sashiko-outbox-206352@kernel.org>
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
	s=selector1; t=1794298748;
	bh=slVVpL6QKglwGCeM5KqOhnZpGWwurPH+OKewiRy3Hjw=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=GMesRZ9qrcMDHpLujr2xhMwQx0GkVZI6XDgvInmIuqQrXC0xPnPPFL9Ai+koGDT63
	 yFlxkQX9x1bGGOKBD6aZ4HpTJMg3gIYIeN7LYmI189SaqINZhdfoOnBmwjjdl2hv2B
	 aWpGFJ+TCb4mP/c54ajm5I5vpox61uaJfL5QdkviBDVLozpmCV4S0k/zGqnhjnnjTJ
	 BYLRr33YBa8sbg8K6fnOYnVqifQcEJt+cDh6WI4f8DgTg3lrWBrlXi/Vf2iFc4UpI9
	 B7MkfQ8q63a0XGMqI2UjI1b0goGRPcLpA6V2Br5Kz4ZxoeuZFox6/cBjhPxj3Ai3Fn
	 d648JoXCzZHTw==

PiANCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBEb2VzIGNhbGxpbmcgcGNpX3NhdmVfc3RhdGUoZGV2
KSBoZXJlIG92ZXJ3cml0ZSB0aGUgUm9vdCBQb3J0J3Mgd29ya2luZyBzYXZlZA0KPiBzdGF0ZSAo
c2F2ZWQgZHVyaW5nIGVudW1lcmF0aW9uIGluIHBjaV9idXNfYWRkX2RldmljZSgpIGFuZA0KPiBw
Y2llX3BvcnRkcnZfcHJvYmUoKSkgd2l0aCBwb3N0LWVycm9yIG9yIHBvc3QtbGluay1kb3duIHJl
Z2lzdGVyIHZhbHVlcz8NCj4gDQo+IER1cmluZyBsaW5rLWRvd24gcmVjb3ZlcnkgdmlhIHBjaV9o
b3N0X2hhbmRsZV9saW5rX2Rvd24oKSAtPg0KPiBwY2llX2RvX3JlY292ZXJ5KCkgLT4gcGNpX2hv
c3RfcmVzZXRfcm9vdF9wb3J0KCkgLT4gcGNpX2J1c19lcnJvcl9yZXNldCgpLCB0aGUNCj4gbGlu
ayBpcyBhbHJlYWR5IGRvd24gYmVmb3JlIHBjaWJpb3NfcmVzZXRfc2Vjb25kYXJ5X2J1cygpIHJ1
bnMuICBEb3duc3RyZWFtDQo+IFBvcnRzIGNsZWFyIFBDSV9FWFBfREVWQ1RMMl9MVFJfRU4gb24g
bGluayBkb3duIChhbmQNCj4gcGNpX2JyaWRnZV9yZWNvbmZpZ3VyZV9sdHIoKSBpbiBwY2lfcmVz
dG9yZV9wY2llX3N0YXRlKCkgaXMgYSBuby1vcCBmb3IgUm9vdCBQb3J0cw0KPiBiZWNhdXNlDQo+
IHBjaV91cHN0cmVhbV9icmlkZ2UoZGV2KSBpcyBOVUxMKSwgd2hpbGUgY29udHJvbGxlcnMgc3Vj
aCBhcyBwY2llLWR3LXJvY2tjaGlwDQo+IGFuZCBwY2llLXFjb20gaGF2ZSBhbHJlYWR5IHJlc2V0
IHRoZWlyIG5vbi1zdGlja3kgUm9vdCBQb3J0IHJlZ2lzdGVycyBvbiB0aGUNCj4gbGluay1kb3du
IGV2ZW50LiAgU2F2aW5nIHN0YXRlIGF0IHRoaXMgcG9pbnQgY2FwdHVyZXMgdGhvc2UgY2xlYXJl
ZCByZWdpc3RlcnMgYW5kDQo+IHJlc3RvcmVzIHRoZW0gYWZ0ZXIgaG9zdC0+cmVzZXRfcm9vdF9w
b3J0KCkuDQo+IA0KPiBTaW1pbGFybHksIGluIHRoZSBmYXRhbCBBRVIgcmVjb3ZlcnkgcGF0aCwg
YWVyX3Jvb3RfcmVzZXQoKSBkaXNhYmxlcyBSb290IFBvcnQgQUVSDQo+IGludGVycnVwdHMgYmVm
b3JlIHJlc2V0dGluZyB0aGUgYnVzOg0KPiANCj4gZHJpdmVycy9wY2kvcGNpZS9hZXIuYzphZXJf
cm9vdF9yZXNldCgpIHsNCj4gCWlmIChob3N0LT5uYXRpdmVfYWVyICYmIGFlcikNCj4gCQlhZXJf
ZGlzYWJsZV9pcnEocm9vdCk7DQo+IAkuLi4NCj4gCX0gZWxzZSB7DQo+IAkJcmMgPSBwY2lfYnVz
X2Vycm9yX3Jlc2V0KGRldik7DQo+IH0NCj4gDQo+IENhbGxpbmcgcGNpX3NhdmVfc3RhdGUoZGV2
KSBpbnNpZGUgcGNpYmlvc19yZXNldF9zZWNvbmRhcnlfYnVzKCkgcmVjb3JkcyB0aGUNCj4gSVJR
LWRpc2FibGVkIFBDSV9FUlJfUk9PVF9DT01NQU5EIHZhbHVlIGludG8gZGV2LT5zYXZlZF9jYXBf
c3BhY2UsIHNvDQo+IGFueSBzdWJzZXF1ZW50IHBjaV9yZXN0b3JlX3N0YXRlKGRldikgd2lsbCBs
ZWF2ZSBSb290IFBvcnQgQUVSIGludGVycnVwdHMNCj4gZGlzYWJsZWQuICBBbmQgaWYgaG9zdC0+
cmVzZXRfcm9vdF9wb3J0KCkgZmFpbHMsIGRldi0+c3RhdGVfc2F2ZWQgaXMgbGVmdCBzZXQgd2l0
aA0KPiB0aGUgYnJva2VuIHN0YXRlLCBjYXVzaW5nIHBjaV9wbV9zdXNwZW5kX25vaXJxX2NvbW1v
bigpIHRvIHNraXAgc2F2aW5nIHN0YXRlDQo+IGFuZCBwY2lfcHJlcGFyZV90b19zbGVlcCgpIG9u
IHN5c3RlbSBzdXNwZW5kLg0KPiANCg0KSSB3aWxsIHNlbmQgYSB2MiB0byBmaXggdGhlIGlzc3Vl
IGZvdW5kIGJ5IFNhc2hpa28NCg0KW0xpLFJvbmdxaW5nXSANCg0KDQo+IC0tDQo+IFNhc2hpa28g
QUkNCj4gcmV2aWV3IMK3IGh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MTExMDA1
MzM0OC4yNDE5LTItbGlyb25ncWluZw0KPiBAYmFpZHUuY29tP3BhcnQ9MQ0K
