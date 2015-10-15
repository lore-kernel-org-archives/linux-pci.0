Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53249 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752419AbbJOUBD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 15 Oct 2015 16:01:03 -0400
Date: Thu, 15 Oct 2015 15:00:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: bhelgaas@google.com, jingoohan1@gmail.com,
	pratyush.anand@gmail.com, linux-pci@vger.kernel.org,
	wangzhou1@hisilicon.com, yuanzhichang@hisilicon.com,
	zhudacai@hisilicon.com, zhangjukuo@huawei.com,
	qiuzhenfa@hisilicon.com, liguozhu@hisilicon.com
Subject: Re: [PATCH v2 ] PCI: Designware: make num-lanes an optional DT
 property
Message-ID: <20151015200058.GA10442@localhost>
References: <1443456190-225875-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443456190-225875-1-git-send-email-gabriele.paoloni@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 29, 2015 at 12:03:10AM +0800, Gabriele Paoloni wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
> 
> Currently num-lanes is read in dw_pcie_host_init().
> For a SoC that performs the link-up operation in UEFI, num-lanes
> is not needed in the DTS; however currently it has to be specified
> to some random value otherwise dw_pcie_host_init will fail.
> If the link is brought up in BIOS dw_pcie_setup_rc should not
> be called.
> This patch reworks dw_pcie_host_init() so that, if num-lanes is
> not specified, it sets pp->lanes = 0. If later on dw_pcie_setup_rc
> is called and pp->num_lanes is not set to a valid value,
> dw_pcie_setup_rc will send an error message and return.
> 
> This patch is a follow-up of
> http://www.spinics.net/lists/linux-pci/msg44394.html
> 
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>

Applied to pci/host-designware for v4.4 with changelog as follows,
thanks, Gabriele!

commit efe52075227729aa2a1ed55e34dd599b3bb0dbf1
Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Date:   Tue Sep 29 00:03:10 2015 +0800

    PCI: designware: Make num-lanes an optional DT property
    
    Currently "num-lanes" is read in dw_pcie_host_init(), but it is only used
    if we call dw_pcie_setup_rc() while bringing up the link.  If the link has
    already been brought up by firmware, we need not call dw_pcie_setup_rc(),
    and "num-lanes" is unnecessary.
    
    Only complain about "num-lanes" if we actually need it and we didn't find a
    valid value.
    
    [bhelgaas: changelog]
    Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
