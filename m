Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244EA19005E;
	Tue, 25 Aug 2026 03:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.187.6.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787629332; cv=none; b=idR5UPdjdRhay/XYuL9+FTU9ok3KCi8zszy1xe61ewNwwLI5KFtCwoWuaKfeIiko6kgi7yppHKpVw1QaKnn/KzfM9B9Qb3KhX0NaniHC6o9tneZLCP+YrjQGCp02vKTX+/E6YOP3RO78WmkI9deuAUDW3Op88ilF6ftBv5LY6B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787629332; c=relaxed/simple;
	bh=9+wxAUbxXOhaGnnNc22FC2GwrZlcxh/cMh2SUy1Kg8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=RVQbfnQcnZ7gvwUVUSCuKfLnXAwOGNLdrCtMyf7tHFJXS9fH37sD2DCVnPzhBlaEDus9V87qRZUHAF0lRC3Hq3J2h/PbNUT+wFYXK72BCvulBglQrlhZTXM8G9ffeOZF9sc7XrBs2z5HJhvT6reXQeg0U/DMHLe3xFSR9tEM1JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=fail (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=mqKhTOdv reason="key not found in DNS"; arc=none smtp.client-ip=52.187.6.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="mqKhTOdv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:Date:From:To:Cc:Subject:
	In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID; bh=sXpzDOVNbcpvTpa32Roi4D3Zaqx1xY2FtIGi
	ZM8sDIg=; b=mqKhTOdvAV2Xy0DSVos7vaIYc9pLXF5Zfh9rDzz//y4Q3sGjiQe8
	JHKA07ZyReFBDEcl7cm9EzYKmotB2HTv31rOhSRJdXXqk0JgfNFHC6Hng8iCPKsg
	RoRmieAltZVaUHIzpZ3Wt8JXb/KF+5GwXYpGbNhVsAGhcvoS8w0W2nQ=
Received: from engguopeng$buaa.edu.cn ( [180.167.85.126] ) by
 ajax-webmail-coremail-app1 (Coremail) ; Tue, 25 Aug 2026 11:41:44 +0800
 (GMT+08:00)
Date: Tue, 25 Aug 2026 11:41:44 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: engguopeng@buaa.edu.cn
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org,
	johnny.li@montage-tech.com, peng.guo@montage-tech.com,
	jingzhong.yang@montage-tech.com
Subject: Re: [PATCH v2 2/2] cxl/core: Skip non-CXL capabilities in MCAP
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20240305(0ac2fdd1) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-63b7ebb9-fa87-40c1-9aec-818ec5a006d9-buaa.edu.cn
In-Reply-To: <20260821190122.54fb48f0@jic23-huawei>
References: <20260817075854.17207-1-engguopeng@buaa.edu.cn>
 <20260817075854.17207-3-engguopeng@buaa.edu.cn>
 <20260821190122.54fb48f0@jic23-huawei>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <667d17a4.6865.1a037027b82.Coremail.engguopeng@buaa.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID:OCz+CgCnRlP4Do1qavivAA--.13482W
X-CM-SenderInfo: d2isijirrujqpexdthxhgxhubq/1tbiAQIKAGdDD6YXagAAs5
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

Ck9uIEZyaSwgMjEgQXVnIDIwMjYgMTk6MDE6MjIgKzAxMDAKSm9uYXRoYW4gQ2FtZXJvbiA8amlj
MjNAa2VybmVsLm9yZz4gd3JvdGU6Cgo+IEhpIFBlbm4sCj4gCj4gSSdtIGEgYml0IGxvc3QgdG8g
d2hhdCBpcyBnb2luZyBvbiBoZXJlLiBTbyBiYXJlIHdpdGggbWUhCj4gSSB0aGluayB0aGUgdXBz
aG90IG9mIHRoZSBmb2xsb3dpbmcgaXMgd2UgbmVlZCBhIGxpdHRsZSBtb3JlIGluZm8KPiBpbiB0
aGlzIHBhdGNoIGRlc2NyaXB0aW9uLgo+IAo+IElmIHRoZSBwcm9ibGVtIHlvdSBkZXNjcmliZSB3
YXMgJ3JlYWwnIHRoZW4gd2UnZCBoYXZlIGEgYmFja3dhcmRzCj4gY29tcGF0aWJpbGl0eSBidWcg
aW4gdGhlIENYTCBzcGVjIGFuZCB0aG9zZSBmb2xrIGFyZSBub3JtYWxseQo+IHByZXR0eSBnb29k
IGF0IGNhdGNoaW5nIHRob3NlIQo+IAo+IFRvIHNvbWVvbmUgd2hvIGRvZXNuJ3Qga25vdyBob3cg
TUNBUCBhbmQgQ1hMIHdlcmUgbWFkZSBjb21wYXRpYmxlCj4gKG9yIGxpa2UgbWUgZm9yZ290ISkg
aXQgaXNuJ3Qgb2J2aW91cyB0aGF0IHRoZSBub24gQ1hMIGNhcGFiaWxpdGllcwo+IGNhbiB0dXJu
IHVwIHZpYSB0aGUgQ1hMIGNhcGFiaWxpdGllcyBzdHJ1Y3R1cmVzIC0gaGF2aW5nIHJlcmVhZAo+
IHRoZSBzcGVjIHNlY3Rpb25zIEknbSBub3Qgc3VyZSB0aGV5IGNhbi4KPiAKPiBBIHJlZmVyZW5j
ZSArIHNvbWUgdGV4dCBmcm9tIHRoZSBpbXBsZW1lbnRhdGlvbiBub3RlIGluIENYTCB2NC4wIDgu
Mi45Cj4gQ1hMIERldmljZSBSZWdpc3RlciBJbnRlcmZhY2Ugd291bGQgYmUgaGVscGZ1bC4gIFRo
ZSBwaWN0dXJlIGluCj4gRmlndXJlIDgtMTIgZm9yIGluc3RhbmNlIGltcGxpZXMgeW91IHNob3Vs
ZCBuZXZlciBzZWUgbm9uIENYTCBjYXBzCj4gaGVhZGVycyB2aWEgdGhlIHRoZSBDWEwgcmVnaXN0
ZXIgYmxvY2sgcGF0aC4KPiAKPiBZb3UgYXJlIGFsbG93ZWQgdG8gYWxpYXMgdGhlIGRlc3RpbmF0
aW9ucyBvZiB0aGUgKHNvcnQgb2YpIHBvaW50ZXJzCj4gaW4gdGhlIGNhcGFiaWxpdGllcyBhcnJh
eSwgYnV0IG5vdCB0aGUgaGVhZGVyIHdpdGggdGhlIHBvaW50ZXJzCj4gaW4gaXQuCj4gCgpIaSBK
b25hdGhhbiwKClRoYW5rcyBmb3IgdGhlIGRldGFpbGVkIHJldmlldy4KCkkgbmVlZCB0byByZXZp
c2l0IHRoZSByZWxldmFudCBzcGVjaWZpY2F0aW9uIHNlY3Rpb25zIGFuZCBpbnZlc3RpZ2F0ZSB0
aGUgCmRldGFpbHMgbW9yZSBjYXJlZnVsbHkuCgpQbGVhc2UgY29uc2lkZXIgdGhpcyBwYXRjaCBz
ZXJpZXMgd2l0aGRyYXduIGZvciBub3cuCgpCZXN0IHJlZ2FyZHMsClBlbm4K
