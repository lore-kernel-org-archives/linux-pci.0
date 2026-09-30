Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A76C3EEACB;
	Wed, 30 Sep 2026 22:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790806961; cv=none; b=FC9TASCWZQTqKILR2e2wSbOVamsLVz9vHDiw4pbEYzZ5l6wePzFWppY/YePcceD0pTQwlUtDjmviacIIfoviCHsHX3FjQuxSmR9LzdckiFnorNr6GETYtyoUqHh6sBx5tphcHZbyR5yuLcTMG/yAN79n6FHQnYSa5hmSxunjVYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790806961; c=relaxed/simple;
	bh=FsePE8o1CpvhwfkdewLFmrzEslvIEel6351uGkQRDdk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d1cS2RbuiEfJJ/OjLzCV8Eja3T/1P2q/tVizxweQml859lWxUN2BZRgSvsTQPEDJMxokNndVs7p9MmkNMx6EfnqFHTze44uUBqVFI/dSUtd3kn+syY6ZQm89FcogDxSbgEjCINCBbvOi3WWh1B1Q7lDG477FDlKorCfiFrEoJIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2e3Rga+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2e3Rga+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9B91F000FF;
	Wed, 30 Sep 2026 22:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790806960;
	bh=QjF6ktPdd3TPb+i2trkMCyjZSnSMNg0vgV3g7TbLMfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=S2e3Rga+wn5uQ0EPWIhh3f+g8DxP0uL6tlDwEIfv8BGZhJLC0VyHEdHspp/ymLBvK
	 dOfzQOb7L2H+v2wpNWxlq6TQXiXsQp0GU9t8H9OAlxX8ZGFY55m0snPmOuQFKfdIsm
	 QBnxut4dp1H/5CUzqi2gBiz9Hs8ByIDYGMDTj4jSYnThWBqwYJH3HMof0AfS7KrmCF
	 BZhQbwqNy0I7vPo2o2EXFq+IoeHwYjWmXoM0eViYNMrVGsBx23k18RTUfmpcQsBiR1
	 lNwx4T1O0orBLq09FSAePQmj9NTUyoHzQ7lLNp2i/qQK051T8dftfL6j3iGXAI63Fq
	 YM97mrB+NfHmw==
Date: Wed, 30 Sep 2026 17:22:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kernelci@lists.linux.dev
Cc: kernelci-results@groups.io, linux-pci@vger.kernel.org,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Hans Zhang <18255117159@163.com>
Subject: Re: [REGRESSION] =?utf-8?Q?linux-pci=2Fnex?=
 =?utf-8?B?dDogKGJ1aWxkKeKAmFBDSUVfUE9SVF9MQU5FX1NLRVc=?= =?utf-8?B?4oCZ?=
 undeclared (first use in this function); did ...
Message-ID: <20260930222238.GA2651781@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179080559722.116660.12892772212991345354@kernelci.org>

[+cc Marek, Hans, just FYI, no action needed]

On Wed, Sep 30, 2026 at 10:00:24PM -0000, KernelCI bot wrote:
> New build issue found on linux-pci/next:
> 
> ---
> ‘PCIE_PORT_LANE_SKEW’ undeclared (first use in this function); did you mean ‘PORT_LANE_SKEW’? in drivers/pci/controller/dwc/pcie-rcar-gen4.o (drivers/pci/controller/dwc/pcie-rcar-gen4.c) [logspec:kbuild,kbuild.compiler.error]
> ---
> 
> Log excerpt:
> =====================================================
> drivers/pci/controller/dwc/pcie-rcar-gen4.c:307:37: error: ‘PCIE_PORT_LANE_SKEW’ undeclared (first use in this function); did you mean ‘PORT_LANE_SKEW’?
>   307 |         val = dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
>       |                                     ^~~~~~~~~~~~~~~~~~~
>       |                                     PORT_LANE_SKEW
> drivers/pci/controller/dwc/pcie-rcar-gen4.c:307:37: note: each undeclared identifier is reported only once for each function it appears in
> drivers/pci/controller/dwc/pcie-rcar-gen4.c: In function ‘rcar_gen5_pcie_init’:
> drivers/pci/controller/dwc/pcie-rcar-gen4.c:338:37: error: ‘PCIE_PORT_LANE_SKEW’ undeclared (first use in this function); did you mean ‘PORT_LANE_SKEW’?
>   338 |         val = dw_pcie_readl_dbi(dw, PCIE_PORT_LANE_SKEW);
>       |                                     ^~~~~~~~~~~~~~~~~~~
>       |                                     PORT_LANE_SKEW
>   CC [M]  sound/soc/codecs/da7219.o
> 
> =====================================================

Conflict between pci/controller/dwc, which renamed PCIE_PORT_LANE_SKEW
to PORT_LANE_SKEW, and pci/controller/dwc-rcar-gen4, which added uses
of PCIE_PORT_LANE_SKEW in rcar_gen5_pcie_init().

Fixed the merge conflict locally.

> When fixing this issue, please attribute this report according to the
> patch submission rules:
> 
> Reported-by: kernelci.org bot <bot@kernelci.org>
> 
> For complete logs and details about the environment used, see the issue
> on the KernelCI dashboard:
> 
> - dashboard: https://d.kernelci.org/i/maestro:9c96bb06403e0f385b3d6d522f160cd82ba4b932
> - giturl: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> - commit HEAD:  bc80f6c85a8e97bdb69604f82af37179fcb01c38
> 
> # Builds where the incident occurred:
> 
> ## defconfig+arm64-chromebook+kcidebug+kcidebug-arm64+lab-setup on (arm64):
> - compiler: gcc-14
> - config: None
> - dashboard: https://d.kernelci.org/build/maestro:6abd7df914cd2ca558e86834
> 
> ## defconfig+lab-setup on (arm64):
> - compiler: gcc-15
> - config: None
> - dashboard: https://d.kernelci.org/build/maestro:6abd7de014cd2ca558e8681d
> 
> ## defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (arm64):
> - compiler: gcc-14
> - config: https://files.kernelci.org/kbuild-gcc-14-arm64-chromebook-6abd7db714cd2ca558e86606/.config
> - dashboard: https://d.kernelci.org/build/maestro:6abd7db714cd2ca558e86606
> 
> ## defconfig+netdev+nfs-root-boot+kselftest on (arm64):
> - compiler: gcc-14
> - config: https://files.kernelci.org/kbuild-gcc-14-arm64-nfsboot-6abd7de614cd2ca558e86820/.config
> - dashboard: https://d.kernelci.org/build/maestro:6abd7de614cd2ca558e86820
> 
> ## defconfig+netdev+nfs-root-boot+kselftest on (arm64):
> - compiler: gcc-15
> - config: https://files.kernelci.org/kbuild-gcc-15-arm64-nfsboot-6abd7dea14cd2ca558e86823/.config
> - dashboard: https://d.kernelci.org/build/maestro:6abd7dea14cd2ca558e86823
> 
> ## defconfig+netdev+nfs-root-boot+ltp on (arm64):
> - compiler: gcc-15
> - config: https://files.kernelci.org/kbuild-gcc-15-arm64-nfsboot-ltp-6abd7def14cd2ca558e8682d/.config
> - dashboard: https://d.kernelci.org/build/maestro:6abd7def14cd2ca558e8682d
> 
> #kernelci issue maestro:9c96bb06403e0f385b3d6d522f160cd82ba4b932
> 
> --
> This is an experimental report format. Please send feedback in!
> Talk to us at kernelci@lists.linux.dev
> 
> Made with love by the KernelCI team - https://kernelci.org
