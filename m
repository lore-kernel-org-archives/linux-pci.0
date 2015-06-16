Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 0/2] x86/PCI: enable pci=use_crs for more machines
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Takashi Iwai <tiwai@suse.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	dayer3@gmail.com, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yinghai Lu <yinghai@kernel.org>
Date: Tue, 16 Jun 2015 11:55:36 -0500
Message-ID: <20150616165033.9306.78046.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We have a few reports of sound devices not working because the BIOS didn't
assign space for the device and the PCI core put it at an address that
doesn't work.

The Foxconn system has two PCI host bridges, and without the information
from _CRS, the PCI core assigns space under the wrong bridge.

We also have reports from pre-2008 systems (where we normally ignore _CRS)
that support more than 32 physical address bits.  After d56dbf5bab8c ("PCI:
Allocate 64-bit BARs above 4G when possible"), we prefer to use that high
space when we can, but it seems the host bridge doesn't respond to it.

_CRS tells us how to avoid both problems, so these patches enable it for
these cases.

---

Bjorn Helgaas (2):
      x86/PCI: Use host bridge _CRS info on Foxconn K8M890-8237A
      x86/PCI: Use host bridge _CRS info on systems with >32 bit addressing


 arch/x86/pci/acpi.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)
