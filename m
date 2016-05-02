Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46392 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754821AbcEBTdJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 2 May 2016 15:33:09 -0400
Date: Mon, 2 May 2016 14:33:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 07/12] pci: sh: SH7751 PCI host bridge driver
Message-ID: <20160502193305.GI24851@localhost>
References: <1462079316-27771-1-git-send-email-ysato@users.sourceforge.jp>
 <1462079316-27771-8-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462079316-27771-8-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, May 01, 2016 at 02:08:31PM +0900, Yoshinori Sato wrote:

> +static __init int sh7751_pci_probe(struct platform_device *pdev)
> +{
> ...

> +	pci->cfg.ops = &pci_sh7751_ops;
> +	return pci_host_common_probe(pdev, pci);
> +}
> +
> +static __refdata struct platform_driver sh7751_pci_driver = {
> +	.driver = {
> +		.name = "sh7751-pci",
> +		.of_match_table = sh7751_pci_of_match,
> +	},
> +	.probe = sh7751_pci_probe,
> +};
> +module_platform_driver(sh7751_pci_driver);

I *think* that if you use builtin_platform_driver_probe() or
module_platform_driver_probe() here, you can get rid of the __refdata
on sh7751_pci_driver while keeping sh7751_pci_probe() as __init.
