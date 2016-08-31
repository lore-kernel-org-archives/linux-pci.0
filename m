Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Whitcroft <apw@canonical.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] treewide: Remove references to the now unnecessary DEFINE_PCI_DEVICE_TABLE
Date: Wed, 31 Aug 2016 09:19:29 -0700
Message-Id: <076eff466fd7edb550c25c8b25d76924ca0eba62.1472660229.git.joe@perches.com>
In-Reply-To: <cover.1472660229.git.joe@perches.com>
References: <cover.1472660229.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It's been eliminated from the sources, remove it from everywhere else.

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/PCI/pci.txt | 1 -
 include/linux/pci.h       | 9 ---------
 scripts/checkpatch.pl     | 9 ---------
 scripts/tags.sh           | 1 -
 4 files changed, 20 deletions(-)

diff --git a/Documentation/PCI/pci.txt b/Documentation/PCI/pci.txt
index 123881f..77f49dc 100644
--- a/Documentation/PCI/pci.txt
+++ b/Documentation/PCI/pci.txt
@@ -124,7 +124,6 @@ initialization with a pointer to a structure describing the driver
 
 The ID table is an array of struct pci_device_id entries ending with an
 all-zero entry.  Definitions with static const are generally preferred.
-Use of the deprecated macro DEFINE_PCI_DEVICE_TABLE should be avoided.
 
 Each entry consists of:
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fbc1fa6..0ab8359 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -683,15 +683,6 @@ struct pci_driver {
 #define	to_pci_driver(drv) container_of(drv, struct pci_driver, driver)
 
 /**
- * DEFINE_PCI_DEVICE_TABLE - macro used to describe a pci device table
- * @_table: device table name
- *
- * This macro is deprecated and should not be used in new code.
- */
-#define DEFINE_PCI_DEVICE_TABLE(_table) \
-	const struct pci_device_id _table[]
-
-/**
  * PCI_DEVICE - macro used to describe a specific pci device
  * @vend: the 16 bit PCI Vendor ID
  * @dev: the 16 bit PCI Device ID
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 8946904..1c82b01 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3610,15 +3610,6 @@ sub process {
 			}
 		}
 
-# check for uses of DEFINE_PCI_DEVICE_TABLE
-		if ($line =~ /\bDEFINE_PCI_DEVICE_TABLE\s*\(\s*(\w+)\s*\)\s*=/) {
-			if (WARN("DEFINE_PCI_DEVICE_TABLE",
-				 "Prefer struct pci_device_id over deprecated DEFINE_PCI_DEVICE_TABLE\n" . $herecurr) &&
-			    $fix) {
-				$fixed[$fixlinenr] =~ s/\b(?:static\s+|)DEFINE_PCI_DEVICE_TABLE\s*\(\s*(\w+)\s*\)\s*=\s*/static const struct pci_device_id $1\[\] = /;
-			}
-		}
-
 # check for new typedefs, only function parameters and sparse annotations
 # make sense.
 		if ($line =~ /\btypedef\s/ &&
diff --git a/scripts/tags.sh b/scripts/tags.sh
index ed7eef2..b3775a9 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -206,7 +206,6 @@ regex_c=(
 	'/\<DEFINE_PER_CPU_SHARED_ALIGNED([^,]*, *\([[:alnum:]_]*\)/\1/v/'
 	'/\<DECLARE_WAIT_QUEUE_HEAD(\([[:alnum:]_]*\)/\1/v/'
 	'/\<DECLARE_\(TASKLET\|WORK\|DELAYED_WORK\)(\([[:alnum:]_]*\)/\2/v/'
-	'/\<DEFINE_PCI_DEVICE_TABLE(\([[:alnum:]_]*\)/\1/v/'
 	'/\(^\s\)OFFSET(\([[:alnum:]_]*\)/\2/v/'
 	'/\(^\s\)DEFINE(\([[:alnum:]_]*\)/\2/v/'
 	'/\<DEFINE_HASHTABLE(\([[:alnum:]_]*\)/\1/v/'
-- 
2.10.0.rc2.1.gb2aa91d
