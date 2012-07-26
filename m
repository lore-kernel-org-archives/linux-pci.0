Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:58576 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642Ab2GZTzm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jul 2012 15:55:42 -0400
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-tegra@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 08/10] of/address: Handle #address-cells > 2 specially
Date: Thu, 26 Jul 2012 21:55:10 +0200
Message-Id: <1343332512-28762-9-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When a bus specifies #address-cells > 2, of_bus_default_map() now
assumes that the mapping isn't for a physical address but rather an
identifier that needs to match exactly.

This is required by bindings that use multiple cells to translate a
resource to the parent bus (device index, type, ...).

See here for the discussion:

	https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-June/016577.html

Originally-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v3:
- new patch

 drivers/of/address.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 7e262a6..2776119 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -69,6 +69,14 @@ static u64 of_bus_default_map(u32 *addr, const __be32 *range,
 		 (unsigned long long)cp, (unsigned long long)s,
 		 (unsigned long long)da);
 
+	/*
+	 * If the number of address cells is larger than 2 we assume the
+	 * mapping doesn't specify a physical address. Rather, the address
+	 * specifies an identifier that must match exactly.
+	 */
+	if (na > 2 && memcmp(range, addr, na * 4) != 0)
+		return OF_BAD_ADDR;
+
 	if (da < cp || da >= (cp + s))
 		return OF_BAD_ADDR;
 	return da - cp;
-- 
1.7.11.2

