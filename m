Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1961B85F8
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785662245; cv=pass; b=XESxmBH2+NY0NTrG5GcgdYe8kmJaHfzKrxbWajSqYRqI3KOfOmZ+dEWJn58iq7bbHGlvq9B5Q+6YU9cGouHBkfkQYUgnytqYknaGQiKd/1HvxqsxGbFkrloVQ8yDS+aEmq1cYHdoCXwtDj/E2PlM/xh1qswu+xneeeyGGhRog2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785662245; c=relaxed/simple;
	bh=++NMWt5Q5eh68RQ2e9rXZWUs9ZxURivVCZ7hK1rq1wg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gi/p3Jq69tcfKczWJlDHuQGlmK2AJsYw3kJtixSpueVFC2EE3TDsGRvZpPWiqyAii+4CF/tDNr23GjtDVk+YOnrFOHXW/OyCOBavPEAW8JxDvWC1VFfKJNJYLQdUM8jlgSHDgVjxMWd88ojdVacjn3Vq2dxcgii+rBfa6O9mZg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baTx0Lph; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baTx0Lph"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8efb708b1a0so15180186d6.3
        for <linux-pci@vger.kernel.org>; Sun, 02 Aug 2026 02:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785662243; cv=none;
        d=google.com; s=arc-20260327;
        b=s2bu4/OipMo8VWgFk1pKUIxl9fGy0ZlTUANX9ouwigLnX8ks5zO10qWXXESN/dH94a
         y8O9xGuBtZJBbVqoKMqpyAxVfdUksnpIUJRjwqScRZPMCkCR4X62hMX3wxABipvW6BzW
         tPxxl8bsOc3DMtb9jagstW/zdOKtB4cYBLMEuhJoe4wlpNNCIBi9Lnic7qyCio8QNTWE
         3wH2NNPdtZLrbgEyWuyUmggX0bnDxrZ0Xe1+jkBOhZW3bOxqgPGZlP0qXfra9R2q7hVW
         JtrQoqyDSF6aYF3MMB6pzwdaVygWk2XxfzaFiJaXH1lLIpur8TflJhFpzna7h9E2kinP
         4Lnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=L6dVF6RCsrZ9MwIxoWLpwti9YFR9InEA7KtCxlu22T8=;
        fh=EfujMstWYmdFvPeCBAhLBiPi7yWFoNM15oJi8Rh/J0k=;
        b=Fb3duB5aJaTSe8/ckJ4wiuR7+BEcAwEEdXqV5yw+bSLX1TVfylMEl0bLju/GPR6pHV
         NsX8OR86w/lLvRqcLPj6oarbYjSIHBTD/33THTlRTEKMc/chN56eZcf6aAbPgps3IV5L
         ni4VYHQNV5G172WOXrok3tFihwONLJB5SAOxs94TEYlEKvSLVOHL9IE9BuBtd4NyVF7U
         OHf1D1+WoofKsgzr1g7VcLgi0J5K+8dWA8ZMyYtvtpTkvnjligsykHa9vZqdFAiQnxJK
         /W79/aDeifhQzSgbUOn5mUGbVIoLC7lsz/qMnplZqbE2HZbqf2t1+I+vKf2+/CMKCrmO
         jclQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785662243; x=1786267043; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=L6dVF6RCsrZ9MwIxoWLpwti9YFR9InEA7KtCxlu22T8=;
        b=baTx0LphMfipecfF8nou6qsX5NxrBL96/P7iobnMQfgYpxbJCloRL7i/jtboHow0hC
         837blqkIbfqNPWE0LU85OJkLj3u17xX430PjO5MULXtDPNb32jnbeCFIlfipbiIwqirq
         MJKQg4NcwVTUWFn8bt7dhq/tHrkBUTwxixh5/RX/WONrd+ZmsRM0mwVfphfkOdfXtO36
         AUUk2uefPwLSNF3UIMA1SlN8COeNFPAWlwnTCMskCDtiYf0tuiJ/e4VqUcOunVvzBSzG
         CZNSV+kJdxI0SgSuXRRYgjgRtj4Hrwt3oXPAu9tXJ/FkXg/Xs2mixEKTHfgVCuJDcWdb
         bZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785662243; x=1786267043;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L6dVF6RCsrZ9MwIxoWLpwti9YFR9InEA7KtCxlu22T8=;
        b=iETHcGlA01yq4VkPkvvWXY1cf58vnPMvwHxtg8P17bqAk0AMTM2x19OpSDVRLLvIym
         HiI3ZCwPa/PDk+/pEvSlnfPaxWzeYoaZPQ/i8u8KNraE2FPWTAv8g8MyWuZR2ZdvIK7T
         y1Alfl0QsX6AamHML0tRgKVDk8vil04cROHXnDj8MQQSiYpPXg7IFYEUoMPV6mtdadBQ
         Hf8VcoFaAdmcNgHCv88NYHN8tV/DYRs4a5REA8aG9jk0GKiyNhFwAuPhxvyjUNtiNw9D
         8dLiTy61JgG58nUYOB3VABtwhzW6zttGVfWBcLfNYnPvYfapsBLkP9SCvg+6rDhF2Ve2
         9Q6g==
