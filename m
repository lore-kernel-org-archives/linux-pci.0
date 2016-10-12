Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754850AbcJLQ0j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 12:26:39 -0400
Date: Wed, 12 Oct 2016 11:01:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: mvebu: Cleanups
Message-ID: <20161012160134.GD4308@localhost>
References: <20161012125403.24580.74990.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161012125403.24580.74990.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 12, 2016 at 07:55:50AM -0500, Bjorn Helgaas wrote:
>   - Add local "dev" pointers to reduce repetition of things like
>     "&pdev->dev".
> 
>   - Tidy up usage of of_node pointer
> 
> Nothing here should change the behavior of the driver.
> 
> Changes from v1:
>   Added of_node cleanup
>   Dropped "PCI: mvebu: Swap order of mvebu_writel() reg/val arguments"
> 
> ---
> 
> Bjorn Helgaas (2):
>       PCI: mvebu: Add local struct device pointers
>       PCI: mvebu: Use existing of_node pointer

I applied these to pci/host-mvebu for v4.9.  I hope to ask Linus to
pull them tomorrow, so if you see any issues, let me know soon.
