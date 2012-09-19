Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, x86 <x86@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 27/40] ACPI: acpi_bus_trim to support two steps.
Date: Wed, 19 Sep 2012 11:54:41 -0700
Message-Id: <1348080894-23412-28-git-send-email-yinghai@kernel.org>
In-Reply-To: <1348080894-23412-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQWFcVNKMnV1qaHchwCXfZuMpyxf_f7GQy3FZid9YuLD3w@mail.gmail.com>
 <1348080894-23412-1-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

current all acpi_bus_trim callers have rmdevice to 1.
that means it will remove all acpi devices.

When 0, is passed, it will keep one parent.

For root bus hotremove support, we need to have pci device removed before
acpi devices.

So try to keep all acpi devices, and only stop drivers with them.

This change should be safe because all current callers all have 1 passed.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/scan.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index d1ecca2..d1a1f25 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1539,10 +1539,7 @@ int acpi_bus_trim(struct acpi_device *start, int rmdevice)
 			child = parent;
 			parent = parent->parent;
 
-			if (level == 0)
-				err = acpi_bus_remove(child, rmdevice);
-			else
-				err = acpi_bus_remove(child, 1);
+			err = acpi_bus_remove(child, rmdevice);
 
 			continue;
 		}
-- 
1.7.7

