Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751387AbcISTl2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Sep 2016 15:41:28 -0400
Date: Mon, 19 Sep 2016 14:41:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Robert Jones <rjones@gateworks.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        Richard Zhu <Richard.Zhu@freescale.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Yinghai Lu <yinghai@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Subject: Re: PCI Resource Allocation
Message-ID: <20160919194122.GA21763@localhost>
References: <CALAE=UDqxjh1qt5OJexyonynj+uEyhiwdAtUF0_dD5ffRkUo=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALAE=UDqxjh1qt5OJexyonynj+uEyhiwdAtUF0_dD5ffRkUo=Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Robert,

On Mon, Sep 19, 2016 at 11:15:39AM -0700, Robert Jones wrote:
> Greetings,
> 
> I'm looking into a PCI resource limitation issue on an IMX6 based
> board and I find that in the 3.14 kernel I am able to use 6 Ath10k
> devices with the following resources:
> 
> 03:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac
> Wireless Network Adapter
>         Flags: fast devsel, IRQ 155
>         Memory at 01200000 (64-bit, non-prefetchable) [disabled] [size=2M]
>         [virtual] Expansion ROM at 01100000 [disabled] [size=64K]
>         Capabilities: [40] Power Management version 2
>         Capabilities: [50] MSI: Enable- Count=1/8 Maskable+ 64bit-
>         Capabilities: [70] Express Endpoint, MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [140] Virtual Channel
>         Capabilities: [160] Device Serial Number 00-00-00-00-00-00-00-00
> 
> In the 3.15 kernel following commit
> (5b28541552ef5eeffc41d6936105f38c2508e566), allocation has changed in
> such a way that results in none of the 6 radios nor the pci based
> ethernet interface being mapped.
> I am very new to PCI but after fiddling with some of the changes in
> the aforementioned commit I was able to come up with a 1 line patch
> that allows all 6 radios to once again become mapped and usable on the
> IMX6. The patch contents being:
> 
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -807,6 +807,7 @@ static struct resource
> *find_free_bus_resource(struct pci_bus *bus,
>  {
>         int i;
>         struct resource *r;
> +       type_mask = IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH;
> 
>         pci_bus_for_each_resource(bus, r, i) {
>                 if (r == &ioport_resource || r == &iomem_resource)
> 
> 
> I understand that this blatantly ignores the type mask parameter and
> would greatly appreciate any insight that you can provide as far as
> the proper way to proceed.
> 
> Note that the IMX6 has a limited memory window (16M) between the PCI
> core and the memory controller. This is mapped as:
> 
> 512KB config space
> 64KB io space
> 15MB mem space available for devices

Can you test this with a current kernel?  v3.15 is over two years old,
and there have been several fixes related to 5b28541552ef.

If a current kernel, e.g., v4.7, still fails, can you post the
complete dmesg log and contents of /proc/iomem?

Bjorn
