Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4455351FCBA;
	Tue,  8 Sep 2026 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788864376; cv=none; b=KzZJvYDTGiYPhPY1b7gFgR0DzIXOpUWcVVLp47zdIuWPTf/03fx53unzmmyRzj7QICaXoa2VPY3K6SxDcO1/JbrQrTE+iY+mZADX19GS39LLZpsFlKUenobaf7to58U68TGzYKXCZ88F0FzhUCy75wGGznX3fR2eVU/pjSSnGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788864376; c=relaxed/simple;
	bh=r/l1YoM6RxKXIyIUKiNRzuIxu6GWquA/QjRvwN8HJKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7EmwxyyYMg2ADAj1vfCPx54SFZuNGMbiYkBbC1QeoMMA5KPeGW5jOUFPPB7kjizNXP02SsNbo5OFe0MKALp3mT53pxCQhac3q1pK5Q1CcZ46d3LWZc4yWjjAv0uu55LSZkRkrEJzazpsx3fmeiweStG+6KNBZLtE4vZ3JmJNQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ij4ikJ85; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ij4ikJ85"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788864373; x=1820400373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=r/l1YoM6RxKXIyIUKiNRzuIxu6GWquA/QjRvwN8HJKc=;
  b=ij4ikJ85Lk67/PYJPngoIW1Z5d//ckY4kyMSu5c5vPYXbtcnV6tIDFif
   gZnI9B/DvT0GZXRczGM8TTJEwT5Qdpv9crQSSjfYn/xTlpYWjfQp2pWRW
   nfcgRUm3YN+mdY4cOWMchvrgk3z7QFuE0ZSwM5ARMzX/yJ77m+zp6mGu2
   M1qACMlv5n76L2pxWnCxJ63zrf2XXlXrWBodngBadKPsuc5+UHqKUJ9I8
   jBkfiG0B0uRo/og2Mw5/JDPjTQfyXtdfRu87meSZ2/2qJxlaSCgqi8TAp
   4C/hxvXe0Yxb/7ZvCSYzRc2ZynZifkt4QcKwPWYb8kGLWxb+ZJjxnUTfk
   g==;
X-CSE-ConnectionGUID: LQ2kziCfSTiKA63Fu2/Cng==
X-CSE-MsgGUID: XVYHP1jKQ0GyiUM2n1z7YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="100421361"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="100421361"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:46:10 -0700
X-CSE-ConnectionGUID: mYt1HGNlT6ubu5HZabgTpw==
X-CSE-MsgGUID: M8egQ/YUTG26EpMeldSn2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="272890143"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.174])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:46:07 -0700
Date: Tue, 8 Sep 2026 13:46:04 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Krzysztof Karas <krzysztof.karas@intel.com>,
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Disable not supported reset methods on DG1 0x4905
Message-ID: <ap_nbJWGXWTI8ARq@intel.com>
References: <20260907090249.1348552-2-janusz.krzysztofik@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907090249.1348552-2-janusz.krzysztofik@linux.intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Mon, Sep 07, 2026 at 10:59:18AM +0200, Janusz Krzysztofik wrote:
> DRM CI consistently reports failing device reset attempts on Intel DG1
> discrete graphics adapters.  Manual reproduction attempts allowed to
> narrow down the scope of that problem to a specific revision of that
> hardware, SKU 8086:4905.  It has been confirmed that both reset methods
> claimed by the device, i.e., flr and bus, suffer from that issue.

IIRC the documented workaround for the issue is some kind of magic
register write after the FLR to unblock some internal state machine,
but the CPU isn't allowed to do that write and instead it has to be
performed by the GuC. That means we'd somehow have to reinitialize
the GuC very early after the FLR, which sounds rather difficult.

> 
> Since consecutively failing device resets may lead to system hangs,
> disable both useless reset methods.  A respective CI test will then be
> skipped instead of aborting whole CI jobs.
> 
> Suggested-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/11814
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> ---
> v2: Fix commit description wording (Andi)
>   - add Suggested-by: tag missing from v1,
>   - add collected Reviewed-by: tags.
> 
>  drivers/pci/quirks.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index de9bbccda21fd..e55475374c6fd 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3811,6 +3811,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, 0xb005, quirk_no_bus_reset);
>   */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1164, quirk_no_bus_reset);
>  
> +/* Intel DG1 0x4905 may not recover from bus reset */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4905, quirk_no_bus_reset);
> +
>  static void quirk_no_pm_reset(struct pci_dev *dev)
>  {
>  	/*
> @@ -5597,6 +5600,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
>   * AMD Neural Processing Unit 0x1502 0x17f0
>   * Intel 82579LM Gigabit Ethernet Controller 0x1502
>   * Intel 82579V Gigabit Ethernet Controller 0x1503
> + * Intel DG1 Discrete Graphics Adapter 0x4905
>   * Mediatek MT7922 802.11ax PCI Express Wireless Network Adapter
>   * Mediatek MT7925 802.11be PCI Express Wireless Network Adapter
>   */
> @@ -5612,6 +5616,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1502, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x17f0, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x4905, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x0616, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x7925, quirk_no_flr);
>  
> -- 
> 2.54.0

-- 
Ville Syrjälä
Intel
