Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58CF2EC083;
	Sun,  1 Mar 2026 01:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329733; cv=none; b=aUMcPsaqZ+AXlbOmrBopn7gXkPn6ptS0kFCwZ4DetFXNlkKys+trY3npphRDE/pNApVhOoReFFgGETU8hX/1eYEqIHmfpvUvwTYGFf403UTT/+94GZULcpV1vJKtmYRCKO24AxAPLj3s9O10nAKKUUiB/n/3I7WEfvYXksrO+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329733; c=relaxed/simple;
	bh=MLxTCJ6X7n7rXfMN6upPtsp1xNlNaRrv4XGTDOGZ8CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JOL/W+4TjQS2RNBfxuq51XjGwwqosaBCROd1Hakq1XjIJNEP4/B77iCeot+L80Ykfx49S4rW3bAOcyVOcTI2YiaPxb7C9z743E7HGVZMUbcCzoDRvXfVtRvoLg1OzrLXV2PQV1vZR5lkDcBM3fpTNeQzAvMLTZhFbU3bxI3+HcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZ6CY9cu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZ6CY9cu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB039C19421;
	Sun,  1 Mar 2026 01:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329733;
	bh=MLxTCJ6X7n7rXfMN6upPtsp1xNlNaRrv4XGTDOGZ8CQ=;
	h=From:To:Cc:Subject:Date:From;
	b=sZ6CY9cuz3xR+5wjvcSSBaPpULQ7o5Wl3Igd8ZHU0ntl7J5Yi1OMkzEY00N+O3bDz
	 CqiUh9+QSdh3qT1DfsGT9D3H3J/6zMASgG/CJN+laPKrtg3oz2d5473pVHJiK+oEsX
	 969hcJjYPWdKsuG/Z7Tyz6q3HnswOLCV8udOXHKY9GH0NxWGbD1CKV2cjxUasUFAOV
	 KQnce1A54GIBlOyRkFe/was9D6Vs3AK762Yfsw2hQ7v0nF3+kl8ePZxVkYrOWz9b6J
	 zUG558j1iTQpV/RUcwM7Xmw0kSSuVJKsZIjCBdRTVLLg74B716a+0M18q5i60MwNoU
	 VxDvHMYWvpkQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org
Subject: FAILED: Patch "PCI: Use resource_set_range() that correctly sets ->end" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:48:51 -0500
Message-ID: <20260301014851.1713136-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 11721c45a8266a9d0c9684153d20e37159465f96 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Dec 2025 16:56:54 +0200
Subject: [PATCH] PCI: Use resource_set_range() that correctly sets ->end
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__pci_read_base() sets resource start and end addresses when resource
is larger than 4G but pci_bus_addr_t or resource_size_t are not capable
of representing 64-bit PCI addresses. This creates a problematic
resource that has non-zero flags but the start and end addresses do not
yield to resource size of 0 but 1.

Replace custom resource addresses setup with resource_set_range()
that correctly sets end address as -1 which results in resource_size()
returning 0.

For consistency, also use resource_set_range() in the other branch that
does size based resource setup.

Fixes: 23b13bc76f35 ("PCI: Fail safely if we can't handle BARs larger than 4GB")
Link: https://lore.kernel.org/all/20251207215359.28895-1-ansuelsmth@gmail.com/T/#m990492684913c5a158ff0e5fc90697d8ad95351b
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: stable@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Link: https://patch.msgid.link/20251208145654.5294-1-ilpo.jarvinen@linux.intel.com
---
 drivers/pci/probe.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 41183aed8f5d9..ad5ae05aad3c8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -287,8 +287,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		if ((sizeof(pci_bus_addr_t) < 8 || sizeof(resource_size_t) < 8)
 		    && sz64 > 0x100000000ULL) {
 			res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
-			res->start = 0;
-			res->end = 0;
+			resource_set_range(res, 0, 0);
 			pci_err(dev, "%s: can't handle BAR larger than 4GB (size %#010llx)\n",
 				res_name, (unsigned long long)sz64);
 			goto out;
@@ -297,8 +296,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		if ((sizeof(pci_bus_addr_t) < 8) && l) {
 			/* Above 32-bit boundary; try to reallocate */
 			res->flags |= IORESOURCE_UNSET;
-			res->start = 0;
-			res->end = sz64 - 1;
+			resource_set_range(res, 0, sz64);
 			pci_info(dev, "%s: can't handle BAR above 4GB (bus address %#010llx)\n",
 				 res_name, (unsigned long long)l64);
 			goto out;
-- 
2.51.0




