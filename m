Return-Path: <SRS0=01Vy=CT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAF2C43461
	for <linux-pci@archiver.kernel.org>; Thu, 10 Sep 2020 02:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309AD20C09
	for <linux-pci@archiver.kernel.org>; Thu, 10 Sep 2020 02:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599705079;
	bh=rpK5TImbUwxuczxPgKi/2SEW4+zwGKS4ZV3zurp+kWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=lW+H3btq27v6sb3Ale4iU4CGs5cGMsMgVq0dcN1JCqvEntYYAvr0yUWg+AFhG35rI
	 xkUFxLK8FbT/d+Bl+6ABtXDIWTG1k+EAHKxj3aBPlgrK8n3SscM9vRaQlchpp8DbiB
	 ZrCCpRTVzEzRJQshzXXnijHg1Bv6wsDyTa5+Cz00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbgIJCbI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:31:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730799AbgIJC0B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Sep 2020 22:26:01 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D3932087C;
        Thu, 10 Sep 2020 02:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599704756;
        bh=rpK5TImbUwxuczxPgKi/2SEW4+zwGKS4ZV3zurp+kWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PfsuGjB1ZZycbitXyUFlPfMo/QY6sApLvwh7m3bf3/9cAVIR1Ro3aEcvpb4B5ZhQt
         iz249d9uvinV+ET9qjh7c5Fg8FxFfu6xckptcBxeauUujIxVBThhe059vyFOkyo47O
         PeA7Vp+4CWkJrbHQpUxo4GrA9VDtfY5pLYxfGAQo=
Date:   Wed, 9 Sep 2020 21:25:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] PCI: pcie_bus_config can be set at build time
Message-ID: <20200910022555.GA749829@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908163248.14330-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 08, 2020 at 12:32:48PM -0400, Jim Quinlan wrote:
> The Kconfig is modified so that the pcie_bus_config setting can be done at
> build time in the same manner as the CONFIG_PCIEASPM_XXXX choice.  The
> pci_bus_config setting may still be overridden by the bootline param.

I guess...  I really hate these build-time config settings for both
ASPM and MPS/MRRS.  But Linux just isn't smart or flexible enough to
do the right thing at run-time, so I guess we're kind of stuck.

I guess you have systems where you need a different default?

It'd be nice if we could put a little more detail in the Kconfig to
help users choose the correct one.  "Ensure MPS matches upstream
bridge" is *accurate*, but it doesn't really tell me why I would
choose this rather than a different one.

Maybe we could mention the corresponding command-line parameters,
e.g., "This is the same as booting with 'pci=pcie_bus_tune_off'"?

> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/Kconfig | 40 ++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.c   | 12 ++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 4bef5c2bae9f..efe69b0d9f7f 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -187,6 +187,46 @@ config PCI_HYPERV
>  	  The PCI device frontend driver allows the kernel to import arbitrary
>  	  PCI devices from a PCI backend to support PCI driver domains.
>  
> +choice
> +	prompt "PCIE default bus config setting"
> +	default PCIE_BUS_DEFAULT
> +	depends on PCI
> +	help
> +	  One of the following choices will set the pci_bus_config at
> +	  compile time.  This will still be overridden by the appropriate
> +	  pci bootline parameter.
> +
> +config PCIE_BUS_TUNE_OFF
> +	bool "Tune Off"
> +	depends on PCI
> +	help
> +	  Use the BIOS defaults; doesn't touch MPS at all.
> +
> +config PCIE_BUS_DEFAULT
> +	bool "Default"
> +	depends on PCI
> +	help
> +	  Ensure MPS matches upstream bridge.
> +
> +config PCIE_BUS_SAFE
> +	bool "Safe"
> +	depends on PCI
> +	help
> +	  Use largest MPS boot-time devices support.
> +
> +config PCIE_BUS_PERFORMANCE
> +	bool "Performance"
> +	depends on PCI
> +	help
> +	  Use MPS and MRRS for best performance.
> +
> +config PCIE_BUS_PEER2PEER
> +	bool "Peer2peer"
> +	depends on PCI
> +	help
> +	  Set MPS = 128 for all devices.
> +endchoice
> +
>  source "drivers/pci/hotplug/Kconfig"
>  source "drivers/pci/controller/Kconfig"
>  source "drivers/pci/endpoint/Kconfig"
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e39c5499770f..dfb52ed4a931 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -101,7 +101,19 @@ unsigned long pci_hotplug_mmio_pref_size = DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
>  #define DEFAULT_HOTPLUG_BUS_SIZE	1
>  unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
>  
> +
> +/* PCIE bus config, can be overridden by bootline param */
> +#ifdef CONFIG_PCIE_BUS_TUNE_OFF
> +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_TUNE_OFF;
> +#elif defined CONFIG_PCIE_BUS_SAFE
> +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_SAFE;
> +#elif defined CONFIG_PCIE_BUS_PERFORMANCE
> +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PERFORMANCE;
> +#elif defined CONFIG_PCIE_BUS_PEER2PEER
> +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_PEER2PEER;
> +#else
>  enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_DEFAULT;
> +#endif
>  
>  /*
>   * The default CLS is used if arch didn't set CLS explicitly and not
> -- 
> 2.17.1
> 
