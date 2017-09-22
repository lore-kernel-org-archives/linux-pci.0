Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:32986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752068AbdIVNfR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Sep 2017 09:35:17 -0400
Date: Fri, 22 Sep 2017 08:35:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc: linux-pci@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: aardvark pci controller ath9k request_irq fail
Message-ID: <20170922133515.GA12546@bhelgaas-glaptop.roam.corp.google.com>
References: <20170922132444.588e27cb@dellmb.labs.office.nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170922132444.588e27cb@dellmb.labs.office.nic.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Thomas (aardvark maintainer), Lorenzo]

On Fri, Sep 22, 2017 at 01:24:44PM +0200, Marek Behún wrote:
> Hello,
> we are developing a new board based on Marvell Armada 3720.
> While testing the PCI-e slot, I have enountered this problem:
> 
> - lspci always correctly prints information about the PCIe card in the
>   slot
> - when a ath9k card is in the slot, ath9k fails to initialize with
>      ath9k 0000:00:00.0: request_irq failed
> 
>   The irq number passed to the request_irq function is from the irq
>   member of struct pci_dev:
>      request_irq(pdev->irq, ath_isr, IRQF_SHARED, "ath9k", sc);
> 
>   this number (pdev->irq) is 255
> 
>   The request_irq function fails in request_threaded_irq on line:
>      desc = irq_to_desc(irq);
>   (desc is NULL and thus -EINVAL is returned.)
> 
> - what is strange is that another card, Intel Centrino Ultimate-N 6300
>   with iwlwifi works.
> 
> - another card (ath10k driver) also does not work.
> 
> Is this a problem with the pci-aardvark driver for the Aardvark
> controller?

What kernel version are you using?  Has any kernel version worked
correctly?  There have been significant IRQ mapping changes in the
last couple releases.

dev->irq should be assigned in pci_assign_irq().  Can you turn on the
debug there (and maybe add more) and collect the complete dmesg log?

Bjorn
