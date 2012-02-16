Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 16 Feb 2012 17:04:22 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org
Subject: shpc with acpi=off?
Message-ID: <20120216150421.GA26167@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I have a box where shpc works fine with acpi,
as well as when acpi is not built into kernel,
but fails with acpi=off
Some debugging seems to indicate that
acpi_get_hp_hw_control_from_firmware
fails with acpi=off.

Is this a bug or is there a reason to prevent shpc
from working in this setup?
Do we even care about acpi=off?
Assuming we want to make acpi_get_hp_hw_control_from_firmware
succeed with acpi=off, what is the best way to do this?
Check acpi_pci_disabled?

Thoughts?
-- 
MST
