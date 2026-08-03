Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3AA380FEA;
	Mon,  3 Aug 2026 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785776530; cv=none; b=oi5D0y8guE/8Cxv8nEy3PGw/3Fl8YXCi3LLms9eM9Q/45kZQurEVhEUlDa2hPxL9gZyDi1o46iiZxjI52d595AO5QMQNllW6MzWmF/moW4V1YpJV9fSFSrI/DVoTdwHKZohDhbpEHGSsbOanqmkPzohovhlDUB/KbGppbo6tiww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785776530; c=relaxed/simple;
	bh=s8DP0exW6noFakNjmAEoGxt/KjiQ2RcUITJs/qgwVFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhKVY3iMPnOIN2y35+AXcXa/odozIaFiklfY9ikWNfY1H5FesBvL+k+1XKycK0LfRFHyWCGlywMB2oK5WLVEMucry0BxR44zOCaGjIHjWUCJIDDswFpVTYyOqanwLTSeW4qs2yo2/jyLUF5r3Xt2m8UelHMDsTFtuUEVDfbLhLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKyMiGpr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKyMiGpr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69631F000E9;
	Mon,  3 Aug 2026 17:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785776529;
	bh=keUiQ6qgpjMHYHUXJ4nroSzC8Q61wU77/5IXJBD3Bnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gKyMiGprwABocBeBz69ENTHcAxnb8CgknQFrOVIw3lmqKseh8Ty9y+8o3ShznKraj
	 Ehs/cIOOOeXqmouPAn7u9bhBufc0DC8r3aYom2tTR5skXL9infdbWqemZ/0/SV5pp1
	 icU+72K3byYE995xHlnX2FqmlM21s+OyI7Z2CJJqGoOz57/4hbic+1y5Ht9miWFsUa
	 bZqIJjj8u4mwoqSiHAMwdCBuJHPSl6ezHS3wrYAz4fNFrWq8A23qMRyH4XpT18fA1g
	 zIzss7u6SBJ0OLW4Egew6cwH3n5J/jK5lnX5VqBU1SXwg+oX8xJTB8/6y/0Jdr0f+T
	 pQQP+NlPlfw6g==
Date: Mon, 3 Aug 2026 19:02:04 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: dwc: ep: Fix unmap potentially unmapping the
 wrong iATU
Message-ID: <fjib2gdwwmg3qlvjrwy74dt6on4onkj6ynlueqbbuk7gefffxz@rbl57aj3vpz7>
References: <20260730133123.1420413-4-cassel@kernel.org>
 <20260730133123.1420413-6-cassel@kernel.org>
 <20260730135116.950031F000E9@smtp.kernel.org>
 <amtcuIHhH5-f1cqd@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amtcuIHhH5-f1cqd@ryzen>

On Thu, Jul 30, 2026 at 04:16:24PM +0200, Niklas Cassel wrote:
> On Thu, Jul 30, 2026 at 01:51:16PM +0000, sashiko-bot@kernel.org wrote:
> > New issues:
> > - [High] Using `readl()` on the host's MSI target address to flush posted writes generates a dangerous PCIe Memory Read Request, causing kernel panics.
> 
> (snip)
> 
> > [Severity: High]
> > Does using readl() on the host's MSI target address generate a dangerous
> > non-posted PCIe Memory Read Request?
> > 
> > Most host interrupt controllers (like GIC ITS or APIC) do not support reads
> > to their doorbell addresses and will reply with an Unsupported Request (UR).
> > 
> > The DWC controller translates the UR completion into an AXI Slave Error,
> > which can trigger a synchronous external abort and kernel panic on the
> > endpoint CPU.
> > 
> > This concern applies to flushing posted writes in both
> > dw_pcie_ep_raise_msix_irq() and dw_pcie_ep_raise_msi_irq().
> > 
> > > +		dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
> > > +		ep->msi_iatu_mapped = false;
> > > +	}
> > > +
> > >  	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);
> > 
> 
> I don't see how this comment is valid.
> 
> I tested this patch with two Rock 5Bs, one in EP mode and one in RC mode.
> 
> The PCIe controller on the host:
> https://github.com/torvalds/linux/blob/v7.2-rc5/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi#L370
> is indeed using GIC ITS, and I saw no issues at all.
> 
> Additionally, we have already been doing a readl() on the MSI-X target
> address, for every single MSI-X, since commit c22533c66cca ("PCI: dwc: ep:
> Flush MSI-X write before unmapping its ATU entry"), first included in
> v7.0-rc2, and not a single soul has complained since then.
> 
> So personally I am not too concerned.
> 

So either the readl() is not generating a PCIe MRd TLP or the host is not
generating UR for the MRd TLP which ends up crashing the Endpoint. In any case,
since the MSI-X read-back was present for a while, we don't need to worry about
this theory.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
