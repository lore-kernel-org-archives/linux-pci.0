Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:36763 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755991AbbDIT6v (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2015 15:58:51 -0400
Received: by obbeb7 with SMTP id eb7so122243358obb.3
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2015 12:58:50 -0700 (PDT)
Date: Thu, 9 Apr 2015 14:58:46 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Export pci_probe_reset_function()
Message-ID: <20150409195846.GL30967@google.com>
References: <20150409155100.6891.72838.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150409155100.6891.72838.stgit@gimli.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 09, 2015 at 09:51:43AM -0600, Alex Williamson wrote:
> The equivalent bus and slot versions of this are already exported and
> vfio-pci would like a function-probe available so we can expose
> function-level reset capabilities to the user without necessarily
> using it to perform a reset before enabling the device for the user.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Applied to pci/virtualization for v4.1, thanks!

> ---
>  drivers/pci/pci.c   |    1 +
>  include/linux/pci.h |    1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 81f06e8..9f3e691 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3524,6 +3524,7 @@ int pci_probe_reset_function(struct pci_dev *dev)
>  {
>  	return pci_dev_reset(dev, 1);
>  }
> +EXPORT_SYMBOL_GPL(pci_probe_reset_function);
>  
>  /**
>   * pci_reset_function - quiesce and reset a PCI device function
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 211e9da..233d1ae 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -986,6 +986,7 @@ int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
>  			  enum pcie_link_width *width);
>  int __pci_reset_function(struct pci_dev *dev);
>  int __pci_reset_function_locked(struct pci_dev *dev);
> +int pci_probe_reset_function(struct pci_dev *dev);
>  int pci_reset_function(struct pci_dev *dev);
>  int pci_try_reset_function(struct pci_dev *dev);
>  int pci_probe_reset_slot(struct pci_slot *slot);
> 
