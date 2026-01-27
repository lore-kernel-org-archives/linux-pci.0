Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0949230BE9
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769546432; cv=none; b=OlCjj46Tt71w5doElcAspaqhCBwcW7oBzNUbPWBlzxp2GVDLBV6y6ggNHIZIGIaUX2chljY2+8h5hoF5wWy0MyXPQ6TpYqp3kVpHLbTtIGpLces/q/fkF2EUL06/buOIJcaWtt60ctnWm3utII9wgzFEqKVab0IItqkaJdeCIfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769546432; c=relaxed/simple;
	bh=uz8S12ycOsiMjO1j4ZoL+w51wPe5Q0RZgD6+OSMHZc4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IiD2PJ3HHlFgDZvNV4tMXLrrbQAvRv1QD5U3BmUd6pKDEd2UA2/lCJM976mMCa68F94lc/DPsNBmhmpLAg9H75mpqFEUOJp3MLVUSyKpypux4ENful7RXMawSdfBi+C+EzZj+kpjYc9HBNKUvjjPFh4kNHnFyblS+fG7K7zN5/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from wasted (213.87.160.169) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 27 Jan
 2026 23:40:19 +0300
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Sergey Shtylyov <s.shtylyov@auroraos.dev>, =?UTF-8?q?Pali=20Roh=C3=A1r?=
	<pali@kernel.org>
Subject: [PATCH] PCI: Check parent for NULL in of_pci_bus_release_domain_nr()
Date: Tue, 27 Jan 2026 23:39:42 +0300
Message-ID: <20260127203944.28588-1-s.shtylyov@auroraos.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

of_pci_bus_find_domain_nr() allows its parent parameter to be NULL but
of_pci_bus_release_domain_nr() (that undoes its effect) doesn't -- that
means it's going to blow up while calling of_get_pci_domain_nr() if the
parent parameter indeed happens to be NULL.  Add the missing NULL check.

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..9fc4c2226b03 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6591,7 +6591,7 @@ static void of_pci_bus_release_domain_nr(struct device *parent, int domain_nr)
 		return;
 
 	/* Release domain from IDA where it was allocated. */
-	if (of_get_pci_domain_nr(parent->of_node) == domain_nr)
+	if (parent && of_get_pci_domain_nr(parent->of_node) == domain_nr)
 		ida_free(&pci_domain_nr_static_ida, domain_nr);
 	else
 		ida_free(&pci_domain_nr_dynamic_ida, domain_nr);
-- 
2.52.0

