Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752556AbdHNVMZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Aug 2017 17:12:25 -0400
Date: Mon, 14 Aug 2017 16:12:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: not need to free epf_test
Message-ID: <20170814211222.GI32525@bhelgaas-glaptop.roam.corp.google.com>
References: <1501728251-196637-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501728251-196637-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 03, 2017 at 10:44:11AM +0800, Shawn Lin wrote:
> It's from devm_kzalloc. so not need to free it when removing
> the test driver.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Kishon?

> ---
> Just compile only. Unless I missed something when
> trying to support ep mode for pcie-rockchip and find this
> issue.
> 
>  drivers/pci/endpoint/functions/pci-epf-test.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 53fff80..4e3abbd 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -455,9 +455,6 @@ static int pci_epf_test_probe(struct pci_epf *epf)
>  
>  static int pci_epf_test_remove(struct pci_epf *epf)
>  {
> -	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> -
> -	kfree(epf_test);
>  	return 0;
>  }
>  
> -- 
> 1.9.1
> 
> 
