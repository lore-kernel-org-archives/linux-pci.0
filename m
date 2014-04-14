Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11284 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753583AbaDNQQf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Apr 2014 12:16:35 -0400
Date: Mon, 14 Apr 2014 18:18:23 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 RESEND 2/4] portdrv: Use pci_enable_msix_exact()
 instead of pci_enable_msix()
Message-ID: <20140414161822.GA11804@dhcp-26-207.brq.redhat.com>
References: <cover.1394128952.git.agordeev@redhat.com>
 <b1f560f01a176784ebfff28b84574d2850413729.1394128952.git.agordeev@redhat.com>
 <20140313035634.GA26657@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140313035634.GA26657@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 12, 2014 at 09:56:34PM -0600, Bjorn Helgaas wrote:
> On Thu, Mar 06, 2014 at 09:11:22PM +0100, Alexander Gordeev wrote:
> > As result of deprecation of MSI-X/MSI enablement functions
> > pci_enable_msix() and pci_enable_msi_block() all drivers
> > using these two interfaces need to be updated to use the
> > new pci_enable_msi_range()  or pci_enable_msi_exact()
> > and pci_enable_msix_range() or pci_enable_msix_exact()
> > interfaces.
> > 
> > Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linux-pci@vger.kernel.org
> 
> Applied to pci/msi for v3.15, thanks!

Hi Bjorn,

If this one indeed applied?

Thanks!

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
