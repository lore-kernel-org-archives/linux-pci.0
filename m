Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7792 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018AbcAOTai (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Jan 2016 14:30:38 -0500
Date: Fri, 15 Jan 2016 11:31:03 -0800
From: "Veal, Bryan E." <bryan.e.veal@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv8 0/5] Driver for new "VMD" device
Message-ID: <20160115193103.GA2249@intel.com>
Reply-To: bryan.e.veal@intel.com
References: <1452629890-17542-1-git-send-email-keith.busch@intel.com>
 <20160115181938.GA5296@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160115181938.GA5296@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 15, 2016 at 12:19:38PM -0600, Bjorn Helgaas wrote:
> I also have a more substantive question about the flags setup.  I
> think you should not clear IORESOURCE_MEM_64.  The intent of
> IORESOURCE_MEM_64 is to describe the *capability* of a BAR, not its
> contents.  But I assume you cleared it for a reason.  vmd->resources[n]
> are not BARs, so the PCI core won't assign resources to them like it
> does for BAR, so we shouldn't care about IORESOURCE_MEM_64 for that
> reason.  Is there some other reason IORESOURCE_MEM_64 makes a
> difference there?

Hi Bjorn & Keith:
  
I did this to fix an issue in pre-RFC code.

The flag is subtly restrictive in one specific scenario: spec-compliant
PCIe ports lack the ability to specify a 64-bit, non-prefetchable range.
IORESOURCE_MEM_64 directs the PCI subsystem to put the address into the
64-bit *prefetchable* range. Below the port, the "prefetchable" propoerty
*is* restrictive: the addresses can't be used for non-prefetchable BARs.

Thus, in the specific case where a 64-bit non-prefetchable VMD bar happens
to contain a 32-bit address, removing the IORESOURCE_MEM_64 flag allows
the address resource to be used for *any* non-prefetchable BARs (32-bit or
64-bit) downstream.  
