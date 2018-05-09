Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:47225 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753339AbeEIH31 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 May 2018 03:29:27 -0400
Date: Wed, 9 May 2018 09:29:25 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 4/9] PCI: armada8k: Drop unnecessary root_bus_nr setting
Message-ID: <20180509092925.2d2cd2f3@windsurf.home>
In-Reply-To: <1525844386-5433-4-git-send-email-shawn.guo@linaro.org>
References: <1525844386-5433-1-git-send-email-shawn.guo@linaro.org>
        <1525844386-5433-4-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Shawn,

On Wed,  9 May 2018 13:39:41 +0800, Shawn Guo wrote:
> The root_bus_nr initialization has already been done in function
> dw_pcie_host_init().

The formulation "has already been done" makes me think it's been done
*before* pp->root_bus_nr = -1, which is not what happens. I believe a
better formulation here would be:

dw_pcie_host_init() already initializes the root_bus_nr field of
'struct pcie_port', so there is no need to initialize it prior to
calling dw_pcie_host_init().

>  The -1 assignment in platform driver before
> calling into dw_pcie_host_init() is not really needed.  Drop it.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Other than my comment on the commit log:

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
