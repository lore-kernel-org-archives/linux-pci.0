Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>, stable@kernel.org,
	Len Brown <lenb@kernel.org>, Adam Belay <abelay@mit.edu>,
	linux-acpi@vger.kernel.org
Subject: [PATCH -v3 02/47] PNPACPI: Fix device ref leaking in acpi_pnp_match
Date: Sun, 18 Mar 2012 22:45:51 -0700
Message-Id: <1332135996-13860-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1332135996-13860-1-git-send-email-yinghai@kernel.org>
References: <1332135996-13860-1-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

During testing pci root bus removal, found some root bus bridge is not freed.

If booting with pnpacpi=off, those hostbridge could be freed without problem.

It turns out that some devices reference are not released during acpi_pnp_match.

That match should not hold one device ref during every calling.

Add put_device calling before returning.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: stable@kernel.org
Cc: Len Brown <lenb@kernel.org>
Cc: Adam Belay <abelay@mit.edu>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org
---
 drivers/pnp/pnpacpi/core.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index b00c176..d21e8f5 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -321,9 +321,14 @@ static int __init acpi_pnp_match(struct device *dev, void *_pnp)
 {
 	struct acpi_device *acpi = to_acpi_device(dev);
 	struct pnp_dev *pnp = _pnp;
+	struct device *physical_device;
+
+	physical_device = acpi_get_physical_device(acpi->handle);
+	if (physical_device)
+		put_device(physical_device);
 
 	/* true means it matched */
-	return !acpi_get_physical_device(acpi->handle)
+	return !physical_device
 	    && compare_pnp_id(pnp->id, acpi_device_hid(acpi));
 }
 
-- 
1.7.7

