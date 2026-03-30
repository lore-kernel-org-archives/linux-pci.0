Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A786133B97B;
	Mon, 30 Mar 2026 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774890861; cv=none; b=jK5JMvXG7yOIVgapzXuGNu5iBb5FOYdNM63k/SbqqcrrmjhWg5g3K0GMCGj+naSxAG5GynZvJVuZvWFWyuAgh25AFHEnEKnWYTsoOeH0swFGfiZ6AD0eMqVBp2Q62mJYGgI4LIuR5mq63mpE+zcmGNnqiYuzTL/nt9DATJP6t1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774890861; c=relaxed/simple;
	bh=AOjcBWmo1xgGPcC3Ta1ltjPtKZ1kkl18kHeUxGCKBW4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uO7VaV2+l0oHwsDgGo6V9dvLfqVel9pxJgB9Nc7wOo2H5rGeoAWssEjE4m/Q6oPqgG/q2W8WrxcXc7rU9SWyDZafOP67RT30mNI/LA48Y4fs75uiBJbjMnVp/fFYTTenhIIJ4yIjNCE2+BbftU/jEbhCMTMksi5Z+SSimF3l3Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHMnXZsz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHMnXZsz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2474EC4CEF7;
	Mon, 30 Mar 2026 17:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774890861;
	bh=AOjcBWmo1xgGPcC3Ta1ltjPtKZ1kkl18kHeUxGCKBW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NHMnXZsz7EF1g4hrsaxenu975/kgBTbOVAkF5uxgOgNoBCWB7jvW2K6fJjRIp5ZRI
	 JwAKTa3FtDx9oz0HCemBeCbJlrCJuYeqTX99fz25ykB2c7JJW+NC7D+CKsmUUixVJ1
	 UXMfvudOojV2b7xWzi89GIzfc/ftdvP9uCaPsZ/dhACJrlwqB5D3lhP6BjoMQAOih3
	 ZmgIZd92bdIwi9/SmC1IS1QulhkpotEH3a/GryZgJlKcdk3uLDxv9qHZ5ZAobCHh98
	 sT26mS5ClYOcv5nDHo8XFw2ApOgO9BKLXU+HZmGAJ2iq1XZHtm0X7pRAcBrK/uoe2r
	 jdI0xcLv+Yz6Q==
Date: Mon, 30 Mar 2026 12:14:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kernelci@lists.linux.dev
Cc: kernelci-results@groups.io, gus@collabora.com,
	linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] linux-pci/next: (build) ignoring return value of
 function declared with 'warn_unused_resul...
Message-ID: <20260330171419.GA83942@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177463434349.1554.5266992356487229955@0d12152ffbcd>

On Fri, Mar 27, 2026 at 05:59:03PM -0000, KernelCI bot wrote:
> 
> 
> 
> 
> Hello,
> 
> New build issue found on linux-pci/next:
> 
> ---
>  ignoring return value of function declared with 'warn_unused_result' attribute [-Werror,-Wunused-result] in drivers/gpu/drm/i915/display/intel_vga.o (drivers/gpu/drm/i915/display/intel_vga.c) [logspec:kbuild,kbuild.compiler.error]
> ---
> 
> - dashboard: https://d.kernelci.org/i/maestro:c2145292d80ae85fd003068675e73a3d1f95c35e
> - giturl: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> - commit HEAD:  50451816531d66141cafe2347f9a896bd4dcb2b3

Dropped the commits related to this, see
https://lore.kernel.org/all/20260330161802.GA79047@bhelgaas

> Please include the KernelCI tag when submitting a fix:
> 
> Reported-by: kernelci.org bot <bot@kernelci.org>
> 
> 
> Log excerpt:
> =====================================================
> /tmp/kci/linux/drivers/gpu/drm/i915/display/intel_vga.c:68:2: error: ignoring return value of function declared with 'warn_unused_result' attribute [-Werror,-Wunused-result]
>    68 |         vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~
> /tmp/kci/linux/drivers/gpu/drm/i915/display/intel_vga.c:93:2: error: ignoring return value of function declared with 'warn_unused_result' attribute [-Werror,-Wunused-result]
>    93 |         vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~
> 2 errors generated.
> 
> =====================================================
> 
> 
> # Builds where the incident occurred:
> 
> ## x86_64_defconfig on (x86_64):
> - compiler: clang-21
> - config: None
> - dashboard: https://d.kernelci.org/build/maestro:69c6b8d23712df3240c2a959
> 
> 
> #kernelci issue maestro:c2145292d80ae85fd003068675e73a3d1f95c35e
> 
> --
> This is an experimental report format. Please send feedback in!
> Talk to us at kernelci@lists.linux.dev
> 
> Made with love by the KernelCI team - https://kernelci.org
