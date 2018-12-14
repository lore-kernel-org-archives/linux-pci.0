Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF5EC43387
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 22:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F2F208C2
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 22:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544826366;
	bh=nBKoQ9cdrUBb+guiM08+nrtsEAwnCDm8SNt3tRHOXDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JyzP43dzg0DvZRj3P9SCuaNezAs19kxTb3B9Qv4i49z8otbhAiEoJTBF0BkV4ZpgP
	 PbZ6OZTQl3yvp+i2G1qfn1+ijqMAes2xjdbFfGAf21g2KrC0fuag0WNh/D3CTgwLnG
	 XWa3PfAJvNwJAgrwe356wPCfeFSRJkQFwoSTsEFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbeLNW0E (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:26:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:60980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbeLNW0E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Dec 2018 17:26:04 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46189206DD;
        Fri, 14 Dec 2018 22:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544826364;
        bh=nBKoQ9cdrUBb+guiM08+nrtsEAwnCDm8SNt3tRHOXDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ot2tD3kIsyOF1sN9pjeYvmyv2PM4H7CT9sncBtsStDmcMcJolWRS52if/Bym8dfuL
         M1haF2p7dMtXeSs2Bhvk57acKP/X7cavKlu1frUE3gO64bkxOQOyC9UzYWywOdVKIO
         TedO73gYQly9jwZELx898rSgzxx+YNwsL368EUGQ=
Date:   Fri, 14 Dec 2018 16:26:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v9 6/6] PCI: Stub out pci_request_acs() when CONFIG_PCI
 is not set
Message-ID: <20181214222601.GH20725@google.com>
References: <20181214163319.27479-1-okaya@kernel.org>
 <20181214163319.27479-7-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214163319.27479-7-okaya@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lorenzo, Robin, Logan]

On Fri, Dec 14, 2018 at 04:33:19PM +0000, Sinan Kaya wrote:
> ACPI IORT table code relies on pci_request_acs() to be present. Define
> a stub function when CONFI_PCI is not set.

This doesn't seem like the simplest approach to me, but I probably
don't understand what's going on in IORT.

It looks like *all* of iort_enable_acs() (the caller of
pci_request_acs()) is PCI-specific; at least, the whole thing is
wrapped in a test for ACPI_IORT_NODE_PCI_ROOT_COMPLEX.  So the whole
function could be wrapped in #ifdef CONFIG_PCI.

Here's the caller of iort_enable_acs():

  iort_init_platform_devices
    acs_enabled = false
    for (i = 0; i < iort->node_count; i++) {
      if (!acs_enabled)
        acs_enabled = iort_enable_acs(iort_node);

It seems like the acs_enabled state could be encapsulated inside
iort_enable_acs().

Today pci_request_acs() is a system-wide thing, but I don't know why
that's the case.  Isn't it conceivable that different PCI hierarchies
could have different ACS policies, e.g., because of P2P DMA or
something?

Bottom line, pci_request_acs() is being called from what looks like
PCI-specific code in IORT, and it would make more sense to me to prune
out that code in IORT than to make a stub pci_request_acs().

> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  include/linux/pci.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 51a5a5217667..f0f2f55ea93c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2101,7 +2101,11 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
>  	return NULL;
>  }
>  
> +#ifdef CONFIG_PCI
>  void pci_request_acs(void);
> +#else
> +static inline void pci_request_acs(void) {}
> +#endif
>  bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
>  bool pci_acs_path_enabled(struct pci_dev *start,
>  			  struct pci_dev *end, u16 acs_flags);
> -- 
> 2.19.0
> 
