Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F2B3C1966;
	Thu, 14 May 2026 06:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778740276; cv=none; b=YgsVmtsguRAbffneNy8Tnx9QZPk7Z8vYlW3WQvtY2m9Cu/51buE7b05OGDek0Sdq6bq4mM/3IaU5kwZ54v2dA3gLLzZyTx3QX5oXhbKqmWaWbGSyKbDCfv0tTYVFFZZ8xM/SYzMUyXwyl9QNoYC7D+9qBFa7z0JA662GVYPQUcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778740276; c=relaxed/simple;
	bh=0Igx9aTadXmb6OTo5npSkahdkSVxYqTYgPLzf5KhhnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nw2rjvCZ2FqxCgqiSB5/4RItz6do1c2/7q4oWvZfOCc3jiS0olkLEzOxmm5dp1VHXxOXUasux7bwK0IeDqax+ktDMzrcTWfYmAupY8KmlEf8655ZyAfTiLo8/peME1HuPgx8xEsSQexQop5EJ+eMz92LVJCgseVbCAEeMPFUENg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=BSSK308O; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="BSSK308O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1778740266;
	bh=0Igx9aTadXmb6OTo5npSkahdkSVxYqTYgPLzf5KhhnA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BSSK308OtzshEfGUjri04Beo/brEnTtxkAnD7TQC16atzT79rTFClLIGRsdEnV+Ys
	 nJ5Fzu7BTdmMudQ5pBs1INI0siqsQ+Fc4lvgWcfCH/SdaT8iF5nOks0ZK06DWxK+n5
	 y5hzOEmUJtMeXtN5P2U0V0CTLszG52PpOf4mw4QI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 14 May 2026 08:31:01 +0200
Subject: [PATCH 2/2] PCI: Constify slot attributes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-sysfs-const-pci-hotplug-v1-2-3b0b6c6f7481@weissschuh.net>
References: <20260514-sysfs-const-pci-hotplug-v1-0-3b0b6c6f7481@weissschuh.net>
In-Reply-To: <20260514-sysfs-const-pci-hotplug-v1-0-3b0b6c6f7481@weissschuh.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778740266; l=6227;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=0Igx9aTadXmb6OTo5npSkahdkSVxYqTYgPLzf5KhhnA=;
 b=0YtG52XP33yk798JhJr0WqbYZ5DSo2ZexwjuNFWk10veO/cpNjlwtWvyT3l/k6ItClZavHczN
 mPHzpJp7xJfAxCSDiRhaJiI8ZjjxNvfR7DqTpXCozWdW6lvitJWs7YZ
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

