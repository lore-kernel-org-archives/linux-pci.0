Return-Path: <SRS0=PPlZ=SV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F039C282DA
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4F0204EC
	for <linux-pci@archiver.kernel.org>; Fri, 19 Apr 2019 18:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698956;
	bh=SiuPTE3En5u1w/lZsTCxrVqfP1Q4Z6SlF0KC8CUicUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FkLEmA5I/0fxHCBeo5okiBUfYONvnV/HItv8+wy4sSlLZnemuN3dYvCq5zsd+ls1s
	 5CJoFF+wNSs71R7yb9HSFpMn6htxptdfoLKnmX+xsZ4ItfG1w6pzd7LDFbU2wwd9Lg
	 5FyotjDER/K/aq7JBZGnrKWGPFc4DAWNQKfpnnOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfDSSfZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfDSS3P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:15 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C553C222A4;
        Fri, 19 Apr 2019 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555680035;
        bh=SiuPTE3En5u1w/lZsTCxrVqfP1Q4Z6SlF0KC8CUicUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Er+k3T7kzDwb/lKTbO0U8uQu9Tq4vDPTZNu+ysHHivtNT3LIj5bPdwkK9NOIcy7BN
         9ZJ8sdarZJdFePXM670gXXw4Bdcl9fvVikIwIxOzeY9fijWampOINeZm980Vv87Lb0
         gUn+RPoqQUjy6PPYV3q2BGQFgubODPdkMcoRMOKc=
Date:   Fri, 19 Apr 2019 08:20:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mohan Kumar <mohankumar718@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frederick Lawler <fred@fredlawl.com>
Subject: Re: [PATCH] drivers: pci: Define pr_fmt() and use pr_*() instead of
 printk()
Message-ID: <20190419132033.GJ126710@google.com>
References: <1555612864-4059-1-git-send-email-mohankumar718@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555612864-4059-1-git-send-email-mohankumar718@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Frederick because I think he's also doing some printk changes.
I don't think they will overlap, so it's just FYI]

Hi Mohan,

This subject line is better, but still doesn't match the convention.
Here's what it would look like if I applied it:

  $ git log --oneline --no-merges drivers/pci/quirks.c | head -5
  7b1068d23f9d drivers: pci: Define pr_fmt() and use pr_*() instead of printk()
  f57a98e1b713 PCI: Work around Synopsys duplicate Device ID (HAPS USB3, NXP i.MX)
  01926f6b321b PCI: Add ACS quirk for HXT SD4800
  1d09d57728fe PCI: Mark expected switch fall-through
  03e6742584af PCI: Override Synopsys USB 3.x HAPS device class

I want it to start with "PCI: " so your patch matches the previous
ones.

On Thu, Apr 18, 2019 at 09:41:04PM +0300, Mohan Kumar wrote:
> Define a pr_fmt() macro that convert all of the explicit printk() calls
> into corresponding pr_*().

  - Ignore drivers/pci/hotplug/ for now.  Many of those drivers define
    their own logging macros that make things messier.

  - Convert these in one patch for all of drivers/pci/ (except
    drivers/pci/hotplug/).  This is pure cleanup and doesn't change
    any behavior, so shouldn't be very controversial:

      printk(KERN_WARN) to pr_warn()
      printk(KERN_ERR)  to pr_err()

  - In a second patch, add "#define pr_fmt()" where useful.  This
    should be a separate patch to make it easier to review.  But this
    also shouldn't change any behavior, so should be pretty
    straightforward.

  - Convert these in a third patch.  This is separate because it
    involves a behavior change and may require some discussion and
    tweaking of individual situations:

      pci_printk(KERN_DEBUG) to pci_info()
      dev_printk(KERN_DEBUG) to dev_info()
      printk(KERN_DEBUG)     to pr_info()

Thanks for your work on this!  Your changes will definitely make the
PCI core more consistent, which makes it more pleasant to work in.

Bjorn

> Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
> ---
>  drivers/pci/pci-stub.c | 11 +++++------
>  drivers/pci/quirks.c   | 10 +++++-----
>  2 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
> index 66f8a59..f946bf9 100644
> --- a/drivers/pci/pci-stub.c
> +++ b/drivers/pci/pci-stub.c
> @@ -16,6 +16,8 @@
>   * .../0000:00:19.0/driver -> ../../../bus/pci/drivers/pci-stub
>   */
>  
> +#define pr_fmt(fmt) "pci-stub: " fmt
> +
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  
> @@ -66,20 +68,17 @@ static int __init pci_stub_init(void)
>  				&class, &class_mask);
>  
>  		if (fields < 2) {
> -			printk(KERN_WARNING
> -			       "pci-stub: invalid id string \"%s\"\n", id);
> +			pr_warn("invalid id string \"%s\"\n", id);
>  			continue;
>  		}
>  
> -		printk(KERN_INFO
> -		       "pci-stub: add %04X:%04X sub=%04X:%04X cls=%08X/%08X\n",
> +		pr_info("add %04X:%04X sub=%04X:%04X cls=%08X/%08X\n",
>  		       vendor, device, subvendor, subdevice, class, class_mask);
>  
>  		rc = pci_add_dynid(&stub_driver, vendor, device,
>  				   subvendor, subdevice, class, class_mask, 0);
>  		if (rc)
> -			printk(KERN_WARNING
> -			       "pci-stub: failed to add dynamic id (%d)\n", rc);
> +			pr_warn("failed to add dynamic id (%d)\n", rc);
>  	}
>  
>  	return 0;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f9cd4d4..3b367b7 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -11,6 +11,7 @@
>   * Init/reset quirks for USB host controllers should be in the USB quirks
>   * file, where their drivers can use them.
>   */
> +#define pr_fmt(fmt) "PCI: " fmt
>  
>  #include <linux/types.h>
>  #include <linux/kernel.h>
> @@ -159,8 +160,7 @@ static int __init pci_apply_final_quirks(void)
>  	u8 tmp;
>  
>  	if (pci_cache_line_size)
> -		printk(KERN_DEBUG "PCI: CLS %u bytes\n",
> -		       pci_cache_line_size << 2);
> +		pr_debug("CLS %u bytes\n", pci_cache_line_size << 2);
>  
>  	pci_apply_fixup_final_quirks = true;
>  	for_each_pci_dev(dev) {
> @@ -177,7 +177,7 @@ static int __init pci_apply_final_quirks(void)
>  			if (!tmp || cls == tmp)
>  				continue;
>  
> -			printk(KERN_DEBUG "PCI: CLS mismatch (%u != %u), using %u bytes\n",
> +			pr_debug("CLS mismatch (%u != %u), using %u bytes\n",
>  			       cls << 2, tmp << 2,
>  			       pci_dfl_cache_line_size << 2);
>  			pci_cache_line_size = pci_dfl_cache_line_size;
> @@ -185,7 +185,7 @@ static int __init pci_apply_final_quirks(void)
>  	}
>  
>  	if (!pci_cache_line_size) {
> -		printk(KERN_DEBUG "PCI: CLS %u bytes, default %u\n",
> +		pr_debug("CLS %u bytes, default %u\n",
>  		       cls << 2, pci_dfl_cache_line_size << 2);
>  		pci_cache_line_size = cls ? cls : pci_dfl_cache_line_size;
>  	}
> @@ -2613,7 +2613,7 @@ static void nvbridge_check_legacy_irq_routing(struct pci_dev *dev)
>  	pci_read_config_dword(dev, 0x74, &cfg);
>  
>  	if (cfg & ((1 << 2) | (1 << 15))) {
> -		printk(KERN_INFO "Rewriting IRQ routing register on MCP55\n");
> +		pr_info("Rewriting IRQ routing register on MCP55\n");
>  		cfg &= ~((1 << 2) | (1 << 15));
>  		pci_write_config_dword(dev, 0x74, cfg);
>  	}
> -- 
> 2.7.4
> 
