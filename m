Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:35686 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbaGAPE4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 1 Jul 2014 11:04:56 -0400
Message-ID: <53B2CE15.7010403@wwwdotorg.org>
Date: Tue, 01 Jul 2014 09:04:53 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com, rjw@sisk.pl,
	nagananda.chumbalkar@hp.com, thierry.reding@gmail.com,
	swarren@nvidia.com, kthota@nvidia.com, linux-pci@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: enable ASPM configuration in PCIE POWERSAVE mode
References: <1404198978-26593-1-git-send-email-vidyas@nvidia.com>
In-Reply-To: <1404198978-26593-1-git-send-email-vidyas@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/01/2014 01:16 AM, Vidya Sagar wrote:
> commit 1a680b7c moved pcie_aspm_powersave_config_link() out of
> pci_raw_set_power_state() to pci_set_power_state() which would enable
> ASPM. But, with commit db288c9c, which re-introduced the following check
> ./drivers/pci/pci.c: pci_set_power_state()
> +   /* Check if we're already there */
> +   if (dev->current_state == state)
> +       return 0;
> in pci_set_power_state(), call to pcie_aspm_powersave_config_link() is never
> made leaving ASPM broken.
> Fix it by not returning from when the above condition is true, rather, jump to
> ASPM configuration code and exit from there eventually.

Out of curiosity, was this patch tested by running an umodified mainline
kernel on a Tegra device, or is this simply a port from our downstream
kernel, without any additional upstream testing?
