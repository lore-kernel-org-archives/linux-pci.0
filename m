Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F503AD512;
	Wed,  2 Sep 2026 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377886; cv=none; b=PNwQ3GDnpOIIq8Rb8TFwA1zx3qwXZQgdzWnIPEy8uIeXOCcrSEbz5RqwmQ4KRzjmhZXuv6OrJrogXHFjkFq/xhTSabNa+ybVoES1llcg2Fj/l3q9g3AIsUHVlJdMapQeDtJAaVlJt7K4Si2OhYQtzK+LwRDc5hS2xakC7WUwmjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377886; c=relaxed/simple;
	bh=Cx9QVXAfqDPfmBPI888g0Dnbwzu9e8P7sj9l58N/0uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7xVhIpN6MS6GeU63/l9pwRO5ppzSGIyZoYNSJmMOwr4S4VsvVyJZYddsEeOkB5NCwIP2hc/mq+70/MjIvQcKZ9RG3VCyJrs5phWXxAUje6TJXDK6mQwI9jWcwjB9s/pdv1CAPquyU3ps78VUhvloGbEZMNcTF8ZH+exWbmMUgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKnielXo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKnielXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB5D1F00A3A;
	Wed,  2 Sep 2026 19:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788377872;
	bh=qcqYbKVza0kLmwK8bO5EEgHIwXuwTg00Nowd1TaXseE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gKnielXo5W49tVog76TYFy2UkMFBYAOOVBOWT3NSOACIvfQjP+0Yr+9WWilYBDNM3
	 xiTseNy2Z3g6BzrL8zO+fihJbp9BD/0YrbPlLIdKBFyT4ggCGP1yDoEGGqUnPYJ7jV
	 uLIQWc7vNuaBAc/r/Nd2AATPJifZUcKQ9HL3eyneX3FURXOdw4bOTwKRhKUDHoL8Kq
	 EQRDhqZhh1jCrbR/fDUxI3AFCVI4+jhMuW1k10Dnd0jGGfInW5FkhGey13MS7rmcxi
	 HsjCsPQXiDxB3pZv9HMjRB2egmJyHA7CGuWzvdwvZhDeAdyom+sJ6l2IKW9iv/vLMZ
	 TteivGLjyipGQ==
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
 [PATCH v2 1/6] ACPI: PM: Drop parent state update from
 acpi_device_get_power()
Date: Wed, 02 Sep 2026 21:24:43 +0200
Message-ID: <2292173.irdbgypaU6@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <5144065.31r3eYUQgx@rafael.j.wysocki>
References: <5144065.31r3eYUQgx@rafael.j.wysocki>
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




