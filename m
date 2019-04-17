Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03896C282DA
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 20:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00EE20651
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 20:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555531955;
	bh=Mo5WVNMnafU6YX4w6aBTS2+7npoANQF42AZYIZO8WMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=150x+cYtWBU8Kj5NNSVPqa4CREtiWbHMZoKdgjatcZ6yFB0G0HrlkpY4iSMOVnYKt
	 Rpbiu+MUueUI6OTIlzESHGI/EBIzYuqWKXSaJY8FgZR8Hi8n1y1X5V3eF783fmTlfZ
	 DA3Xe0fJ3TfWtCuc9zHkRuxrzJ0QpLFR0g8xw9DQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfDQUMf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfDQUMe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Apr 2019 16:12:34 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F82B20651;
        Wed, 17 Apr 2019 20:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555531953;
        bh=Mo5WVNMnafU6YX4w6aBTS2+7npoANQF42AZYIZO8WMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fGMRy6KihRFj/gkZMyd9mZ4HZ+GNtpgT0gH97XupSfhMLpIOroCMQMpc807ZMEgo5
         1fs/RGNzmWGLsv3ESzAigwOnX3NOkuL6pzyG22qvY8zK1xhPITVb3eDerCan15idio
         xpfEUnqy62w7nAS+wdYnu6aN8Yb+aepXkNVXRyjM=
Date:   Wed, 17 Apr 2019 15:12:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sundeep.lkml@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        sean.stalley@intel.com, sgoutham@marvell.com,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: Re: [v3 PATCH 1/2] PCI: read fixed bus numbers in EA for type 1
 functions
Message-ID: <20190417201232.GQ126710@google.com>
References: <1548249481-24645-1-git-send-email-sundeep.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548249481-24645-1-git-send-email-sundeep.lkml@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 23, 2019 at 06:48:00PM +0530, sundeep.lkml@gmail.com wrote:
> From: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> As per the spec - ECN_Enhanced_Allocation_23_Oct_2014_Final
> and section 6.9.1.2, EA capability contains fixed secondary
> and subordinate bus numbers for type 1 functions.
> This patch adds support to read the fixed bus numbers
> from EA capability for bridge.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
> v3:
>   As per Bjorn's suggestion placed EA stuff in pci_ea_init and
>   captured bus numbers in pci_dev

You were right the first time, and my idea of putting this stuff in
pci_ea_init() was well-intentioned but wrong.  It doesn't seem
worthwhile to add those two fields to pci_dev when they will almost
always be unused.

I applied your v2 patch and revised it a little; I'll respond to that
patch so the comments make sense there.

> v2:
>   None just added Sean
> 
>  drivers/pci/pci.c             | 10 ++++++++--
>  include/linux/pci.h           |  4 ++++
>  include/uapi/linux/pci_regs.h |  4 ++++
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c25acac..484b63e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2909,6 +2909,7 @@ void pci_ea_init(struct pci_dev *dev)
>  	u8 num_ent;
>  	int offset;
>  	int i;
> +	u32 dw;
>  
>  	/* find PCI EA capability in list */
>  	ea = pci_find_capability(dev, PCI_CAP_ID_EA);
> @@ -2922,9 +2923,14 @@ void pci_ea_init(struct pci_dev *dev)
>  
>  	offset = ea + PCI_EA_FIRST_ENT;
>  
> -	/* Skip DWORD 2 for type 1 functions */
> -	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
> +	/* Note fixed bus numbers for type 1 functions */
> +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> +		pci_read_config_dword(dev, offset, &dw);
> +		dev->fixed_sec_busnr = dw & PCI_EA_FIXED_SEC_BUS;
> +		dev->fixed_sub_busnr = (dw & PCI_EA_FIXED_SUB_BUS) >>
> +					PCI_EA_FIXED_SUB_SHIFT;
>  		offset += 4;
> +	}
>  
>  	/* parse each EA entry */
>  	for (i = 0; i < num_ent; ++i)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 65f1d8c..3e9a3ae 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -459,6 +459,10 @@ struct pci_dev {
>  	char		*driver_override; /* Driver name to force a match */
>  
>  	unsigned long	priv_flags;	/* Private flags for the PCI driver */
> +
> +	/* bus numbers from EA capability if this device is a bridge */
> +	u8 fixed_sec_busnr; /* Fixed Secondary Bus number */
> +	u8 fixed_sub_busnr; /* Fixed Subordinate Bus number */
>  };
>  
>  static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e1e9888..51e9ac0 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -372,6 +372,10 @@
>  #define PCI_EA_FIRST_ENT_BRIDGE	8	/* First EA Entry for Bridges */
>  #define  PCI_EA_ES		0x00000007 /* Entry Size */
>  #define  PCI_EA_BEI		0x000000f0 /* BAR Equivalent Indicator */
> +/* Fixed Secondary and Subordinate bus numbers in EA for Bridge */
> +#define   PCI_EA_FIXED_SEC_BUS		0xff
> +#define   PCI_EA_FIXED_SUB_BUS		0xff00
> +#define   PCI_EA_FIXED_SUB_SHIFT	8
>  /* 0-5 map to BARs 0-5 respectively */
>  #define   PCI_EA_BEI_BAR0		0
>  #define   PCI_EA_BEI_BAR5		5
> -- 
> 1.8.3.1
> 
