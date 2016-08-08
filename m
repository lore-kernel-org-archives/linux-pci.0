Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 8 Aug 2016 15:22:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rui Wang <rui.y.wang@intel.com>
Cc: tglx@linutronix.de, rjw@rjwysocki.net, tony.luck@intel.com,
	bhelgaas@google.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 1/3] x86/ioapic: Support hot-removal of IOAPICs
 present during boot
Message-ID: <20160808202251.GB6129@localhost>
References: <20160623173445.GF17987@localhost>
 <1466912697-3498-1-git-send-email-rui.y.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466912697-3498-1-git-send-email-rui.y.wang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jun 26, 2016 at 11:44:57AM +0800, Rui Wang wrote:
> v5: Remove #ifdef CONFIG_X86 from setup-bus.c, making it neutral to archs.
> v4: Add comments explaining when to call acpi_ioapic_add().
> v3: Previous versions break mips. This version fixes it.
> 
> IOAPICs present during system boot aren't added to ioapic_list,
> thus are unable to be hot-removed. Fix it by calling
> acpi_ioapic_add() during root bus enumeration.
> 
> Signed-off-by: Rui Wang <rui.y.wang@intel.com>

Hi Rui,

Where are we at with this?  If there's anything that still needs to be
merged, can you rebase it to v4.8-rc1 and post a new, complete,
series?

Bjorn
