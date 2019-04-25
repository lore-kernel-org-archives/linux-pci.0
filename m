Return-Path: <SRS0=AiiY=S3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C8FC43219
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 15:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3168F2081C
	for <linux-pci@archiver.kernel.org>; Thu, 25 Apr 2019 15:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfDYPGs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:06:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46182 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfDYPGr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Apr 2019 11:06:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3918A78;
        Thu, 25 Apr 2019 08:06:46 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F76C3F5AF;
        Thu, 25 Apr 2019 08:06:45 -0700 (PDT)
Date:   Thu, 25 Apr 2019 16:06:40 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ellie Reeves <ellierevves@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: aardvark: Use LTSSM state to build link training
 flag
Message-ID: <20190425150640.GA20770@e121166-lin.cambridge.arm.com>
References: <20190316161243.29517-1-repk@triplefau.lt>
 <20190425110830.GC10833@e121166-lin.cambridge.arm.com>
 <20190425142353.GO2754@voidbox.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425142353.GO2754@voidbox.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 25, 2019 at 04:23:53PM +0200, Remi Pommarel wrote:
> Hi Lorenzo,
> 
> On Thu, Apr 25, 2019 at 12:08:30PM +0100, Lorenzo Pieralisi wrote:
> > On Sat, Mar 16, 2019 at 05:12:43PM +0100, Remi Pommarel wrote:
> > > The PCI_EXP_LNKSTA_LT flag in the emulated root device's PCI_EXP_LNKSTA
> > > config register does not reflect the actual link training state and is
> > > always cleared. The Link Training and Status State Machine (LTSSM) flag
> > > in LMI config register could be used as a link training indicator.
> > > Indeed if the LTSSM is in L0 or upper state then link training has
> > > completed (see [1]).
> > > 
> > > Unfortunately because setting the PCI_EXP_LINCTL_RL flag does not
> > > instantly imply a LTSSM state change (e.g. L0s to recovery state
> > > transition takes some time), LTSSM can be in L0 but link training has
> > > not finished yet. Thus a lower L0 LTSSM state followed by a L0 or upper
> > > state sequence has to be seen to be sure that link training has been
> > > done.
> > 
> > Hi Remi,
> > 
> > I am a bit confused, so you are saying that the LTSSM flag in the
> > LMI config register can't be used to detect when training is completed ?
> 
> Not exactly, I am saying that PCI_EXP_LNKSTA_LT from PCI_EXP_LNKSTA
> register can't be used with this hardware, but can be emulated with
> LTSSM flag.
> 
> > 
> > Certainly it can't be used by ASPM core that relies on:
> > 
> > PCI_EXP_LNKSTA_LT flag
> > 
> > in the PCI_EXP_LNKSTA register, and that's what you are setting through
> > this timeout mechanism IIUC.
> > 
> > Please elaborate on that.
> 
> The problem here is that the hardware does not change PCI_EXP_LNKSTA_LT
> at all. So in order to support link re-training feature we need to
> emulate this flag. To do so LTSSM flag can be used.

Understood.

> Indeed we can set the emulated PCI_EXP_LNKSTA_LT as soon as re-training
> is asked and wait for LTSSM flag to be back to a configured state
> (e.g. L0, L0s) before clearing it.

The check for the LTSSM is carried out through advk_pcie_link_up()
(ie register CFG_REG), correct ?

> The problem with that is that LTSSM flag does not change instantly after
> link re-training has been asked, and will stay in configured state for a
> small amount of time. So the idea is to poll the LTSSM flag and wait for
> it to enter a recovery state then waiting for it to be back in
> configured state.

When you say "poll" you mean checking advk_pcie_link_up() ?

More below on the code.

> The timeout is only here as a fallback in the unlikely event that we
> missed the LTSSM flag entering recovery state.
> 
> > 
> > I am picking Bjorn's brain on this patch since what you are doing
> > seems quite arbitrary and honestly it is a bit of a hack.
> 
> Yes, sorry, it is a bit of a hack because I try to workaround a
> hardware issue.

No problems, it is not your fault.
> 
> Please note that vendor has been contacted about this in the meantime
> and answered the following:
> 
> "FW can poll LTSSM state equals any of the following values: 0xB or 0xD
> or 0xC or 0xE. After that, polls for LTSSM equals 0x10. For your
> information, LTSSM will transit from 0x10 -> 0xB -> 0xD -> 0xC or 0xE
> ........... -> 0x10".
> 
> It is basically what this patch does, I've just added a timeout fallback
> to not poll LTSSM state forever if its transition to 0xB, 0xD, 0xC or
> 0xE has been missed.

When you say "missed" you mean advk_pcie_link_up() returning true, right ?

[...]

> > > +static int advk_pcie_link_retraining(struct advk_pcie *pcie)
> > > +{
> > > +	if (!advk_pcie_link_up(pcie)) {

That's the bit I find confusing. Is this check here to detect if the
link went through the sequence below ? Should not it be carried
out only if (pcie->rl_asked == 1) ?

"... LTSSM will transit from 0x10 -> 0xB -> 0xD -> 0xC or 0xE
 ........... -> 0x10".

> > > +		pcie->rl_asked = 0;

Why ?

> > > +		return 1;
> > > +	}
> > > +
> > > +	if (pcie->rl_asked && time_before(jiffies, pcie->rl_deadline))
> > > +		return 1;

This ensures that if the LTSSM >= 0x10 we still wait for a delay before
considering the link up (because I suppose, after asking a retraining
it takes a while for the LTSSM state to become < 0x10), correct ?

You have to comment this code since it is not easy to grasp.

Lorenzo

> > > +
> > > +	pcie->rl_asked = 0;
> > > +	return 0;
> > > +}
> > >  
> > >  static pci_bridge_emul_read_status_t
> > >  advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
> > > @@ -426,11 +442,19 @@ advk_pci_bridge_emul_pcie_conf_read(struct pci_bridge_emul *bridge,
> > >  		return PCI_BRIDGE_EMUL_HANDLED;
> > >  	}
> > >  
> > > +	case PCI_EXP_LNKCTL: {
> > > +		u32 val = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg) &
> > > +			~(PCI_EXP_LNKSTA_LT << 16);
> > > +		if (advk_pcie_link_retraining(pcie))
> > > +			val |= (PCI_EXP_LNKSTA_LT << 16);
> > > +		*value = val;
> > > +		return PCI_BRIDGE_EMUL_HANDLED;
> > > +	}
> > > +
> > >  	case PCI_CAP_LIST_ID:
> > >  	case PCI_EXP_DEVCAP:
> > >  	case PCI_EXP_DEVCTL:
> > >  	case PCI_EXP_LNKCAP:
> > > -	case PCI_EXP_LNKCTL:
> > >  		*value = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + reg);
> > >  		return PCI_BRIDGE_EMUL_HANDLED;
> > >  	default:
> > > @@ -447,8 +471,15 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
> > >  
> > >  	switch (reg) {
> > >  	case PCI_EXP_DEVCTL:
> > > +		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
> > > +		break;
> > > +
> > >  	case PCI_EXP_LNKCTL:
> > >  		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
> > > +		if (new & PCI_EXP_LNKCTL_RL) {
> > > +			pcie->rl_asked = 1;
> > > +			pcie->rl_deadline = jiffies + LINK_RETRAIN_DELAY_MAX;
> > > +		}
> > >  		break;
> > >  
> > >  	case PCI_EXP_RTCTL:
> > > -- 
> > > 2.20.1
> > > 
