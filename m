Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 10 May 2018 08:31:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v15 7/9] PCI/PORTDRV: Implement generic find device
Message-ID: <20180510133104.GG173327@bhelgaas-glaptop.roam.corp.google.com>
References: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
 <1525323838-1735-8-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525323838-1735-8-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 03, 2018 at 01:03:56AM -0400, Oza Pawandeep wrote:
> This patch implements generic pcie_port_find_device() routine.
> ...

> + * pcie_port_find_device - find the struct device
> + * @dev: PCI Express port the service devices associated with
> + * @service: For the service to find
> + *
> + * Find PCI Express port service driver associated with given service
> + */
> +struct  device *pcie_port_find_device(struct pci_dev *dev,

s/struct  device/struct device/ (remove extra space)

> +				      u32 service)
> +{
> +	struct device *device;
> +	struct portdrv_service_data pdrvs;
> +
> +	pdrvs.dev = NULL;
> +	pdrvs.service = service;
> +	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
> +
> +	device = pdrvs.dev;
> +	return device;
> +}
> +
> +/**
