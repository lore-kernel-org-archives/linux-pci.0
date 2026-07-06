Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F3F42CAE0;
	Mon,  6 Jul 2026 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341627; cv=none; b=f/5YQWReuvknusH2wCbDKbx7UHtpu+oez3eO77D4G80sWi4UMhNfuullvQcIZCnXyBVexHOnz8Mja6y1J3qQlHrJO5Y2NGlsNAzuuph88Slv5GCqROdhqAt7/skQR64C3xEWBfZZhE8j4H+4qlhP40fQrNYtcS8z3Be4QkjOl3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341627; c=relaxed/simple;
	bh=DwuScNVFy48ypLlKiTPMXNym/1tGjmsdpAYygi6LIDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mpWhYYzhR2W7N5T5YL28lx/qEdNMCqZPVjF2Awm7WGbZaf/F7UTNf+jdSQ8aC+Vopc/2MNb2+SajQRYrNw+uZHxyzLcw2/fzXWOKUtMmA5/+Nwa+8dGhASwNN/Tqx3WxJgoNHn1BGwuQeTU+s7UrRR+W5ypM+pjAV9YjUdB+GEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpPYr98p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpPYr98p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79611F000E9;
	Mon,  6 Jul 2026 12:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783341624;
	bh=+Vwk9lX7OjF6cB8h0QPRGiEM7HXO/E0m8UvURF95vTI=;
	h=From:To:Cc:Subject:Date;
	b=OpPYr98pD/tJWFfIPQkVRuWP5/6ur/OsUF8qfZUKDETYPTN6scsuYwhHtglnEDWbh
	 H2O02jKMlcK+3EaW2+R3pzbIz3m4sO1UuKfEcFO3RLmDNbMIxwjzP7VMWttAOUibDR
	 XaE0Dx6raxRhQEm/VcEQAiAjtd36nKlrFYoFAFn+Pytd4F8rlbtkfOpxZl45jn4Ylh
	 6W+2ZcH4NMOBWOkIJHQorN9hDQS+5sl1uhOOlCzEr/8v1sRpZT9hY6G+fpWkFQ0hTJ
	 B3okkCI6xH8XHmPnCcaX/Axt4AHYoBnxxgzJpSDQ3LUfFVt3D5lJYR7AJCw3f9K/NG
	 MZM+1AVz/ICug==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] PCI: acpiphp_ibm: Do not use uninitialized device_class
Date: Mon, 06 Jul 2026 14:40:22 +0200
Message-ID: <8730724.T7Z3S40VBb@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Passing an uninitialized pnp.device_class string to
acpi_bus_generate_netlink_event() is effectively equivalent
to passing an empty string literal to it.

Accordingly, make the driver do the latter instead of doing the
former.

No intentional functional impact.

This will facilitate the removal of device_class from struct
acpi_device_pnp in the future.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/hotplug/acpiphp_ibm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
index f8016ed24523..7337bd1ac6df 100644
--- a/drivers/pci/hotplug/acpiphp_ibm.c
+++ b/drivers/pci/hotplug/acpiphp_ibm.c
@@ -258,8 +258,7 @@ static void ibm_handle_events(acpi_handle handle, u32 event, void *context)
 
 	if (subevent == 0x80) {
 		pr_debug("%s: generating bus event\n", __func__);
-		acpi_bus_generate_netlink_event(note->device->pnp.device_class,
-						  dev_name(&note->device->dev),
+		acpi_bus_generate_netlink_event("", dev_name(&note->device->dev),
 						  note->event, detail);
 	} else
 		note->event = event;
-- 
2.51.0




