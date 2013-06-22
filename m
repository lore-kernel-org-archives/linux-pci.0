Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J . Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"Alexander E . Patrakov" <patrakov@gmail.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <liuj97@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ACPI / dock / PCI: Fix problems with dock and PCI hotplug
Date: Sat, 22 Jun 2013 23:19:52 +0200
Message-ID: <2737587.I0nULev1kj@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

Unfortunately, the Alexander's docking station for Sony VAIO VPCZ23A4R is
basically unusable with v3.10-rc6 and, as it turns out, there are multiple
problems with it.

First, the acpiphp initialization ordering has changed recently,
acpiphp_enumerate_slots() is now always run for the first time during the
initial ACPI namespace scan in acpi_scan_init() which has broken support
for PCI devices on ACPI-based docking stations, because the ACPI dock
subsystem has to be initialized *before* acpiphp_enumerate_slots() is first
run.

Fix that, and it turns out that undocking actually doesn't work correctly
because of some synchronization problems between the dock driver, acpiphp
and the PCI core.  [That part was actually the most difficult to fix.]

Fix that, and you'll find that PCI resources are not allocated correctly
after undocking and re-docking (when initially docked).

The three patches in this series make the Alexander's docking station kind
of usable, so if no one has objections, I'd like to put them on a fast track
to Linus.

[1/3] Initialize ACPI dock subsystem before enumerating the PCI hierarchy
      (that also makes the dock driver non-modular).

[2/3] Make acpiphp use the same rules for allocating PCI resources that are
      used at boot time.

[3/3] Make acpiphp handle dock events synchronously (instead of spawning
      separate work items to handle them).  [The changelog of this patch
      is likely one of the longest I've ever written and it sort of looks
      like a crime story.]

This series is mostly based on the work of Jiang Liu (thanks Gerry!) and
the Alexander's testing that we wouldn't have done much progress without
(thanks Alexander!).

Alexander, I've modified patch [3/3] a bit since you have tested it.
The modifications shouldn't affect the behavior, but if you could re-test it,
that would be great.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
