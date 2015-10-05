Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:28530 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238AbbJEW0v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 5 Oct 2015 18:26:51 -0400
Date: Mon, 5 Oct 2015 15:23:51 -0700
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	linux-api@vger.kernel.org, yinghai@kernel.org,
	rajatxjain@gmail.com, gong.chen@linux.intel.com,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v4 3/5] PCI: Handle IORESOURCE_PCI_FIXED when sizing and
 assigning resources.
Message-ID: <20151005222351.GA4821@sean.stalley.intel.com>
References: <1443825476-26880-1-git-send-email-ddaney.cavm@gmail.com>
 <1443825476-26880-4-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443825476-26880-4-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 02, 2015 at 03:37:54PM -0700, David Daney wrote:

...

> +/*
> + * Try to assign any resources marked as IORESOURCE_PCI_FIXED, as they
> + * are skipped by pbus_assign_resources_sorted().
> + */
> +static void pdev_assign_fixed_resources(struct pci_dev *dev)
> +{
> +	int i;
> +
> +	for (i = 0; i <  PCI_NUM_RESOURCES; i++) {
> +		struct pci_bus *b;
> +		struct resource *r = &dev->resource[i];
> +
> +		if (r->parent || !(r->flags & IORESOURCE_PCI_FIXED) ||
> +		    !(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
> +			continue;
> +
> +		b = dev->bus;
> +		while (b && !r->parent) {
> +			assign_fixed_resource_on_bus(b, r);
> +			b = b->parent;
> +		}
> +		if (!r->parent) {
> +			/*
> +			 * If that didn't work, try to fallback to the
> +			 * ultimate parent.
> +			 */
> +			if (r->flags &  IORESOURCE_IO)
> +				request_resource(&ioport_resource, r);
> +			else
> +				request_resource(&iomem_resource, r);
> +		}

I don't think this check is necessary.
assign_fixed_resource_on_bus() should find these resources when it reaches the top bus.
(since since the root bus contains these resources).

> +	}
> +}

-Sean
