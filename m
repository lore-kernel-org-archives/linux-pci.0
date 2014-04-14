Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113]:42111 "EHLO
	e06smtp17.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbaDNSHf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Apr 2014 14:07:35 -0400
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <sebott@linux.vnet.ibm.com>;
	Mon, 14 Apr 2014 19:07:33 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 24FB62190041
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2014 19:07:23 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com [9.149.37.249])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s3EI7Ttg590260
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2014 18:07:29 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s3EI7TBP022617
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2014 12:07:29 -0600
Date: Mon, 14 Apr 2014 20:07:28 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [Resend] pcibios_add_platform_entries usage
In-Reply-To: <20140414173541.GA4417@google.com>
Message-ID: <alpine.LFD.2.11.1404141958120.1561@denkbrett>
References: <alpine.LFD.2.11.1403281931410.1516@denkbrett> <alpine.LFD.2.11.1404141101500.1529@denkbrett> <20140414173541.GA4417@google.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463784958-1842069568-1397498848=:1561"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463784958-1842069568-1397498848=:1561
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hello Bjorn,

On Mon, 14 Apr 2014, Bjorn Helgaas wrote:
> [+cc Greg]
> 
> On Mon, Apr 14, 2014 at 11:03:42AM +0200, Sebastian Ott wrote:
> > Hello Bjorn,
> > 
> > for pci on s390 we currently use pcibios_add_platform_entries to add
> > some arch specific attributes to pdevs. This has 2 downsides - it will
> > race with userspace which is triggered by udev events and expecting
> > these attributes (but that's a theoretical issue). More important to
> > me is that one cannot use attribute_groups with this. Both issues could
> > be addressed by using pdev->dev.groups and let the driver core handle
> > attribute creation.
> > 
> > So would it be ok if we set pdev->dev.groups in pcibios_add_device?
> > (It should be since it's not used by pci common code which uses bus_type,
> > dev_type, and class groups).
> 
> Hi Sebastian,
> 
> Sorry, I meant to respond to this earlier, but forgot.  This sounds
> reasonable to me, but Greg can give you a much better answer than I can.
> 
> Documentation/driver-model/device.txt says the dev->groups pointer
> should be set before calling device_register().  PCI calls
> device_initialize() and device_add() instead of using device_register(),
> and pcibios_add_device() looks like it happens at the right time:
> 
>     pci_scan_root_bus
>       pci_scan_child_bus
>         pci_scan_slot
>           pci_scan_single_device
>             pci_device_add
>               device_initialize
>               pcibios_add_device                # <---
>               device_add
>       pci_bus_add_devices
>         pci_bus_add_device
>           pci_create_sysfs_dev_files
>             pcibios_add_platform_entries        # 8d4cd0833107 (benh)
>           device_attach
> 
> I'm not sure why pci_create_sysfs_dev_files() is done later.  It seems
> like that should be done before device_add() as well.  Maybe it's
> because BARs might not be valid yet (that doesn't seem like a very good
> excuse, but it's all I can think of).
> 
> I assume that if you change s390, you'll also change microblaze and
> powerpc?  They look structurally similar to s390.

Yes, that sounds like a plan - this way we can get rid of
pcibios_add_platform_entries altogether. I'll send these patches soon.

Regards,
Sebastian
---1463784958-1842069568-1397498848=:1561--

