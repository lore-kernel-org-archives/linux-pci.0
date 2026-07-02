Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E333D4128;
	Thu,  2 Jul 2026 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979695; cv=none; b=tk1XQkkxeCWhoWjgB1azn56B1EcBDrUdqTXCgwUUOIN1fO4EEWQebtd5c5mAH2yhQMm+hI1ykChQHTcEhqpIWmSkoQ7Zd3GtWeDS42FkcERkATHZbBFDHiin5zkp7G+9pIRfwhE6kB0W6NPydxfLJukiEZQYztfnEr6Hq97VAn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979695; c=relaxed/simple;
	bh=7Bxp6L7c4GBiyTQ+N598V0dr731D5JIIwB8F2IwX46k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6xwhAc5g9wJemcZaf0kd/B8mhJHNZHqTUmSTuB6tmdqVF8BHKwMdLQcPR3vD7Y8FXjJqvqZaOR1Wfr+Tr4iGSvIuXoggT/mL0U3eBg1HY/ffvBIt/kEVddb2uEI74WKKzrluMy/Hd77JtRlgo2NEXTwf4veFVFpJK7wpYPfykE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmvyEr0J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmvyEr0J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2A41F000E9;
	Thu,  2 Jul 2026 08:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782979694;
	bh=LEZ9FXTh3lbFrgZS4VvA4DGKcjdCgOjVpgz/HPsJPgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mmvyEr0J4QaiLYA+LYhUXtyPtCU7MnYt84jazBmvGdi/BrL8g43AwEkISeZQyOJNo
	 Z1MxdEwvHtPEXx9jx7X6Z+HaGvxuya5hm6RaALfmSv/nh+w7uaiQ1zKalj2lcg1eFb
	 Pp7D4A3Na7PK6mh9qvywmPVTCuOAcxywem+75ubv6P14LY9pGL44cH+7aNjhn6bxK1
	 s6FRsoisVkkLqvWwVBA5NsSYCy7RynKSKLXplqIUJFjlbsv+1FjJwZU8ytG2AOY3Dr
	 Tx0u5hzhTiNykvs4HvBPJg/RzUZR/el4zMUqPcDJZL8nTsaNvO8OIwgxjMMoE728we
	 35XJ/D52nm+bg==
Date: Thu, 2 Jul 2026 10:08:06 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Max Lee <max.lee@canonical.com>, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, acelan.kao@canonical.com, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Victor Shih <victorshihgli@gmail.com>, 
	Lukas Wunner <lukas@wunner.de>, Jon Pan-Doh <pandoh@google.com>
Subject: Re: [PATCH v2] PCI: Mask Replay Timer Timeout for Realtek RTS525A
Message-ID: <yomdfujuuzw4dvl7dip5ywwcceovlf76qzgkpirnpdqix5txzj@m4blcyhitouv>
References: <oc3i3yn4c22s5c3gtqgs7a4wrpqiywwvboxstdf7josxddqmpd@y43m75ovby2t>
 <20260701204201.GA302478@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701204201.GA302478@bhelgaas>

On Wed, Jul 01, 2026 at 03:42:01PM -0500, Bjorn Helgaas wrote:
> [+cc Kai-Heng, Victor, Lukas, Jon]
> 
> On Wed, Jul 01, 2026 at 08:27:13AM +0200, Manivannan Sadhasivam wrote:
> > On Wed, Jun 10, 2026 at 10:47:23AM +0800, Max Lee wrote:
> > > The Realtek RTS525A PCI-Express SD card reader (10ec:525a) generates
> > > excessive Correctable Error (Replay Timer Timeout) AER events during
> > > PCIe link initialization. On systems where firmware enables AER
> > > reporting (CERptEn+), this causes an AER storm of ~240K error events
> > > within 11 seconds of boot, overwhelming the kernel error handler and
> > > blocking shutdown/reboot.
> 
> Specifically, I guess these error events are the AER interrupts.  We
> rate-limit the actual *messages*, but not the interrupts, so we can be
> overwhelmed by handling them.
> 
> > > The root cause is a transient link training instability inherent to this
> > > device -- even on BIOS versions that suppress reporting, the error
> > > status register (CESta) shows Timeout+ set.
> > > 
> > > Unlike the GL9750/GL9755 fixup, which only masks the parent root port,
> 
> I think PCI_ERR_COR_REP_TIMER is masked in both the GL975x Endpoint
> and the Downstream Port leading to it:
> 
>   015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Mask the replay timer
>   timeout of AER")
> 
>   eeee3b5e6d0b ("PCI: Mask Replay Timer Timeout errors for Genesys
>   GL975x SD host controller")
> 
> Maybe those should be combined so the quirk masks
> PCI_ERR_COR_REP_TIMER at both ends of the link in one place.  A quirk
> like that could be used for both GL975x and RTS525A.
> 
> > > the RTS525A also needs its endpoint Correctable Error Mask bit 12
> > > (PCI_ERR_COR_REP_TIMER) masked when the endpoint exposes AER, so it does
> > > not send ERR_COR messages upstream. Also mask the parent root port to
> > > cover root-port reporting of link errors caused by the endpoint.
> 
> I think this and the similar comment in the code are slightly
> misleading.  pci_mask_replay_timer_timeout() masks
> PCI_ERR_COR_REP_TIMER in the Downstream Port leading to pdev.  That
> may be either a Root Port or a Switch Downstream Port.
> 
> > > Signed-off-by: Max Lee <max.lee@canonical.com>
> > > ---
> > > Changes in v2:
> > >   - Mask the parent root port even when the endpoint lacks AER capability.
> > 
> > You've added this based on the comment by Sashiko I believe. But I
> > think Sashiko was wrong here. If the EP lacks AER capability, then
> > there is no way it is going to send AER errors to upstream RP. So it
> > is OK to skip the quirk.
> 
> I'm not sure it's OK to skip the quirk.
> 
> Based on the flowchart in PCIe r7.0, sec 6.2.5, it looks like an
> Endpoint that detects a Correctable Error but lacks an AER Capability
> sets PCI_EXP_DEVSTA_CED and, if PCI_EXP_DEVCTL_CERE is set, sends
> ERR_COR upstream.
> 

Ah, you're right. I missed CERE.

> I suspect that what we need here is:
> 
>   - Mask PCI_ERR_COR_REP_TIMER in Endpoint to prevent it from sending
>     ERR_COR
> 
>   - Mask PCI_ERR_COR_REP_TIMER in upstream bridge to prevent it from
>     sending ERR_COR
> 
>   - If the upstream bridge is not the Root Port, mask
>     PCI_ERR_COR_REP_TIMER in Root Port to prevent AER interrupt if it
>     receives ERR_COR, e.g., if the Endpoint or bridge lacks AER
> 

If the endpoint lacks AER capability, it will simply send an ERR_COR message to
the upstream bridge without any advanced logging info. Because the message
reaches the Root Port as a generic ERR_COR, RP will log the error in its Root
Error Status register and raise the AER interrupt without checking its own
PCI_ERR_COR_REP_TIMER mask status. Also, any upstream bridge lacking AER
capability will simply forward the ERR_COR message upstream irrespective of its
own PCI_ERR_COR_REP_TIMER status.

So if the endpoint lacks AER capability, we cannot prevent it from reporting the
error, unless we disable CERE, which will affect other errors also. However, we
can still mask PCI_ERR_COR_REP_TIMER in the upstream bridge's AER to prevent
the bridge itself from generating its own Replay Link Timeout errors due to the
endpoint's behavior, but this acts only as a safeguard and will not prevent the
messages originating from the endpoint.

Correct me if my understanding is wrong.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
