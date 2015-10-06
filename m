Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:34795 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbbJFU6r (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Oct 2015 16:58:47 -0400
Message-ID: <56143603.9090708@gmail.com>
Date: Tue, 06 Oct 2015 13:58:43 -0700
From: David Daney <ddaney.cavm@gmail.com>
MIME-Version: 1.0
To: "Sean O. Stalley" <sean.stalley@intel.com>
CC: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	linux-api@vger.kernel.org, yinghai@kernel.org,
	rajatxjain@gmail.com, gong.chen@linux.intel.com,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v4 3/5] PCI: Handle IORESOURCE_PCI_FIXED when sizing and
 assigning resources.
References: <1443825476-26880-1-git-send-email-ddaney.cavm@gmail.com> <1443825476-26880-4-git-send-email-ddaney.cavm@gmail.com> <20151005222351.GA4821@sean.stalley.intel.com>
In-Reply-To: <20151005222351.GA4821@sean.stalley.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/05/2015 03:23 PM, Sean O. Stalley wrote:
> On Fri, Oct 02, 2015 at 03:37:54PM -0700, David Daney wrote:
>
> ...
>
>> +/*
>> + * Try to assign any resources marked as IORESOURCE_PCI_FIXED, as they
>> + * are skipped by pbus_assign_resources_sorted().
>> + */
>> +static void pdev_assign_fixed_resources(struct pci_dev *dev)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i <  PCI_NUM_RESOURCES; i++) {
>> +		struct pci_bus *b;
>> +		struct resource *r = &dev->resource[i];
>> +
>> +		if (r->parent || !(r->flags & IORESOURCE_PCI_FIXED) ||
>> +		    !(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
>> +			continue;
>> +
>> +		b = dev->bus;
>> +		while (b && !r->parent) {
>> +			assign_fixed_resource_on_bus(b, r);
>> +			b = b->parent;
>> +		}
>> +		if (!r->parent) {
>> +			/*
>> +			 * If that didn't work, try to fallback to the
>> +			 * ultimate parent.
>> +			 */
>> +			if (r->flags &  IORESOURCE_IO)
>> +				request_resource(&ioport_resource, r);
>> +			else
>> +				request_resource(&iomem_resource, r);
>> +		}
>
> I don't think this check is necessary.
> assign_fixed_resource_on_bus() should find these resources when it reaches the top bus.
> (since since the root bus contains these resources).

You are correct.  It does work fine without that last fallback bit.  I 
will remove that, and re-send the patches.

Thanks,
David Daney



>
>> +	}
>> +}
>
> -Sean
>

