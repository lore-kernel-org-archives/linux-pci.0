Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1C8C10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 20:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2BE2075B
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 20:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555447915;
	bh=kBcrF9neRSWS6nM9tksG/1DcGAum+/LO2r2bCCps/rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FmAbsV3IBn1C+39ozom7qcBWiNQSaIb424RhC1XB/BVIyKO72ckwFuXp81L/y24D1
	 mFoiarlkUDCj/SMi3tE5NoJ6BApEWTC6i/TsJLJ3Hqgw9LL7td50C+nQ8sc9KLZOGP
	 qucznPdRL8lCMCghkGIsyprfpSUGVdb6GmROEq/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfDPUvy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:51:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728405AbfDPUvy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Apr 2019 16:51:54 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9054520684;
        Tue, 16 Apr 2019 20:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555447913;
        bh=kBcrF9neRSWS6nM9tksG/1DcGAum+/LO2r2bCCps/rs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GjbRAlqmFkRcwj0VfnT3QWcNVLPrZwo8ZeKgNeX7rwL2Yum7gQ7F5s2djZX0F7cn5
         HMTAygLxGrY9HqtfNvkSgVaOfGkFSSvymucxse3Z6J/C+T0ecdgHI7DkiUGFPuNFKg
         mw3tDPhXrq+3URzkc6fF2L35R/MLRRTcQz14VbiY=
Date:   Tue, 16 Apr 2019 15:51:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sundeep.lkml@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        sean.stalley@intel.com, sgoutham@marvell.com,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: Re: [v3 PATCH 1/2] PCI: read fixed bus numbers in EA for type 1
 functions
Message-ID: <20190416205149.GP126710@google.com>
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

Section 6.9.1.2 "Enhanced Allocation Capability Second DW [Type 1
Functions Only]" is in the ECN (approved 23 Oct 2014), but is not in
the PCIe r4.0 spec, and is *STILL* not in the draft PCIe r5.0 spec, as
far as I can tell.

I thought we had a plan to get the spec updated?  Maybe that was
wishful thinking on my part.

> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
> v3:
>   As per Bjorn's suggestion placed EA stuff in pci_ea_init and
>   captured bus numbers in pci_dev
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
