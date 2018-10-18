Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFF2C5ACCC
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 19:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA291208E4
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 19:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmlfJ65V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA291208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbeJSDLw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Oct 2018 23:11:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbeJSDLw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Oct 2018 23:11:52 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17DF320658;
        Thu, 18 Oct 2018 19:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539889768;
        bh=f0GzIzCcRAqZOFlvEicHGBxe8ILtd5BnaOQbnt5jCT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jmlfJ65Vml9WpR8iRy0GkwinRu9xoybHkjWfPMJOuNaYYA9dN7wU+90KCIJpV5SNd
         pHVKG6AygwIuTaaUxWHPCyk9ZLBmNuOR2T1+T6DxvYS/un/YsTtRqL5aVQDNwLJ+S9
         lD3XFbgpNHUL2rmXuoVi63JdkYdYcL04dV9jHNq0=
Date:   Thu, 18 Oct 2018 14:09:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pcie: remove redundant 'default n' from Kconfig
Message-ID: <20181018190926.GJ5906@bhelgaas-glaptop.roam.corp.google.com>
References: <CGME20181016143814eucas1p21b1f3099131fc3f4263947932195299e@eucas1p2.samsung.com>
 <20181016143814eucas1p21b1f3099131fc3f4263947932195299e~eHZ_4THEH2088320883eucas1p2s@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016143814eucas1p21b1f3099131fc3f4263947932195299e~eHZ_4THEH2088320883eucas1p2s@eucas1p2.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 16, 2018 at 04:38:13PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 'default n' is the default value for any bool or tristate Kconfig
> setting so there is no need to write it explicitly.
> 
> Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
> is not set' for visible symbols") the Kconfig behavior is the same
> regardless of 'default n' being present or not:
> 
>     ...
>     One side effect of (and the main motivation for) this change is making
>     the following two definitions behave exactly the same:
>     
>         config FOO
>                 bool
>     
>         config FOO
>                 bool
>                 default n
>     
>     With this change, neither of these will generate a
>     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
>     That might make it clearer to people that a bare 'default n' is
>     redundant.
>     ...
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to pci/misc for v4.20, thanks!

> ---
>  drivers/pci/pcie/Kconfig |    4 ----
>  1 file changed, 4 deletions(-)
> 
> Index: b/drivers/pci/pcie/Kconfig
> ===================================================================
> --- a/drivers/pci/pcie/Kconfig	2018-10-09 15:58:49.831123212 +0200
> +++ b/drivers/pci/pcie/Kconfig	2018-10-16 16:36:32.419732670 +0200
> @@ -36,7 +36,6 @@ config PCIEAER
>  config PCIEAER_INJECT
>  	tristate "PCI Express error injection support"
>  	depends on PCIEAER && DYNAMIC_FTRACE_WITH_REGS
> -	default n
>  	help
>  	  This enables PCI Express Root Port Advanced Error Reporting
>  	  (AER) software error injector.
> @@ -84,7 +83,6 @@ config PCIEASPM
>  config PCIEASPM_DEBUG
>  	bool "Debug PCI Express ASPM"
>  	depends on PCIEASPM
> -	default n
>  	help
>  	  This enables PCI Express ASPM debug support. It will add per-device
>  	  interface to control ASPM.
> @@ -129,7 +127,6 @@ config PCIE_PME
>  config PCIE_DPC
>  	bool "PCI Express Downstream Port Containment support"
>  	depends on PCIEPORTBUS && PCIEAER
> -	default n
>  	help
>  	  This enables PCI Express Downstream Port Containment (DPC)
>  	  driver support.  DPC events from Root and Downstream ports
> @@ -139,7 +136,6 @@ config PCIE_DPC
>  
>  config PCIE_PTM
>  	bool "PCI Express Precision Time Measurement support"
> -	default n
>  	depends on PCIEPORTBUS
>  	help
>  	  This enables PCI Express Precision Time Measurement (PTM)
