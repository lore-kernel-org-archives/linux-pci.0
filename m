Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032103AbdIZVA1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Sep 2017 17:00:27 -0400
Date: Tue, 26 Sep 2017 15:57:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: SR-IOV & virtfn/physfn sysfs links
Message-ID: <20170926205745.GR15970@bhelgaas-glaptop.roam.corp.google.com>
References: <d3328861-2da2-918d-c3db-cc0795ab1586@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d3328861-2da2-918d-c3db-cc0795ab1586@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 18, 2017 at 08:53:45PM -0500, Stuart Hayes wrote:
> Bjorn et al,
> 
> I'm hoping to enhance network device naming in systemd to parse
> sysfs "virtfn%u" and "physfn" links, so it understands virtual
> devices.
> 
> I've noticed that the udev event which triggers the
> systemd/biosdevname network device naming--the udev "add" event for
> the network device, which happens within pci_bus_add_device() when
> the network driver's probe function calls register_netdev()--occurs
> before the sysfs links "physfn" and "virtfn%u" are created.  This
> creates a race when the network naming code tries to look at those
> links (something biosdevname already does).
> 
> Is there any reason why we couldn't switch the order of those calls
> to eliminate the race, as shown in the patch below?  I couldn't
> think of any, since those links apply to the pci subsystem devices
> in sysfs (which are already created), not the net subsystem devices.
> I'd be happy to submit a patch if that looks ok.

Seems plausible.  I think the sequence you're describing is this:

  pci_iov_add_virtfn
    pci_bus_add_device
      pci_create_sysfs_dev_files
      device_attach
        ...
	  register_netdev
	    ...
	      # udev "add" event
    sysfs_create_link("virtfn%u)
    sysfs_create_link("physfn")
    kobject_uevent(KOBJ_CHANGE)

We create most of the sysfs files before attaching the driver, and it
makes sense to me that we should set up the IOV sysfs files as well.

Bjorn

> --- linux-4.14-rc1/drivers/pci/iov.c.orig	2017-09-18 15:00:43.168255665 -0500
> +++ linux-4.14-rc1/drivers/pci/iov.c	2017-09-18 15:07:04.792280999 -0500
> @@ -162,7 +162,6 @@ int pci_iov_add_virtfn(struct pci_dev *d
>  
>  	pci_device_add(virtfn, virtfn->bus);
>  
> -	pci_bus_add_device(virtfn);
>  	sprintf(buf, "virtfn%u", id);
>  	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
>  	if (rc)
> @@ -173,6 +172,8 @@ int pci_iov_add_virtfn(struct pci_dev *d
>  
>  	kobject_uevent(&virtfn->dev.kobj, KOBJ_CHANGE);
>  
> +	pci_bus_add_device(virtfn);
> +
>  	return 0;
>  
>  failed2:
> 
> 
> ---
> This email has been checked for viruses by Avast antivirus software.
> https://www.avast.com/antivirus
> 
