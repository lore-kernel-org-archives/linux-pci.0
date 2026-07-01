Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A04028F949;
	Wed,  1 Jul 2026 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938524; cv=none; b=PuKeHgGaazQk4S49KQPjpXJuV1Hv3r4bKB8dqbEHD0izDnkeKrvSBqIw0hLExAugxx+h60NLq6ykpazMS036/80vQmgUWmuyk5YvZt+FWfX5VfmIJZk3tPIGfkf9wbg8Val0dMafpdrw6z1D6qhe4AWMw6kxitdhuSiEEFIXs1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938524; c=relaxed/simple;
	bh=ZN9AZcGKAHaLOTcgERXge7BsFowGdMD3CJWwWGLUh7c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=vD1+euhwUZXuVzojyyU8YePeXtRE+KBLNPHdxqaCloTh2tNcBE54WDDsO/8A4QdbCTFUZL98hFr1wApJkLt4VI56pA8aWIBeNb+AkQWBelGNj5PnQYvUUeeBfSUJi6+5P6IuoFHGS/OhhEenzZo4YqgjIKxilvVz+YhJ9SGg+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbwM3lPr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbwM3lPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7231B1F000E9;
	Wed,  1 Jul 2026 20:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782938522;
	bh=cGQKT2MFOzeJX1V7gjheSzUBLNFkYL74RYdPRxHX6TY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=AbwM3lPrIc+zNJvvP+hoJFeSggenzsKaQrLyeUchvrfxkQyOd1q5/hdwmvGhgYOXy
	 fj/JNvP0Kr3EFwAhZg+/6kELI3mgsR3hqKsaYYdJ9TYPfKdKKQzhcOm0N8KrHsC5EY
	 sULegjgs0ag2T3u1bRm9NG1CCUga0U1oIhOAikUEG5OuUjOBfOZ7zwCbusoIQHHqTR
	 7RbsU72E7/+km76C0NbrVFZaq169bL3qHF8W1xkiMRJ6m7VCNmfMjcakDX2OncjyiO
	 kg+OVLKEQUfP+PySO9z2R5EdWzo8XNQL4WGA/W1m4NADYpwgadQn5LFfdbTIQJjNok
	 SoV6vGzgygPLQ==
Date: Wed, 1 Jul 2026 15:42:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Max Lee <max.lee@canonical.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	acelan.kao@canonical.com, Kai-Heng Feng <kaihengf@nvidia.com>,
	Victor Shih <victorshihgli@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, Jon Pan-Doh <pandoh@google.com>
Subject: Re: [PATCH v2] PCI: Mask Replay Timer Timeout for Realtek RTS525A
Message-ID: <20260701204201.GA302478@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oc3i3yn4c22s5c3gtqgs7a4wrpqiywwvboxstdf7josxddqmpd@y43m75ovby2t>

[+cc Kai-Heng, Victor, Lukas, Jon]

On Wed, Jul 01, 2026 at 08:27:13AM +0200, Manivannan Sadhasivam wrote:
> On Wed, Jun 10, 2026 at 10:47:23AM +0800, Max Lee wrote:
> > The Realtek RTS525A PCI-Express SD card reader (10ec:525a) generates
> > excessive Correctable Error (Replay Timer Timeout) AER events during
> > PCIe link initialization. On systems where firmware enables AER
> > reporting (CERptEn+), this causes an AER storm of ~240K error events
> > within 11 seconds of boot, overwhelming the kernel error handler and
> > blocking shutdown/reboot.

Specifically, I guess these error events are the AER interrupts.  We
rate-limit the actual *messages*, but not the interrupts, so we can be
overwhelmed by handling them.

> > The root cause is a transient link training instability inherent to this
> > device -- even on BIOS versions that suppress reporting, the error
> > status register (CESta) shows Timeout+ set.
> > 
> > Unlike the GL9750/GL9755 fixup, which only masks the parent root port,

