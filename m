Return-Path: <SRS0=QMsv=KB=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=QMsv=KB=intel.com=jonathan.derrick@kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Keith Busch <keith.busch@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Logan Gunthorpe <logang@deltatree.com>,
	Stephen Bates <sbates@raithlin.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: [RFC 3/3] docs: Document the expanded hp{io,mem}size interface
Date: Tue, 17 Jul 2018 15:39:47 -0600
Message-Id: <1531863587-3723-4-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1531863587-3723-1-git-send-email-jonathan.derrick@intel.com>
References: <1531863587-3723-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

The expanded interface allows specifying sizes on a per-device/per-bus
path granularity.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 533ff5c..8e4c129 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3142,11 +3142,24 @@
 				the default.
 				off: Turn ECRC off
 				on: Turn ECRC on.
-		hpiosize=nn[KMG]	The fixed amount of bus space which is
-				reserved for hotplug bridge's IO window.
+		hpiosize=
+				Format:
+				<nn[KMG]>
+				<nn[KMG]>@][<domain>:]<bus>[:<slot>.<func>][; ...]
+				<nn[KMG]>@]pci:<vendor>:<device>\
+						[:<subvendor>:<subdevice>][; ...]
+				The fixed amount of bus space which is reserved
+				for the matching hotplug bridge(s)'s IO window.
 				Default size is 256 bytes.
-		hpmemsize=nn[KMG]	The fixed amount of bus space which is
-				reserved for hotplug bridge's memory window.
+		hpmemsize=
+				Format:
+				<nn[KMG]>[P]
+				<nn[KMG]>[P]@][<domain>:]<bus>[:<slot>.<func>][; ...]
+				<nn[KMG]>[P]@]pci:<vendor>:<device>\
+						[:<subvendor>:<subdevice>][; ...]
+				The fixed amount of bus space which is reserved
+				for the matching hotplug bridge(s)'s memory window.
+				'P' specifies prefetchable.
 				Default size is 2 megabytes.
 		hpbussize=nn	The minimum amount of additional bus numbers
 				reserved for buses below a hotplug bridge.
-- 
1.8.3.1
