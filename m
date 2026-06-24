Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9424638A715
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286211; cv=none; b=qVbpeHzmBrRw6M+BPjfR94YSJ0CNjyJnbrkQGos3h1HbaxhgCjVAMTXQWnGTGH3f0gDd1N8OuB07PxPp+ZR2yxJlebJn0phyw9SM1VK4PMq2ayXeAH1VHlOdBhFq3aF6Cg3WA+1WojXVQXPKRgBb8QNLCBQKY1vxwRK6XMXJut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286211; c=relaxed/simple;
	bh=mIECLREcOOURCjBys9JaqEbp3tsHvBPYnC/wCHuNVDU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=pNBMps022T68RuCBOBQ5pXFEbKBKuXJpcQdtHawvkWernWJkvQGKxn6PZikvUcUfO7/52hu80hUnG6m+nse5q7xUri+eG6QcBcqxHjXAQI2Twz/VG1LzGdYpJK95/fu73xj6RhI/4h42vbjpgEqQjcq9hgteLi9tgj3NAudzlkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=In14pfLI; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="In14pfLI"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260624073005epoutp018f354d0942fbd1c345e7a698dec9ca82~789xgsLgp3251732517epoutp01z
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 07:30:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260624073005epoutp018f354d0942fbd1c345e7a698dec9ca82~789xgsLgp3251732517epoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1782286205;
	bh=hxHXRaB9uyp+RYupYTlmB3j4pwxcxTCdmXxtRJMmgmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=In14pfLIbs3g6klu9QE3UFELYMvaSqlmXBzwPrQuTuSy04Ph6Mk3/3HDQ5ouaHsrB
	 Lzg8eyutigVvXsrXtT93Y5lOgGLr1IubxPjdVHnoyAViF98C/XlLjqAj2pUR/JakuG
	 H0HKwbYlpzZO/2FCLK12DFImK79iM5sadwKMdkqQ=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260624073004epcas5p179392006951924f87e3f7b29f26419e1~789w8n06X0504505045epcas5p1F;
	Wed, 24 Jun 2026 07:30:04 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4glYVh5N15z3hhT4; Wed, 24 Jun
	2026 07:30:04 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260624072914epcas5p17ddfb515b6bce70cee2a2aa379225330~789Bur0l01803918039epcas5p1i;
	Wed, 24 Jun 2026 07:29:14 +0000 (GMT)
Received: from arun-B560M-DS3H-V2 (unknown [107.99.41.170]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260624072912epsmtip17f7006cc99eb0ef6e7a229081f5a447f~788--YnKs1800818008epsmtip16;
	Wed, 24 Jun 2026 07:29:12 +0000 (GMT)
Date: Wed, 24 Jun 2026 20:48:21 +0530
From: Shrihari E S <shrihari.s@samsung.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
	vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
	dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 7/8] hw/pci: hw/cxl: Wire SVC initialization into port
 realize functions.
Message-ID: <1316557528.121782286204742.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260617154521.520191-3-junjie.cao@intel.com>
X-CMS-MailID: 20260624072914epcas5p17ddfb515b6bce70cee2a2aa379225330
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----dRaRfFW49P0MWGzTWjnkSO4RdHzY68Yl_7ceN5kYWmJQ.fIX=_53877_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260624072914epcas5p17ddfb515b6bce70cee2a2aa379225330
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
	<20260609105836.3702787-8-shrihari.s@samsung.com>
	<20260617154521.520191-3-junjie.cao@intel.com>
	<CGME20260624072914epcas5p17ddfb515b6bce70cee2a2aa379225330@epcas5p1.samsung.com>

