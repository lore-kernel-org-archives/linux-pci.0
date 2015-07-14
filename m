Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:48834 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbbGNWZI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 14 Jul 2015 18:25:08 -0400
Message-ID: <55A58C41.9000804@intel.com>
Date: Wed, 15 Jul 2015 00:25:05 +0200
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
CC: Myron Stowe <myron.stowe@redhat.com>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: Re: [PATCH 1/2] PCI: Fix pcie_port_device_resume() comment
References: <20150714193757.13471.77973.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20150714194503.13471.65928.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150714194503.13471.65928.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7/14/2015 9:45 PM, Bjorn Helgaas wrote:
> The function comment claimed this was pcie_port_device_suspend(), but it's
> really pcie_port_device_resume().  Perils of cut and paste.
>
> Use the correct function name in the comment.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

ACK

> ---
>   drivers/pci/pcie/portdrv_core.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 2f0ce66..88122dc 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -448,7 +448,7 @@ static int resume_iter(struct device *dev, void *data)
>   }
>   
>   /**
> - * pcie_port_device_suspend - resume port services associated with a PCIe port
> + * pcie_port_device_resume - resume port services associated with a PCIe port
>    * @dev: PCI Express port to handle
>    */
>   int pcie_port_device_resume(struct device *dev)
>

