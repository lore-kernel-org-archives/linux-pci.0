Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA16C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 14:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B782171F
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555080611;
	bh=NjeUXI+qwF1Pjo3cVfe3d4dyz0qw8P3Szp4bFY/MBlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xJjKB1W1o5ifTQ5ENFcxLXu/uDnVS12TDMHNXqGEK5RKbDws85n3LKcpsxhht9IqR
	 Y3VQ9RXzrCzulYG54WoKGsWJmkfOT9zyebJj04j0u848JqKoioTRSQVfDGcdK0u7Ka
	 7/UBjuPsAKq9VVZCAUOF4V6xWg8QWPOXyvZLO4tQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfDLOuL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfDLOuK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 10:50:10 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67EDD20850;
        Fri, 12 Apr 2019 14:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555080609;
        bh=NjeUXI+qwF1Pjo3cVfe3d4dyz0qw8P3Szp4bFY/MBlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xc5AcMos1QUe3+YP+dK0Y3Tr+EIS6pE2T/sxxRBbaA7VQK0IYcogCNgFXb7uPDq5w
         Cor5NpLrovCgXAxYwZ2bvS8Od9MMZnfcUqkoWJMXhOeTj2pJqANJcTNlbWgHHmdzrf
         0eGEe6ZgwFpY+DJ/5bOrdwagN9DOG28tKbbF2HP4=
Date:   Fri, 12 Apr 2019 09:50:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Ley Foon Tan <lftan@altera.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 22/30] PCI: tegra: Access endpoint config only if PCIe
 link is up
Message-ID: <20190412145003.GE141472@google.com>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-23-mmaddireddy@nvidia.com>
 <20190411201535.GS256045@google.com>
 <e721e7f4-85c9-bee1-7131-12e0b7dfc0d1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e721e7f4-85c9-bee1-7131-12e0b7dfc0d1@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jingoo, Gustavo (dwc maintainers), Ley (altera), Michal (xilinx)]

On Fri, Apr 12, 2019 at 12:30:22PM +0530, Manikanta Maddireddy wrote:
> On 12-Apr-19 1:45 AM, Bjorn Helgaas wrote:
> > On Thu, Apr 11, 2019 at 10:33:47PM +0530, Manikanta Maddireddy wrote:
> >> Add PCIe link up check in config read and write callback functions
> >> before accessing endpoint config registers.

> >>  static int tegra_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
> >>  				  int where, int size, u32 *value)
> >>  {
> >> +	struct tegra_pcie *pcie = bus->sysdata;
> >> +	struct pci_dev *bridge;
> >> +	struct tegra_pcie_port *port;
> >> +
> >>  	if (bus->number == 0)
> >>  		return pci_generic_config_read32(bus, devfn, where, size,
> >>  						 value);
> >>  
> >> +	bridge = pcie_find_root_port(bus->self);
> >> +
> >> +	list_for_each_entry(port, &pcie->ports, list)
> >> +		if (port->index + 1 == PCI_SLOT(bridge->devfn))
> >> +			break;
> >> +
> >> +	/* If there is no link, then there is no device */
> >> +	if (!tegra_pcie_link_status(port)) {
> >
> > This is racy and you should avoid it if possible.  The link could go down
> > between calling tegra_pcie_link_status() and issuing the config read/write.
> >
> > If your driver is to be reliable, it must be able to handle any bad
> > consequence of issuing that config read/write anyway, so I think it's
> > better if it doesn't even bother checking whether the link is up.
>
> This change is made based on similar check present in dwc driver
> dw_pcie_valid_device(), reasons for making this change in Tegra might
> differ dwc.

Yes, you won't be surprised to learn that I don't like the similar
checks in dwc, altera, xilinx, and xilinx-nwl either :)  I raise this
issue every time I see it, but I can't remember if I've mentioned dwc
specifically.

We need to either eradicate this pattern of checking for link up, or
include a comment about why it is absolutely necessary.

> Intention here is to reduce the number of AER errors when device is
> falling off the bus or going through hot reset. So racy condition here is
> OK

I'm not convinced about this.  The issues you mention need to be
solved in a generic way, not a tegra-specific way.

We don't want to end up with code that silently avoids the config
access 99.99% of the time, but once in a blue moon, we lose the race
(the device stops responding after we've determined the link is up)
and the access causes a mysterious AER error that we have no way to
debug.

> >> +		*value = 0xffffffff;
> >> +		return PCIBIOS_DEVICE_NOT_FOUND;
> >> +	}
> >> +
> >>  	return pci_generic_config_read(bus, devfn, where, size, value);
> >>  }
