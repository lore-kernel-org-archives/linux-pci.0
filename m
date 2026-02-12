Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B0B32C924
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770934324; cv=none; b=Y7W6iwYI0EDUkj2aGAgovaWVwq8hEpsF1Aap2y6Bzmq+vQsvJHWR03/5eONbV01xQIegWz1r1J9O9hHqVh7Myvn3JLbqtczhcxSgjjLeZUqzIduo2UijIYfuN2LoWh7PBKd4OH0LYniwakpmZ4aH4p2YHyuEkLbBuSHJhISNXXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770934324; c=relaxed/simple;
	bh=P+pzFy5+vWY5qTnGnrzxTzJSZtVT7IXcrh2A7b5elxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSkXFzRR2Sytvv+ntqAuqq5q/XkaXkhupeS46UH6/UI2p+JKHVb3hYKpgp5k57VOe0QpRDrzio0LcXGuLnC8kBYmYzjYHWehKkNADRqoofXDcerkelClMMRlnPLY+Mz+2kp3Cw2ysmtq3wxL0S86xhg7FNMEaN+Bk6Ths0vGE/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcLI7bwh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcLI7bwh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC22C4CEF7;
	Thu, 12 Feb 2026 22:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770934324;
	bh=P+pzFy5+vWY5qTnGnrzxTzJSZtVT7IXcrh2A7b5elxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JcLI7bwhIQvmph+YAT0zMjnZPvqg7dkFnT01aYEagdXQb72kqmhK0Kk12M66Ymo7O
	 yk5QNQ70dSTW3DDXMQsnvdcqPYTvPXYnyGpJT2iuIyJm7TsXWzUurSb/1Q4RAt37kC
	 Ny0uW6T2TpKrtvXm9RVvPHFGxLAjHqL7WYiOokhss0pUCmd9lCgvMkvctosZuKd6rc
	 Tz+/X59ZGhdy6EI6YscT7eMewWezTd4IWBWg/2NxBsQfHxw6aR5ST/mt/IlAEuoOQ/
	 pT+LIw7EHJf2iscEgha5wqJlRKtAveOEZlx7pF/GNDYQCkxKMm58+g2vnR522ZFOkT
	 sA8oG1OH6TbWQ==
Date: Thu, 12 Feb 2026 15:12:02 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Danielle Costantino <dcostantino@meta.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/DPC: Clear Interrupt Status in dpc_reset_link()
Message-ID: <aY5QMlr_7XLIbOsV@kbusch-mbp>
References: <20260212191818.3625264-1-dcostantino@meta.com>
 <20260212191818.3625264-2-dcostantino@meta.com>
 <9b75cf12-a0b4-49bf-b261-cbe02c0fe310@linux.intel.com>
 <aY5E4OWE_v0Jdyd1@kbusch-mbp>
 <9a7a176d-4450-47ac-859c-0ce69a19afee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a7a176d-4450-47ac-859c-0ce69a19afee@linux.intel.com>

On Thu, Feb 12, 2026 at 01:49:52PM -0800, Kuppuswamy Sathyanarayanan wrote:
> Hi Keith,
> 
> On 2/12/2026 1:23 PM, Keith Busch wrote:
> > On Thu, Feb 12, 2026 at 11:50:54AM -0800, Kuppuswamy Sathyanarayanan wrote:
> >> In case of EDR, firmware owns the interrupt handling. It just uses ACPI
> >> method to request OS help with recovery. Since interrupt handling is
> >> owned by firmware, I think firmware should clear the interrupt status.
> > 
> > But the PCI Firmware Specication says the OS owns the status register
> > while it is handling EDR notification
> > 
> > "
> >    the operating system is permitted to write the following:
> > 
> >      * Device Status Register
> >      * Uncorrectable Error Status Register
> >      * Correctable Error Status Register
> >      * Root Error Status Register
> >      * RP PIO Status Register
> > 
> >    in the Port that triggered DPC while processing an Error Disconnect Recover
> >    notification from firmware
> > "
> 
> Please check the _OSC DPC control bit details in PCI firmware spec.
> 
> It specifically calls out OS is permitted to write to DPC trigger status
> bit in DPC status register. It does not talk about about DPC interrupt
> status bit.
> 
> Copied here for reference:
> 
> "If control of this feature was requested and denied, or was not requested,
> then the operating system is permitted to write to the DPC Trigger Status bit
> in the DPC Status Register in the Port that triggered containment"
> 
> I think since firmware registers interrupt handler for DPC, after OS helps
> handle the recovery it should complete the loop and clear it.

But that just creates a window for when after the OS lets the link
retrain that the port will be unable to trigger a new containment event.

Sure, there's no explicit language in any spec I can find that the OS
must write 1 to bit 3 of the status register, but it doesn't say
firmware owns that bit either. The firmware handed control of the status
to the OS in this path. It would not make sense to return to firmware in
a state that makes it impossible to report new errors during that
transition window.

Besides, is firmware first even triggering off an interrupt? Pretty sure
it's triggering off the ERR_COR message, no? Why would it need to own
the Interrupt Status bit when it's not even relying on it?
