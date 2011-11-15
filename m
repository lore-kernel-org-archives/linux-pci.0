Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:40288 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757046Ab1KOUPi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2011 15:15:38 -0500
Date: Tue, 15 Nov 2011 13:15:36 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Prarit Bhargava <prarit@redhat.com>
Cc: Don Dutile <ddutile@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	James Paradis <jparadis@redhat.com>, linux-pci@vger.kernel.org,
	mstowe@redhat.com, jbarnes@virtuousgeek.org
Subject: Re: [PATCH] pci: Workaround Stratus broken PCIE hierarchy
Message-ID: <20111115201536.GF4387@parisc-linux.org>
References: <bd3514f0-1a80-45ac-a08e-b327a367b276@zmail15.collab.prod.int.phx2.redhat.com> <4EBD73C8.8070407@redhat.com> <CAErSpo5eZ=4yqnMFpFjTOqGvK6p4mOmsppJbodeGe+vkjfKdbw@mail.gmail.com> <4EBD8714.30401@redhat.com> <4EC12962.2040105@redhat.com> <20111114181418.GE4387@parisc-linux.org> <4EC28B93.1060101@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EC28B93.1060101@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 15, 2011 at 10:56:03AM -0500, Prarit Bhargava wrote:
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 04e74f4..fc88a9b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1270,13 +1270,18 @@ static unsigned no_next_fn(struct pci_dev *dev, unsigned fn)
>  	return 0;
>  }
>  
> +int pcie_scan_all = 0; /* set via pci=pcie_scan_all */
>  static int only_one_child(struct pci_bus *bus)
>  {
>  	struct pci_dev *parent = bus->self;
> +	if (pcie_scan_all)
> +		return 0;
>  	if (!parent || !pci_is_pcie(parent))
>  		return 0;
> -	if (parent->pcie_type == PCI_EXP_TYPE_ROOT_PORT ||
> -	    parent->pcie_type == PCI_EXP_TYPE_DOWNSTREAM)
> +	if (parent->pcie_type == PCI_EXP_TYPE_ROOT_PORT)
> +		return 1;
> +	if (parent->pcie_type == PCI_EXP_TYPE_DOWNSTREAM &&
> +	    !is_broken_pcie_port())
>  		return 1;
>  	return 0;
>  }
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7285145..ef4d0e7 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3092,3 +3092,21 @@ int pci_dev_specific_reset(struct pci_dev *dev, int probe)
>  
>  	return -ENOTTY;
>  }
> +
> +static int _is_broken_pcie_port = -1;
> +int is_broken_pcie_port(void)
> +{
> +	if (_is_broken_pcie_port >= 0)
> +		return _is_broken_pcie_port;
> +	/*
> +	 * Stratus/NEC ftServer systems have a broken PCIE hierarchy in which
> +	 * one upstream and one downstream port are plugged into a downstream
> +	 * port.  Avoiding the downstream port check in only_one_child() results
> +	 * in a functional system.
> +	 */
> +	if (dmi_name_in_vendors("ftServer"))
> +		_is_broken_pcie_port = 1;
> +	else
> +		_is_broken_pcie_port = 0;
> +	return _is_broken_pcie_port;
> +}

This feels like belt-and-braces.  Why don't you just set pcie_scan_all
if the DMI string contains ftServer?

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
