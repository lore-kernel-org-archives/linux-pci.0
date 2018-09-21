Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B928ECE567
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 16:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9679821567
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 16:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbVXiIUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9679821567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390076AbeIUWrP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388909AbeIUWrP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Sep 2018 18:47:15 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E765A2150E;
        Fri, 21 Sep 2018 16:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537549050;
        bh=R55saNyUWZTHFxodxNzxvCw2Q5L6g/1otHxshcwGHl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dbVXiIUoUhRDtR8c3LD/bIAHzRESDfxmLyKJ3KioEa5sobUXjOG9pBtSPG8yv9m3h
         nia8240Y77S4hZrjUvXgpONff1pwrTAjFbhq8aQd696VKaGWjtRIgWObt7xnnW5auw
         TSA4vYYiMhEoWpN5zYNR6PTPmSHvYgy5PM6hGy5Y=
Date:   Fri, 21 Sep 2018 11:57:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Fix compile error with DPC disabled
Message-ID: <20180921165729.GK224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180921142210.1191-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921142210.1191-1-keith.busch@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 21, 2018 at 08:22:10AM -0600, Keith Busch wrote:
> The alternate functions when CONFIG_PCIE_DPC is not defined need to be
> static inline.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

If you tell me which patch, I'll fold this into it so there's no bisection
hole.

> ---
>  drivers/pci/pci.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index a244bd0c5ca7..eb3125decffe 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -402,8 +402,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
>  void pci_save_dpc_state(struct pci_dev *dev);
>  void pci_restore_dpc_state(struct pci_dev *dev);
>  #else
> -void pci_save_dpc_state(struct pci_dev *dev) {}
> -void pci_restore_dpc_state(struct pci_dev *dev) {}
> +static inline void pci_save_dpc_state(struct pci_dev *dev) {}
> +static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
>  #endif
>  
>  #ifdef CONFIG_PCI_ATS
> -- 
> 2.14.4
> 
