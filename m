Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751074AbdISTo1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Sep 2017 15:44:27 -0400
Date: Tue, 19 Sep 2017 14:44:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: make pci_dev_type const
Message-ID: <20170919194426.GF22312@bhelgaas-glaptop.roam.corp.google.com>
References: <1505214813-9591-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505214813-9591-1-git-send-email-bhumirks@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 12, 2017 at 04:43:33PM +0530, Bhumika Goyal wrote:
> Make this const as it not modified in the file referencing it. 
> It is only stored in a const field 'type' of a device structure. 
> Also, add const to the variable declaration in the header file.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied to pci/misc for v4.15, thanks!

> ---
>  drivers/pci/pci-sysfs.c | 2 +-
>  drivers/pci/pci.h       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 1eecfa3..882d6c3 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1788,6 +1788,6 @@ static umode_t sriov_attrs_are_visible(struct kobject *kobj,
>  	NULL,
>  };
>  
> -struct device_type pci_dev_type = {
> +const struct device_type pci_dev_type = {
>  	.groups = pci_dev_attr_groups,
>  };
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index a6560c9..1db36f2 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -192,7 +192,7 @@ static inline int pci_no_d1d2(struct pci_dev *dev)
>  }
>  extern const struct attribute_group *pci_dev_groups[];
>  extern const struct attribute_group *pcibus_groups[];
> -extern struct device_type pci_dev_type;
> +extern const struct device_type pci_dev_type;
>  extern const struct attribute_group *pci_bus_groups[];
>  
>  
> -- 
> 1.9.1
> 