I think PCI_ERR_COR_REP_TIMER is masked in both the GL975x Endpoint
and the Downstream Port leading to it:

  015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Mask the replay timer
  timeout of AER")

  eeee3b5e6d0b ("PCI: Mask Replay Timer Timeout errors for Genesys
  GL975x SD host controller")

Maybe those should be combined so the quirk masks
PCI_ERR_COR_REP_TIMER at both ends of the link in one place.  A quirk
like that could be used for both GL975x and RTS525A.

> > the RTS525A also needs its endpoint Correctable Error Mask bit 12
> > (PCI_ERR_COR_REP_TIMER) masked when the endpoint exposes AER, so it does
> > not send ERR_COR messages upstream. Also mask the parent root port to
> > cover root-port reporting of link errors caused by the endpoint.

I think this and the similar comment in the code are slightly
misleading.  pci_mask_replay_timer_timeout() masks
PCI_ERR_COR_REP_TIMER in the Downstream Port leading to pdev.  That
may be either a Root Port or a Switch Downstream Port.

> > Signed-off-by: Max Lee <max.lee@canonical.com>
> > ---
> > Changes in v2:
> >   - Mask the parent root port even when the endpoint lacks AER capability.
> 
> You've added this based on the comment by Sashiko I believe. But I
> think Sashiko was wrong here. If the EP lacks AER capability, then
> there is no way it is going to send AER errors to upstream RP. So it
> is OK to skip the quirk.

I'm not sure it's OK to skip the quirk.

Based on the flowchart in PCIe r7.0, sec 6.2.5, it looks like an
Endpoint that detects a Correctable Error but lacks an AER Capability
sets PCI_EXP_DEVSTA_CED and, if PCI_EXP_DEVCTL_CERE is set, sends
ERR_COR upstream.

I suspect that what we need here is:

  - Mask PCI_ERR_COR_REP_TIMER in Endpoint to prevent it from sending
    ERR_COR

  - Mask PCI_ERR_COR_REP_TIMER in upstream bridge to prevent it from
    sending ERR_COR

  - If the upstream bridge is not the Root Port, mask
    PCI_ERR_COR_REP_TIMER in Root Port to prevent AER interrupt if it
    receives ERR_COR, e.g., if the Endpoint or bridge lacks AER

I wonder if aer.c should disable the AER interrupt by temporarily
clearing PCI_ERR_ROOT_CMD_COR_EN if it detects a storm.  Maybe that
could avoid device quirks for transient issues like this.

> There is a slight chance that the RP itself generating AER events
> when it has detected the Replay Timeout. But to verify, you need to
> share the AER log during bootup.
> 
> Also, since you mentioned that the firmware is enabling the AER
> reporting for the device, which means the device would've been
> enumerated by BIOS before the kernel boots. In that case, RP would
> still continue to receive the COR_ERR and by the time the AER driver
> binds to the RP (which happens before the quirk for the RTS525A gets
> executed due to depth first enumeration), those AER errors will
> still be logged until the quirk execution. So you'd still see AER
> errors in dmesg, but not a flood before this patch.

> > +++ b/drivers/pci/quirks.c
> > @@ -6380,4 +6380,26 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
> >  }
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
> > +
> > +static void pci_mask_replay_timer_timeout_on_endpoint(struct pci_dev *pdev)
> > +{
> > +	u32 val;
> > +
> > +	if (pdev->aer_cap) {
> > +		pci_info(pdev, "mask Replay Timer Timeout on endpoint due to hardware defect\n");
> > +
> > +		pci_read_config_dword(pdev, pdev->aer_cap + PCI_ERR_COR_MASK, &val);
> > +		val |= PCI_ERR_COR_REP_TIMER;
> > +		pci_write_config_dword(pdev, pdev->aer_cap + PCI_ERR_COR_MASK, val);
> > +	}
> > +
> > +	/*
> > +	 * Also mask the parent root port. Do this even if the endpoint lacks
> > +	 * AER capability because the root port may still report link errors
> > +	 * caused by the endpoint.
> > +	 */
> > +	pci_mask_replay_timer_timeout(pdev);
> > +}
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, 0x525a,
> > +			pci_mask_replay_timer_timeout_on_endpoint);
> >  #endif
> > -- 
> > 2.43.0
> > 
