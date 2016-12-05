Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56133 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750841AbcLEOBp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2016 09:01:45 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uB5DsgX5060659
        for <linux-pci@vger.kernel.org>; Mon, 5 Dec 2016 08:59:22 -0500
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2756v9jgyh-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Mon, 05 Dec 2016 08:59:22 -0500
Received: from localhost
        by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
        Mon, 5 Dec 2016 11:59:20 -0200
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: gpiccoli@linux.vnet.ibm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, benh@kernel.crashing.org,
        frowand.list@gmail.com, marc.zyngier@arm.com
Subject: [PATCH v2] of/irq: improve error report on irq discovery process failure
Date: Mon,  5 Dec 2016 11:59:16 -0200
Message-Id: <1480946356-16778-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On PowerPC machines some PCI slots might not have level triggered
interrupts capability (also know as level signaled interrupts),
leading of_irq_parse_pci() to complain by presenting error messages
on the kernel log - in this case, the properties "interrupt-map" and
"interrupt-map-mask" are not present on device's node in the device
tree.

This patch introduces a different message for this specific case,
and also reduces its level from error to warning. Besides, we warn
(once) that possibly some PCI slots on the system have no level
triggered interrupts available.
We changed some error return codes too on function of_irq_parse_raw()
in order other failure's cases can be presented in a more precise way.

Before this patch, when an adapter was plugged in a slot without level
interrupts capabilitiy on PowerPC, we saw a generic error message
like this:

    [54.239] pci 002d:70:00.0: of_irq_parse_pci() failed with rc=-22

Now, with this applied, we see the following specific message:

    [16.154] pci 0014:60:00.1: of_irq_parse_pci: no interrupt-map found,
    INTx interrupts not available

Finally, we standardize the error path in of_irq_parse_raw() by always
taking the fail path instead of returning directly from the loop.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---

v2:
  * Changed function return code to always return negative values;
  * Improved/simplified warning outputs;
  * Changed some return codes and some error paths in of_irq_parse_raw()
in order to be more precise/consistent;

 drivers/of/irq.c        | 19 ++++++++++++-------
 drivers/of/of_pci_irq.c | 10 +++++++++-
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 393fea8..9deee86 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -104,7 +104,7 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 	const __be32 *match_array = initial_match_array;
 	const __be32 *tmp, *imap, *imask, dummy_imask[] = { [0 ... MAX_PHANDLE_ARGS] = ~0 };
 	u32 intsize = 1, addrsize, newintsize = 0, newaddrsize = 0;
-	int imaplen, match, i;
+	int imaplen, match, i, rc = -EINVAL;
 
 #ifdef DEBUG
 	of_print_phandle_args("of_irq_parse_raw: ", out_irq);
@@ -134,7 +134,7 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 	pr_debug("of_irq_parse_raw: ipar=%s, size=%d\n", of_node_full_name(ipar), intsize);
 
 	if (out_irq->args_count != intsize)
-		return -EINVAL;
+		goto fail;
 
 	/* Look for this #address-cells. We have to implement the old linux
 	 * trick of looking for the parent here as some device-trees rely on it
@@ -153,8 +153,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 	pr_debug(" -> addrsize=%d\n", addrsize);
 
 	/* Range check so that the temporary buffer doesn't overflow */
-	if (WARN_ON(addrsize + intsize > MAX_PHANDLE_ARGS))
+	if (WARN_ON(addrsize + intsize > MAX_PHANDLE_ARGS)) {
+		rc = -EFAULT;
 		goto fail;
+	}
 
 	/* Precalculate the match array - this simplifies match loop */
 	for (i = 0; i < addrsize; i++)
@@ -240,10 +242,11 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 			    newintsize, newaddrsize);
 
 			/* Check for malformed properties */
-			if (WARN_ON(newaddrsize + newintsize > MAX_PHANDLE_ARGS))
-				goto fail;
-			if (imaplen < (newaddrsize + newintsize))
+			if (WARN_ON(newaddrsize + newintsize > MAX_PHANDLE_ARGS)
+			    || (imaplen < (newaddrsize + newintsize))) {
+				rc = -EFAULT;
 				goto fail;
+			}
 
 			imap += newaddrsize + newintsize;
 			imaplen -= newaddrsize + newintsize;
@@ -271,11 +274,13 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 		ipar = newpar;
 		newpar = NULL;
 	}
+	rc = -ENOENT; /* No interrupt-map found */
+
  fail:
 	of_node_put(ipar);
 	of_node_put(newpar);
 
-	return -EINVAL;
+	return rc;
 }
 EXPORT_SYMBOL_GPL(of_irq_parse_raw);
 
diff --git a/drivers/of/of_pci_irq.c b/drivers/of/of_pci_irq.c
index 2306313..c175d9c 100644
--- a/drivers/of/of_pci_irq.c
+++ b/drivers/of/of_pci_irq.c
@@ -93,7 +93,15 @@ int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq
 		goto err;
 	return 0;
 err:
-	dev_err(&pdev->dev, "of_irq_parse_pci() failed with rc=%d\n", rc);
+	if (rc == -ENOENT) {
+		dev_warn(&pdev->dev,
+			"%s: no interrupt-map found, INTx interrupts not available\n",
+			__func__);
+		pr_warn_once("%s: possibly some PCI slots don't have level triggered interrupts capability\n",
+			__func__);
+	} else {
+		dev_err(&pdev->dev, "%s: failed with rc=%d\n", __func__, rc);
+	}
 	return rc;
 }
 EXPORT_SYMBOL_GPL(of_irq_parse_pci);
-- 
2.1.0