------dRaRfFW49P0MWGzTWjnkSO4RdHzY68Yl_7ceN5kYWmJQ.fIX=_53877_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 17/06/26 11:45PM, Junjie Cao wrote:
>Hi Shrihari,
>
>On Tue,  9 Jun 2026 16:28:35 +0530, Shrihari E S wrote:
>> +    pcie_config_uio_svc(d, errp);
>>      pcie_cap_arifwd_init(d);
>>      pcie_cap_deverr_init(d);
>>      pcie_cap_slot_init(d, s);
>
>In rp_realize() (and the two xio3130 ports) pcie_config_uio_svc() runs
>before pcie_aer_init().  pcie_svc_cap_init() falls back to offset 0x100
>when no extended capability exists yet, so SVC is placed at 0x100 at
>this point -- and then pcie_aer_init() puts AER at the same 0x100 and
>overwrites it, while dev->exp.svc_cap still points there.
>
>The visible effect is that "-device pcie-root-port,x-uio-svc=on" comes
>up with no SVC capability in the extended config space (the chain is
>just AER -> ACS), and no error is reported, so the request is silently
>dropped.  I reproduced this by walking the extended capability list of
>the root port over ECAM: SVC (0x35) never appears, even though the
>property was set.
>
>> +    rc = pcie_config_uio_svc(pci_dev, errp);
>> +    if (p->flitmode && rc >= 0) {
>> +        crp->uio_capable = true;
>> +    }
>
>On cxl-rp this runs a second time: cxl_rp_realize() first calls the
>parent rp_realize() (which already calls pcie_config_uio_svc() per the
>hunk above) and then calls it again directly.  The first call collides
>with AER at 0x100 as above; the second runs after the extended caps
>exist, so SVC ends up correctly at 0x200.  So cxl-rp happens to work,
>but via a double init.
>
>Just moving the call to after pcie_aer_init() isn't quite enough on
>its own: the CXL ports (cxl-rp/usp/dsp) build their DVSECs at fixed
>offsets and then add SVC themselves at the end, so if the shared
>parent rp_realize() also adds SVC before those DVSECs are built, the
>cxl-rp ends up with its DVSECs off the chain.
>
>What worked for me was to move the SVC call after the ECAP inits in
>the pure-PCIe paths and skip it in the parent when the device is CXL,
>letting the CXL realize functions keep adding it last as they already
>do:
>
>  - rp_realize(): move pcie_config_uio_svc() to after pcie_acs_init(),
>    guarded by if (!pci_is_cxl(d)) so cxl-rp's own call (which runs
>    after build_dvsecs()) remains the one that places SVC.
>  - xio3130_upstream/downstream realize(): move the call to after
>    pcie_aer_init().
>  - cxl-rp/usp/dsp: unchanged, they already add it last.
>
>With that, plain pcie-root-port, the xio3130 switch ports and the CXL
>ports all come up with SVC at 0x200, and cxl-rp keeps its four DVSECs.
>

Hi Junjie,

     Thank you for pointing this bug, got missed in our testing. Will check
     and move the svc_init() function properly in the next version of the patch.

>One thing to note is that this only gets the capability enumerated --
>I haven't verified the SVC behaviour beyond that.  Looking at
>pcie_svc_cap_write_config()/pcie_svc_apply_gating(), writing the SVC
>Enable bit just copies ctrl/status into the shadow struct; no VC
>Resource Status bit (the per-VC negotiation bit, SVC_VC_NEGO) is ever
>set, and the SVC Status register stays zero.  So a guest that enables
>SVC and polls for negotiation wouldn't see anything change.  If the
>data-plane series on top is expected to drive that, fine -- I just
>wanted to flag that as things stand the enable is observationally a
>no-op, in case a driver is expected to key off it.
>
>Many thanks,
>Junjie

Yeah this patch series is meant for enumeration (probe) puprpose only
and yes we have plan to add data plane support as well.

Thanks,
Shrihari


------dRaRfFW49P0MWGzTWjnkSO4RdHzY68Yl_7ceN5kYWmJQ.fIX=_53877_
Content-Type: text/plain; charset="utf-8"


------dRaRfFW49P0MWGzTWjnkSO4RdHzY68Yl_7ceN5kYWmJQ.fIX=_53877_--

