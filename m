Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20120210023702.10311.31450.stgit@bhelgaas.mtv.corp.google.com>
References: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com> <20120210023702.10311.31450.stgit@bhelgaas.mtv.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 9 Feb 2012 18:46:39 -0800
Message-ID: <CAErSpo7SY+ShKF_gOeV13Z8YH4je_EkW5CvGFcMdz_-wRKy4VA@mail.gmail.com>
Subject: Re: [PATCH v2 08/18] ia64/PCI: SN: convert to pci_scan_root_bus() for
 correct root bus resources
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	Jack Steiner <steiner@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 9, 2012 at 6:37 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Convert from pci_scan_bus() to pci_scan_root_bus().  Supply the root
> bus resources from bussoft.  When we move the resource adjustment from
> pcibios_fixup_resources() to the PCI core, it will be important to have
> the root bus resources correct from the beginning.

Hi Jack, this ia64 box has some of the more complicated PCI code, and
of course, I have no way to test it.  If I understand correctly, these
boxes don't have ACPI.  If any of these still exist and if you're
interested in testing this series on them, I'd be happy to help
resolve any issues.

Bjorn
