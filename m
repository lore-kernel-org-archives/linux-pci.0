Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751492AbeCNRMH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Mar 2018 13:12:07 -0400
Date: Wed, 14 Mar 2018 12:12:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-pci@vger.kernel.org, Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        David Howells <dhowells@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-am33-list@redhat.com
Subject: Re: [PATCH] PCI/MSI: Don't set up INTx if MSI or MSI-X is enabled
Message-ID: <20180314171202.GA179719@bhelgaas-glaptop.roam.corp.google.com>
References: <152097754955.241946.9551793957889760940.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180314083519.GA24043@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180314083519.GA24043@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 14, 2018 at 01:35:19AM -0700, Christoph Hellwig wrote:
> Should this logic go into a little helper so that everyone is kept
> in sync?

Great point, thanks!  What I'd really like is to completely get rid of
most of the pcibios_enable_device() implementations.  Most of them
contain nothing that's arch-specific.

I'll look at that some more, but will probably do that as additional
steps on top of this one.  That way this patch stays mostly trivial
and obvious as a generalization of 16cf0ebc35dd ("x86/PCI: Do not use
interrupt links for devices using MSI-X") to other affected arches.

Bjorn
