Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:60596 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751958Ab3A2C0W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 28 Jan 2013 21:26:22 -0500
Message-ID: <51072F83.7040102@cn.fujitsu.com>
Date: Tue, 29 Jan 2013 10:10:11 +0800
From: Gu Zheng <guz.fnst@cn.fujitsu.com>
MIME-Version: 1.0
To: Paul Bolle <pebolle@tiscali.nl>
CC: Oliver Neukum <oneukum@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: pciehp: errors on resume
References: <1359377173.1345.25.camel@x61.thuisdomein>
In-Reply-To: <1359377173.1345.25.camel@x61.thuisdomein>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Paul,
	I think cause of the issue you mentioned is the device already exists when we resume.
Because we do not really suspend/remove the device when suspend, the device still exists, so 
we try to add the device when resume will failed. The suspend routine does not match the resume,
it seems a bug here.

On 01/28/2013 08:46 PM, Paul Bolle wrote:

> 0) Since release v3.7 a laptop I use prints these errors at every
> resume:
>     pciehp 0000:00:1c.1:pcie04: Device 0000:03:00.0 already exists at 0000:03:00, cannot hot-add
>     pciehp 0000:00:1c.1:pcie04: Cannot add device at 0000:03:00
> 
> That must have been caused by commit
> 87683e22c646e563061a91f4a0106e6913acebf8 ("PCI: pciehp: Always implement
> resume, regardless of pciehp_force param").
> 
> 1) Those messages appear to be printed for the wireless card that is
> apparently attached to one of this laptop's two pcie ports:
>     lspci | grep -e 00:1c.1 -e 03:00.0
>     00:1c.1 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 2 (rev 03)
>     03:00.0 Network controller: Intel Corporation PRO/Wireless 4965 AG or AGN [Kedron] Network Connection (rev 61)
> 
>     lspci -vt | grep -e 1c.1 -e 03
>            +-1c.1-[03]----00.0  Intel Corporation PRO/Wireless 4965 AG or AGN [Kedron] Network Connection
> 
> 2) There are no apparent issues with this wireless card on all those
> resumes. So could these errors somehow be suppressed? 
> 
> 3) For what it's worth, the callchain that triggers these errors seems
> to be:
>     pciehp_resume()
>         pciehp_enable_slot()
>             board_added()
>                 pciehp_configure_device()
>                     pci_get_slot()
>                     ctrl_err([...] "Device %s already exists " [...])
>                 ctrl_err([...] "Cannot add device at [...]")
> 
> 
> Paul Bolle
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


