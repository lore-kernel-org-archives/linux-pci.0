Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C27347BD7;
	Thu, 30 Jul 2026 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420989; cv=none; b=uzkBiqg5puElg0Rezq+XwvYpZ0BS9xTbjVsACdh/m1G4VHSl7CUzteb0UBm8XrOt3Pk7jmzVvCJB1a97JSywHn7GXnuyaDCD2dt3+Btbe7owSA294mInub8thsuZO4sRGzlMV9Ilflgio4zAaDwXHB3vrVmSmQJPI5RB9eDrF3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420989; c=relaxed/simple;
	bh=olu8qrnyJBKXKBWPgV8op4bNTr/vWo54B0cqvuEdS7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+hz2Ubo0uOwspevfsjH4QJ3lv18HNCY8ds95O6ehDqAfhzJOfPL4ugWgYwSKkQWVwEpFM/us/RNMl4DyqW9ceUPPVUprLWT84u7Pb5AUC31YrhIVM25LN9mlP0Q5BtGB9f4iSnRxUnwVa+KIIFE5pjlKSEVSEPlChYpWZw4994=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiVwjMDV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiVwjMDV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2631F000E9;
	Thu, 30 Jul 2026 14:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785420987;
	bh=m5hQrrskYjOxgl/yJuBD54inLkA+2XpLqqIF5NOHV+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BiVwjMDVphid46z0BoY1y7VZGJHmhe8/Z8cUIPrFetWDfS8KBsMAT/JPcmtvJnKHg
	 kCp9ZfX4h3TyMlRjh9QLBOnNcbnNyx5fLPh94oce+Tf5M/Ihm8naI3vUiMpZQeGegW
	 X9KhI0okiST6LnlpI626JqcLV4z4QbGAHBgG9lZBOL7wxlFBj0tfpiFdGHqgXirIrP
	 6KNQYgDSPiESmBRyVOS8vOIJL7V/9A8p5/dPeUrBeTMJ0+4BCUUPxBn17c5mEizWoy
	 vxed9pwHP/RUHQ1Jxi5C3yZd93LHlm221jOyViljknMnOM7yJwVrW9rr8sPrExaJao
	 6sLUez6Qwl4hg==
Date: Thu, 30 Jul 2026 16:16:24 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: dwc: ep: Fix unmap potentially unmapping the
 wrong iATU
Message-ID: <amtcuIHhH5-f1cqd@ryzen>
References: <20260730133123.1420413-4-cassel@kernel.org>
 <20260730133123.1420413-6-cassel@kernel.org>
 <20260730135116.950031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730135116.950031F000E9@smtp.kernel.org>

On Thu, Jul 30, 2026 at 01:51:16PM +0000, sashiko-bot@kernel.org wrote:
> New issues:
> - [High] Using `readl()` on the host's MSI target address to flush posted writes generates a dangerous PCIe Memory Read Request, causing kernel panics.

(snip)

> [Severity: High]
> Does using readl() on the host's MSI target address generate a dangerous
> non-posted PCIe Memory Read Request?
> 
> Most host interrupt controllers (like GIC ITS or APIC) do not support reads
> to their doorbell addresses and will reply with an Unsupported Request (UR).
> 
> The DWC controller translates the UR completion into an AXI Slave Error,
> which can trigger a synchronous external abort and kernel panic on the
> endpoint CPU.
> 
> This concern applies to flushing posted writes in both
> dw_pcie_ep_raise_msix_irq() and dw_pcie_ep_raise_msi_irq().
> 
> > +		dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
> > +		ep->msi_iatu_mapped = false;
> > +	}
> > +
> >  	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);
> 

I don't see how this comment is valid.

I tested this patch with two Rock 5Bs, one in EP mode and one in RC mode.

The PCIe controller on the host:
https://github.com/torvalds/linux/blob/v7.2-rc5/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi#L370
is indeed using GIC ITS, and I saw no issues at all.

Additionally, we have already been doing a readl() on the MSI-X target
address, for every single MSI-X, since commit c22533c66cca ("PCI: dwc: ep:
Flush MSI-X write before unmapping its ATU entry"), first included in
v7.0-rc2, and not a single soul has complained since then.

So personally I am not too concerned.


Kind regards,
Niklas
