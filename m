Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF37C43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 21:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFEF20863
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 21:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbyKYUgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFEF20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbeK2I6v (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:58:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:52024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbeK2I6v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Nov 2018 03:58:51 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74E9D20832;
        Wed, 28 Nov 2018 21:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543442146;
        bh=hnatV5gSfA0QK7wLhAQgFTdYewmVXZ8mCF85eWy+dCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SbyKYUgzrpMs3sNYzWGoHlD884gKy/yHnH1buFoSyUmPhbKM82ik+1eGObMs7CVW4
         VMRCqYT+d6pv24ltCxIiOvuso8Yt6ChukZ0ll+PkTSAvv4IAILdNhPCqZqet/dgyEZ
         HoegN+HuAyS4OHBugubqMlCpqktN9Qz/R+UXYfDg=
Date:   Wed, 28 Nov 2018 15:55:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sundeep.lkml@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        sean.stalley@intel.com, sgoutham@marvell.com,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: Re: [PATCH v2] PCI: assign bus numbers present in EA capability for
 bridges
Message-ID: <20181128215545.GC178809@google.com>
References: <1542633272-16161-1-git-send-email-sundeep.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542633272-16161-1-git-send-email-sundeep.lkml@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 19, 2018 at 06:44:32PM +0530, sundeep.lkml@gmail.com wrote:
> From: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> As per the spec, bridges with EA capability work
> with fixed secondary and subordinate bus numbers.
> Hence assign bus numbers to bridges from EA if the
> capability exists.

A reference to the spec section would be good, i.e., PCIe r4.0, sec xxx.

> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
> Changes for v2:
> 	No changes just added Sean Stalley who did EA support for BARs.
> 
>  drivers/pci/probe.c           | 58 ++++++++++++++++++++++++++++++++++++++++---
>  include/uapi/linux/pci_regs.h |  6 +++++
>  2 files changed, 60 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b1c05b5..f41d2e6 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1030,6 +1030,40 @@ static void pci_enable_crs(struct pci_dev *pdev)
>  
>  static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>  					      unsigned int available_buses);
> +/*
> + * pci_ea_fixed_busnrs() - Read fixed Secondary and Subordinate bus
> + * numbers from EA capability.
> + * @dev: Bridge with EA
> + * @secondary: updated with secondary bus number in EA
> + * @subordinate: updated with subordinate bus number in EA
> + *
> + * If it is a bridge with EA capability then fixed bus numbers are
> + * read from EA capability list and secondary, subordinate reference
> + * variables will be updated. Otherwise secondary and subordinate reference
> + * variables will be zeroed.
> + */
> +static void pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *secondary,
> +				u8 *subordinate)
> +{
> +	int ea;
> +	int offset;
> +	u32 dw;
> +
> +	*secondary = *subordinate = 0;
> +
> +	if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
> +		return;
> +
> +	/* find PCI EA capability in list */
> +	ea = pci_find_capability(dev, PCI_CAP_ID_EA);
> +	if (!ea)
> +		return;
> +
> +	offset = ea + PCI_EA_FIRST_ENT;
> +	pci_read_config_dword(dev, offset, &dw);

"Num Entries" in the first DW of the capability is allowed to be zero,
in which case this word (the second DW) is invalid.  [See comments
below; this code would be valid based on the 2014 ECN, but not per the
2017 PCIe r4.0 spec]

It would be much better if this function could be somehow incorporated
into pci_ea_init(), which already knows how to parse much of the EA
capability.

> +	*secondary =  dw & PCI_EA_SEC_BUS_MASK;
> +	*subordinate = (dw & PCI_EA_SUB_BUS_MASK) >> PCI_EA_SUB_BUS_SHIFT;
> +}
>  
>  /*
>   * pci_scan_bridge_extend() - Scan buses behind a bridge
> @@ -1064,6 +1098,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  	u16 bctl;
>  	u8 primary, secondary, subordinate;
>  	int broken = 0;
> +	u8 fixed_sec, fixed_sub;
> +	int next_busnr;
>  
>  	/*
>  	 * Make sure the bridge is powered on to be able to access config
> @@ -1163,17 +1199,25 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  		/* Clear errors */
>  		pci_write_config_word(dev, PCI_STATUS, 0xffff);
>  
> +		/* read bus numbers from EA */
> +		pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
> +
> +		next_busnr = max + 1;
> +		/* Use secondary bus number in EA */
> +		if (fixed_sec)
> +			next_busnr = fixed_sec;
> +
>  		/*
>  		 * Prevent assigning a bus number that already exists.
>  		 * This can happen when a bridge is hot-plugged, so in this
>  		 * case we only re-scan this bus.
>  		 */
> -		child = pci_find_bus(pci_domain_nr(bus), max+1);
> +		child = pci_find_bus(pci_domain_nr(bus), next_busnr);
>  		if (!child) {
> -			child = pci_add_new_bus(bus, dev, max+1);
> +			child = pci_add_new_bus(bus, dev, next_busnr);
>  			if (!child)
>  				goto out;
> -			pci_bus_insert_busn_res(child, max+1,
> +			pci_bus_insert_busn_res(child, next_busnr,
>  						bus->busn_res.end);
>  		}
>  		max++;
> @@ -1234,7 +1278,13 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  			max += i;
>  		}
>  
> -		/* Set subordinate bus number to its real value */
> +		/*
> +		 * Set subordinate bus number to its real value.
> +		 * If fixed subordinate bus number exists from EA
> +		 * capability then use it.
> +		 */
> +		if (fixed_sub)
> +			max = fixed_sub;
>  		pci_bus_update_busn_res_end(child, max);
>  		pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
>  	}
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e1e9888..c3d0904 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -372,6 +372,12 @@
>  #define PCI_EA_FIRST_ENT_BRIDGE	8	/* First EA Entry for Bridges */

You didn't add PCI_EA_FIRST_ENT_BRIDGE (Sean did with f80b0ba95964
("PCI: Add Enhanced Allocation register entries")), but it is unused
and I can't match it with anything in the spec (PCIe r4.0, sec 7.8.5).

It might be related to the code in pci_ea_init() that skips DWORD 2
for type 1 functions.  But I still don't see that in the spec.

If it's obsolete, we should remove it (with a separate patch).

Hmm, I do see this in the ECN dated 23 Oct 2014, sec 6.9.1.2.  But
presumably that would be incorporated in PCIe r4.0, which is dated 27
Sep 2017.

I have no idea what to do with this.  I can't merge this without some
clarification here,

>  #define  PCI_EA_ES		0x00000007 /* Entry Size */
>  #define  PCI_EA_BEI		0x000000f0 /* BAR Equivalent Indicator */
> +
> +/* EA fixed Secondary and Subordinate bus numbers for Bridge */
> +#define PCI_EA_SEC_BUS_MASK	0xff
> +#define PCI_EA_SUB_BUS_MASK	0xff00
> +#define PCI_EA_SUB_BUS_SHIFT	8
> +
>  /* 0-5 map to BARs 0-5 respectively */
>  #define   PCI_EA_BEI_BAR0		0
>  #define   PCI_EA_BEI_BAR5		5
> -- 
> 1.8.3.1
> 
