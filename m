Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Babu Moger <babu.moger@oracle.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexander.duyck@gmail.com, babu.moger@oracle.com, hare@suse.de,
	mkubecek@suse.com, shane.seymour@hpe.com, myron.stowe@gmail.com,
	VenkatKumar.Duvvuru@avago.com
Subject: [PATCH RFC] pci: Blacklist vpd access for buggy devices
Date: Mon, 11 Jan 2016 13:13:09 -0800
Message-Id: <1452546789-62938-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <20160109010545.GA31085@localhost>
References: <20160109010545.GA31085@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Reading or Writing of PCI VPD data causes system panic.
We saw this problem by running "lspci -vvv" in the beginning.
However this can be easily reproduced by running
 cat /sys/bus/devices/XX../vpd

VPD length has been set as 32768 by default. Accessing vpd
will trigger read/write of 32k. This causes problem as we
could read data beyond the VPD end tag. Behaviour is un-
predictable when this happens. I see some other adapter doing
similar quirks(commit bffadffd43d4 ("PCI: fix VPD limit quirk
for Broadcom 5708S"))

I see there is an attempt to fix this right way.
https://patchwork.ozlabs.org/patch/534843/ or
https://lkml.org/lkml/2015/10/23/97

Tried to fix it this way, but problem is I dont see the proper
start/end TAGs(at least for this adapter) at all. The data is
mostly junk or zeros. This patch fixes the issue by setting the
vpd length to 0x80.

Also look at the threds 

https://lkml.org/lkml/2015/11/10/557
https://lkml.org/lkml/2015/12/29/315

Signed-off-by: Babu Moger <babu.moger@oracle.com>
---

NOTE:
Jordan, Are you sure all the devices in PCI_VENDOR_ID_ATHEROS and
PCI_VENDOR_ID_ATTANSIC have this problem. You have used PCI_ANY_ID.
I felt it is too broad. Can you please check.


 drivers/pci/quirks.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b03373f..8abcee5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2123,6 +2123,47 @@ static void quirk_via_cx700_pci_parking_caching(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, 0x324e, quirk_via_cx700_pci_parking_caching);
 
 /*
+ * A read/write to sysfs entry ('/sys/bus/pci/devices/<id>/vpd')
+ * will dump 32k of data. The default length is set as 32768.
+ * Reading a full 32k will cause an access beyond the VPD end tag.
+ * The system behaviour at that point is mostly unpredictable.
+ * Apparently, some vendors have not implemented this VPD headers properly.
+ * Adding a generic function disable vpd data for these buggy adapters
+ * Add the DECLARE_PCI_FIXUP_FINAL line below with the specific with
+ * vendor and device of interest to use this quirk.
+ */
+static void quirk_blacklist_vpd(struct pci_dev *dev)
+{
+	if (dev->vpd) {
+		dev->vpd->len = 0;
+		dev_warn(&dev->dev, "PCI vpd access has been disabled due to firmware bug\n");
+	}
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0060,
+		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x007c,
+		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0413,
+		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0078,
+		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0079,
+		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0073,
+		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0071,
+		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005b,
+		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x002f,
+		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005d,
+		quirk_blacklist_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f,
+		quirk_blacklist_vpd);
+
+/*
  * For Broadcom 5706, 5708, 5709 rev. A nics, any read beyond the
  * VPD end tag will hang the device.  This problem was initially
  * observed when a vpd entry was created in sysfs
-- 
1.7.1
