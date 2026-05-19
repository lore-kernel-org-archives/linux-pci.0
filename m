Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B178367B92;
	Tue, 19 May 2026 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779215107; cv=none; b=C5bP13731KkVACRSuC2dEmLHRBOtU9C03DNuNAyfrod4q4tBWhsJKbUBau3Ynvg5FpXRK8Hc2Azk9y3wjXdhitrxO/sdDvRLTwEFM2lRV5GAwktahZDSaZldn6j7dU4wzPGtqCaossf/mbdseLc0zv27VhnP9dhQM0DPGWxluNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779215107; c=relaxed/simple;
	bh=0Igx9aTadXmb6OTo5npSkahdkSVxYqTYgPLzf5KhhnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mt86RR4NpRVRIvk/abJ+vASIvIziWgjBe4NPPs8Dmv0bPrWAwWL/Iw9Mnb5Uqu8niVt3ru6AciXimVRG88uo3uC4G3KJOo4qFLU8RZ6e0SZpuXp7mljacqWXFY8yqnAFjmRXMKKushCSJESWgQ2pD+fPeJq8LwxQHvm7LqlMXDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=J1vU355U; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="J1vU355U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1779214557;
	bh=0Igx9aTadXmb6OTo5npSkahdkSVxYqTYgPLzf5KhhnA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J1vU355UglbG8HytnPhUQ5qXiPaznmWT4cWuT7A95hH7e5zyx2bZL8dyHSM5klBkJ
	 DfodJnbpzeouauu6toAFXK3L3w5eGeeAUuudCgyL3foj79gbLJ+P2Z/e87dLj8+wZC
	 ySsROu9T/jejgdBxU1ERoomtAustizKSPQD8X7zA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 19 May 2026 20:15:52 +0200
Subject: [PATCH v2 2/2] PCI: Constify slot attributes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-sysfs-const-pci-hotplug-v2-2-16e90346a522@weissschuh.net>
References: <20260519-sysfs-const-pci-hotplug-v2-0-16e90346a522@weissschuh.net>
In-Reply-To: <20260519-sysfs-const-pci-hotplug-v2-0-16e90346a522@weissschuh.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779214556; l=6227;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=0Igx9aTadXmb6OTo5npSkahdkSVxYqTYgPLzf5KhhnA=;
 b=WlP8rCYG0gLbEH08CE6dD5I6KxfRxyzt6WN8thfg6T9qfuSj2d7gie0xWeMhdlb1sFoCkVmyu
 DfX08TGKB2oCVyNlTKR/Jw0GQ0ejYri553C1MHc+4ZHFPGTLJgLhqhH
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The attribute struct are never modified, mark them as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/pci/hotplug/pci_hotplug_core.c | 19 ++++++++++---------
 drivers/pci/pci.h                      |  2 +-
 drivers/pci/slot.c                     | 14 +++++++-------
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index 7c4e197f5581..cdf3293aade7 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -97,7 +97,7 @@ static ssize_t power_write_file(struct pci_slot *pci_slot, const char *buf,
 	return count;
 }
 
