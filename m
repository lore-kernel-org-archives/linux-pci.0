Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Prarit Bhargava <prarit@redhat.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/2] ACPI: return error in acpi_pci_irq_enable when there is no irq
Date: Sat, 14 Sep 2013 01:43:51 +0200
Message-ID: <2086253.mJBe8Nv4qL@vostro.rjw.lan>
In-Reply-To: <52330A82.7050607@redhat.com>
References: <1375965314-24232-1-git-send-email-heikki.krogerus@linux.intel.com> <52330A82.7050607@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, September 13, 2013 08:52:18 AM Prarit Bhargava wrote:
> 
> On 08/08/2013 08:35 AM, Heikki Krogerus wrote:
> > Hi,
> > 
> > This is the fix for the Dell PowerEdge 840 issue where nothing
> > allocated an irq for it's PCH if I understood correctly. The issue was
> > reported by Prarit Bhargava.
> > 
> > The second patch is just a minor cleanup.
> > 
> > Thanks,
> > 
> > 
> > Heikki Krogerus (2):
> >   ACPI / PCI: don't allow PCI devices without irq to be enabled
> >   ACPI / PCI: remove an extra check from acpi_pci_irq_enable()
> > 
> 
> Rafael, is this in your queue?

No, it is not, because Bjorn wanted to debug this issue deeper as far as I
could understand.

Bjorn?

