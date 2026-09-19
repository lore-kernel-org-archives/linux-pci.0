Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0338431F9B9
	for <linux-pci@vger.kernel.org>; Sat, 19 Sep 2026 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850013; cv=none; b=Lj2dx0qGboGu8WZWACvf1I1dsLbGns7AG8ZMtWevPjnryVX0OGvrEPOKatjhs/Bg8oO+jSVwXvd0sM1o9p4EHviPFENorlxQWegonpwM2FMECbeygDHo2i8UUQy6H6Bt0zPsHtqzCMkA0DQx6eUMhsQbqO5BzlbSRih6edU0+jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850013; c=relaxed/simple;
	bh=ToIFuHGX1qXvaY4UgTm2hHa9eEtMZ5+1iK5QEs1EMb0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LIFdOVCEAMNVn6O+ZWfNPuiDpYi1f/enczZG72kAR74V8J0WxQMjxAER91TZN+vA/YAyuCSOuSPgangJV+MBDdQHNUOQSaz9yi2zk5cWMkJWzOc7lFcLC4ruYYRq0RMRwvVjWByPI0ECMvIJSoSg7CS1K8WYG9gqd27qyTD7ftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=OQP2o63H; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="OQP2o63H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1789850003; x=1790109203;
	bh=ToIFuHGX1qXvaY4UgTm2hHa9eEtMZ5+1iK5QEs1EMb0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OQP2o63HKIa9klgE/uT/7h2DvJ5o79pdRclnqQ6hmnivZ6rPbglHOBm0Lilg0zGFw
	 VBIAdvixzcbqQs9tHcKX9XFN+XM2tCmeJaA0p99uFcytTDOQIF701qPPO+zWexIM6z
	 9QrXeBUHp/i6I5cDGc65VLAtGlvUY8kiLslv8bKvRoWiRYnfxly/659xHA3aZpOjTQ
	 8+gEV1WVSugjvIXFOqitG5x+11ZToGCzMG/qEWxqIFwVe0+hRpCjLx/MR3AS7i1WPH
	 q2ZPJWP7wHtw8Set7s7WWzPu5Vj9BZS2vlrLxEJvW8GtRmbNoxS6XTzqirvF8Pq/nb
	 g0uvBng7M6Anw==
Date: Sat, 19 Sep 2026 20:33:20 +0000
To: "mani@kernel.org" <mani@kernel.org>
From: Birk Skyum <birk.skyum@pm.me>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: X1E80100 USB4 PCI0 MSI-X routing under EL1/Gunyah
Message-ID: <g7V4kc2AO9xogkH0h-XHDvPbjDXcnS11cp1q3hv0X96KPW-zed6V79HUJY5BFA4pBWUE-p2MBYCeDcjWwUGBIU2hXjDpodiWaxB38obe8RE=@pm.me>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 0b1b2cde094082b5a5cccb1b9677588f86d49931
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Mani,

I'm working on experimental USB4 support for the Lenovo Yoga Slim 7x
(83ED, X1E80100), building on Jim Martin's published Glymur stack. This is
an out-of-tree bring-up, not a regression report against mainline.

A directly connected LaCie Rugged SSD4 negotiates USB4, enumerates through
a PCIe tunnel and completes a 4096-byte read into RAM. However, NVMe
completions are recovered through timeout polling, with zero
device-generated interrupts recorded.

MSI-X is enabled and unmasked, and the table matches Linux's programmed
messages. Software ITS INT commands reach the NVMe handlers. In a
separate test, redirecting one MSI-X vector to owned coherent RAM
captured the expected endpoint payload, but that does not prove delivery
to the ITS.

The endpoint RID is 0x0100. The captured firmware IORT and our DT agree
on DeviceID 0x80100, with MSI address 0x17050040 and event data 0/1. The
PCIe SMMU remains firmware-owned.

Source and test results are published here:
https://github.com/birkskyum/yoga-slim7x-usb4

Is direct ITS delivery the intended route for USB4 PCI0 under EL1/Gunyah?
Is additional controller forwarding or DeviceID setup required?

I also found the QCS8550 change using the internal DWC MSI receiver to
avoid a Gunyah limitation:
https://github.com/torvalds/linux/commit/33cae252054a694269f9dcd41b35406319=
3c8f59

I realise that involves different hardware and symptoms. If an internal
receiver is appropriate for X1 PCI0, where can I find its parent IRQ and
required initialization?

I can test a targeted change on the Yoga and publish the results.

Birk