-static struct pci_slot_attribute hotplug_slot_attr_power = {
+static const struct pci_slot_attribute hotplug_slot_attr_power = {
 	.attr = {.name = "power", .mode = S_IFREG | S_IRUGO | S_IWUSR},
 	.show = power_read_file,
 	.store = power_write_file
@@ -136,7 +136,7 @@ static ssize_t attention_write_file(struct pci_slot *pci_slot, const char *buf,
 	return count;
 }
 
-static struct pci_slot_attribute hotplug_slot_attr_attention = {
+static const struct pci_slot_attribute hotplug_slot_attr_attention = {
 	.attr = {.name = "attention", .mode = S_IFREG | S_IRUGO | S_IWUSR},
 	.show = attention_read_file,
 	.store = attention_write_file
@@ -154,7 +154,7 @@ static ssize_t latch_read_file(struct pci_slot *pci_slot, char *buf)
 	return sysfs_emit(buf, "%d\n", value);
 }
 
-static struct pci_slot_attribute hotplug_slot_attr_latch = {
+static const struct pci_slot_attribute hotplug_slot_attr_latch = {
 	.attr = {.name = "latch", .mode = S_IFREG | S_IRUGO},
 	.show = latch_read_file,
 };
@@ -171,7 +171,7 @@ static ssize_t presence_read_file(struct pci_slot *pci_slot, char *buf)
 	return sysfs_emit(buf, "%d\n", value);
 }
 
-static struct pci_slot_attribute hotplug_slot_attr_presence = {
+static const struct pci_slot_attribute hotplug_slot_attr_presence = {
 	.attr = {.name = "adapter", .mode = S_IFREG | S_IRUGO},
 	.show = presence_read_file,
 };
@@ -196,7 +196,7 @@ static ssize_t test_write_file(struct pci_slot *pci_slot, const char *buf,
 	return count;
 }
 
-static struct pci_slot_attribute hotplug_slot_attr_test = {
+static const struct pci_slot_attribute hotplug_slot_attr_test = {
 	.attr = {.name = "test", .mode = S_IFREG | S_IRUGO | S_IWUSR},
 	.store = test_write_file
 };
@@ -239,7 +239,7 @@ static bool has_test_file(struct hotplug_slot *slot)
 	return false;
 }
 
-static struct attribute *hotplug_slot_attrs[] = {
+static const struct attribute *const hotplug_slot_attrs[] = {
 	&hotplug_slot_attr_power.attr,
 	&hotplug_slot_attr_attention.attr,
 	&hotplug_slot_attr_latch.attr,
@@ -248,7 +248,8 @@ static struct attribute *hotplug_slot_attrs[] = {
 	NULL
 };
 
-static umode_t hotplug_slot_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+static umode_t hotplug_slot_attr_is_visible(struct kobject *kobj, const struct attribute *attr,
+					    int idx)
 {
 	struct hotplug_slot *slot = to_pci_slot(kobj)->hotplug;
 
@@ -271,8 +272,8 @@ static umode_t hotplug_slot_attr_is_visible(struct kobject *kobj, struct attribu
 }
 
 static const struct attribute_group hotplug_slot_group = {
-	.is_visible = hotplug_slot_attr_is_visible,
-	.attrs = hotplug_slot_attrs,
+	.is_visible_const = hotplug_slot_attr_is_visible,
+	.attrs_const = hotplug_slot_attrs,
 };
 
 static int fs_add_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..3ca3832c7267 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -478,7 +478,7 @@ struct pci_slot_attribute {
 	ssize_t (*show)(struct pci_slot *, char *);
 	ssize_t (*store)(struct pci_slot *, const char *, size_t);
 };
-#define to_pci_slot_attr(s) container_of(s, struct pci_slot_attribute, attr)
+#define to_pci_slot_attr(s) container_of_const(s, struct pci_slot_attribute, attr)
 
 enum pci_bar_type {
 	pci_bar_unknown,	/* Standard PCI BAR probe */
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 6d5cd37bfb1e..7929bb87b195 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -18,7 +18,7 @@ static ssize_t pci_slot_attr_show(struct kobject *kobj,
 					struct attribute *attr, char *buf)
 {
 	struct pci_slot *slot = to_pci_slot(kobj);
-	struct pci_slot_attribute *attribute = to_pci_slot_attr(attr);
+	const struct pci_slot_attribute *attribute = to_pci_slot_attr(attr);
 	return attribute->show ? attribute->show(slot, buf) : -EIO;
 }
 
@@ -26,7 +26,7 @@ static ssize_t pci_slot_attr_store(struct kobject *kobj,
 			struct attribute *attr, const char *buf, size_t len)
 {
 	struct pci_slot *slot = to_pci_slot(kobj);
-	struct pci_slot_attribute *attribute = to_pci_slot_attr(attr);
+	const struct pci_slot_attribute *attribute = to_pci_slot_attr(attr);
 	return attribute->store ? attribute->store(slot, buf, len) : -EIO;
 }
 
@@ -93,14 +93,14 @@ static void pci_slot_release(struct kobject *kobj)
 	kfree(slot);
 }
 
-static struct pci_slot_attribute pci_slot_attr_address =
+static const struct pci_slot_attribute pci_slot_attr_address =
 	__ATTR(address, S_IRUGO, address_read_file, NULL);
-static struct pci_slot_attribute pci_slot_attr_max_speed =
+static const struct pci_slot_attribute pci_slot_attr_max_speed =
 	__ATTR(max_bus_speed, S_IRUGO, max_speed_read_file, NULL);
-static struct pci_slot_attribute pci_slot_attr_cur_speed =
+static const struct pci_slot_attribute pci_slot_attr_cur_speed =
 	__ATTR(cur_bus_speed, S_IRUGO, cur_speed_read_file, NULL);
 
-static struct attribute *pci_slot_default_attrs[] = {
+static const struct attribute *const pci_slot_default_attrs[] = {
 	&pci_slot_attr_address.attr,
 	&pci_slot_attr_max_speed.attr,
 	&pci_slot_attr_cur_speed.attr,
@@ -108,7 +108,7 @@ static struct attribute *pci_slot_default_attrs[] = {
 };
 
 static const struct attribute_group pci_slot_default_group = {
-	.attrs = pci_slot_default_attrs,
+	.attrs_const = pci_slot_default_attrs,
 };
 
 static const struct attribute_group *pci_slot_default_groups[] = {

-- 
2.54.0

