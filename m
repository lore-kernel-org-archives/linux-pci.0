Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5829F2FD1AA;
	Thu, 20 Aug 2026 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787193412; cv=none; b=ACPMyfPHsAkhJFUOFm6NnMQRkgka5P8Mx8rJTxNvuWymHhsGik15SZpph5p5gGsGpeV5itWmtDvaGUj3yoH/fRtBdoO/LDztm614/Xj/sOb5rl7o61y5zAiOdo7Q6heIZbFJGwjPzr7M8r8pTRTh2J5rL4/RDWhUx//mn3C2SKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787193412; c=relaxed/simple;
	bh=/N6IPX6nX4Bfm6REEFV8JHeJDp+25v3d9KgBAZ14Q2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=EpkSFA7Y1hvg8SqdIinFX4SdgAevooij70Y0MwlIto2CElzLdIuvvqf7uPyf/05D8hmqWY+m2CYfjkXENY4NuTwmcXocHcoeWAwC+hJjE+LBOOu8+X+7x4Jk6a+Qw3JyI6L0vNruZhmAPDQ/FwnTtNiVIlzOJ5+FzE5YKiEaTOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=fail (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=yRqEMnC1 reason="key not found in DNS"; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="yRqEMnC1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:Date:From:To:Cc:Subject:
	In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID; bh=mMt5Vvl0GgRHM+z+JCBC6qQlSsKC1u1SqfUb
	sN18njM=; b=yRqEMnC1ieJBSWiYb+68ApIuy893qLRx1mEi8pEilrwnEicrOwBB
	PkObZAeIzLhcU45sxDXAGHBXBPAb3ztYtGH9+SAeJ03RvqeYTqe2mX7zzXTDCG27
	bYmr6nsuEVBuqf40ac/CAzuCBxjcA3mNgyYQ7yolF8DQs0qlBZVUBis=
Received: from engguopeng$buaa.edu.cn ( [180.167.85.126] ) by
 ajax-webmail-coremail-app1 (Coremail) ; Thu, 20 Aug 2026 10:36:31 +0800
 (GMT+08:00)
Date: Thu, 20 Aug 2026 10:36:31 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: engguopeng@buaa.edu.cn
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com, dave@stgolabs.net,
	jic23@kernel.org, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org,
	johnny.li@montage-tech.com, peng.guo@montage-tech.com,
	jingzhong.yang@montage-tech.com
Subject: Re: [PATCH v2 2/2] cxl/core: Skip non-CXL capabilities in MCAP
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20240305(0ac2fdd1) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-63b7ebb9-fa87-40c1-9aec-818ec5a006d9-buaa.edu.cn
In-Reply-To: <7a8f49cf-2254-47c5-a4d2-c4f9387358db@intel.com>
References: <20260817075854.17207-1-engguopeng@buaa.edu.cn>
 <20260817075854.17207-3-engguopeng@buaa.edu.cn>
 <c01709c9-4c3b-4ced-9635-72947807c301@intel.com>
 <56e8d5aa.4be5.1a017a28956.Coremail.engguopeng@buaa.edu.cn>
 <7a8f49cf-2254-47c5-a4d2-c4f9387358db@intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3cf66cad.515e.1a01d06f9bd.Coremail.engguopeng@buaa.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID:OCz+CgCnRlMvaIZqD62YAA--.11142W
X-CM-SenderInfo: d2isijirrujqpexdthxhgxhubq/1tbiAQIFAGdDD6SRMAABsp
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

CgpPbiBXZWQsIEF1ZyAxOSwgMjAyNiBhdCAxMTowOSBQTSBEYXZlIEppYW5nIDxkYXZlLmppYW5n
QGludGVsLmNvbT4gd3JvdGU6Cj4gU291bmRzIHJlYXNvbmFibGUuIERvIHlvdSBoYXZlIE1NUFQg
c3VwcG9ydCBzdWJtaXR0ZWQgdG8gdXBzdHJlYW0gZm9yIHRoZSBQQ0kgc3Vic3lzdGVtIHlldD8g
SSdtIGN1cmlvdXMgYmVjYXVzZSB0aGVyZSBhcmUgY2VydGFpbmx5IHNlY3VyaXR5IGNvbmNlcm5z
IG9mIGFuIG9wYXF1ZSBwaXBlIGZyb20gZGV2aWNlIHRoYXQgdGhlIGtlcm5lbCBoYXMgbm8gdmlz
aWJpbGl0eSB0by4gVGhlcmUgd2lsbCBjZXJ0YWlubHkgYmUgc2VjdXJpdHkgcHVzaGJhY2sgb24g
dGhlIGVuYWJsaW5nIGZyb20gdGhlIGtlcm5lbCBjb21tdW5pdHkgd2l0aG91dCBzb21lIHByb3Rv
Y29sIGluIHBsYWNlIHRvIGVuc3VyZSB0aGUgZGF0YSBiZWluZyB0dW5uZWxlZCB3aWxsIG5vdCBy
ZXN1bHQgaW4gbWFsaWNpb3VzIGFjdGlvbnMuCj4gCj4gREogCgpObywgTU1QVCBzdXBwb3J0IGhh
cyBub3QgYmVlbiBzdWJtaXR0ZWQgdXBzdHJlYW0geWV0LCBhbmQgSSBoYXZlIG5vdApsb29rZWQg
aW50byB0aGUgc2VjdXJpdHkgaW1wbGljYXRpb25zIGluIGRldGFpbC4gVGhhbmsgeW91IGZvciBw
b2ludGluZwp0aGlzIG91dC4KCkkgd2lsbCB0cnkgdG8gaW52ZXN0aWdhdGUgTU1QVCBzdXBwb3J0
LCBpbmNsdWRpbmcgdGhlIHNlY3VyaXR5IGNvbmNlcm5zCnlvdSBtZW50aW9uZWQsIGJlZm9yZSBj
b25zaWRlcmluZyBhbiB1cHN0cmVhbSBzdWJtaXNzaW9uLgoKVGhhbmtz
