Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [RFC][PATCH 0/8] ACPI / hotplug / PCI: Consolidation of handling notifications (in progress)
Date: Tue, 09 Jul 2013 02:01:55 +0200
Message-ID: <26431283.HJCKsss0rt@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Following is the current set of acpiphp updates targeted at the consolidation
of device notifications handling and removal of suprefluous infrastructure.
Still on top of 3.10 with ACPI+PM 3.11 material merged on top (I'll rebase it
on top of linux-pm.git/bleeding-edge eventually).

[1/8] Make bus registration and unregistration symmetric.  [Resend]
[2/8] Consolidate acpiphp_enumerate_slots().  [Resend]
[3/8] Fix error code path in register_slot().  [Resend]
[4/8] Introduce hotplug context objects for ACPI device objects corresponding
      to PCI hotplug devices.  [Update]
[5/8] Unified notify handler for hotplug events.  [Resend]
[6/8] Drop acpiphp_handle_to_bridge() and use context objects instead of it.
[7/8] Pass entire hotplug context objects (instead of their fields
      individually) to event handling work functions.
[8/8] Merge hotplug event handling functions.

Comments welcome.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

