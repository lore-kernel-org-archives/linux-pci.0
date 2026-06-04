Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A07405C45;
	Thu,  4 Jun 2026 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780578832; cv=none; b=pzM1RaTqFRvU+ovQI4gTAO8hVKEDE/k5Alp9w6FGRDKPQTRK3dt3s8U2tdu5Uo1vWdGrzH6zd5sXicHL6t8IePETPUAAcj2r5rtqIjqd/uzYWGeTngqumfakBbP9Zb5zAIKUDyOmvdY/o+xx5Fsn2l4m95IgZCQBxAh5nnR07K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780578832; c=relaxed/simple;
	bh=l/75B24Cu47jkFek3s0pWrT/4s4hr1GK1DZ0Iexgp9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=EJr2Z2GzGngMXM2xrSCWmMac6fiUpQ/HF0qaAOo5DMwx19VQKC69MziN+j3zYLm6klNuvmjS3ueNxPOl9bsEzf8Teje9nbpO2R71Lol1Y46xvUw0naCrpf+11G2hITVOFLFy/RRVGiTmhziM3KJkGnJtgot/kZnL6opU5L8Cs5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cloFivz9; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cloFivz9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=l/75B24Cu47jkFek3s0pWrT/4s4hr1GK1DZ0Iexgp9Y=; b=c
	loFivz95sWGzECDP4DFNfiSwMU0qHHffbk6/xEFo7ay61xmyFUSwBWUMbnqxDWHV
	xMGkHpACmLoLWPRUq8QHZzL26Si2kZNfgRSFOYvPi6gouYZLOICBmBdY3yCJla2C
	a6cgzkNdqftxHf7LbrjW6ZDFjPXYQY/AEslo/3mXe0=
Received: from w15303746062$163.com ( [113.200.174.80] ) by
 ajax-webmail-wmsvr-40-139 (Coremail) ; Thu, 4 Jun 2026 21:13:16 +0800 (CST)
Date: Thu, 4 Jun 2026 21:13:16 +0800 (CST)
From: w15303746062  <w15303746062@163.com>
To: airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-pci@vger.kernel.org,
	"Mingyu Wang" <25181214217@stu.xidian.edu.cn>
Subject: Re:[PATCH v2] char: agp: amd64 - fix broken error propagation in
 agp_amd64_probe()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260504074823.99377-1-w15303746062@163.com>
