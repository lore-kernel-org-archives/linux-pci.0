Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E279A3A6413
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723632; cv=none; b=LrSb+GDme6L+lqSGXN/nhrB0wKjlbpSdEic+fZEe7MlstCTcn9tUp7YBiePcajEy32i8AuC1rKquaBXkT8vAWV1nGbzJWclilhE4Ck0oSMdmbC2l2Cr3olu2i+v9MD9ilewkZOWLkrWu0L8Umjvll/rKzN6YVsV17BpdEPuA6ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723632; c=relaxed/simple;
	bh=Ibh2bGmqBWk2KxkcdsDNsEXmMqEhPAATmvMlu7kOn/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWSePKrA8Mx/XQmOYvZ1uquWt8KJt3lUOOaoovN1e48SC+Axl73P5YLhLQvcrMvkcFc/9Ql5Dkw3J9UP2u35bRIEyCUPW/qaDJYOyJ/MZuEWNiwAtkxPgKB2b01834ZoVNMH1U0IscJ5WOS8pspeGFyI5+97T/dXwNu47GCdYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQkN0S8J; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQkN0S8J"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12732e6a123so133277c88.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 07:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772723628; x=1773328428; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N8eW07+TyJYijMsjeCHBsnEU5co6837wg++Yi11YMsM=;
        b=AQkN0S8JldFJpaCu0pJttJv6ZF1cnn0qf0RsOVHG+hhx+FNdG+qEd6u9IMHMSRTsSg
         uVTO/mfjmVCDrxmAtYjHzFKMzyWbHYc2pu9kxKnW5zP8qwkQ5agcql4LQp8VJOWwR1hG
         MvrYVEBcrK1MrFESsxtkEcV6ijaDfkqFN0D2hsYmTWnnN3Fr70m3zxaGwcfzuigynsFG
         xmYEs5e/mQ3W5xk692TbzY/aptoKUrepOBuf/TsDV1EVrzu/F9CzRJJ6YqdkmpuzdJWY
         IC3TBdi3kDRDWp5pBLIradLHYIweDgBM/Ni2HbPdB21evnfp8Quy88tgWG9PCUU1LOg6
         XSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772723628; x=1773328428;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8eW07+TyJYijMsjeCHBsnEU5co6837wg++Yi11YMsM=;
        b=pbYW26hBbTgeRlXYInIIbURzeU0hVM2YRG1QqQDdfVC0a/iPEo+4rcOWuBHw6WUWG6
         bO4fXSRfHmJkF8RmOb3UQL3kLrV5hdJC+NQqAKuAvWBW0OYPCBdGCG5xFpDSeIwJWZVc
         uCdVPMmsr3P/j3kCgB+b/s2jrH2npcTPU9ufTeC7gaE4NLWiV9h8SqvuI9VFgdPq+yQ4
         BMK6XhHkzJLsvgN20vveuGfK+ECVeoHQcxvF5noCn+5M+GEwhC5AKY4G4fVHm4VrWsI1
         rElyWtLpspaUMU750ZXdFHrzP0xXee0B6op4Yx4Nss68ZKl6OeWJy4eMeKycuDCYToqs
         jGWw==
X-Gm-Message-State: AOJu0Yz5RkPmP2OGG7+vP0dCpWQXZnK2b8Jd/jGFF30eGQ8aHABmRGIz
	r2YP7xiK9JbGPchNLvIUdw0U82jftAtdgsXIljORT69WJZXXq7ogz/Fqa02BSs3V
X-Gm-Gg: ATEYQzzQ6hudN9P/D+PVzgtu/5KxU4kWf6Vg912KqZwgUY14LHaW9hjWbhTK4JOAZr0
	cxZuWzebaMOQzIrjlrRCBjqonZDQ5ahS1Ys1k3YiMjnj7xl7kY51UjYdO8fGLc00VIrurwF1pTZ
	2N5eAdVQhEgoBZasSAi3g8WtKcR5B3XU3zxbYnx1jihyEEW19slaw3kD2ixIW+/G0QIqjMYSGtP
	nFQBdIQztVMIivVxu6ZoYOQBum+V5QMRVOczkz25/NT0lZEJvuiPiHs4N1TtHz5N18CuRcDRjTV
	OklKChsF0/finmzi+oVpXBKKwdY2Eh7R7JToTirePvjEha2rcxl4MvBSdXhgH/jSa4Ux0ii0do8
	Vp46cQKNVfICjl6qEUNHUODqTh194P/vhKgTEL2jmlwdHGzM/vmjFVEvNO0n71SnzEKnUI77UFx
	XObJN2JDXjkEMPufYHMVxhSxKE/4j27C9l8PKw
