Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 9 Apr 2018 17:29:57 -0600
From: Keith Busch <keith.busch@intel.com>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Wei Zhang <wzhang@fb.com>, Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v13 4/6] PCI/DPC: Unify and plumb error handling into DPC
Message-ID: <20180409232957.GF6283@localhost.localdomain>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-5-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1523284914-2037-5-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 09, 2018 at 10:41:52AM -0400, Oza Pawandeep wrote:
> +static int find_dpc_dev_iter(struct device *device, void *data)
> +{
> +	struct pcie_port_service_driver *service_driver;
> +	struct device **dev;
> +
> +	dev = (struct device **) data;
> +
> +	if (device->bus == &pcie_port_bus_type && device->driver) {
> +		service_driver = to_service_driver(device->driver);
> +		if (service_driver->service == PCIE_PORT_SERVICE_DPC) {
> +			*dev = device;
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static struct device *pci_find_dpc_dev(struct pci_dev *pdev)
> +{
> +	struct device *dev = NULL;
> +
> +	device_for_each_child(&pdev->dev, &dev, find_dpc_dev_iter);
> +
> +	return dev;
> +}

The only caller of this doesn't seem to care to use struct device. This
should probably just extract struct dpc_dev directly from in here.
