Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 4 Aug 2014 20:59:23 +0200
From: Quentin Lambert <lambert.quentin@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Murray <scott@spiteful.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Fixing checkpatch errors and warnings for PCI hotplug
Message-ID: <20140804185923.GA4185@greed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Patch 1 and 2 fix checkpatch coding style warnings.

Patch 3 fixes chechpatch errors due to assignement
in if conditions.


Quentin Lambert (3):
  PCI hotplug: fix a missing space coding style issue
  PCI hotplug: fix a simple if coding style issue
  PCI hotplug: remove assignement from if conditions

 drivers/pci/hotplug/acpi_pcihp.c    |  3 ++-
 drivers/pci/hotplug/cpcihp_zt5550.c | 42 ++++++++++++++++++-------------------
 2 files changed, 23 insertions(+), 22 deletions(-)

-- 
1.9.1

