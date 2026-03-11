Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE3D2877C3;
	Wed, 11 Mar 2026 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232424; cv=none; b=pK3BJMOCpxwULl4QpwHiGV8Ubps2ctp6PG3g3OaLE10GsX+l3lspPCl9+kxFnH4JPnRoFrX86IGFHYtVbciqL3tQCjr3O/Y5/XC3UwXT6UISvXq6tGG+d/0T3N58/+qvm/evfmRe5bwV28ViqM9E9MCEriYgRiEdO2t1yRh/xBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232424; c=relaxed/simple;
	bh=+J1EgSs3yVorF0G+jb94JiobSJNb8UX0YbEzR1remQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iD5vzq7LK7oQ6gQRvW/l6fAnR7csjaoxIxebC7ZE4QK0JDXGpZX1Dl8gkVOHbNF2d1zSvJloWQtW95Dw19rths0SZPIskS27V9xFAdH+3H2ZBHy+CY5scOyrFE+Goxrt3a4MMOlZY4AIoyGwyCRfbZ5Eb31T6Nt1T+VS51m7ysU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJvRthEm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJvRthEm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A80C4CEF7;
	Wed, 11 Mar 2026 12:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773232423;
	bh=+J1EgSs3yVorF0G+jb94JiobSJNb8UX0YbEzR1remQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pJvRthEmWqz76nsAf972JnvXxTWFbzxueKgKXgL7xDkHyW36BBSCIQBATnuxbCAoK
	 SeqYc3bhQbkREYqkHDivdLSaYwVM4egN56Yi+5kg/wQ/KHMMzwJiz7Pcj2NVl0MyZ2
	 YFfJfEZXb0Q2YM+vGnhARKXtYTMs/21KFX1C6uzstcfz+yQzFjWlY2DNTr2xKhkCTb
	 aLGPXXb38lVwC1kGY0L7o2/DYp2fEeATbHcr51XRe1l+J6Md51ncGhQmJZY/VMX5vf
	 yqgVLSB6dG9tNkwD4ghuSmm/PENZBdFaBOGP8rq8RNTIRPkGALY18ptSLZssx+asCP
	 H5AuroHcT7P3w==
Date: Wed, 11 Mar 2026 18:02:51 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Hans Zhang <18255117159@163.com>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>, 
	Grimmauld <grimmauld@grimmauld.de>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
Message-ID: <pvef2ck2xpmq6amueka25odt6wjd3usmkjspf3mvlmfzsd7lyz@5eraltok22tq>
References: <20260226101032.1042-1-linux.amoon@gmail.com>
 <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177260693908.10259.13055467642416391434.b4-ty@kernel.org>

On Wed, Mar 04, 2026 at 12:18:59PM +0530, Manivannan Sadhasivam wrote:
> 
> On Thu, 26 Feb 2026 15:40:23 +0530, Anand Moon wrote:
> > Rockchip DWC PCIe driver currently performs synchronous link training for
> > combo PHYs (PCIe 3.0/2.0 and SATA 3.0) during boot. This process waits for
> > the link to be fully established, adding several milliseconds to the boot
> > sequence. To optimize boot time, this change enables asynchronous probing,
> > allowing link establishment to proceed in the background while the kernel
> > continues probing other devices.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] PCI: dw-rockchip: Enable async probe by default
>       commit: ec392abc95932838bf7e3d659d358f4df9ff5a0a
> 

Dropped the patch from controller/dwc-rockchip branch due to concerns with the
potential deadlock in the phylib. When Bjorn updates the pci/next branch, this
will get dropped from linux-next as well.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
