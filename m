Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983080;
	b=Fmx5iGGP1Y8Dn4Zs6A3xcutkXE3fO83+uRh21tkNZPuQb1BhwSx4rbVhWJLk78kZa+sm
	 HuQBJR2DDQl+Rd8i1+ZJuSVKMnrAt9w+u88iR6vOQIn4NqbSHbz3H9bXpOTR35ngDQENY
	 rqi/gmzpueCQQXsvRmDhzBY54NVxo1OEQNqlRGj+7ZvgPW+87iJSNnHaRs9FMEthU0gLd
	 5vv/Rh9UTVcAtQ1HvfMqXXMUsk0M9oXlzM+5gKBExG2WfljCiS2XdgdJovz6N0KBxqCpK
	 yjeK+w/hLTiOO/a/bZHvxdWijlFuyAgTR2UTDRQQirSjsEZIg/xHFtt+Dz/3ynokzYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983080;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=S5YhcK54YIyo61TeC8ElmDU96Anu4dDvUB5DJqcPL40=;
	b=j4ZGhSKhdhMtNtaFWYLv0QblpDRFnxfmpefXQTgwrXNQ/IsZgOioegAkTYlWBfOjW8Vl
	 5YhhOOyB5KrL8v5V7Z5ctdFugQC76NdBhBrapWJ4bkJlF1e8lhRka3gdG7XCRKYaxA9Rz
	 7/VFUaoUuHk2iGakvDd3uVzxDGUzZUazDlvJFqz3kefgJiu8Azu5SaxAPsvdTxrjR23L0
	 kgppLXqbFiQLtuHlkN5w+ce8cZAdC8u3EqLIOhgiM4AplP6oYqKpGkXmPRrjliqtUm90z
	 /CyLOlCf/Apibtw4w95u2qAmzL3IZlRz8FtFabFD+zsmzkPH5iLJg4seY10SeKnAcLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BSSInwB+;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E686606A326;
	Fri,  6 Nov 2026 16:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E686606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BSSInwB+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793983079; x=1825519079;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wNVZfOIIT+sM0W2kjGBnAlhFGgRNsj/UgmD0XJLbzJk=;
  b=BSSInwB+WwtrW7d3DmozIiDdUcFSs5qovg1aad/SCQ9moz6WW0O1jbMA
   j03T+JKa5rztBYqB3G3gzajL4XQCLeUa+fNUC4A19svqqTceHemBZASwp
   Ivk33dwi3hIp68snFyvBl8UoMpxJzaaXcNdtky7Npwkls8f8+MBYdpOjY
   hJ9iWlsVejPdJU7ju0y0TVkzyRDTPr+gQjAjn57OawfNi1esjzYZ1D/1+
   MZJmKDfMQ/edbGlsXps+FXcelYxF1g7g9pKZGM13mxgJm494LIy3LLhQ+
   z9Zw7iLYJGsNUPvB4WFXJvxEg6maWmwEs1eqGj2KSbqFCZ1HW/+vH083n
   g==;
X-CSE-ConnectionGUID: 8r1rL46+Q3qQvDsUvGb6nQ==
X-CSE-MsgGUID: XN//eqCnQIWUWpg3qjrTVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2692140"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2692140"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:37:58 -0800
X-CSE-ConnectionGUID: WiHzMi50R7at8iRa7ViQTA==
X-CSE-MsgGUID: byCzqf+GTqC8OgNphwVkwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7746044"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:37:56 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 6 Nov 2026 18:37:52 +0200 (EET)
To: shao.mingyin@zte.com.cn
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, mani@kernel.org, 
    kwilczynski@kernel.org, lpieralisi@kernel.org, kishon@kernel.org, 
    Frank.Li@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] PCI: rebar: Guard pci_rebar_bytes_to_size() against
 overflow
In-Reply-To: <20261107002315181vFaB7Y_zoFugWEVkOSGJZ@zte.com.cn>
Message-ID: <a9c36a69-a0d3-62af-e5d7-cf99c427a1ff@linux.intel.com>
References: 20261107002305850zuBaVsGBz3wbco2Ae4ScR@zte.com.cn <20261107002315181vFaB7Y_zoFugWEVkOSGJZ@zte.com.cn>
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
> pci_rebar_bytes_to_size() passes its argument straight to
> roundup_pow_of_two(), whose implementation is (1UL << fls(bytes - 1)).
> For bytes == 0 and for values above 2^63, fls() returns 64 and the
> shift count is undefined behavior.  A value with bit 63 set cannot be
> encoded either: exactly 2^63 rounds to itself and is encoded as 43,
> outside the 5-bit BAR Size field.
> 
> Bail out for bytes == 0 and for any value with bit 63 set; a zero size
> is returned, which encodes the 1 MB minimum.  The largest valid BAR size
> is 128 TB, far below the 2^63 boundary, so no legitimate input is
> affected.
> 
> Fixes: 192f1bf7559e ("PCI: Add pci_rebar_bytes_to_size()")

This is missing how it can be reproduced with the existing kernel code. If 
it's not triggerable, the Fixes tag should be dropped.

> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> Tested on 7.3.0-next-20261030 (QEMU/TCG x86_64) with a TEST-ONLY hook
> (applied to both kernels) that calls pci_rebar_bytes_to_size() at boot

So no real reproducer?

> with pathological inputs (0, 2^63, U64_MAX) and two sane sizes (1 MB,
> 1 GB), built with CONFIG_UBSAN_SHIFT.  No extra hardware is needed.
> 
> Unpatched, the 2^63 input is encoded as BAR size 43 (outside the valid
> 0..31 range) and the 0/U64_MAX inputs shift by 64 (UBSAN reports "shift
> exponent 64 is too large for 64-bit type").  With this patch all
> pathological inputs return 0, the two sane sizes are unchanged (1 MB -> 0,
> 1 GB -> 10) and no UBSAN report appears.
> 
>   unpatched                               patched
>   UBSAN shift-out-of-bounds; size 43      size 0, no UBSAN report
> 
> diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
> index 5bbdc9470a31..fd448dc7c322 100644
> --- a/drivers/pci/rebar.c
> +++ b/drivers/pci/rebar.c
> @@ -31,6 +31,13 @@ int pci_rebar_bytes_to_size(u64 bytes)
>  {
>  	int rebar_minsize = ilog2(PCI_REBAR_MIN_SIZE);
>  
> +	/*
> +	 * roundup_pow_of_two() is undefined for 0 and above 2^63; any value
> +	 * with bit 63 set is outside the 5-bit BAR Size field, so bail out.
> +	 */
> +	if (!bytes || bytes & (1ULL << 63))
> +		return 0;

Won't this clash with the normal return values? -EINVAL seems better 
choice.

...So now you get to add the error handling too.

-- 
 i.
