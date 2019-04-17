Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F9DC282DA
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 20:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6E4217D7
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 20:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555532208;
	bh=cyCI8diDJZ0M9iDJmQNehqLUZ5bfYWyznljguyBcHyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yG3XLkzBFlaU9w5KgADFXNwKv6UGpUzsGaOLLe9Y3h14upAKuJtqyGXExoOpRqsyB
	 /r0s1FyT7C/fqlis1kh1VMcR+VHwtehf3Js709JIdH/UXXtqY3qNjI/x7Qyt/McK3s
	 zNRQJe1Y1WF74N+PIQbAYU8b8D+WYygrfiltyOZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfDQUQs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfDQUQs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Apr 2019 16:16:48 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CDA020651;
        Wed, 17 Apr 2019 20:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555532206;
        bh=cyCI8diDJZ0M9iDJmQNehqLUZ5bfYWyznljguyBcHyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lEhQVZRBkalOtx5X+b8mGiTkFuouFVKS3/G7iJ//RT6QX5uINki0YeQlwQk1zolKe
         rFluOS5a+Ie+Wv1dQdx2DXQ1Tte88ILBkOhBxWlHdyQXVmxwd7itoQyF/Yq+iKZO4b
         h9kRhwdKR3YbnLRWAZSuuIshexRSxqEOYTUB5SJ4=
Date:   Wed, 17 Apr 2019 15:16:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sundeep.lkml@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        sean.stalley@intel.com, sgoutham@marvell.com,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: Re: [PATCH v2] PCI: assign bus numbers present in EA capability for
 bridges
Message-ID: <20190417201645.GR126710@google.com>
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
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

I applied this with minor revisions to pci/enumeration for v5.2,
thanks!

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

I initially thought this was not quite safe because EA could supply a
secondary bus number of 0, in which case we would erroneously ignore
it.  But it's actually not possible for a PCI-to-PCI bridge to have a
secondary bus number of 0, so it *is* safe.

But it's still a little subtle and since I've already done the work to
add a bool return value from pci_ea_fixed_busnrs(), maybe it will be
OK to keep that.  The patch as applied is below, let me know if you
have any comments.

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

commit 2dbce5901179
Author: Subbaraya Sundeep <sbhatta@marvell.com>
Date:   Mon Nov 19 18:44:32 2018 +0530

    PCI: Assign bus numbers present in EA capability for bridges
    
    The "Enhanced Allocation (EA) for Memory and I/O Resources" ECN, approved
    23 October 2014, sec 6.9.1.2, specifies a second DW in the capability for
    type 1 (bridge) functions to describe fixed secondary and subordinate bus
    numbers.  This ECN was included in the PCIe r4.0 spec, but sec 6.9.1.2 was
    omitted, presumably by mistake.
    
    Read fixed bus numbers from the EA capability for bridges.
    
    Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
    [bhelgaas: add pci_ea_fixed_busnrs() return value]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 012250a78da7..a6874c306908 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1086,6 +1086,36 @@ static void pci_enable_crs(struct pci_dev *pdev)
 
 static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 					      unsigned int available_buses);
+/**
+ * pci_ea_fixed_busnrs() - Read fixed Secondary and Subordinate bus
+ * numbers from EA capability.
+ * @dev: Bridge
+ * @sec: updated with secondary bus number from EA
+ * @sub: updated with subordinate bus number from EA
+ *
+ * If @dev is a bridge with EA capability, update @sec and @sub with
+ * fixed bus numbers from the capability and return true.  Otherwise,
+ * return false.
+ */
+static bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
+{
+	int ea, offset;
+	u32 dw;
+
+	if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
+		return false;
+
+	/* find PCI EA capability in list */
+	ea = pci_find_capability(dev, PCI_CAP_ID_EA);
+	if (!ea)
+		return false;
+
+	offset = ea + PCI_EA_FIRST_ENT;
+	pci_read_config_dword(dev, offset, &dw);
+	*sec =  dw & PCI_EA_SEC_BUS_MASK;
+	*sub = (dw & PCI_EA_SUB_BUS_MASK) >> PCI_EA_SUB_BUS_SHIFT;
+	return true;
+}
 
 /*
  * pci_scan_bridge_extend() - Scan buses behind a bridge
@@ -1120,6 +1150,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	u16 bctl;
 	u8 primary, secondary, subordinate;
 	int broken = 0;
+	bool fixed_buses;
+	u8 fixed_sec, fixed_sub;
+	int next_busnr;
 
 	/*
 	 * Make sure the bridge is powered on to be able to access config
@@ -1219,17 +1252,24 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		/* Clear errors */
 		pci_write_config_word(dev, PCI_STATUS, 0xffff);
 
+		/* Read bus numbers from EA Capability (if present) */
+		fixed_buses = pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
+		if (fixed_buses)
+			next_busnr = fixed_sec;
+		else
+			next_busnr = max + 1;
+
 		/*
 		 * Prevent assigning a bus number that already exists.
 		 * This can happen when a bridge is hot-plugged, so in this
 		 * case we only re-scan this bus.
 		 */
-		child = pci_find_bus(pci_domain_nr(bus), max+1);
+		child = pci_find_bus(pci_domain_nr(bus), next_busnr);
 		if (!child) {
-			child = pci_add_new_bus(bus, dev, max+1);
+			child = pci_add_new_bus(bus, dev, next_busnr);
 			if (!child)
 				goto out;
-			pci_bus_insert_busn_res(child, max+1,
+			pci_bus_insert_busn_res(child, next_busnr,
 						bus->busn_res.end);
 		}
 		max++;
@@ -1290,7 +1330,13 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 			max += i;
 		}
 
-		/* Set subordinate bus number to its real value */
+		/*
+		 * Set subordinate bus number to its real value.
+		 * If fixed subordinate bus number exists from EA
+		 * capability then use it.
+		 */
+		if (fixed_buses)
+			max = fixed_sub;
 		pci_bus_update_busn_res_end(child, max);
 		pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
 	}
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 5c98133f2c94..c51e0066de8b 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -372,6 +372,12 @@
 #define PCI_EA_FIRST_ENT_BRIDGE	8	/* First EA Entry for Bridges */
 #define  PCI_EA_ES		0x00000007 /* Entry Size */
 #define  PCI_EA_BEI		0x000000f0 /* BAR Equivalent Indicator */
+
+/* EA fixed Secondary and Subordinate bus numbers for Bridge */
+#define PCI_EA_SEC_BUS_MASK	0xff
+#define PCI_EA_SUB_BUS_MASK	0xff00
+#define PCI_EA_SUB_BUS_SHIFT	8
+
 /* 0-5 map to BARs 0-5 respectively */
 #define   PCI_EA_BEI_BAR0		0
 #define   PCI_EA_BEI_BAR5		5
