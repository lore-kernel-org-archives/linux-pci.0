Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:57226 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637Ab2D1T0C (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 28 Apr 2012 15:26:02 -0400
Date: Sat, 28 Apr 2012 13:26:00 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Matthew Wilcox <matthew.wilcox@linux.intel.com>,
	Don Dutile <ddutile@redhat.com>,
	Myron Stowe <mstowe@redhat.com>,
	James Paradis <jim.paradis@stratus.com>
Subject: Re: [PATCH v1] PCI: work around Stratus ftServer broken PCIe
	hierarchy
Message-ID: <20120428192559.GB28349@parisc-linux.org>
References: <20120425233632.12292.32916.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120425233632.12292.32916.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 25, 2012 at 05:36:32PM -0600, Bjorn Helgaas wrote:
> @@ -2161,6 +2161,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  				on: Turn realloc on
>  		realloc		same as realloc=on
>  		noari		do not use PCIe ARI.
> +		pcie_scan_all	Scan all possible PCIE devices.  Otherwise we
> +				only look for one device below a PCIE downstream
> +				port.

We should probably s/device/slot/ throughout.  I've recently become
aware of a hype-rvisor that doesn't include PCI device number remapping,
so if you assign, say, function 03.6 to a guest, the PCI scanning code
doesn't find it.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
