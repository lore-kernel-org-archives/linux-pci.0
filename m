Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753659AbcJLQCx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 12:02:53 -0400
Date: Wed, 12 Oct 2016 11:02:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: rockchip: Cleanup
Message-ID: <20161012160240.GG4308@localhost>
References: <20161012130256.25212.33689.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161012130256.25212.33689.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 12, 2016 at 08:04:16AM -0500, Bjorn Helgaas wrote:
>   - Remove platform drvdata because it appears unused (we called
>     platform_set_drvdata() but not platform_get_drvdata()).
> 
> Nothing here should change the behavior of the driver.
> 
> Changes from v1:
>   Added Dan's indentation fix.
>   I dropped the following patches because they were a lot of churn for
>   questionable benefit:
>     PCI: rockchip: Rename accessors
>     PCI: rockchip: Swap order of rockchip_writel() reg/val arguments
> 
> ---
> 
> Bjorn Helgaas (1):
>       PCI: rockchip: Remove unused platform data
> 
> Dan Carpenter (1):
>       PCI: rockchip: Indent "if" statement body

I applied these to pci/host-rockchip for v4.9.  I hope to ask Linus to
pull them tomorrow, so if you see any issues, let me know soon.
