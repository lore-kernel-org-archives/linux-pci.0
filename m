Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751609AbdJBTfe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Oct 2017 15:35:34 -0400
Date: Mon, 2 Oct 2017 14:35:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ray Jui <ray.jui@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Hari Vyas <hari.vyas@broadcom.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>
Subject: Re: [RFC] PCIe bus address at 0x00000000
Message-ID: <20171002193532.GA5407@bhelgaas-glaptop.roam.corp.google.com>
References: <a9aba0db-4865-2a6b-b77c-9cb70a4eeab0@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a9aba0db-4865-2a6b-b77c-9cb70a4eeab0@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 29, 2017 at 05:47:23PM -0700, Ray Jui wrote:
> Hi Bjorn and all,
> 
> One of our ARM64 based processor (NS2) has our system address
> reversed for PCIe outbound transaction in the range of 0x0000_0000
> and 0x1fff_ffff. If we use 1:1 mapping between the system address
> and PCIe address, we end up having the PCIe address in the same
> range.
> 
> In this case, we noticed that certain USB-PCI adapters will decline
> access to BARs mapped in this address range with "Unsupported
> Request". In this case, if we change the PCIe address range to
> something else like 0x8000_0000, it would work without an issue.
> 
> This sounds like an issue with the USB PCI adapter that cannot allow
> BARs to be used with specific PCIe address range. Is my
> understanding correct?

I assume you're seeing "Unsupported Request" completions on the PCIe
link?  Can you tell with an analyzer that the TLP actually appears on 
the link and it's the device that is responding with UR?  I'm just
wondering if there's something in the RC that could be
short-circuiting this.  But I guess you mention "certain USB-PCI
adapters", which implies that these BAR addresses work for *some*
devices, just not these particular USB-PCI ones.

AFAIK, there's no PCIe reason why the 0x0000_0000 - 0x1fff_ffff
region shouldn't be used for BARs.

It's surprising to me that a device would special-case addresses like
that, but maybe it does.

Bjorn
