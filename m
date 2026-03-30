Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA07F33B97B;
	Mon, 30 Mar 2026 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774890875; cv=none; b=MODXg194kJywyUsaPHN1zOSbJN8wyK7ECt6rljo578asin8c6uLeCGi+GtTZYM8JfSrNxNoEGenjq/kTA0J7cJGZnoRIsN3aNCkAC8KbGObSS0ta/5Q0KdoTIad1FOeIBwOQjBeSxXCEysnD4feAFImhLvIQ4nUuMUCbaoP9Frg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774890875; c=relaxed/simple;
	bh=q9h/syO7kNCfJ58ERVsTRXaw2C0cY3Gdps0OmK3fpio=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UIhrtoCP72W/aiV9oIo2XNiFThWB0RKN5M5+SWpZiHAmZbF+zbcMMU16RoRIKDInwSW9Farz/8lt1k1dwiMLxP1nJPO91WpCNxzLjAOWB8bFv9GP1dAfl6BMN74vfLk02ZFPM1h7duoxHSFcDfzn/56Yr7OaEy8WTduiZx0xlmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFHmgSuF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFHmgSuF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF868C4CEF7;
	Mon, 30 Mar 2026 17:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774890874;
	bh=q9h/syO7kNCfJ58ERVsTRXaw2C0cY3Gdps0OmK3fpio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SFHmgSuFT1Wgn8xn5rmuDSa5zbAEcQUo7HP1DpZcKVNC5dxQzQAKIC8JgnCbVhCrD
	 lppTGF5CdH5gcQEGYZzn5JiWWy+MpbHjx56AW7N5O7/l93BF0AcQbF/WnN6/T4HWz4
	 v4h2S8rFlfUBG9k+OnHkw87XuD+f9TJY9tWfhUVkFi9azrNULsj69wcX2OlxvO5axC
	 DYfoY5EccTq8i/G0Zm/SK3PhT2Wr7ELKrC3XIbirvvUpWyuQ/wKWItHMsZwIFv8nvR
	 vZ9KD7XPDPyMPWZ0yE1PdzG1cvWVdkT4f/lG13Xuj6mHKhunPJF/iciyaT902zDjck
	 RT3VzJcned09w==
Date: Mon, 30 Mar 2026 12:14:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kernelci@lists.linux.dev
Cc: kernelci-results@groups.io, gus@collabora.com,
	linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] =?utf-8?Q?linux-pci=2Fnex?=
 =?utf-8?Q?t=3A_=28build=29_ignoring_return_value_of_=E2=80=98vga=5Fget=5F?=
 =?utf-8?Q?uninterruptible=E2=80=99?= declared with a...
Message-ID: <20260330171433.GA84073@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177463434509.1554.4896275539353552635@0d12152ffbcd>

On Fri, Mar 27, 2026 at 05:59:05PM -0000, KernelCI bot wrote:
> 
> 
> 
> 
> Hello,
> 
> New build issue found on linux-pci/next:
> 
> ---
>  ignoring return value of ‘vga_get_uninterruptible’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result] in drivers/gpu/drm/i915/display/intel_vga.o (drivers/gpu/drm/i915/display/intel_vga.c) [logspec:kbuild,kbuild.compiler.error]
> ---
> 
> - dashboard: https://d.kernelci.org/i/maestro:f670fdf443306495220d2cea8670ce85a80aed1e
> - giturl: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> - commit HEAD:  50451816531d66141cafe2347f9a896bd4dcb2b3

Dropped the commits related to this, see
https://lore.kernel.org/all/20260330161802.GA79047@bhelgaas

> 
> 
> Please include the KernelCI tag when submitting a fix:
> 
> Reported-by: kernelci.org bot <bot@kernelci.org>
> 
> 
> Log excerpt:
> =====================================================
> /tmp/kci/linux/drivers/gpu/drm/i915/display/intel_vga.c:68:9: error: ignoring return value of ‘vga_get_uninterruptible’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
>    68 |         vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /tmp/kci/linux/drivers/gpu/drm/i915/display/intel_vga.c: In function ‘intel_vga_reset_io_mem’:
> /tmp/kci/linux/drivers/gpu/drm/i915/display/intel_vga.c:93:9: error: ignoring return value of ‘vga_get_uninterruptible’ declared with attribute ‘warn_unused_result’ [-Werror=unused-result]
>    93 |         vga_get_uninterruptible(pdev, VGA_RSRC_LEGACY_IO);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> =====================================================
> 
> 
> # Builds where the incident occurred:
> 
> ## x86_64_defconfig+kselftest on (x86_64):
> - compiler: gcc-14
> - config: None
> - dashboard: https://d.kernelci.org/build/maestro:69c6b9023712df3240c2a985
> 
> 
> #kernelci issue maestro:f670fdf443306495220d2cea8670ce85a80aed1e
> 
> --
> This is an experimental report format. Please send feedback in!
> Talk to us at kernelci@lists.linux.dev
> 
> Made with love by the KernelCI team - https://kernelci.org
