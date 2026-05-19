Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B29E36827E;
	Tue, 19 May 2026 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779215107; cv=none; b=swc17OWCD7zwhFeHcNeF4Ec3ff51eYjPQQ2/ntpKy+5CRAenpLoPOZjkbC/PqyW3fBYJJLKWN9w9SRhykK9z7MkkzinQYGca1BN+IaNilR0M9xlVUd9FFRP/xxd9joHOygqyR54g2G/TmqjHLbOVMTekcCnTdw6eL+rJA0fgAZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779215107; c=relaxed/simple;
	bh=37gkrudc3UZ+P4Z9TUfyE6f275CQW1zKf1om7jujkkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ol9emiQDv+dMjXJWjKfiLPs6AUePWpLuWNKPWcD+0/1iA40NcKYP3KezoS5edgzbt/cO9yVSl+WA9pGDYG8O/JuE9K/+kppQbPerQIR/6TP/ohJqu2Q2d0TxkCfrdWyda37MDv8ZyjPHL/AzBRX3EWfCHqIGf8f7desVacpaPoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=iBd/aCJR; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="iBd/aCJR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1779214557;
	bh=37gkrudc3UZ+P4Z9TUfyE6f275CQW1zKf1om7jujkkA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iBd/aCJRzBCS7L4JwtMe6eu8QHEdriUOAmXfwsep/IQ0F7dllrkJDL/29dT1ovev1
	 OAafRb4C6wq29DdZUknRDP9deDUszKZ1vbr8CrchhSO6J5AAVG0/78QuavhKVXtQS6
	 KZjwaVOE683JcDaSQrOn+iqNVbwUtT+QUC+IgZ+Q=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 19 May 2026 20:15:51 +0200
Subject: [PATCH v2 1/2] PCI: hotplug: Manage hotplug slot attributes as
 group
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-sysfs-const-pci-hotplug-v2-1-16e90346a522@weissschuh.net>
References: <20260519-sysfs-const-pci-hotplug-v2-0-16e90346a522@weissschuh.net>
In-Reply-To: <20260519-sysfs-const-pci-hotplug-v2-0-16e90346a522@weissschuh.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779214556; l=4449;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=37gkrudc3UZ+P4Z9TUfyE6f275CQW1zKf1om7jujkkA=;
 b=v8UsVpKOXXUTNrRPNwO4EXyxE7INRP1HZ2DADJYghswGIS354MAQ5qq1/j97BwKYvPAO6cKFW
 mKtfdSbuDEOAO8VCXT2nY7U9uWAPD5x2Q80Y9ZM0e+qNyxtK+RupZoq
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Make use of 'struct attribute_group' to manage all attribute together,
simplifying the lifecycle management.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/pci/hotplug/pci_hotplug_core.c | 114 +++++++++++++--------------------
 1 file changed, 43 insertions(+), 71 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index fadcf98a8a66..7c4e197f5581 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -239,10 +239,46 @@ static bool has_test_file(struct hotplug_slot *slot)
 	return false;
 }
 
+static struct attribute *hotplug_slot_attrs[] = {
+	&hotplug_slot_attr_power.attr,
+	&hotplug_slot_attr_attention.attr,
+	&hotplug_slot_attr_latch.attr,
+	&hotplug_slot_attr_presence.attr,
+	&hotplug_slot_attr_test.attr,
+	NULL
+};
+
+static umode_t hotplug_slot_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	struct hotplug_slot *slot = to_pci_slot(kobj)->hotplug;
+
+	if (attr == &hotplug_slot_attr_power.attr && !has_power_file(slot))
+		return 0;
+
+	if (attr == &hotplug_slot_attr_attention.attr && !has_attention_file(slot))
+		return 0;
+
+	if (attr == &hotplug_slot_attr_latch.attr && !has_latch_file(slot))
+		return 0;
+
+	if (attr == &hotplug_slot_attr_presence.attr && !has_adapter_file(slot))
+		return 0;
+
+	if (attr == &hotplug_slot_attr_test.attr && !has_test_file(slot))
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group hotplug_slot_group = {
+	.is_visible = hotplug_slot_attr_is_visible,
+	.attrs = hotplug_slot_attrs,
+};
+
 static int fs_add_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
 {
 	struct kobject *kobj;
-	int retval = 0;
+	int retval;
 
 	/* Create symbolic link to the hotplug driver module */
 	kobj = kset_find_obj(module_kset, slot->mod_name);
@@ -254,82 +290,18 @@ static int fs_add_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
 		kobject_put(kobj);
 	}
 
-	if (has_power_file(slot)) {
-		retval = sysfs_create_file(&pci_slot->kobj,
-					   &hotplug_slot_attr_power.attr);
-		if (retval)
-			goto exit_power;
-	}
-
-	if (has_attention_file(slot)) {
-		retval = sysfs_create_file(&pci_slot->kobj,
-					   &hotplug_slot_attr_attention.attr);
-		if (retval)
-			goto exit_attention;
-	}
-
-	if (has_latch_file(slot)) {
-		retval = sysfs_create_file(&pci_slot->kobj,
-					   &hotplug_slot_attr_latch.attr);
-		if (retval)
-			goto exit_latch;
-	}
-
-	if (has_adapter_file(slot)) {
-		retval = sysfs_create_file(&pci_slot->kobj,
-					   &hotplug_slot_attr_presence.attr);
-		if (retval)
-			goto exit_adapter;
-	}
-
-	if (has_test_file(slot)) {
-		retval = sysfs_create_file(&pci_slot->kobj,
-					   &hotplug_slot_attr_test.attr);
-		if (retval)
-			goto exit_test;
+	retval = sysfs_create_group(&pci_slot->kobj, &hotplug_slot_group);
+	if (retval) {
+		sysfs_remove_link(&pci_slot->kobj, "module");
+		return retval;
 	}
 
-	goto exit;
-
-exit_test:
-	if (has_adapter_file(slot))
-		sysfs_remove_file(&pci_slot->kobj,
-				  &hotplug_slot_attr_presence.attr);
-exit_adapter:
-	if (has_latch_file(slot))
-		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_latch.attr);
-exit_latch:
-	if (has_attention_file(slot))
-		sysfs_remove_file(&pci_slot->kobj,
-				  &hotplug_slot_attr_attention.attr);
-exit_attention:
-	if (has_power_file(slot))
-		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_power.attr);
-exit_power:
-	sysfs_remove_link(&pci_slot->kobj, "module");
-exit:
-	return retval;
+	return 0;
 }
 
 static void fs_remove_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
 {
-	if (has_power_file(slot))
-		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_power.attr);
-
-	if (has_attention_file(slot))
-		sysfs_remove_file(&pci_slot->kobj,
-				  &hotplug_slot_attr_attention.attr);
-
-	if (has_latch_file(slot))
-		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_latch.attr);
-
-	if (has_adapter_file(slot))
-		sysfs_remove_file(&pci_slot->kobj,
-				  &hotplug_slot_attr_presence.attr);
-
-	if (has_test_file(slot))
-		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_test.attr);
-
+	sysfs_remove_group(&pci_slot->kobj, &hotplug_slot_group);
 	sysfs_remove_link(&pci_slot->kobj, "module");
 }
 

-- 
2.54.0

