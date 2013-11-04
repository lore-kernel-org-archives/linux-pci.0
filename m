Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toshi Kani <toshi.kani@hp.com>, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 0/3] ACPI scan and hotplug fixes for 3.14
Date: Mon, 04 Nov 2013 01:17:12 +0100
Message-ID: <5839747.7HXXGHmMBd@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

The following three patches fix some issues that we have in the common ACPI
hotplug infrastructure.

If anyone sees any problems with them, please let me know.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
