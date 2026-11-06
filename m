Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983210;
	b=OzGBZyhDNUIM/skxhxSNS0TVKWjhrQfBsUBTfk8eeTdbq/ajUSZI/w9YY9Yy8aDuFYdh
	 PVT755/nPs+FnJTfOT4JRwsOsKBQAZmA9FcxIqVM1UXvW0jBzs3pHiT9gnARWon9SR5PQ
	 HOKNPp1U1YtUwFPLaFBaS5EfXc6bHHjGL+aquNM5rDTcFwqNGBe2uaFG5Cme5vW4B4KcP
	 mv1gU+pjjKRbjx3wbLEtAiOE95ts9jpfCRmGqcAW4ejtxOssf6I04uoRA0ez85X/i9Hb0
	 jiy/WkbiPE0JXolk52S4almjFAfMLzqPHSvmiprA4fMqPVryb+D8qJeuAitQN131plA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983210;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=3od45yn4F2nDGEx105ntFBdvMs4lucUjvk02NFYGg7E=;
	b=W4vsjf7o9bR9lkunUNGYBZoeODV+mqUP1Q0VEZag7aY8AuP8dA1LcYvCyhULvCbj/LlL
	 w5UJ5y9z3RwzGKGg5X7ue6yKz47aJuYpRr2aF/mmIHGVBxk2sbNoXiAMKjbTYtpelzluX
	 dAaYAEG5pEjw468BKaxnlIGDpIQH2d3SIFscTDHsuwLHEhXudBY2NLGvEBbGTOPOpfQui
	 LKpZixK3xsNm0FlywFyEO3YzD7wW7Zoxj+yld/7j8mQvIYLrHFhcPxEgIOIitZSVJJWZt
	 O6Y3Ax03ZGoOSNiUgLXReJBHAGwRDzVvga4A5lof9YeQs75H9C3xrFy9ahIvVdBGGcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=io4X81DL;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF75606A326;
	Fri,  6 Nov 2026 16:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FF75606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=io4X81DL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793983209; x=1825519209;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=A9yIYyIHMGbPHEPoCl4HMVzQ6Gc8pcY5dH9rfk0kUx8=;
  b=io4X81DLlOtOHpiDZHuFQSuASixYV0tg6hnRSIwt2Auq6hSphwwRJfn2
   t0VgZ6FqHFbYS8DiUm0JfUhA2hmcMyb2LxGqw9Pb1JzeTawljJ7/cZj0w
   HQyKeJVn4E4GDL1Qv37jmpbIx8v0Bssru6lRGdzCsNSfaZzVbkLS2fgw+
   UhXPT3dd9agDtyVcCanW2xyOkgZIH4wirDACka7rAYXxG45zOLcggBccF
   Cy8/0h2AexBvoUDZu5l+RXH3RvaQLXvbqYWu7zP6xmRA8RjWDGt38olsM
   s7xn42l3PCw76EU9HMeqvEeWnZ5AVbM8GjVFWCw1m4wK4lyyL0VbyRFy1
   Q==;
X-CSE-ConnectionGUID: WWiojqtyQJyVaux7dOmCcQ==
X-CSE-MsgGUID: HEQMKAVoRA2H8ix+WlBtWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2841644"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2841644"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:39:52 -0800
X-CSE-ConnectionGUID: hoRGSZkBRL22ACUL0SyhqQ==
X-CSE-MsgGUID: u6kZGfpvTTmd34NIMiM5oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7648249"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:39:49 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 6 Nov 2026 18:39:45 +0200 (EET)
To: shao.mingyin@zte.com.cn
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, mani@kernel.org, 
    kwilczynski@kernel.org, lpieralisi@kernel.org, kishon@kernel.org, 
    Frank.Li@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] PCI: Reject negative resource alignment order
In-Reply-To: <20261107002311316z2o2PFtFGoXh-VbqXtTGg@zte.com.cn>
Message-ID: <89d84d22-9c75-c49b-a4f7-4682a80187d7@linux.intel.com>
References: 20261107002305850zuBaVsGBz3wbco2Ae4ScR@zte.com.cn <20261107002311316z2o2PFtFGoXh-VbqXtTGg@zte.com.cn>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 7 Nov 2026, shao.mingyin@zte.com.cn wrote:

> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> pci_specified_resource_alignment() parses the pci=resource_alignment=
> boot parameter with sscanf("%d%n", &align_order, ...) and rejects only
> orders above 63.  A negative order, e.g. "pci=resource_alignment=-5@...",
> passes that check and later reaches "align = 1ULL << align_order" with a
> negative shift count, which is undefined behavior; on x86 the 64-bit
> shift count is masked to six bits, silently producing a 2^59-byte
> alignment that mis-aligns (or fails to align) the affected IOV resources.
> 
> Reject any order outside the valid [0, 63] range and fall back to the
> default page-size alignment, matching the existing handling of
> out-of-range positive orders.
> 
> Fixes: 6534aac198b5 ("PCI: Bounds-check command-line resource alignment requests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the
> pci=resource_alignment= boot parameter and a QEMU e1000 NIC; no extra
> hardware is needed.
> 
> Booting with pci=resource_alignment=-5@pci:8086:100e parses a negative
> order that the "> 63" check lets through, so "align = 1ULL << align_order"
> shifts by -5 (masked to 2^59 on x86-64); the e1000 BAR is resized to
> 2^59 bytes, which cannot be assigned, and the e1000 fails to probe:
> 
>   unpatched                            patched
>   requesting alignment to              PCI: Invalid requested alignment
>   0x800000000000000                    (order -5)
>   e1000 probe failed, no eth0          e1000 eth0 probes
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index bca3a5d84cd9..c2260ee1f956 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6605,7 +6605,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>  		if (sscanf(p, "%d%n", &align_order, &count) == 1 &&
>  		    p[count] == '@') {
>  			p += count + 1;
> -			if (align_order > 63) {
> +			if (align_order < 0 || align_order > 63) {

Wouldn't it be better to use %u ?

>  				pr_err("PCI: Invalid requested alignment (order %d)\n",
>  				       align_order);
>  				align_order = PAGE_SHIFT;
> 

-- 
 i.

