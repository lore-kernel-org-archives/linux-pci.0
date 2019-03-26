Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E87C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 19:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0E62084B
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 19:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553628299;
	bh=Tqq4THWtjlYn1tW04YUldKqpOXYiHwUKtX6cGrceRiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EP+f/InaIIHxhe4BYzE+TwW65C6grk7vbIorck21g1DLBSuYXA8459b3XOIBZUNZd
	 9K2c3XkFNrMS4tHL9UKXdlgJX81CGWpBrC3SNG69Misf/b+OyK3kcwT73uM9nE6Vl5
	 Gx+kEYW6hWknl0lKCRSgdFvusOBYyVKdoHXgSQG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbfCZTY7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:24:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730451AbfCZTY6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Mar 2019 15:24:58 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7346520823;
        Tue, 26 Mar 2019 19:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553628297;
        bh=Tqq4THWtjlYn1tW04YUldKqpOXYiHwUKtX6cGrceRiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l3NR8QAzvl0SRP9sjowAsWVfGbqOf3tsLpCQuOIee2zmUODvFBsLzsYVeF6WwlhYQ
         HbX+cjXh9F9TJNTqtV19PkGrlHJGiKJXJ2aeKxyDQaoG1BlhLhvWzl5YfHdyI8boAB
         CFMTT1ZbpDOnJXYCzGK6jkRfpeTD8n5vRBLtiGQw=
Date:   Tue, 26 Mar 2019 14:24:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux@yadro.com
Subject: Re: [PATCH RFC v4 05/21] PCI: hotplug: Add a flag for the movable
 BARs feature
Message-ID: <20190326192455.GN24180@google.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-6-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311133122.11417-6-s.miroshnichenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 11, 2019 at 04:31:06PM +0300, Sergey Miroshnichenko wrote:
> If a new PCIe device has been hot-plugged between the two active ones
> without big enough gap between their BARs, 

Just to speak precisely here, a hot-added device is not "between" two
active ones because the new device has zeros in its BARs.

BARs from different devices can be interleaved arbitrarily, subject to
bridge window constraints, so we can really only speak about a *BAR*
(not the entire device) being between two other BARs.

Also, I don't think there's anything here that is PCIe-specific, so we
should talk about "PCI", not "PCIe".

> these BARs should be moved
> if their drivers support this feature. The drivers should be notified
> and paused during the procedure:
> 
> 1)                 dev 8 (new)
>                        |
>                        v
> .. |  dev 3  |  dev 3  |  dev 5  |  dev 7  |
> .. |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 0  |
> 
> 2)                             dev 8
>                                  |
>                                  v
> .. |  dev 3  |  dev 3  | -->           --> |  dev 5  |  dev 7  |
> .. |  BAR 0  |  BAR 1  | -->           --> |  BAR 0  |  BAR 0  |
> 
>  3)
> 
> .. |  dev 3  |  dev 3  |  dev 8  |  dev 8  |  dev 5  |  dev 7  |
> .. |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 0  |
> 
> Thus, prior reservation of memory regions by BIOS/bootloader/firmware
> is not required anymore for the PCIe hotplug.
> 
> The PCI_MOVABLE_BARS flag is set by the platform is this feature is
> supported and tested, but can be overridden by the following command
> line option:
>     pcie_movable_bars={ off | force }

A chicken switch to turn this functionality off is OK, but I think it
should be enabled by default.  There isn't anything about this that's
platform-specific, is there?

> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  7 ++++++
>  drivers/pci/pci.c                             | 24 +++++++++++++++++++
>  include/linux/pci.h                           |  2 ++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2b8ee90bb644..d40eaf993f80 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3417,6 +3417,13 @@
>  		nomsi	Do not use MSI for native PCIe PME signaling (this makes
>  			all PCIe root ports use INTx for all services).
>  
> +	pcie_movable_bars=[PCIE]
> +			Override the movable BARs support detection:
> +		off
> +			Disable even if supported by the platform
> +		force
> +			Enable even if not explicitly declared as supported
> +
>  	pcmv=		[HW,PCMCIA] BadgePAD 4
>  
>  	pd_ignore_unused
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 69898fe5255e..4dac49a887ec 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -139,6 +139,30 @@ static int __init pcie_port_pm_setup(char *str)
>  }
>  __setup("pcie_port_pm=", pcie_port_pm_setup);
>  
> +static bool pcie_movable_bars_off;
> +static bool pcie_movable_bars_force;
> +static int __init pcie_movable_bars_setup(char *str)
> +{
> +	if (!strcmp(str, "off"))
> +		pcie_movable_bars_off = true;
> +	else if (!strcmp(str, "force"))
> +		pcie_movable_bars_force = true;
> +	return 1;
> +}
> +__setup("pcie_movable_bars=", pcie_movable_bars_setup);
> +
> +bool pci_movable_bars_enabled(void)
> +{
> +	if (pcie_movable_bars_off)
> +		return false;
> +
> +	if (pcie_movable_bars_force)
> +		return true;
> +
> +	return pci_has_flag(PCI_MOVABLE_BARS);
> +}
> +EXPORT_SYMBOL(pci_movable_bars_enabled);
> +
>  /* Time to wait after a reset for device to become responsive */
>  #define PCIE_RESET_READY_POLL_MS 60000
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index cb2760a31fe2..cbe661aff9f5 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -866,6 +866,7 @@ enum {
>  	PCI_ENABLE_PROC_DOMAINS	= 0x00000010,	/* Enable domains in /proc */
>  	PCI_COMPAT_DOMAIN_0	= 0x00000020,	/* ... except domain 0 */
>  	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,	/* Scan all, not just dev 0 */
> +	PCI_MOVABLE_BARS	= 0x00000080,	/* Runtime BAR reassign after hotplug */
>  };
>  
>  /* These external functions are only available when PCI support is enabled */
> @@ -1345,6 +1346,7 @@ unsigned char pci_bus_max_busnr(struct pci_bus *bus);
>  void pci_setup_bridge(struct pci_bus *bus);
>  resource_size_t pcibios_window_alignment(struct pci_bus *bus,
>  					 unsigned long type);
> +bool pci_movable_bars_enabled(void);
>  
>  #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
>  #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
> -- 
> 2.20.1
> 