X-Gm-Message-State: AOJu0YzYDkr9KT6yk6HzCO/RHqALT5p/7Utylgfm7AR96gQld1qtxwlF
	MmEueoSC0DV/t4eN4LctEnDzkl5uB6AF4Z6wZmak25lopw23ncs5e7kWallYSAHA3qS3X7fPJLP
	//www6LEbfASpQp88wGsPS1ln1vGx0EyHI7f5
X-Gm-Gg: AR+sD10wbyCIFSTnSKjq8/Ro2s63dtwkmnm886t1D/5J9wTQkoLkTea/AHOy6hrHUoR
	Fa4o117Vf/lmLNJQrnDYX3hfRdii+TQ5J0AvPJx/wSqH7tO5mcU3YbTxULq+VtLWQrdii5Zr9MG
	WQR5l7M2STyofMC9mXOAmcKxRVDnA0hmamLok6lJr0gkcMbwjirQT7k23pbUh5Bljj+AWbU8uca
	a/JLxn/E0MGcWKCjmRiPG3gj+IQqA7MqMkNkxKt0qc7mkoITtMYHAKx9CLO09h0pGXGlztI3r0R
	B9LXjt9trfBzc14r/iMGvXFyoSGFb8XcUMLkqrbfsAEKXqCwVSShV7sLkR4BsGG3I3qI7otNQ0z
	D
X-Received: by 2002:a05:6214:450d:b0:8ea:10f8:ae87 with SMTP id
 6a1803df08f44-908495753f4mr130405246d6.11.1785662242749; Sun, 02 Aug 2026
 02:17:22 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 2 Aug 2026 02:17:22 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 2 Aug 2026 02:17:22 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ego RRR <egorkara@gmail.com>
Date: Sun, 2 Aug 2026 02:17:22 -0700
X-Gm-Features: AUfX_mysp6yZ2ceNoowFqJFJIs40jVG3_td-rlEcnF0BkMv9A4exMxF1RIkGOEM
Message-ID: <CAPbDjBakdW2DdVoegF94Hk8w83oh4X1nCF8brQ7H8S1UZJwbng@mail.gmail.com>
Subject: [PCI] AMD RX780/RD790 root port and RX 6600 upstream bridge train at
 Gen2 x2; RX 570 reaches Gen2 x8 in the same slot
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am requesting guidance on a reproducible PCIe link-width interoperability
problem involving an old AMD RX780/RD790 root port and an AMD Radeon RX 6600.
This is not yet claimed to be a Linux regression: the evidence currently
localizes the problem to link training on one external hop.

Hardware
========

