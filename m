Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A6D496D55;
	Thu,  1 Oct 2026 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856899; cv=none; b=q9OvZY0m+yfSSrK+GcKECgrybN3/hbFJzgPEyd4AkHUiwe+JY1cjiTuR0Dk8yBVpleq4KROsSOL3yjnJtQHLGteV+b9EtLEGJGoeuzaots8QITFzLu1vnYnVgEJQ3FdsfSmKf72vzXYq9dcc78k2W3FepSY2YFxwDk4//faQmSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856899; c=relaxed/simple;
	bh=wzl4bQpHufVbGcUH2VpVjtJU0TDaij6VKMDPl43NN0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UX4f4xTzQH8rJIcbAP/4WMTUtQM4PsuzGwG9qIUGqsHEG1t9M51jQJMwHCcSBHyG2FfxcA6y/RTTK0r4EzZYKrT9XwuLfDywS5RWOGD1TQ66F0ZRuswY4a3/3bCMRN8lJRbiP10e5SS2n6/Qa83ZdSvAGA9B2392HCKvEEwbJTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EazoPou7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EazoPou7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747F31F00898;
	Thu,  1 Oct 2026 12:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790856897;
	bh=DYmoiuH04vCrKntkd6fvwAuUoeiwmoc5CuyAp/tVUL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EazoPou70hQV84XiGWeQ+BeuJoBKc/GYwYe9XuLqYpTz2Fg9aFnD6H48Vu8DM3Xtm
	 oEz9bOD2d9e95OsLDsvMpuLs2FAV761uBC/zHq3uwi5gvW6Z3fB1g+m3jiR5aQmai2
	 Yb3dqLWR+s8ZzSnAqreTt9XMKrDr5r0g5+RH2vXyKSs7oLqxBxVS4AwejkDFNyWXSF
	 Kvfn8tQs/1dGByjVSzzMo0lczqFxsxFVwNMbR7wWce+7axsqz/kYQX7gZ2dEAG3dNZ
	 xJABUE1EMx0X9LaUUoZszyqKkM5qNugxkFPQJdCMp8h9ERuBaZ/mb4wvnzIctgYfsW
	 gten9bB/dSIWg==
Date: Thu, 1 Oct 2026 14:14:54 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Andi Shyti <andi.shyti@linux.intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>, 
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>, Krzysztof Niemiec <krzysztof.niemiec@intel.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Disable not supported reset methods on DG1 0x4905
Message-ID: <ar5Ol94SjttvxEAO@zenone.zhora.eu>
References: <20260907090249.1348552-2-janusz.krzysztofik@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907090249.1348552-2-janusz.krzysztofik@linux.intel.com>

Hi,

any news here? This patch looks to be stuck, can someone please
give it a look?

Thanks,
Andi

On Mon, Sep 07, 2026 at 10:59:18AM +0200, Janusz Krzysztofik wrote:
> DRM CI consistently reports failing device reset attempts on Intel DG1
> discrete graphics adapters.  Manual reproduction attempts allowed to
> narrow down the scope of that problem to a specific revision of that
> hardware, SKU 8086:4905.  It has been confirmed that both reset methods
> claimed by the device, i.e., flr and bus, suffer from that issue.
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
> 
