Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:44768 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934935Ab1KJObF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2011 09:31:05 -0500
Date: Thu, 10 Nov 2011 07:31:02 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pci@vger.kernel.org, mstowe@redhat.com, ddutile@redhat.com,
	jparadis@redhat.com, matthew.wilcox@linux.intel.com,
	jbarnes@virtuousgeek.org
Subject: Re: [PATCH] pci: Workaround Stratus broken PCIE hierarchy
Message-ID: <20111110143102.GP22937@parisc-linux.org>
References: <1320933613-25909-1-git-send-email-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320933613-25909-1-git-send-email-prarit@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 10, 2011 at 09:00:13AM -0500, Prarit Bhargava wrote:
> Stratus systems have a hierarchy that includes a PCIE Downstream bridge
> connected to a PCIE Upstream bridge and a PCI Downstream bridge.  The system
> boots with this wrong hierarchy into a crippled mode (USB doesn't work,
> network doesn't work ...).  Avoiding the Downstream bridge check in
> only_one_child() causes all the bridges to be enumerated and the system
> to function properly.

> @@ -1275,7 +1276,15 @@ static int only_one_child(struct pci_bus *bus)
>  	struct pci_dev *parent = bus->self;
>  	if (!parent || !pci_is_pcie(parent))
>  		return 0;
> -	if (parent->pcie_type == PCI_EXP_TYPE_ROOT_PORT ||
> +	if (parent->pcie_type == PCI_EXP_TYPE_ROOT_PORT)
> +		return 1;
> +	/*
> +	 * Stratus/NEC ftServer systems have a broken PCIE hierarchy in which
> +	 * one upstream and one downstream port are plugged into a downstream
> +	 * port.  Avoiding the downstream port check here results in a
> +	 * functional system.
> +	 */
> +	if (!dmi_name_in_vendors("ftServer") &&
>  	    parent->pcie_type == PCI_EXP_TYPE_DOWNSTREAM)
>  		return 1;
>  	return 0;

dmi_name_in_vendors is relatively expensive, so the order of these two
should be swapped, at least:

> 	if (parent->pcie_type == PCI_EXP_TYPE_DOWNSTREAM &&
>  	    !dmi_name_in_vendors("ftServer"))

Plus, this gets called for every PCI bridge.  We should be caching it
somewhere, so it's only called once.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
