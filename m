Return-Path: <SRS0=9PB/=Y7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC82C5DF61
	for <linux-pci@archiver.kernel.org>; Thu,  7 Nov 2019 09:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C9C206C3
	for <linux-pci@archiver.kernel.org>; Thu,  7 Nov 2019 09:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbfKGJ32 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:29:28 -0500
Received: from foss.arm.com ([217.140.110.172]:52554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733209AbfKGJ32 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 04:29:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC0BE46A;
        Thu,  7 Nov 2019 01:29:27 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22CAF3F71A;
        Thu,  7 Nov 2019 01:29:26 -0800 (PST)
Date:   Thu, 7 Nov 2019 09:29:25 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 3/5] PCI/ASPM: Remove dependency on PCIEPORTBUS
Message-ID: <20191107092924.GR9723@e119886-lin.cambridge.arm.com>
References: <20191106222420.10216-1-helgaas@kernel.org>
 <20191106222420.10216-4-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106222420.10216-4-helgaas@kernel.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 06, 2019 at 04:24:19PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The ASPM support does not depend on the portdrv, so remove the Kconfig
> dependency.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index b0d781d72d1b..b196ad816129 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -63,7 +63,7 @@ config PCIE_ECRC
>  #
>  config PCIEASPM
>  	bool "PCI Express ASPM control" if EXPERT
> -	depends on PCI && PCIEPORTBUS
> +	depends on PCI
>  	default y
>  	help
>  	  This enables OS control over PCI Express ASPM (Active State
> -- 

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> 2.24.0.rc1.363.gb1bccd3e3d-goog
> 