Motherboard: MSI 870-C45 (MS-7599)
Chipset: AMD 770 / SB710; GFX root port identified as RX780/RD790
BIOS: AMI V1.15, 2011-03-04
CPU: AMD Phenom II X6 1055T
GPU under test: ASRock Radeon RX 6600, Navi 23 [1002:73ff]
Control GPU: Radeon RX 570, Ellesmere [1002:67df]

Linux environments tested
=========================

* Gentoo LiveCD, Linux 6.18.38, with amdgpu not loaded or bound
* gentoo-sources 6.18.39 custom kernel
* Gentoo distribution binary kernel 6.18.39

RX 6600 topology and observed links
===================================

00:02.0 [1002:5978] AMD RX780/RD790 root port
  LnkCap: 5.0 GT/s, Width x16
  LnkSta: 5.0 GT/s, Width x2

01:00.0 [1002:1478] AMD upstream port of the GPU PCIe switch
  LnkCap: 16.0 GT/s, Width x8
  LnkSta: 5.0 GT/s, Width x2

02:00.0 [1002:1479] AMD downstream port
  LnkCap/LnkSta: 16.0 GT/s, Width x16

03:00.0 [1002:73ff] Navi 23 GPU endpoint
  LnkCap/LnkSta: 16.0 GT/s, Width x16

Thus the affected external hop is 00:02.0 <-> 01:00.0. Its common maximum is
Gen2 x8. The internal 02:00.0 <-> 03:00.0 x16 link is healthy and must not be
confused with the external card interface.

Control result with RX 570
==========================

Using the same motherboard, physical slot, Gentoo LiveCD and Linux 6.18.38:

00:02.0 [1002:5978]
  LnkCap: 5.0 GT/s, Width x16
  LnkSta: 5.0 GT/s, Width x8

01:00.0 RX 570 [1002:67df]
  LnkCap: 8.0 GT/s, Width x16
  LnkSta: 5.0 GT/s, Width x8

This demonstrates that the board/root port/slot and this Linux environment can
operate at least eight lanes. The reduced width follows the RX 6600 or the
specific RX780/RD790 <-> [1002:1478] pairing.

Early and repeated observations
===============================

* pci=earlydump on the custom kernel captured root-port LnkSta 0xf022,
  corresponding to Gen2 x2, before normal driver initialization.
* Current root-port LnkSta remained Gen2 x2.
* The result was stable for 72/72 samples after a cold boot and 12/12 samples
  after complete power removal and reseating.
* No AER errors were reported, but this does not prove that unused lanes are
  electrically functional.
* The RX 6600 produces video and remains stable at x2.

Experiments already completed without improvement
=================================================

* normal PCIe link retrain;
* an early kernel retrain before amdgpu;
* Gen1 -> Gen2 target-speed cycle;
* Secondary Bus Reset;
* amdgpu PCIe DPM state changes.

Each completed with the external hop still at x2. A Link Disable experiment
hung during early PCI enumeration and must not be repeated.

AMD RD790 indirect register observation
=======================================

PCIEIND_P_A2 = 0x00000226

Decoded from related AMD documentation/source material:

* intended/target width code: 6 (x16 at the root port);
* trained/current width code: 2 (x2);
* renegotiation support: 1;
* renegotiation enable: 0;
* upconfigure support: 0.

No width value was written. A forced vendor-register write is intentionally
not being attempted because current width is below intended width and the
platform does not report upconfigure support.

Questions
=========

1. Is there a known interoperability erratum or quirk for the AMD
   RX780/RD790 [1002:5978] root port paired with AMD [1002:1478]?
2. Is there any upstream-supported read-only diagnostic that can identify why
   lanes 2-7 fail to become active during initial training?
3. Would a PCI quirk be appropriate here, or does the early Gen2 x2 state make
   this a firmware/electrical issue outside Linux control?
4. Which exact config-space dumps or traces would maintainers like next?

I can provide full lspci -vvxxx output, earlydump/current config bytes, dmesg,
kernel configurations, and the existing experiment reports. I will not repeat
Link Disable, force a vendor width register, or run additional PCI writes
without a reviewed procedure.

Thank you.
