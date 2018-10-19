Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58761C67863
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 01:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058D821477
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 01:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/QZFJuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058D821477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeJSJPU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 05:15:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbeJSJPU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 05:15:20 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4C362087A;
        Fri, 19 Oct 2018 01:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539911497;
        bh=klujbr7nYprovwe9U06oVDIuLXYayo3DMcd3onFZyPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/QZFJufiYBlnWN54oS1DulHo7tA9wrzExP9UMk9HULuGb9EtHVZXbQhuPHgVbNWo
         VmuRWfUboGy1O+ZV5mIxIGsRXES1b3TWbf3MB77fstsbqt1aR2mgMAOA1plHSNb8cz
         LyL4SxtDF/2fxkQmJt9WMSoZZsy/Xjinkn6DF69Y=
Date:   Thu, 18 Oct 2018 20:11:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Matthew Wilcox <willy@infradead.org>,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI/AER: Enable error reporting for all ports
Message-ID: <20181019011135.GP5906@bhelgaas-glaptop.roam.corp.google.com>
References: <153989603841.78375.436243401553964151.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20181018230312.GB23301@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018230312.GB23301@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 18, 2018 at 05:03:13PM -0600, Keith Busch wrote:
> On Thu, Oct 18, 2018 at 03:53:58PM -0500, Bjorn Helgaas wrote:
> > Change the AER service driver so it binds to *all* PCIe Ports,
> > including Switch Upstream and Downstream Ports.  Enable AER error
> > reporting for all these Ports, but not for any children.
> 
> I'm looking at this again and think enabling/disabling error
> reporting for ports is the responsibility of the port driver, not
> the AER service.

That's an interesting idea.  Can you expand on this a little more?
Why is it the responsibility of the port driver?

Do you think pci_enable_pcie_error_reporting() shouldn't be part of
the AER service because it updates the Device Control register, which
is in the PCIe Capability, not the AER Capability?

What about pci_aer_clear_device_status(), which clears Device Status,
which is also in the PCIe Capability?

> The following should do the same as this patch, but without making
> AER driver handle non-root ports.  The report enabling/disabling
> functions are already stubbed for '!CONFIG_PCIE_AER' and have checks
> for aer_cap and firmware first.

If we thought we should enable error reporting *always*, regardless of
whether the AER service is enabled, this would make perfect sense to
me, and I might suggest doing it in an even more generic place like
pci_configure_device() or pci_init_capabilities().

But that doesn't seem like where you're headed.  It seems like you
still only want error reporting enabled when CONFIG_PCIEAR=y.  If
that's the case, it seems like doing it in portdrv only obfuscates the
connection with AER.  When CONFIG_PCIEAER is unset, the portdrv code
*looks* like it's doing something but it's really not because of the
#ifdef magic.

> A real patch for this could even make this remove all the aer
> specific error report enabling, so it'd be a net-loss in code lines.
> :)
> 
> ---
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 0acca3596807..f129a33c8303 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -122,12 +122,13 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  		pm_runtime_put_autosuspend(&dev->dev);
>  		pm_runtime_allow(&dev->dev);
>  	}
> -
> +	pci_enable_pcie_error_reporting(dev);
>  	return 0;
>  }
>  
>  static void pcie_portdrv_remove(struct pci_dev *dev)
>  {
> +	pci_disable_pcie_error_reporting(dev);
>  	if (pci_bridge_d3_possible(dev)) {
>  		pm_runtime_forbid(&dev->dev);
>  		pm_runtime_get_noresume(&dev->dev);
> --
