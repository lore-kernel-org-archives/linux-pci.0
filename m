Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out-mta4.ai270.net ([94.126.40.171]:42118 "EHLO
	out-mta1.ai270.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933048AbcA3Ryd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 30 Jan 2016 12:54:33 -0500
Subject: Re: Hint HB6 - kernel doesn't see chips behind it.
To: Bjorn Helgaas <helgaas@kernel.org>
References: <5698191B.1070904@keynet-technology.com>
 <20160115172640.GC28453@localhost> <569CFB5B.7050903@keynet-technology.com>
 <20160119033839.GA3339@localhost> <56A8DA21.7060607@keynet-technology.com>
 <20160127215522.GA4875@localhost> <56A9EC07.8080509@keynet-technology.com>
 <20160129162400.GB12965@localhost>
Cc: linux-pci@vger.kernel.org
From: Richard F <lists@keynet-technology.com>
Message-ID: <56ACF8D4.8010607@keynet-technology.com>
Date: Sat, 30 Jan 2016 17:54:28 +0000
MIME-Version: 1.0
In-Reply-To: <20160129162400.GB12965@localhost>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 29/01/2016 16:24, Bjorn Helgaas wrote:
> On Thu, Jan 28, 2016 at 10:23:03AM +0000, Richard F wrote:
>> Bjorn,
>>
>> Thanks for looking at it. Actually I've tried 3 different PCI cards in
>> both slots and they all work fine.  I have 2 different single channel
>> BT878 based PCI cards in there now capturing CCTV 24 x 7, the machine
>> stays up for months. That's why it's so odd.  Any other pointers?  Does
>> the kernel need the BIOS to detect the card right?
> 
> The kernel should at least discover the card even if the BIOS doesn't
> do anything.  But on x86, the BIOS usually *does* configure things, so
> it's very possible we could trip over a Linux defect if it doesn't.
> 
> Try booting with "pci=pcie_scan_all".  That *shouldn't* make a
> difference because this isn't a PCIe device, but maybe our logic is
> broken.
> 
> Your topology looks a little strange:
> 
>   00:1c.0 PCIe root port to [bus 01]    slot 0
>   00:1c.1 PCIe root port to [bus 02]    slot 1
>   00:1c.2 PCIe root port to [bus 03-05] slot 2
>   03:00.0 PCI bridge to [bus 04-05] (Integrated Technology Express)
>   04:01.0 PCI bridge to [bus 05] (Hint Corp)
> 
> 00:1c.2 is a normal PCIe Root Port, so the device it's connected to
> *should* be a PCIe device, but 03:00.0 doesn't have a PCIe capability.
> Is this an adapter card of some kind?

It's a motherboard bridge to get from PCIe to legacy PCI slots, quite a
few motherboards use it I think. It's not an adapter I plugged in.

pci=pcie_scan_all didn't yield anything new, as you expected.

I posted the output of DMESG with your patch (in 4.4.0) to the bugzilla
https://bugzilla.kernel.org/show_bug.cgi?id=110851

It produced a fair bit of output but doesn't look like the card was
recognised. At least modprobe'ing bttv with the right parameters didn't
yield the right response.

I also tried pci=reouteirq and posted the result, that also didn't help.

Please let me know if there's anything else I can try. The AMI BIOS
doesn't have any setup parameters for the PCI/e.

Thanks
Richard


> 03:00.0 is an ITE 8893, and we do have a quirk related to a similar
> device:
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/quirks.c?h=v4.4#n3662
> 
> Can you try the patch below, please?
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 6d7ab9b..f6d8e85 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1530,6 +1530,7 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
>  		return false;
>  
> +	dev_info(&bus->dev, "%s %02x %#010x\n", __func__, devfn, *l);
>  	/* some broken boards return 0 or ~0 if a slot is empty: */
>  	if (*l == 0xffffffff || *l == 0x00000000 ||
>  	    *l == 0x0000ffff || *l == 0xffff0000)
> @@ -1571,6 +1572,7 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>  	struct pci_dev *dev;
>  	u32 l;
>  
> +	dev_info(&bus->dev, "%s %02x\n", __func__, devfn);
>  	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
>  		return NULL;
>  
> @@ -1751,6 +1753,7 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
>  {
>  	struct pci_dev *dev;
>  
> +	dev_info(&bus->dev, "%s %02x\n", __func__, devfn);
>  	dev = pci_get_slot(bus, devfn);
>  	if (dev) {
>  		pci_dev_put(dev);
> @@ -1825,6 +1828,7 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
>  	unsigned fn, nr = 0;
>  	struct pci_dev *dev;
>  
> +	dev_info(&bus->dev, "%s %02x\n", __func__, devfn);
>  	if (only_one_child(bus) && (devfn > 0))
>  		return 0; /* Already scanned the entire slot */
>  

