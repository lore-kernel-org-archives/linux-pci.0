Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55883 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752437AbeDLRJ3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Apr 2018 13:09:29 -0400
Date: Thu, 12 Apr 2018 11:10:26 -0600
From: Keith Busch <keith.busch@intel.com>
To: Alex_Gagniuc@Dellteam.com
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        scott.bauer@intel.com
Subject: Re: [PATCH 0/4] PCI/AER: Use-after-free fix
Message-ID: <20180412171025.GB6424@localhost.localdomain>
References: <20180409220444.6632-1-keith.busch@intel.com>
 <a97b5921e5cf4855b5e76110a7984fdf@ausx13mps321.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a97b5921e5cf4855b5e76110a7984fdf@ausx13mps321.AMER.DELL.COM>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 12, 2018 at 05:06:05PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> From: Keith Busch [mailto:keith.busch@intel.com] 
> 
> > AER error handling walks the PCI topology below a root port, saving
> > pointers of the pci_dev structs affected by the error along the way.
> 
> Hi Keith,
> 
> I've been trying to do an ABA test to confirm that your change
> eliminates the use-after-free issue we've seen. The race seems to be
> quite elusive, so I can't reliably reproduce it. Your changes have not
> been forgotten; I have them staged for further testing.
> 
> Alex

No worries. This is essentially just a "safe" version of the patch that
you had tested, so if that one was successful, this one should be too.
