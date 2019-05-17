Return-Path: <SRS0=S6xX=TR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9C6C04AB4
	for <linux-pci@archiver.kernel.org>; Fri, 17 May 2019 13:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FEF2168B
	for <linux-pci@archiver.kernel.org>; Fri, 17 May 2019 13:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558099496;
	bh=1l3aEKcWXS7u0eJCQcg2c+X7k3wBikYs5PdunFGggVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2WpBwPMbZ0FIsWVTHejx7vBEi1APZlBK0ojGUrpxsprfsoF1NimVhbzZ4AAoQinnV
	 c0cC3ZcKaB7jpj/cuPOeFkpwee6WL+AZ5BXey3Ou4bmcfy4sDL3uCG75UGla96QfW8
	 +nOPEAIkuw16DzQTNV/uXHMfyn3n/Zyh82nbpMAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfEQNYz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 17 May 2019 09:24:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728478AbfEQNYz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 May 2019 09:24:55 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73CAE20833;
        Fri, 17 May 2019 13:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558099494;
        bh=1l3aEKcWXS7u0eJCQcg2c+X7k3wBikYs5PdunFGggVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x6kSWvoTTsvVY9GnYA7pSailCmLxC/mlyl6yE68qcGsYVLxtdU9B1NxPD35KloGnH
         kCH7jNPLHtzRIxM5hjQ2nTKgQ+EtUMqQbyF9mcV/LC21tKWbxmTtM0jhVNm5syGqwv
         E/P4t8OfY0mDG+uP9zamvZ72jxHARSBHYFxpLINA=
Date:   Fri, 17 May 2019 08:24:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Christoph Hellwig <hch@infradead.org>, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V6 02/15] PCI/PME: Export pcie_pme_disable_msi() &
 pcie_pme_no_msi() APIs
Message-ID: <20190517132453.GA30700@google.com>
References: <20190513050626.14991-1-vidyas@nvidia.com>
 <20190513050626.14991-3-vidyas@nvidia.com>
 <20190513072539.GA27708@infradead.org>
 <3a8cea93-2aeb-e5e2-4d56-f0c6449073c3@nvidia.com>
 <20190516133426.GC101793@google.com>
 <bd08ccaa-c6ee-f966-91e4-bcd5d99d5cf2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd08ccaa-c6ee-f966-91e4-bcd5d99d5cf2@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 17, 2019 at 01:49:49PM +0530, Vidya Sagar wrote:
> On 5/16/2019 7:04 PM, Bjorn Helgaas wrote:
> > On Tue, May 14, 2019 at 09:00:19AM +0530, Vidya Sagar wrote:
> > > On 5/13/2019 12:55 PM, Christoph Hellwig wrote:
> > > > On Mon, May 13, 2019 at 10:36:13AM +0530, Vidya Sagar wrote:
> > > > > Export pcie_pme_disable_msi() & pcie_pme_no_msi() APIs to enable drivers
> > > > > using these APIs be able to build as loadable modules.
> > > > 
> > > > But this is a global setting.  If you root port is broken you need
> > > > a per-rootport quirk instead.
> > > > 
> > > There is nothing broken in Tegra194 root port as such, rather, this
> > > is more of software configuration choice and we are going with
> > > legacy interrupts than MSI interrupts (as Tegra194 doesn't support
> > > raising PME interrupts through MSI and please note that this doesn't
> > > mean root port is broken).
> > 
> > I think the port *is* broken.  PCIe r4.0, sec 6.1.6, says
> > 
> >    If the Root Port is enabled for edge-triggered interrupt signaling
> >    using MSI or MSI-X, an interrupt message must be sent every time the
> >    logical AND of the following conditions transitions from FALSE to
> >    TRUE:
> > 
> >      * The associated vector is unmasked (not applicable if MSI does
> >        not support PVM).
> > 
> >      * The PME Interrupt Enable bit in the Root Control register is set
> >        to 1b.
> > 
> >      * The PME Status bit in the Root Status register is set.
> > 
> > The Tegra194 root port advertises MSI support, so the above should
> > apply.
> I had a discussion with our hardware engineers and we are of the
> opinion that the root port is not really broken w.r.t MSI as spec
> doesn't clearly say that if root port advertises MSI support, it
> must generate MSI interrupts for PME. All that it says is, if MSI is
> enabled, then MSI should be raised for PME events. Here, by
> 'enable', we understand that as enabling at hardware level to
> generate MSI interrupt which is not the case with Tegra194.  In
> Tegra194, root port is enabled to generate MSI only for hot-plug
> events and legacy interrupts are used for PME, AER.

Do you have "lspci -vvxxx" output for the root ports handy?

If there's some clue in the standard config space that would tell us
that MSI works for some events but not others, we could make the PCI
core pay attention it.  That would be the best solution because it
wouldn't require Tegra-specific code.

If this situation requires Tegra-specific code, that becomes an issue
if you ever want to use the part in an ACPI system because the ACPI
host bridge driver is generic and there isn't a place to put
device-specific code.

Bjorn
