Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:36833 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933246Ab3E1H7V (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2013 03:59:21 -0400
Message-ID: <51A463D2.7000400@huawei.com>
Date: Tue, 28 May 2013 15:59:14 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Stefan Frings <stefan@stefanfrings.de>
CC: <linux-pci@vger.kernel.org>, <1178131@bugs.launchpad.net>
Subject: Re: 14e4:16bc SD card slot not working on Acer Aspire One 756
References: <da540280c592e7bbe5ab96cbe5e47ddc-EhVcX11DRwJZRxoEDQMJVjBXdh9XVlpBXkJHHFtcNkhYS1oKWUF0BUtdMl5cR0wFXlJcQVw=-webmailer2@server03.webmailer.hosteurope.de>
In-Reply-To: <da540280c592e7bbe5ab96cbe5e47ddc-EhVcX11DRwJZRxoEDQMJVjBXdh9XVlpBXkJHHFtcNkhYS1oKWUF0BUtdMl5cR0wFXlJcQVw=-webmailer2@server03.webmailer.hosteurope.de>
Content-Type: multipart/mixed;
	boundary="------------090708050904040607070806"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--------------090708050904040607070806
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

According to boot dmesg.
We found "ACPI FADT declares the system doesn't support PCIe ASPM, so disable it", so FADT dictate no aspm support in this platform.
Matthew pcie_clear_aspm() to acpi_pci_root_add() when acpi_pci_osc_control_set() return success.
Unfortunately in your machine, acpi_pci_osc_control_set() return failed, so system missing the pcie_clear_aspm();
So we should move pci_clear_aspm() out of ACPI_SUCCESS() check.

Stefan, can you help test the attached patch in 3.10-rcx?

Thanks!
Yijing.

On 2013/5/28 13:21, Stefan Frings wrote:
> 14e4:16bc SD card slot not working on Acer Aspire One 756
> 
> The memory card read (Broadcaom BCM57765) does not work on Aver Aspire One 756 because Linux enabled ASPM L1 on the PCIe channel since a related change in Kernel 3.0.20. Please change the code so that only APSN L0s is enabled on that machine on the PCIe channel 00:1c.2.
> 
> Until a solution is available, I use the following command as a workaround: sudo setpci -s 00:1c.2 0x50.B=0x41
> 
> Description of the change that introduced the problem: https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/?id=6cac12dfab9c57a4f76821412224b226a9b08dff
> 
> The full problem description with log files and result of my bisecting can be found in the Ubuntu Bug L#1178131.
> 
> Link to the Ubuntu Bug report: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1178131
> 
> The problem is still present in Kernel 3.10-rc1, rc2 and rc3.
> Kernels before 3.0.20 are NOT affected by the problem.
> The first problematic Linux version is 3.0.20.
> 
> Steps to reproduce:
> 
> - Boot Linux with any Kernel after 3.0.19 (Using Gnome 3 Desktop)
> - Insert any memory card into the card reader
> - Problem: nothing happens
> - Problem: In dmesg, the mmc driver reports communication timeouts for the card reader
> - Remove the memory card
> - Enter sudo setpci -s 00:1c.2 0x50.B=0x41 (This disables ASPM L1)
> - Insert the memory card
> - Result: It gets detected immediately. Gnome pop-ups a related notification window.
> - Remove the memory card
> - Enter sudo setpci -s 00:1c.2 0x50.B=0x43 (this is the value that the Linux Kernel sets during boot)
> - Insert the memory card
> - Problem: The card is not detected
> 


-- 
Thanks!
Yijing

--------------090708050904040607070806
Content-Type: text/x-patch;
	name="0001-PCI-move-pcie_clear_aspm-out-of-ACPI_SUCCESS-checkin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-PCI-move-pcie_clear_aspm-out-of-ACPI_SUCCESS-checkin.pa";
	filename*1="tch"

>From deec1ca8eb80cea58beadb1404abb163426956f3 Mon Sep 17 00:00:00 2001
From: Yijing Wang <wangyijing@huawei.com>
Date: Tue, 28 May 2013 16:02:55 +0800
Subject: [PATCH] PCI: move pcie_clear_aspm() out of ACPI_SUCCESS() checking

We should move pcie_clear_aspm() out of ACPI_SUCCESS() checking
in acpi_pci_root_add(), because if FADT dictate no aspm support,
and acpi_pci_osc_control_set() get _OSC control fail. We will
miss aspm clear here.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/acpi/pci_root.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index f6c0998..632c6e3 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -506,13 +506,6 @@ static int acpi_pci_root_add(struct acpi_device *device,
 		if (ACPI_SUCCESS(status)) {
 			dev_info(&device->dev,
 				"ACPI _OSC control (0x%02x) granted\n", flags);
-			if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
-				/*
-				 * We have ASPM control, but the FADT indicates
-				 * that it's unsupported. Clear it.
-				 */
-				pcie_clear_aspm(root->bus);
-			}
 		} else {
 			dev_info(&device->dev,
 				"ACPI _OSC request failed (%s), "
@@ -522,6 +515,13 @@ static int acpi_pci_root_add(struct acpi_device *device,
 				"disabling ASPM\n");
 			pcie_no_aspm();
 		}
+		if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
+			/*
+			 * We have ASPM control, but the FADT indicates
+			 * that it's unsupported. Clear it.
+			 */
+			pcie_clear_aspm(root->bus);
+		}
 	} else {
 		dev_info(&device->dev,
 			 "Unable to request _OSC control "
-- 
1.7.1


--------------090708050904040607070806--
