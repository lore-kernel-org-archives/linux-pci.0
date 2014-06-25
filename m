Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [Patch V3 03/16] ACPI: Correct return value of acpi_dev_resource_address_space()
Date: Wed, 25 Jun 2014 16:40:34 +0800
Message-Id: <1403685648-10103-4-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1403685648-10103-1-git-send-email-jiang.liu@linux.intel.com>
References: <1403685648-10103-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Change acpi_dev_resource_address_space() to return failure if the
acpi_resource structure can't be converted to an ACPI address64 structure.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/resource.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 0bdacc5e26a3..33bb71cbe72a 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -200,7 +200,7 @@ bool acpi_dev_resource_address_space(struct acpi_resource *ares,
 
 	status = acpi_resource_to_address64(ares, &addr);
 	if (ACPI_FAILURE(status))
-		return true;
+		return false;
 
 	res->start = addr.minimum;
 	res->end = addr.maximum;
-- 
1.7.10.4

