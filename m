Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752191AbdHCXXc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 19:23:32 -0400
Date: Thu, 3 Aug 2017 18:23:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add const to bin_attribute structures
Message-ID: <20170803232329.GW20308@bhelgaas-glaptop.roam.corp.google.com>
References: <1501687647-4462-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501687647-4462-1-git-send-email-bhumirks@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 02, 2017 at 08:57:27PM +0530, Bhumika Goyal wrote:
> Add const to bin_attribute structures as they are only passed to the
> functions sysfs_{remove/create}_bin_file. The corresponding arguments
> are of type const, so declare the structures to be const.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied to pci/misc for v4.14, thanks!

> ---
>  drivers/pci/pci-sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 2f3780b..2fc358c 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1431,7 +1431,7 @@ static ssize_t pci_read_rom(struct file *filp, struct kobject *kobj,
>  	return count;
>  }
>  
> -static struct bin_attribute pci_config_attr = {
> +static const struct bin_attribute pci_config_attr = {
>  	.attr =	{
>  		.name = "config",
>  		.mode = S_IRUGO | S_IWUSR,
> @@ -1441,7 +1441,7 @@ static ssize_t pci_read_rom(struct file *filp, struct kobject *kobj,
>  	.write = pci_write_config,
>  };
>  
> -static struct bin_attribute pcie_config_attr = {
> +static const struct bin_attribute pcie_config_attr = {
>  	.attr =	{
>  		.name = "config",
>  		.mode = S_IRUGO | S_IWUSR,
> -- 
> 1.9.1
> 
