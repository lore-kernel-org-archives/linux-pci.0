Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:50871 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965193Ab2I1Vuy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 28 Sep 2012 17:50:54 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linux PM list <linux-pm@vger.kernel.org>
Subject: [RFD][PATCH 6/7] PM / Domains: Check device PM QoS flags in pm_genpd_poweroff()
Date: Fri, 28 Sep 2012 23:56:15 +0200
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Huang Ying <ying.huang@intel.com>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Lan Tianyu <tianyu.lan@intel.com>,
	Aaron Lu <aaron.lu@intel.com>, Jean Pihet <j-pihet@ti.com>,
	linux-pci@vger.kernel.org,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	mark gross <markgross@thegnar.org>
References: <201209282351.10663.rjw@sisk.pl>
In-Reply-To: <201209282351.10663.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201209282356.15423.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make the generic PM domains pm_genpd_poweroff() function take
device PM QoS flags into account when deciding whether or not to
remove power from the domain.

After this change the routine will return -EBUSY without executing
the domain's .power_off() callback if there is at least one PM QoS
flags request for at least one device in the domain and at least of
those request has at least one of the NO_POWER_OFF and REMOTE_WAKEUP
flags set.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Index: linux/drivers/base/power/domain.c
===================================================================
--- linux.orig/drivers/base/power/domain.c
+++ linux/drivers/base/power/domain.c
@@ -474,10 +474,19 @@ static int pm_genpd_poweroff(struct gene
 		return -EBUSY;
 
 	not_suspended = 0;
-	list_for_each_entry(pdd, &genpd->dev_list, list_node)
+	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
+		enum pm_qos_flags_status stat;
+
+		stat = dev_pm_qos_flags(pdd->dev,
+					PM_QOS_FLAG_NO_POWER_OFF
+						| PM_QOS_FLAG_REMOTE_WAKEUP);
+		if (stat > PM_QOS_FLAGS_NONE)
+			return -EBUSY;
+
 		if (pdd->dev->driver && (!pm_runtime_suspended(pdd->dev)
 		    || pdd->dev->power.irq_safe))
 			not_suspended++;
+	}
 
 	if (not_suspended > genpd->in_progress)
 		return -EBUSY;

