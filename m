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
Subject: [RFC 2/3] module: Ignore delete_id parameter
Date: Wed, 27 Sep 2017 16:40:21 -0400
Message-Id: <1506544822-2632-3-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1506544822-2632-1-git-send-email-jonathan.derrick@intel.com>
References: <1506544822-2632-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

The PCI driver delete_id parameter is handled in each individual driver
registration callback.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 kernel/module.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index de66ec8..2b2dccf 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3620,6 +3620,13 @@ static int unknown_module_param_cb(char *param, char *val, const char *modname,
 		return 0;
 	}
 
+	/*
+	 * Ignore driver delete list arguments. They are handled by driver
+	 * registration callbacks
+	 */
+	if (strcmp(param, "delete_id") == 0)
+		return 0;
+
 	/* Check for magic 'dyndbg' arg */
 	ret = ddebug_dyndbg_module_param_cb(param, val, modname);
 	if (ret != 0)
-- 
1.8.3.1
