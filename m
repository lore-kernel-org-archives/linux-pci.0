Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36364 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791AbcHOSvQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 15 Aug 2016 14:51:16 -0400
Date: Mon, 15 Aug 2016 13:51:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Yong, Jonathan" <jonathan.yong@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] PCI: Precision Time Measurement support
Message-ID: <20160815185111.GC9790@localhost>
References: <20160613185945.12503.32760.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160719211926.GB17840@localhost>
 <578EBC81.3090601@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <578EBC81.3090601@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 20, 2016 at 07:49:21AM +0800, Yong, Jonathan wrote:
> On 07/20/2016 05:19, Bjorn Helgaas wrote:
> > On Mon, Jun 13, 2016 at 02:05:26PM -0500, Bjorn Helgaas wrote:
> >> This is a slightly different proposal for the PTM support Jonathan
> >> proposed here:
> >>
> >>   http://lkml.kernel.org/r/1462956446-27361-2-git-send-email-jonathan.yong@intel.com
> >>
> >> I split this into three pieces mostly for ease in reviewing.  They
> >> could all be squashed:
> >>
> >>   - Enable PTM in root ports and switches automatically at boot
> >>   - Enable PTM in endpoints when requested by driver
> >>   - Add clock granularity information
> >>
> >> I have some open questions about how PTM works on Root Complex
> >> Integrated Endpoints and whether we should enable it automatically
> >> even without a driver request.  And I probably left out some details
> >> of the clock granularity computation, so treat this as more of an RFC
> >> than anything.
> >>
> > 
> > Jonathan, any comments?
> > 
> 
> I don't have any new information on how to configure integrated endpoints.
> 
> This line:
> ctrl = PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT;
> 
> should also set the responder capable bit (7.32.2):
> 	If PTM Root Capable is Set, this bit must be Set to 1b.

The PTM Responder Capable bit (bit 1 in Table 7-145) is a HwInit bit
in the PTM Capability register, so it's read-only from the kernel's
perspective.

The line you mention ("ctrl = PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT")
is turning on bits in the PTM Control register, not the Capability
register.

Bjorn
