Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:63539 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207AbaDNRfr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Apr 2014 13:35:47 -0400
Received: by mail-ig0-f171.google.com with SMTP id c1so3642644igq.16
        for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2014 10:35:47 -0700 (PDT)
Date: Mon, 14 Apr 2014 11:35:41 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [Resend] pcibios_add_platform_entries usage
Message-ID: <20140414173541.GA4417@google.com>
References: <alpine.LFD.2.11.1403281931410.1516@denkbrett>
 <alpine.LFD.2.11.1404141101500.1529@denkbrett>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <alpine.LFD.2.11.1404141101500.1529@denkbrett>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Greg]

On Mon, Apr 14, 2014 at 11:03:42AM +0200, Sebastian Ott wrote:
> Hello Bjorn,
> 
> for pci on s390 we currently use pcibios_add_platform_entries to add
> some arch specific attributes to pdevs. This has 2 downsides - it will
> race with userspace which is triggered by udev events and expecting
> these attributes (but that's a theoretical issue). More important to
> me is that one cannot use attribute_groups with this. Both issues could
> be addressed by using pdev->dev.groups and let the driver core handle
> attribute creation.
> 
> So would it be ok if we set pdev->dev.groups in pcibios_add_device?
> (It should be since it's not used by pci common code which uses bus_type,
> dev_type, and class groups).

Hi Sebastian,

Sorry, I meant to respond to this earlier, but forgot.  This sounds
reasonable to me, but Greg can give you a much better answer than I can.

Documentation/driver-model/device.txt says the dev->groups pointer
should be set before calling device_register().  PCI calls
device_initialize() and device_add() instead of using device_register(),
and pcibios_add_device() looks like it happens at the right time:

    pci_scan_root_bus
      pci_scan_child_bus
        pci_scan_slot
          pci_scan_single_device
            pci_device_add
              device_initialize
              pcibios_add_device                # <---
              device_add
      pci_bus_add_devices
        pci_bus_add_device
          pci_create_sysfs_dev_files
            pcibios_add_platform_entries        # 8d4cd0833107 (benh)
          device_attach

I'm not sure why pci_create_sysfs_dev_files() is done later.  It seems
like that should be done before device_add() as well.  Maybe it's
because BARs might not be valid yet (that doesn't seem like a very good
excuse, but it's all I can think of).

I assume that if you change s390, you'll also change microblaze and
powerpc?  They look structurally similar to s390.

Bjorn
