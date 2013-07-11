Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 11 Jul 2013 08:11:44 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/8] PCI: acpiphp: enable_device(): rescan even if no
 new devices on slot
Message-ID: <20130711051144.GF4898@intel.com>
References: <1372860295-8306-1-git-send-email-mika.westerberg@linux.intel.com>
 <1372860295-8306-4-git-send-email-mika.westerberg@linux.intel.com>
 <1827270.u1sYdQ8l8y@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1827270.u1sYdQ8l8y@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 11, 2013 at 02:25:42AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, July 03, 2013 05:04:50 PM Mika Westerberg wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
> > pci_scan_slot() returns number of new devices connected *directly*
> > connected to the slot. Current enable_device() checks the return value
> > and stops if it doesn't see a new device.
> > 
> > In Thunderbolt chaining case the new device can be deeper in hierarchy, so
> > do the rescan anyway.
> > 
> > Because of that we must make sure that pcibios_resource_survey_bus() and
> > check_hotplug_bridge() get called only for a just found bus and not the
> > ones already added to the system. Failure to do so will lead to resource
> > conflicts.
> 
> Well, I wonder what we're doing to this end, because there's nothing in that
> area in the patch?

We forgot to update the changelog of this patch. The last paragraph should
not be there.
