Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Hilman <khilman@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/4] PM: Use CONFIG_PM instead of CONFIG_PM_RUNTIME in core code
Date: Thu, 27 Nov 2014 01:37:13 +0100
Message-ID: <37310416.jZXoh5nfSC@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

After commit b2b49ccbdd54 "PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
selected" (currently in Linux next) CONFIG_PM_RUNTIME is set whenever
CONFIG_PM is set, so CONFIG_PM can be used in #ifdefs instead of
CONFIG_PM_RUNTIME which simplifies things in quite a few cases.

For this reason, the following patches modify some core code to use
CONFIG_PM instead of CONFIG_PM_RUNTIME.

[1/4] Drop a macro which is redundant after the above commit.
[2/4] Use PM instead of PM_RUNTIME in the core device PM code.
[3/4] Use PM instead of PM_RUNTIME in the ACPI core.
[4/4] Use PM instead of PM_RUNTIME in the PCI core.

They build for me for all of the relevant combinations of options (on x86),
but more testing (on the other architectures) would be welcome.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
