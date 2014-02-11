Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PCI <linux-pci@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] ACPI / hotplug / PCI: Work along with PCIe native hotplug
Date: Tue, 11 Feb 2014 01:17:13 +0100
Message-ID: <1461050.jQppMgDSvA@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

Patch [2/2] in this series makes ACPIPHP add its hotplug contexts to devices
that should be handler by PCIeHP (the changelog explains why that should be
safe now).  Patch [1/2] is just a function rename.

Both are on top of the current linux-next branch of linux-pm.git.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