X-Received: by 2002:a05:693c:2c96:b0:2ba:96d8:530b with SMTP id 5a478bee46e88-2be311c3194mr2359478eec.32.1772723627653;
        Thu, 05 Mar 2026 07:13:47 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be002ee839sm13379098eec.8.2026.03.05.07.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 07:13:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 5 Mar 2026 07:13:45 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org,
	Malte =?iso-8859-1?Q?Schr=F6der?= <malte+lkml@tnxip.de>
Subject: Re: [PATCH 03/23] PCI: Stop over-estimating bridge window size
Message-ID: <b05a6f14-979d-42c9-924c-d8408cb12ae7@roeck-us.net>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
 <20251219174036.16738-4-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251219174036.16738-4-ilpo.jarvinen@linux.intel.com>

Hi,

On Fri, Dec 19, 2025 at 07:40:16PM +0200, Ilpo Järvinen wrote:
> New way to calculate the bridge window head alignment produces
> tight-fit, that is, it does not leave any gaps between the resources.
> Similarly, relaxed tail alignment does not leave extra tail room.
> 
> Start to use bridge window calculation that does not over-estimate
> the size of the required window.
> 
> pbus_upstream_space_available() can be removed.
> 
> Tested-by: Malte Schröder <malte+lkml@tnxip.de>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Google's experimental AI code review agent produced the following feedback.
It seems real to me, but I may be missing something. PTAL and let me know
if it has a point.

If it is a real problem, it may have been fixed by a later patch which I
may have missed. If so, my apologies for the noise.

Thanks,
Guenter

---
commit 3958bf16e2fe1b1c95467e58694102122c951a31
Author: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

    PCI: Stop over-estimating bridge window size

    New way to calculate the bridge window head alignment produces tight-fit,
    that is, it does not leave any gaps between the resources.  Similarly,
    relaxed tail alignment does not leave extra tail room.

    Link: https://patch.msgid.link/20251219174036.16738-4-ilpo.jarvinen@linux.intel.com

> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index cd12926a72af..25d6d4d3afc1 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c

[ ... ]

> @@ -1409,13 +1346,8 @@
>  				continue;
>  			}
>  			size += max(r_size, align);
> -			/*
> -			 * Exclude ranges with size > align from calculation of
> -			 * the alignment.
> -			 */
> -			if (r_size <= align)
> -				aligns[order] += align;
> -			aligns2[order] += align;
> +
> +			aligns[order] += align;
>  			if (order > max_order)
>  				max_order = order;
>  
> @@ -1429,38 +1361,19 @@
>  
>  	old_size = resource_size(b_res);
>  	win_align = window_alignment(bus, b_res->flags);
> -	min_align = calculate_mem_align(aligns, max_order);
> +	min_align = calculate_head_align(aligns, max_order);
>  	min_align = max(min_align, win_align);
> -	size0 = calculate_memsize(size, min_size, 0, 0, old_size, min_align);
> +	size0 = calculate_memsize(size, min_size, 0, 0, old_size, win_align);

Does the removal of the `r_size <= align` check cause bridge window size
underestimations if we have child resources larger than their alignment?

If we have child resources with the following requirements:
- Resource A: 4MB size, 4MB align
- Resource B: 3MB size, 1MB align
- Resource C: 1MB size, 1MB align

The requested `size` is calculated as 4 + 3 + 1 = 8MB.
`aligns[order]` for 1MB will now incorrectly include B, summing to 2MB.
`calculate_head_align()` will see the 2MB remainder and reduce `min_align`
to 2MB, assuming the remainder can perfectly fill a 2MB head gap.

If the bridge window of size 8MB is allocated at a 2MB-aligned address
(e.g., `0x10200000`), the 4MB aligned Resource A must be placed at
`0x10400000`, leaving a 2MB gap.

Resource B (3MB) cannot fit in this 2MB gap, so it is placed after A at
`0x10800000`.
Resource C (1MB) fits in the gap at `0x10200000`.

The total space used spans from `0x10200000` to `0x10AFFFFF` (9MB).
Since `size0` was calculated as 8MB, won't Resource B fail to allocate
because it exceeds the bridge window?

