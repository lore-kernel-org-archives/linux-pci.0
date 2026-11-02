Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793601780;
	b=aT4Gm758oaKd4ZyjJzkIyuFWB0H7FnxpFfV05JTr3XFOPcdxKWQWdZgfhZ7/6/avNqzz
	 fuvX/yJrsWV6uL0ZqveAgjPfLWTc49SG4zYPnGOpvkA3qj8RlvYwWCML2WIHYpQL71EXY
	 1uwZ7iR4f8E2Y5fqLzr4IDAaddRQKWgpysFqyNILIq/aIXcVYRZ2ZJIrn/DICtjdHHPJl
	 mA6OYPyHExPQxzZfD4kYXkgJwQiNUPwcxkzTNQZmefbaAqKifLNw8WzjycbauZn4TINAE
	 g02tUbx5Q2JwLm1s6M728L2zGT08abhnTkGeXrSEw1w29e98DHl4Dgs4W+g8dBjzK5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601780;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:X-Priority:
	 X-Mailer:X-NTES-SC:Content-Transfer-Encoding:Content-Type:
	 MIME-Version:Message-ID:X-Coremail-Locale:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=kWZoFVAL8CDALinsDEDFexHPLbiz0T0JfrbwWbplEnM=;
	b=SQPVWh5AAKB5pgPxFVSXJo19RuXrR7LE6Sez2qDiYTsaQhfgKBIHYnEfCl8o4Hk8SM56
	 taeycS6k0YAG0YqZSJCcSKYvr/MpaEnHO5lK9FTp/7XQqMe5XgG3W42FffaNqSkdzVgcj
	 8vMiC6DlgnqQh5GxhviqnitvUzxvbHLe0cjGtl2jl8wKYXPavenpNrTmh9yibol8zaUOO
	 VqZcGUir+e8pY//wYGnggy0T7ltP6sdT0bmGccsivpp/g7eHKZkyuxpvl4i6aNEx0JQdi
	 KkCisHk4YBmTV9p6M02Kj1ii35EEud++zUX/g2+h5XNmh5vBha6+96HspHAnoZmx6tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=Pyu4MBZu;
	arc=none smtp.remote-ip=117.135.210.7
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E545B606A324;
	Mon,  2 Nov 2026 06:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E545B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=Pyu4MBZu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=kWZoFVAL8CDALinsDEDFexHPLbiz0T0JfrbwWbplEnM=; b=P
	yu4MBZuZilzTMEmyy9k+wjS5vwUUlyFBHaep/RQdfwZ09ZsEG25LJ66na194GPmg
	K07VZw1WVOPWXUbY7neiD41EMYC7fTQ6O2IjRnc/Qgu0oWHYN2vPa12GN90WRQNo
	lgz7CpHvb7j90drTRI8VJxTyVQjh3CV0wHvJCAPg8E=
Date: Mon, 2 Nov 2026 14:42:31 +0800 (CST)
From: "Jing Lv" <lvjing_421@126.com>
To: Helgaas <bhelgaas@google.com>, Gunthorpe <logang@deltatee.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI/P2PDMA: Add HYGON to pci_p2pdma_whitelist
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 126com
X-NTES-SC: AL_Qu2SAfqbvk8u5yaYbOkfmUwVj+k3XsqxuP8i24VXP5p6jAnj4Dw8b2RTOEXczNyWGy+QnRm5Vxhh19RTdLhgYLkgTk2JhXMcdXJLdD+kWBEA8g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <3ead5562.4f02.1a19afeca3e.Coremail.lvjing_421@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cSkvCgDHn8HXMOhq4E9aAA--.13638W
X-CM-SenderInfo: poymx0tjbujia6rslhhfrp/xtbBqBcWo2roMNdIvAAA3b
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpEZWFyIEJqb3JuIGFuZCBMb2dhbiwKCgpJIGFtIHdvcmtpbmcgb24gSHlnb24gQzg2LTRHIChP
UE46IDc0OTApIHBsYXRmb3JtIHdpdGggVWJ1bnR1IDI0LjA0LjQgTFRTIChHTlUvTGludXggNi44
LjAtNTMtZ2VuZXJpYykuIEl0IGhhcHBlbnMgY3Jvc3MtYnJpZGdlIHAycGRtYSBiZXR3ZWVuIEdQ
VSBhbmQgU1NEIGlzIG5vdCBzdXBwb3J0ZWQuIFdpdGgge1BDSV9WRU5ET1JfSURfSFlHT04sIDB4
MTQ4MCwgMH0gYWRkZWQgaW4gc3RydWN0IHBjaV9wMnBkbWFfd2hpdGVsaXN0LCB0aGVyZSBpcyBu
byBwcm9ibGVtLiBJIG5vdGljZSB0aGVyZSBhcmUgc2ltaWxhciBjb2RlIGNoYW5nZXMgcmVjZW50
bHksIGUuZy4sICJbUEFUQ0hdIFBDSS9QMlBETUE6IEFkZCBaaGFveGluIGhvc3QgYnJpZGdlcyB0
byB3aGl0ZWxpc3QiIGFuZCAiW1BBVENIXSBQQ0kvUDJQRE1BOiBBZGQgQWxpYmFiYSBULUhFQUQg
WWl0aWFuIDcxMCB0byB3aGl0ZWxpc3QiLiBJdCB3b3VsZCBiZSBhcHByZWNpYXRlZCBpZiB0aGUg
Zml4IGNvdWxkIGJlIG1lcmdlZCB0byB0aGUgbGludXggcmVwbyAtLSBwbGVhc2UgaW52b2x2ZSBI
eWdvbiBpbiB0aGUgY29tbXVuaXR5IGlmIGFwcHJvcHJpYXRlLgoKCgpXaXRoIHJlZ2FyZHMsCkpp
bmcKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcDJw
ZG1hLmMgYi9kcml2ZXJzL3BjaS9wMnBkbWEuYwppbmRleCAwYzM2MTU2MWI4NTUuLmU2NmZiN2U3
MWJkYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvcDJwZG1hLmMKKysrIGIvZHJpdmVycy9wY2kv
cDJwZG1hLmMKQEAgLTQ0Miw2ICs0NDIsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9wMnBk
bWFfd2hpdGVsaXN0X2VudHJ5IHsKwqAgwqAgwqAgwqAge1BDSV9WRU5ET1JfSURfSU5URUwsICAg
MHgyMDMzLCAwfSwKwqAgwqAgwqAgwqAge1BDSV9WRU5ET1JfSURfSU5URUwsICAgMHgyMDIwLCAw
fSwKwqAgwqAgwqAgwqAge1BDSV9WRU5ET1JfSURfSU5URUwsICAgMHgwOWEyLCAwfSwKKyAgICAg
ICAvKiBIeWdvbiBDODYtNEcgKE9QTjogNzQ5MCkgKi8KKyAgICAgICB7UENJX1ZFTkRPUl9JRF9I
WUdPTiwgICAweDE0ODAsIDB9LArCoCDCoCDCoCDCoCB7fQrCoH07Cg==
