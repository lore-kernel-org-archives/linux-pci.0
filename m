Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2ED2DEA61;
	Fri, 17 Apr 2026 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776415783; cv=none; b=c2jlF7EzdzeAtfAXMk7Xx+MSDaMhfxOuzzELibakYRlS3u8TJIQyGn287Jn4jJuGwc1rrsdUqY1YP9DcxCjNU5YrW7MaixqOZBqypShMOI9ZLYF/3RcypF+j70LbXs8cFFp7j6AmB9CpXzDzqLf1Dg7JUM89rlotGVwK3gAp1l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776415783; c=relaxed/simple;
	bh=hrDCA86iMRZe79wW6zL67X7WRlZuj7pevmL/QYIw9GQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=efd106rat9C29At9cvnuP6/fDxgbCd+ohL9ypNaXD2UMTflN0ZACz0drRda56B1mUdCXeaRYokY3+WGlZvwf7Ew4l/Hslp2swcaUW/aRD9TXkTZ/Jx6oVhMDi32KH7k4eEpDaql0hS1C0TFgScMBATpMXKUKmb2mlhmeGMVEVtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from zhangsenchuan$eswincomputing.com ( [10.12.96.83] ) by
 ajax-webmail-app2 (Coremail) ; Fri, 17 Apr 2026 16:49:22 +0800 (GMT+08:00)
Date: Fri, 17 Apr 2026 16:49:22 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: zhangsenchuan <zhangsenchuan@eswincomputing.com>
To: "Felix Gu" <ustc.gu@gmail.com>
Cc: "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	"Manivannan Sadhasivam" <mani@kernel.org>,
	"Rob Herring" <robh@kernel.org>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	"Yanghui Ou" <ouyanghui@eswincomputing.com>,
	"Yu Ning" <ningyu@eswincomputing.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: eswin: Fix resource leak on dw_pcie_host_init()
 failure
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260416-eswin-v1-1-a4991725b5ca@gmail.com>
References: <20260416-eswin-v1-1-a4991725b5ca@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <63f0d797.55eb.19d9aa167da.Coremail.zhangsenchuan@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TQJkCgA3TJ8S9OFpvmgSAA--.2402W
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/1tbiAQEABmnhD
	xkcjwAAsL
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiBTdWJqZWN0OiBbUEFUQ0hdIFBDSTogZXN3aW46IEZpeCByZXNvdXJjZSBsZWFrIG9uIGR3X3Bj
aWVfaG9zdF9pbml0KCkgZmFpbHVyZQo+IAo+IFdoZW4gZHdfcGNpZV9ob3N0X2luaXQoKSBmYWls
cywgdGhlIGNvZGUganVtcHMgdG8gZXJyX2luaXQgd2hpY2gKPiBvbmx5IGNhbGxzIHBtX3J1bnRp
bWVfcHV0KCkgYnV0IHNraXBzIHRoZSBjbGVhbiB1cCBvZiBwb3J0IHJlc291cmNlcy4KPiAKPiBG
aXhlczogYjU5M2MyNmQwODFhICgiUENJOiBlc3dpbjogQWRkIEVTV0lOIFBDSWUgUm9vdCBDb21w
bGV4IGRyaXZlciIpCj4gU2lnbmVkLW9mZi1ieTogRmVsaXggR3UgPHVzdGMuZ3VAZ21haWwuY29t
Pgo+IC0tLQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWVzd2luLmMgfCAzICst
LQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCj4gCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZXN3aW4uYyBiL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZXN3aW4uYwo+IGluZGV4IDI4NDU4MzJiMzgy
NC4uMDE4NWI1NWUwOWUzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtZXN3aW4uYwo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZXN3
aW4uYwo+IEBAIC0zNDgsNyArMzQ4LDcgQEAgc3RhdGljIGludCBlc3dpbl9wY2llX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gIAlyZXQgPSBkd19wY2llX2hvc3RfaW5pdCgm
cGNpLT5wcCk7Cj4gIAlpZiAocmV0KSB7Cj4gIAkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gaW5p
dCBob3N0XG4iKTsKPiAtCQlnb3RvIGVycl9pbml0Owo+ICsJCWdvdG8gZXJyX3BtX3J1bnRpbWVf
cHV0Owo+ICAJfQo+ICAKPiAgCXJldHVybiAwOwo+IEBAIC0zNTgsNyArMzU4LDYgQEAgc3RhdGlj
IGludCBlc3dpbl9wY2llX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gIAkJ
cmVzZXRfY29udHJvbF9wdXQocG9ydC0+cGVyc3QpOwo+ICAJCWxpc3RfZGVsKCZwb3J0LT5saXN0
KTsKPiAgCX0KPiAtZXJyX2luaXQ6Cj4gIAlwbV9ydW50aW1lX3B1dChkZXYpOwo+ICAKPiAgCXJl
dHVybiByZXQ7CgpUaGFua3MgZm9yIHlvdXIgcmVtaW5kZXIuCkluIHNvbWUgY2FzZXMsIHJlc291
cmNlcyBhcmUgaW5kZWVkIHVuYWJsZSB0byBiZSByZWxlYXNlZC4gRm9yIGluc3RhbmNlLCBpZiB0
aGUgCmNsa19idWxrX3ByZXBhcmVfZW5hYmxlIGZ1bmN0aW9uIGZhaWxzIHRvIGV4ZWN1dGUsIG9y
IGlmIHNvbWUgZnVuY3Rpb25zIAppbiBkd19wY2llX2hvc3RfaW5pdCBmYWlsIHRvIGV4ZWN1dGUs
IGFuZCB0aGUgcG9ydCByZXNvdXJjZXMgYXJlIG5vdCByZWxlYXNlZC4KCktpbmQgcmVnYXJkcywK
U2VuY2h1YW4KPiAKPiAtLS0KPiBiYXNlLWNvbW1pdDogOTM2YzIxMDY4ZDdhZGUwMDMyNWU0MGQ4
MmJmZDJmM2YyOWQ5ZjY1OQo+IGNoYW5nZS1pZDogMjAyNjA0MTYtZXN3aW4tNGQwOWRmNGU4ZjQ4
Cj4gCgo=
