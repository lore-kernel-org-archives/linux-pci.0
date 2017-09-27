Return-Path: <SRS0=Xovj=A4=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=Xovj=A4=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Alan Cox <alan@linux.intel.com>,
	Dan J Williams <dan.j.williams@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [RFC 3/3] Documentation: Add pci device delete_id interface
Date: Wed, 27 Sep 2017 16:40:22 -0400
Message-Id: <1506544822-2632-4-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1506544822-2632-1-git-send-email-jonathan.derrick@intel.com>
References: <1506544822-2632-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

Document the <driver>.delete_id= cmdline interface for masking built-in
and module device id tables.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0549662..862c8b5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -789,6 +789,19 @@
 			Defaults to the default architecture's huge page size
 			if not specified.
 
+	driver.delete_id=
+			[PCI]
+			Specified pci device format(s) will mask built-in
+			driver id tables, preventing devices from
+			automicatically attaching to built-in or module
+			drivers.  Later attachment should be done by adding the
+			deleted id back through the "new_id" sysfs interface.
+			Format: <vendor>:<device>[:<subvendor>:<subdevice>]\
+					[:class][:class_mask][, ...]
+			PCI_ANY_ID masks should use the full 32-bit format.
+			Examples: virtio-pci.delete_id=ffffffff:ffffffff
+				  nvme.delete_id=1234:5678,1111:ffffffff
+
 	dhash_entries=	[KNL]
 			Set number of hash buckets for dentry cache.
 
-- 
1.8.3.1
