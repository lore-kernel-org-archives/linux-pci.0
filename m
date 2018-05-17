Return-Path: <linux-kernel-owner@vger.kernel.org>
To: dmeyer@gigaio.com, kurt.schwemmer@microsemi.com,
        linux-pci@vger.kernel.org, linux-ntb@googlegroups.com
Cc: bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, linux-kernel@vger.kernel.org
References: <1526558413-23113-1-git-send-email-dmeyer@gigaio.com>
 <1526558413-23113-3-git-send-email-dmeyer@gigaio.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a0997fec-ba06-0d1d-a43d-fcc1600484f5@deltatee.com>
Date: Thu, 17 May 2018 09:48:04 -0600
MIME-Version: 1.0
In-Reply-To: <1526558413-23113-3-git-send-email-dmeyer@gigaio.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 2/2] NTB: PCI Quirk to Enable Switchtec NT Functionality
 with IOMMU On
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks for your hard work on this Doug!

On 17/05/18 06:00 AM, dmeyer@gigaio.com wrote:

> +	if (pci_enable_device(pdev)) {
> +		dev_err(&pdev->dev, "Cannot enable Switchtec device\n");
> +		return;
> +	}

I suspect we should probably cass pci_disable_device() before leaving
this function so it's in the same state we started. Just like we unmap
the mmio.

Logan
