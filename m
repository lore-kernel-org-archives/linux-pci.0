Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A597349CFD
	for <linux-pci@vger.kernel.org>; Sun, 18 Oct 2026 04:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792298152; cv=none; b=GJBg2pv4Kb5RHIh3gU/2t6Ugpc0uqo1kakJ0I1Bq7gstSxxcdCS6QYoB702zysNSNloWxDpGudYekrc/LOE8UVHbOKqYotEyfS+4Sn0spA/W11IzykafnzGN74jLyW4DSTT2XJYmfQslSW7RlecXTZQeOcDMv8kU2B13pSnOCmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792298152; c=relaxed/simple;
	bh=Yqd4iOCg4iu2u405pEONxbc5rSue+ZGiXbk0EdbQS1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T12qPt76+rLzGaZvMs0a0hZsrI10y+U/nil6BwIELV+TM9ul3nRwUM72qG1h5dXHjGihMSYYm6AKr2z3uzeIEOWYV3ZFEdBxFJF2nIqiOEkaXQErTGdH9SNFV5Vq3PhgKdeaFnvaYc1UOCcEr/7jRCm2zm3c5PFg24Gw0l1iSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3E9Rqqn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3E9Rqqn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E451F000C4;
	Sun, 18 Oct 2026 04:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792298151;
	bh=qdIVrSpMtK5zxHRgcArGiQkPWd9/eYBAHEZePZ+kECI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A3E9Rqqnj37ALGfj9RcYKyKZNOvIQSgWV+TXcMuqbPw6r9dnPHBV4Rv5dJdPyF93G
	 ICL7Q4aMhGC5eGXk3okNZmot2vxMuzRGjc+Y3erSJn4+sEUw782qElApJZE2XjBiWR
	 Dp61hdStKxV40IRbbu0FQ7G4uTXGUjKxl3GW5+/GNRGR9ZzElI5g1uUvQYkGjA6Ygu
	 8qjD9w2ANmU8FXA7S2yjAi722sS4CRNGP0iUGt5sCrV/iP/GgqDzGQ52TIUvPEluUZ
	 byd9IMJGOzIzNi5ExpIBVP0u24FelroZprGtRgC17smV9cWflUKKnIRno3W42NUog5
	 ioxRkbj77pvgA==
Date: Sun, 18 Oct 2026 10:05:39 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dw-rockchip: Enable INTx affinity support
Message-ID: <atRLsp1qUA_sGS-0@debian>
References: <1790664898-207928-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1790664898-207928-1-git-send-email-shawn.lin@rock-chips.com>

+ Thomas

On Tue, Sep 29, 2026 at 02:54:58PM +0800, Shawn Lin wrote:
> Leverage the interrupt redirection infrastructure to enable CPU
> affinity support for the legacy INTx interrupts. The INTx virqs are
> demultiplexed by the chained handler of the "legacy" interrupt, whose
> affinity cannot be changed, so affinity control for the INTx virqs is
> achieved by redirecting the handler to run in IRQ work context on the
> target CPU.
> 
> Mask the INTx source in .irq_pre_redirect() before the handler is
> redirected: the legacy interrupt is level triggered, so an unmasked
> line would keep re-firing the chained interrupt until the redirected
> handler runs.
> 
> Same approach as the DesignWare core, commit eaf290c404f7c39f2 ("PCI:
> dwc: Enable MSI affinity support").
> 
> Test was done on RK3588 EVB1 board with an NVMe with pci=nomsi
> parameter. The /proc/interrupts columns are trimmed for brevity.
> 
>   # cat /proc/interrupts | grep INTx
>   51:  137 0 0 0 0 0 0 0 INTx 0 Edge PCIe PME, nvme0q0, nvme0q1
>   # echo 10 > /proc/irq/51/smp_affinity
>   # dd if=/dev/nvme0n1p1 of=/dev/null bs=1M count=200
>   200+0 records in
>   200+0 records out
>   209715200 bytes (210 MB, 200 MiB) copied, 0.182021 s, 1.2 GB/s
>   # cat /proc/interrupts | grep INTx
>   51:  137 0 0 0 946 0 0 0 INTx 0 Edge PCIe PME, nvme0q0, nvme0q1
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

I'd like to get an Ack from Thomas for this patch since I'm not an irqchip
expert to decipher whether this patch is valid or not.

If this patch is valid and INTx affinity can be enabled like this, I'd like to
extend this to other RC drivers exposing INTx irqchip.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
