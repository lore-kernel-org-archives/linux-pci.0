Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE503546E0;
	Thu, 21 May 2026 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779347310; cv=none; b=N9zvV2hABviWpjFETTdXWfH04FAsjb/IIEpKELBaCGJXGe0B0wGxCMAAd5FbyJQRJNiGI2ctWd61Sb5XSprAV4lUcyd1bFuIlygOEzrZDM3NBrnobb+suKQbzJRSIONPXl5QEMZvRbIgYbznJbUhyuOPCklT8QFY35p6vS65G/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779347310; c=relaxed/simple;
	bh=399+N0BGkr2dphM86ZMmk/qW+QNICoGeSb6gWScdRz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=RPNH3bu2OWPsO/09Kws9x+VcNt5pri53gOPfbU5PgxGY/q275ph4ODqU6egKMboiSuKD9hHfVlba+0+niautQtiCvUjLVQfse6SEC8iwojLHNSHFuEaMM4GeY/HKDNQtvC6OM9Hlcd1PwK4rBmbhBFcJMbfiM/hfXwp7SODZDHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from zhangsenchuan$eswincomputing.com ( [10.12.96.83] ) by
 ajax-webmail-app2 (Coremail) ; Thu, 21 May 2026 15:08:20 +0800 (GMT+08:00)
Date: Thu, 21 May 2026 15:08:20 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: zhangsenchuan <zhangsenchuan@eswincomputing.com>
To: "Felix Gu" <ustc.gu@gmail.com>
Cc: "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	"Manivannan Sadhasivam" <mani@kernel.org>,
	"Rob Herring" <robh@kernel.org>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	"Philipp Zabel" <p.zabel@pengutronix.de>,
	"Yu Ning" <ningyu@eswincomputing.com>,
	"Yanghui Ou" <ouyanghui@eswincomputing.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: eswin: Fix resource leak on dw_pcie_host_init()
 failure
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260520-eswin-v2-1-a221438a6317@gmail.com>
References: <20260520-eswin-v2-1-a221438a6317@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2d07dcc6.66e3.19e495d208f.Coremail.zhangsenchuan@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TQJkCgA3TJ9krw5qvysbAA--.4511W
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/1tbiAQEOBmoN4
	h4ScAABsw
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

Cgo+IEZpeGVzOiBiNTkzYzI2ZDA4MWEgKCJQQ0k6IGVzd2luOiBBZGQgRVNXSU4gUENJZSBSb290
IENvbXBsZXggZHJpdmVyIikKPiBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBHdSA8dXN0Yy5ndUBnbWFp
bC5jb20+Cj4gLS0tCj4gICAgQ2hhbmdlcyBpbiB2MjoKPiAgICAtIEZpeCBNYW5pJ3MgY29tbWVu
dC4KPiAgICAtIFJlbW92ZSBpbmNvcnJlY3QgcG9ydCBjbGVhbnVwIGNvZGUgaW4gZXN3aW5fcGNp
ZV9ob3N0X2luaXQoKSBlcnJvciBwYXRoLgo+ICAgIC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGttbC8yMDI2MDQxNi1lc3dpbi12MS0xLWE0OTkxNzI1YjVjYUBnbWFpbC5j
b20vCj4gLS0tCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZXN3aW4uYyB8IDEx
ICsrKy0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDggZGVsZXRp
b25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
ZXN3aW4uYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZXN3aW4uYwo+IGluZGV4
IGNlOGQ2NGY4YTM5NS4uN2EwMmFiOTFhMTkwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtZXN3aW4uYwo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZXN3aW4uYwo+IEBAIC0xODIsNyArMTgyLDcgQEAgc3RhdGljIGludCBlc3dpbl9w
Y2llX2hvc3RfaW5pdChzdHJ1Y3QgZHdfcGNpZV9ycCAqcHApCj4gIHsKPiAgCXN0cnVjdCBkd19w
Y2llICpwY2kgPSB0b19kd19wY2llX2Zyb21fcHAocHApOwo+ICAJc3RydWN0IGVzd2luX3BjaWUg
KnBjaWUgPSB0b19lc3dpbl9wY2llKHBjaSk7Cj4gLQlzdHJ1Y3QgZXN3aW5fcGNpZV9wb3J0ICpw
b3J0LCAqdG1wOwo+ICsJc3RydWN0IGVzd2luX3BjaWVfcG9ydCAqcG9ydDsKPiAgCXUzMiB2YWw7
Cj4gIAlpbnQgcmV0Owo+ICAKPiBAQCAtMjUyLDEwICsyNTIsNiBAQCBzdGF0aWMgaW50IGVzd2lu
X3BjaWVfaG9zdF9pbml0KHN0cnVjdCBkd19wY2llX3JwICpwcCkKPiAgCXJlc2V0X2NvbnRyb2xf
YnVsa19hc3NlcnQoRVNXSU5fTlVNX1JTVFMsIHBjaWUtPnJlc2V0cyk7Cj4gIGVycl9kZWFzc2Vy
dDoKPiAgCWNsa19idWxrX2Rpc2FibGVfdW5wcmVwYXJlKHBjaWUtPm51bV9jbGtzLCBwY2llLT5j
bGtzKTsKPiAtCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShwb3J0LCB0bXAsICZwY2llLT5wb3J0
cywgbGlzdCkgewo+IC0JCXJlc2V0X2NvbnRyb2xfcHV0KHBvcnQtPnBlcnN0KTsKPiAtCQlsaXN0
X2RlbCgmcG9ydC0+bGlzdCk7Cj4gLQl9CgpIaSwgRmVsaXgKCklmIHJlbW92ZWQsIGluIHRoZSBk
d19wY2llX3Jlc3VtZV9ub2lycSBmdW5jdGlvbiwgaWYgdGhlIGV4ZWN1dGlvbiBvZiAKInBjaS0+
cHAub3BzLT5pbml0KCZwY2ktPnBwKSIgZmFpbHMsIHRoZSByZXNvdXJjZXMgd2lsbCBub3QgYmUg
cmVsZWFzZWQuCgpLaW5kIHJlZ2FyZHMsClNlbmNodWFuCgo+ICAKPiAgCXJldHVybiByZXQ7Cj4g
IH0KPiBAQCAtMzQ3LDE4ICszNDMsMTcgQEAgc3RhdGljIGludCBlc3dpbl9wY2llX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gIAlyZXQgPSBkd19wY2llX2hvc3RfaW5pdCgm
cGNpLT5wcCk7Cj4gIAlpZiAocmV0KSB7Cj4gIAkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gaW5p
dCBob3N0XG4iKTsKPiAtCQlnb3RvIGVycl9pbml0Owo+ICsJCWdvdG8gZXJyX3BtX3J1bnRpbWVf
cHV0Owo+ICAJfQo+ICAKPiAgCXJldHVybiAwOwo+ICAKPiAgZXJyX3BtX3J1bnRpbWVfcHV0Ogo+
ICsJcG1fcnVudGltZV9wdXQoZGV2KTsKPiAgCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShwb3J0
LCB0bXAsICZwY2llLT5wb3J0cywgbGlzdCkgewo+ICAJCXJlc2V0X2NvbnRyb2xfcHV0KHBvcnQt
PnBlcnN0KTsKPiAgCQlsaXN0X2RlbCgmcG9ydC0+bGlzdCk7Cj4gIAl9Cj4gLWVycl9pbml0Ogo+
IC0JcG1fcnVudGltZV9wdXQoZGV2KTsKPiAgCj4gIAlyZXR1cm4gcmV0Owo+ICB9Cgo=
