Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	ddutile@redhat.com, linux-kernel@vger.kernel.org, lenb@kernel.org
Subject: Re: [PATCH v2 0/2] ACPI / PCI: Fix _PRT lookup for ARI enabled devices
Date: Sat, 30 May 2015 01:53:30 +0200
Message-ID: <3075635.JhZ4D0jF4G@vostro.rjw.lan>
In-Reply-To: <20150529221848.GD12733@google.com>
References: <20150526210927.7537.55656.stgit@gimli.home> <20150529221848.GD12733@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, May 29, 2015 05:18:48 PM Bjorn Helgaas wrote:
> On Tue, May 26, 2015 at 03:11:38PM -0600, Alex Williamson wrote:
> > v2: don't modify entry->id.device
> > 
> > In most cases we only use ARI with SR-IOV VFs, which do not support
> > INTx and therefore never hit this problem.  However, some non-SR-IOV
> > implementations create multiple PFs, extending beyond the standard
> > 3-bit function numbers with ARI, and do support INTx for those
> > additional functions.  This can happen with Solarflare SFC9120
> > adapters.  The host driver typically doesn't use INTx, so we also
> > haven't noticed this problem on bare metal, but when we attempt to
> > assign the device to a VM using vfio-pci, we fail trying to setup
> > default INTx signaling.  Thanks,
> > 
> > Alex
> > 
> > ---
> > 
> > Alex Williamson (2):
> >       PCI: Move pci_ari_enabled() to global header
> >       ACPI / PCI: Account for ARI in _PRT lookups
> 
> Rafael, do you want this or should I take it?
> 
> I put it on my pci/virtualization branch for v4.2.

That's fine.  Please feel free to add my ACKs to those if that helps.

Rafael

