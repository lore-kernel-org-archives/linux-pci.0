Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933423AbcKNVDW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Nov 2016 16:03:22 -0500
Date: Mon, 14 Nov 2016 15:03:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] PCI: Balance ports to avoid ACS errata on Pericom
 switches
Message-ID: <20161114210319.GC9868@bhelgaas-glaptop.roam.corp.google.com>
References: <20161026175156.23495.12980.stgit@gimli.home>
 <20161026180140.23495.27388.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161026180140.23495.27388.stgit@gimli.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 26, 2016 at 12:01:40PM -0600, Alex Williamson wrote:
> As described in the included code comment, this quirk is intended to
> work around an errata in a variety of Pericom 4-lane, 3 and 4 port
> PCIe 2.0 switches.  The switches advertise ACS capabilities, but the
> P2P Request Redirection support includes an errata that PCI_ACS_RR
> effectively doesn't work and results in transactions being queued and
> not delivered within the PCIe switch.  The errata has no planned
> hardware fix.

Is there a published erratum we can reference here?  It'd be really
nice to have a URL.
