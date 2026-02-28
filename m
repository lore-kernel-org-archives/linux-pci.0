Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0461C3BFC;
	Sat, 28 Feb 2026 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772265219; cv=none; b=PEPvBhReE8F5E4ey0zrVHclWDiNDjiIv8A5Eqi4TZRTP53ilDSe83P54oK1sUNGk7ku1iYa/8U7uykMwe7yk3gM5mPT5mwMV8Ragz8rnvjYCLBk74r7uqG4zCkjLFI3xIxZ8QnNEuevkYz4U6iGcgojVlfgKDNhtWrb/FX7Sb0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772265219; c=relaxed/simple;
	bh=YcQaWVETeuorH9WRE8v62/lxkYK2PUPHzqpTlZcKWd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=eSWNH45DHzIYpIldJopt5Gha6eKLheEOytmswpgoyHh6tIgw5kVQiFybB5iAY9K/qnFwFe2QkvolEqTNz3i7S++YpU7iukK2NFQJPTjZKerYWtZ/cYY/KoarhGIuUI2MmbsWY3jCltADwXT8p3PnqHACSxgP6CZBIKX0KUrI8l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from zhangsenchuan$eswincomputing.com ( [10.12.96.83] ) by
 ajax-webmail-app2 (Coremail) ; Sat, 28 Feb 2026 15:53:09 +0800 (GMT+08:00)
Date: Sat, 28 Feb 2026 15:53:09 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: zhangsenchuan <zhangsenchuan@eswincomputing.com>
To: "Bjorn Helgaas" <helgaas@kernel.org>
Cc: bhelgaas@google.com, mani@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christian.bruel@foss.st.com, shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com, thippeswamy.havalige@amd.com,
	inochiama@gmail.com, Frank.li@nxp.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	ouyanghui@eswincomputing.com
Subject: Re: Re: [PATCH v11 2/2] PCI: eic7700: Add Eswin PCIe host
 controller driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260227171554.GA3898780@bhelgaas>
References: <20260227171554.GA3898780@bhelgaas>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <28f8d39b.3add.19ca33cb23a.Coremail.zhangsenchuan@eswincomputing.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:TQJkCgAnPqHlnqJpmGMEAA--.1105W
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/1tbiAgEMBmmhx
	4YVtQAAsg
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMSAyLzJdIFBDSTogZWljNzcwMDogQWRkIEVzd2luIFBD
SWUgaG9zdCBjb250cm9sbGVyIGRyaXZlcgo+IAo+IE9uIEZyaSwgRmViIDI3LCAyMDI2IGF0IDA3
OjE4OjA4UE0gKzA4MDAsIHpoYW5nc2VuY2h1YW5AZXN3aW5jb21wdXRpbmcuY29tIHdyb3RlOgo+
ID4gRnJvbTogU2VuY2h1YW4gWmhhbmcgPHpoYW5nc2VuY2h1YW5AZXN3aW5jb21wdXRpbmcuY29t
Pgo+ID4gCj4gPiBBZGQgZHJpdmVyIGZvciB0aGUgRXN3aW4gRUlDNzcwMCBQQ0llIGhvc3QgY29u
dHJvbGxlciwgd2hpY2ggaXMgYmFzZWQgb24KPiA+IHRoZSBEZXNpZ25XYXJlIFBDSWUgY29yZSwg
SVAgcmV2aXNpb24gNS45NmEuIFRoZSBQQ0llIEdlbi4zIGNvbnRyb2xsZXIKPiA+IHN1cHBvcnRz
IGEgZGF0YSByYXRlIG9mIDggR1QvcyBhbmQgNCBjaGFubmVscywgc3VwcG9ydCBJTlR4IGFuZCBN
U0kKPiA+IGludGVycnVwdHMuCj4gCj4gRG9lcyAiNCBjaGFubmVscyIgbWVhbiAiNCBsYW5lcyIs
IGkuZS4sIHdoYXQgd2UgdHlwaWNhbGx5IGNhbGwgYSAieDQKPiBsaW5rIj8KCkhpIEJqb3JuLAoK
IjQgY2hhbm5lbHMiIGluZGVlZCByZWZlcnMgdG8gIjQgbGFuZXMiLCBpbiB0aGUgbmV4dCB2ZXJz
aW9uIG9mIHRoZSBwYXRjaCwgaQp3aWxsIHVwZGF0ZSB0aGUgY29tbWVudHMsIGNoYW5naW5nICI0
IGNoYW5uZWxzIiB0byAiNCBsYW5lcyIuIEFwYXJ0IGZyb20gdGhpcyAKaXNzdWUsIGRvIHlvdSBo
YXZlIGFueSBvdGhlciBzdWdnZXN0aW9ucz8gTWF5IEkgc2VuZCB0aGUgbmV4dCBwYXRjaD8KCktp
bmQgcmVnYXJkcywKU2VuY2h1YW4=