References: <20260504074823.99377-1-w15303746062@163.com>
X-NTES-SC: AL_Qu2TAvmct08i4CGZZ+kfmU0Qguw9Xcq5uPkj34FWN5t8jBHo5DwgRW1dDETv98+JMgaTmhKYQh1n599XY4JFX4E5uOxV0hz19UAW9WuReBlwaA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <71742084.a1c9.19e92c4425c.Coremail.w15303746062@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iygvCgDXH_jseSFqUqgCAA--.3876W
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4wx8YGoheezUywAA3y
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpIaSBEYXZlIGFuZCBldmVyeW9uZSwKCkp1c3QgYSBnZW50bGUgcGluZyBvbiB0aGlzIHBhdGNo
LiBJdCBoYXMgYmVlbiBhIG1vbnRoIHNpbmNlIHYyIHdhcyBzdWJtaXR0ZWQuCgpQbGVhc2UgbGV0
IG1lIGtub3cgaWYgdGhlcmUgYXJlIGFueSBxdWVzdGlvbnMsIG9yIGlmIGFueSBmdXJ0aGVyIG1v
ZGlmaWNhdGlvbnMgYXJlIG5lZWRlZC4KClRoYW5rcywKTWluZ3l1CgpBdCAyMDI2LTA1LTA0IDE1
OjQ4OjIzLCB3MTUzMDM3NDYwNjJAMTYzLmNvbSB3cm90ZToKPkZyb206IE1pbmd5dSBXYW5nIDwy
NTE4MTIxNDIxN0BzdHUueGlkaWFuLmVkdS5jbj4KPgo+QSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVu
Y2Ugd2FzIG9ic2VydmVkIGluIHRoZSBBTUQ2NCBBR1AgZHJpdmVyIHdoZW4KPnJ1bm5pbmcgaW4g
YSB2aXJ0dWFsaXplZCBlbnZpcm9ubWVudCAoZS5nLiwgUUVNVS9LVk0pIHdpdGhvdXQgYSBwaHlz
aWNhbAo+QU1EIE5vcnRoYnJpZGdlLiBUaGUgY3Jhc2ggb2NjdXJzIGluIGFtZDY0X2ZldGNoX3Np
emUoKSB3aGVuIGF0dGVtcHRpbmcKPnRvIGRlcmVmZXJlbmNlIHRoZSBwb2ludGVyIHJldHVybmVk
IGJ5IG5vZGVfdG9fYW1kX25iKDApLgo+Cj5UaGUgcm9vdCBjYXVzZSBvZiB0aGlzIGNyYXNoIGlz
IGJyb2tlbiBlcnJvciBwcm9wYWdhdGlvbiBpbgo+YWdwX2FtZDY0X3Byb2JlKCkuIFdoZW4gbm8g
QU1EIE5vcnRoYnJpZGdlcyBhcmUgZm91bmQsIGNhY2hlX25icygpCj5jb3JyZWN0bHkgcmV0dXJu
cyAtRU5PREVWLiBIb3dldmVyLCB0aGUgcHJvYmUgZnVuY3Rpb24gZXJyb25lb3VzbHkKPmNoZWNr
ZWQgdGhlIHJldHVybiB2YWx1ZSBhZ2FpbnN0IGV4YWN0bHkgLTEsIHJhdGhlciB0aGFuIDwgMC4K
Pgo+QXMgYSByZXN1bHQsIHRoZSBoYXJkd2FyZSBhYnNlbmNlIGVycm9yIHdhcyBtYXNrZWQsIGFs
bG93aW5nIHRoZSBkcml2ZXIKPnRvIGltcHJvcGVybHkgcHJvY2VlZCB3aXRoIGluaXRpYWxpemF0
aW9uLiBJdCBldmVudHVhbGx5IGNhbGxlZAo+YWdwX2FkZF9icmlkZ2UoKSwgd2hpY2ggaW52b2tl
cyBhbWQ2NF9mZXRjaF9zaXplKCkuIFNpbmNlIHRoZSBoYXJkd2FyZQo+ZG9lcyBub3QgZXhpc3Qs
IG5vZGVfdG9fYW1kX25iKDApIHJldHVybnMgTlVMTCwgbGVhZGluZyB0byBhIEdlbmVyYWwKPlBy
b3RlY3Rpb24gRmF1bHQgKEdQRikgd2hlbiBhY2Nlc3NpbmcgaXRzIC0+bWlzYyBtZW1iZXIuCj4K
PkZpeCB0aGUgaXNzdWUgYnkgY29ycmVjdGluZyB0aGUgZXJyb3IgY2hlY2sgaW4gYWdwX2FtZDY0
X3Byb2JlKCkgdG8KPmFib3J0IHByb3Blcmx5IHdoZW4gY2FjaGVfbmJzKCkgcmV0dXJucyBhbnkg
bmVnYXRpdmUgZXJyb3IgY29kZS4gVGhpcwo+cHJldmVudHMgdGhlIGRyaXZlciBmcm9tIGVycm9u
ZW91c2x5IHByb2NlZWRpbmcgd2l0aG91dCBoYXJkd2FyZSwgdGhlcmVieQo+cmVzb2x2aW5nIHRo
ZSBzdWJzZXF1ZW50IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCBpdHMgc291cmNlLgo+Cj5T
aWduZWQtb2ZmLWJ5OiBNaW5neXUgV2FuZyA8MjUxODEyMTQyMTdAc3R1LnhpZGlhbi5lZHUuY24+
Cj4tLS0KPisgQ2hhbmdlcyBpbiB2MjoKPisgLSBEcm9wcGVkIHJlZHVuZGFudCBOVUxMIHBvaW50
ZXIgY2hlY2tzIGluIHZhcmlvdXMgaW5pdGlhbGl6YXRpb24gZnVuY3Rpb25zLgo+KyAtIEZpeGVk
IHRoZSBhY3R1YWwgcm9vdCBjYXVzZTogYnJva2VuIGVycm9yIHByb3BhZ2F0aW9uIGluIGFncF9h
bWQ2NF9wcm9iZSgpIAo+KyAgIHdoZXJlIGl0IGVycm9uZW91c2x5IGNoZWNrZWQgY2FjaGVfbmJz
KCkgYWdhaW5zdCBleGFjdGx5IC0xIGluc3RlYWQgb2YgPCAwLgo+KyAgIChUaGFua3MgdG8gU2Fz
aGlrbyBBSSBmb3IgdGhlIHJldmlldyBmZWVkYmFjaykuCj4rCj4gZHJpdmVycy9jaGFyL2FncC9h
bWQ2NC1hZ3AuYyB8IDIgKy0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKPgo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci9hZ3AvYW1kNjQtYWdwLmMgYi9k
cml2ZXJzL2NoYXIvYWdwL2FtZDY0LWFncC5jCj5pbmRleCAyNTA1ZGYxZjRlNjkuLjY3NDEyNzBl
MGE5OCAxMDA2NDQKPi0tLSBhL2RyaXZlcnMvY2hhci9hZ3AvYW1kNjQtYWdwLmMKPisrKyBiL2Ry
aXZlcnMvY2hhci9hZ3AvYW1kNjQtYWdwLmMKPkBAIC01NDYsNyArNTQ2LDcgQEAgc3RhdGljIGlu
dCBhZ3BfYW1kNjRfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsCj4gCS8qIEZpbGwgaW4gdGhl
IG1vZGUgcmVnaXN0ZXIgKi8KPiAJcGNpX3JlYWRfY29uZmlnX2R3b3JkKHBkZXYsIGJyaWRnZS0+
Y2FwbmR4K1BDSV9BR1BfU1RBVFVTLCAmYnJpZGdlLT5tb2RlKTsKPiAKPi0JaWYgKGNhY2hlX25i
cyhwZGV2LCBjYXBfcHRyKSA9PSAtMSkgewo+KwlpZiAoY2FjaGVfbmJzKHBkZXYsIGNhcF9wdHIp
IDwgMCkgewo+IAkJYWdwX3B1dF9icmlkZ2UoYnJpZGdlKTsKPiAJCXJldHVybiAtRU5PREVWOwo+
IAl9Cj4tLSAKPjIuMzQuMQo=
