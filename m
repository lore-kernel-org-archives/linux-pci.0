Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33328 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756013Ab2IODWW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Sep 2012 23:22:22 -0400
Received: by pbbrr13 with SMTP id rr13so6515908pbb.19
        for <linux-pci@vger.kernel.org>; Fri, 14 Sep 2012 20:22:22 -0700 (PDT)
Message-ID: <5053F461.5040508@gmail.com>
Date: Sat, 15 Sep 2012 11:22:09 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Yijing Wang <wangyijing@huawei.com>,
	PCI <linux-pci@vger.kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: Re: a small problem about pci_stop_and_remove_bus_device() function
References: <503DD9A7.70007@huawei.com> <CAErSpo7JknWsMGpYnxyLqmLQO5Xr5jMGYnpgdCmEjYWN-=5vjA@mail.gmail.com>
In-Reply-To: <CAErSpo7JknWsMGpYnxyLqmLQO5Xr5jMGYnpgdCmEjYWN-=5vjA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/14/2012 12:43 AM, Bjorn Helgaas wrote:
> I didn't intend this change in behavior, so in that sense, this is a
> regression.  We could restore the previous behavior by changing
> pci_stop_and_remove_bus_device() so the "pci_remove_bus();
> dev->subordinate = NULL;" code is after the pci_stop_dev() call, as
> you suggest.
> 
> But I'm not 100% sure that's the correct fix.  I think it's possible
> to have a bridge device that has no secondary bus.  For example, I
> don't think a bridge configured with "secondary > subordinate", e.g.,
> "[bus ff-00]", will forward any config transactions downstream.  In
> that case, we'll have a struct pci_dev for the bridge device, but
> there won't be a struct pci_bus for the secondary bus, so
> dev->subordinate will be NULL.  There are actually quite a few
> existing tests for this situation in pnv_ioda_setup_bus_PE(),
> eeh_add_device_tree_late(), yenta_probe(), etc.
> 
> When we enumerate bridges, we build the bridge pci_dev before building
> the downstream pci_bus, so symmetry suggests that we should tear down
> the pci_bus before tearing down the pci_dev.
> 
> So I wonder if a better fix is remove the assumption that
> "dev->subordinate != NULL means this is a bridge device."  There are
> many places where we test "dev->subordinate" to iterate through
> downstream devices or something similar; those should be fine.  We'd
> only have to change the places that care about actual type of the
> device, e.g., the config space differences between header types.
> 
> Where did you trip over this?  If you just found this by inspection,
> my congratulations, it's a pretty subtle issue :)
HI Bjorn,
	This issue was disclosed when developing the patch set "[PATCH v2 0/9] 
enhance PCI related drivers to handle hotplug events". BTW, I have sent this patch
set to you just now.
	We are not assume that dev->subordinate is not NULL for a bridge device,
but that dev->subordinate is consistent when PCI bus notification callbacks are
called for BUS_NOTIFY_ADD_DEVICE and BUS_NOTIFY_DEL_DEVICE.
	Thanks!
	Gerry
