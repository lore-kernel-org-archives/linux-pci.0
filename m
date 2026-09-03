Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BF04F55AB;
	Thu,  3 Sep 2026 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455426; cv=none; b=JMh+U3FHII5W6TJn/8/wx9iZ3pWXf65Wnoko+X7e47ewQHWzCeGbBAGjwKYTtIUtMR402+LJa214hdcAl9CfuQ8aSISEaWUHctQwuR6GM4/e+syJU239+sqkJheNqBO723cS7nCYaCmGgYYECwf37UY8VSTVjPfwq6o0yB1O5pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455426; c=relaxed/simple;
	bh=GH/g/OZMVl7/sRJh1johwXbAhEh1Q8GWsJAZ+lGNQqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sh7b3KAjJRh6HuR2nWw21ZdGsrScH6Cq7v7okLg9Vlh6YRQYOzBS4doFRJYkCOqG2h5HSVUWk2l3xaQAWpFTT7pSuh8jTSysq1/S7OsyltaazPuP5wSfx+BBEBLu1sVEL1S5ncgENbwDLr4+7hJO0KCTHgDKEnlNgXXzwcFpeJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3f8fPBF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3f8fPBF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909031F000E9;
	Thu,  3 Sep 2026 17:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788455424;
	bh=AfjWkTiBRpjiyLTWPUphlOoar+l8hOsIqNhemePK8cY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P3f8fPBF596sF1nT69tXjoay9AkgP6d53PsB10hHJebITR3LG+WxWcix7hKglpy2I
	 FynlbdB7TrGrznn7kD/c2QtkFdactlU689yHM8yL5qHH9/Z++hn6Z5LeBDgDvXOPz1
	 E6fb027JbgDh4DGTj/F8P/dpbO7tRI/gZvc+qKK96TGbRCjSrWgsxpWnYwJVat4Tyn
	 8FykzOaFLS0/LVy7lz1ucurcrEUjJ4U8RMx0fz/dcjIlwl6WomTKAH7p+jo6eGaMvO
	 UGtxgTs+bXU6KAMZlTPhBxkxVNlqlurGV0CkJX9DWraT2r3LFJFwI/jpfYWU1J4g6M
	 7V95OEuoQcKdw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Peixin Xie <peixin.xie@linux.spacemit.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Lukas Wunner <lukas@wunner.de>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Hans de Goede <hansg@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v3 1/4] ACPI: PM: Drop parent state update from
 acpi_device_get_power()
Date: Thu, 03 Sep 2026 18:58:34 +0200
Message-ID: <5147279.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <6044499.DvuYhMxLoT@rafael.j.wysocki>
References: <6044499.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The parent state update in acpi_device_get_power(), that occurs when the
child device turns out to be in D0 and the parent's power state is still
unknown, is highly questionable because it may cause the reference
counters of the power resources used by the parent in D0 (if any) to
underflow when the parent goes into a low-power state later.  Moreover,
there is no reason to do it on reads from the real_power_state sysfs
attribute of the child.

That check had been added by commit 8f7412a792bc ("ACPI / PM: Infer
parent power state from child if unknown, v2") before starting to
handle the "missing _PSC and no power resources" case directly in
acpi_bus_init_power(), as of commit b3785492268f ("ACPI / PM: Do not
power manage devices in unknown initial states").  It is not necessary
any more and commit b3785492268f should have removed it.

Drop it now.

Fixes: b3785492268f ("ACPI / PM: Do not power manage devices in unknown initial states")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: No changes

New patch in v2.

---
 drivers/acpi/device_pm.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index aa55ecfc2923..4269735aadde 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -75,15 +75,14 @@ static int acpi_dev_pm_explicit_get(struct acpi_device *device, int *state)
 int acpi_device_get_power(struct acpi_device *device, int *state)
 {
 	int result = ACPI_STATE_UNKNOWN;
-	struct acpi_device *parent;
 	int error;
 
 	if (!device || !state)
 		return -EINVAL;
 
-	parent = acpi_dev_parent(device);
-
 	if (!device->flags.power_manageable) {
+		struct acpi_device *parent = acpi_dev_parent(device);
+
 		/* TBD: Non-recursive algorithm for walking up hierarchy. */
 		*state = parent ? parent->power.state : ACPI_STATE_D0;
 		goto out;
@@ -119,16 +118,6 @@ int acpi_device_get_power(struct acpi_device *device, int *state)
 			result = psc > ACPI_STATE_D2 ? ACPI_STATE_D3_HOT : psc;
 	}
 
-	/*
-	 * If we were unsure about the device parent's power state up to this
-	 * point, the fact that the device is in D0 implies that the parent has
-	 * to be in D0 too, except if ignore_parent is set.
-	 */
-	if (!device->power.flags.ignore_parent && parent &&
-	    parent->power.state == ACPI_STATE_UNKNOWN &&
-	    result == ACPI_STATE_D0)
-		parent->power.state = ACPI_STATE_D0;
-
 	*state = result;
 
  out:
-- 
2.51.0




