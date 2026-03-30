Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F812BB13;
	Mon, 30 Mar 2026 07:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774854889; cv=none; b=AnWxV4CVHHiQWrWtafq/NNxXd7ADfos3nGZPa0VxJ+mkLXxznMoXq3uZmh+Pfo/bT0MnbOcdbqvl+o91MidLznrKGlvxL3p3b+zSskI6P1SoMtedkKwUJjKgob0hNHxLJpp8E5tRVfzSAlq0Q2edNJDxRvKtXTgn66XLEUUFEpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774854889; c=relaxed/simple;
	bh=4+WUmL//Da8vau3D/G22njSDuAsGNSU2A8TohX1s4jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q74qKVLVkBbIzSfiu2BMNRFqJiStnoaAnCNdbc9cj0mHhi/LTuICUBkefZnmJb3yfIBu3DwyrmxKGL2N0Rp+9TVqEKvLFbsCLA4P7Zj8xrP0otIOJaBja4jYCorzZWD6dCD3Kt4WAlTJqjtLuQsj6pVg9QiYpI+CQASt1MOmkq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+SGYVCr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+SGYVCr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A49EC4CEF7;
	Mon, 30 Mar 2026 07:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774854888;
	bh=4+WUmL//Da8vau3D/G22njSDuAsGNSU2A8TohX1s4jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+SGYVCrNyPWovt5SuhQLbtXYdEg+IUwa8qQac1sQgDmpXwSAOg88Ae1O0cwIP2xs
	 Z0+0Ig/yZMkwVtpt6fsuDOl1vQfDdjzhvK5nqd/l13pMHuBdOs2H5NHilLcIzY/5mm
	 s1m50BMCwqI1sbAkzZekVvMZ7sf22dh0lVxhauLuhXKi/TOpdJGqgX/9Fge3ResuKb
	 IOaQsEHYwjaSIlf8eLyALVX50aBktM88QQNwP1APxk8p/V54thDEsvudOb+k54Nzp2
	 ZeegV4INYQcLosw2Ut74efbOuIKOA8yUTJCX6KsQRFqqfjaY1CM3B5W2RJCDCurvYX
	 k2ZetYunQ3pFA==
Date: Mon, 30 Mar 2026 12:44:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Florian Eckert <fe@dev.tdt.de>
Cc: Chuanhua Lei <lchuanhua@maxlinear.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Johan Hovold <johan+linaro@kernel.org>, Sajid Dalvi <sdalvi@google.com>, 
	Ajay Agarwal <ajayagarwal@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] PCI: intel-gw: Remove atu base assignment
Message-ID: <suniibb6lqihuvjq2jjyxtqojccpxtaacvssw7z4nnvn3l7bep@vi7vxw2dyzkd>
References: <20260317-pcie-intel-gw-v1-0-7fe13726ad4f@dev.tdt.de>
 <20260317-pcie-intel-gw-v1-4-7fe13726ad4f@dev.tdt.de>
 <eu7z775hpux7vo4p2nzzmyqw6fpvehpuabxs7zfjqhhv4hcsnu@d4dns7uuwu2d>
 <55d7a2bee58cc44ca162072b0762b3ac@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55d7a2bee58cc44ca162072b0762b3ac@dev.tdt.de>

On Fri, Mar 27, 2026 at 12:44:34PM +0100, Florian Eckert wrote:
> On 2026-03-26 17:15, Manivannan Sadhasivam wrote:
> > On Tue, Mar 17, 2026 at 11:12:52AM +0100, Florian Eckert wrote:
> > > In the current implementation, only one PCIe bridge is recognised.
> > > This
> > > change removes the assignment of the ATU base address during host
> > > setup.
> > > Instead, the ATU base address is read from the device tree. To do
> > > this,
> > > the 'atu' range of the DTS entry must be changed for PCIe.
> > > 
> > > Old DTS entry for PCIe:
> > > reg = <0xd1000000 0x1000>,
> > > 	<0xd3000000 0x20000>,
> > > 	<0xd0c41000.0x1000>;
> > > reg-names = "dbi", "config", "app";
> > > 
> > > New DTS entry for PCIe
> > > reg = <0xd1000000 0x1000>,
> > > 	<0xd10c0000 0x1000>,
> > > 	<0xd3000000 0x20000>,
> > > 	<0xd0c41000.0x1000>;
> > > reg-names = "dbi", "atu", "config", "app";
> > > 
> > 
> > You just broke the DT backwards compatibility here. What if the driver
> > is used
> > with an old DT that doesn't provide this 'atu' entry? The driver will
> > break.
> > Moreover, this entry should be added to the DT binding first before any
> > driver
> > change.
> 
> When I looked at the driver’s history, I found a note in a commit that the
> driver
> is only used internally by Maxlinear [1]. The maintainer
> 'Lei Chuan Hua <lchuanhua@maxlinear.com>' from Maxlinear was still active at
> that time. He mentioned this on the LKML [2].
> 
> Therefore, backward compatibility shouldn’t be necessary.
> 

Ok, fair enough. But you do need the DT binding change and you should justify
in the commit log of both binding and driver on why you are breaking ABI and why
it is OK.

> Unfortunately, it’s already been three months since I last looked into this
> issue.
> But as far as I can remember I have to read the 'atu' resource from DTS and
> so have
> to remove this line so the driver does work again.
> 
> Because the resource is already initialized by the dwc core during the
> function
> call 'dw_pcie_get_resources()'on line 141 [3]. This function is called in
> the DWC
> host core [4]. This raises the question of why the driver is doing this
> itself at

> all, when the core already handles it for us.
> 

dw_pcie_get_resources() got added recently. So this driver has been passing the
iATU address from its inception.

> Additional, I have noticed that it seems to be bad practice to include this
> resource information in the source code. This information should instead be
> loaded via the DTS see commit [5].
> 
> If backwards compatibility isn't an issue, then the DWC core should handle
> loading the 'atu' resource from the DTS.
> 

Yes, we should always avoid hardcoding the MMIO address in the driver and obtain
it from the hardware description like DT. But some DWC drivers do hardcode the
MMIO address as they often have resources like 'atu' at a fixed offset from the
DBI base address. And those drivers often ended up updating the offset based on
the IP version or compatible. So it is best to get this info from DT.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
