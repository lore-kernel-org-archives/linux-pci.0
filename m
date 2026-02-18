Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9ED2E2EF2;
	Wed, 18 Feb 2026 22:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771454072; cv=none; b=Py/oTI8SE7LzIV6wXyk2oGO9VrYvXXbnryzJwxy2TWf6V7YxpqGbUAHsUiSg5plPrC0CloraSXJ7SAxpKKBo8Na8l7IbSWPpbct64QIOKgEcWPoQmAMMjuOFtavyA4/8Tkwli8p7h0u+O8HPQVfluKB5LUucn6WdIU3NX65J/+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771454072; c=relaxed/simple;
	bh=LbmBDzmjfxN6KxrAG7aKdbncGsiMExuY3HZ1qZki3pk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fooDEp1Gz2R6D1Hnwr4xuj6xh2/KvD6QyJACMtln2uuxhs/dfkbWEPPaP8BAKDazXolIwnZjAvccb8RXeSH709+d+8JLqRd5GJwVkOn5At7YYqhrjQoJm8KITjmzFKDI4n66DdQiwtiskigIMrTVvkz6oPIVRwvBYzjNuejWRrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TpRyUOgl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TpRyUOgl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771454071; x=1802990071;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LbmBDzmjfxN6KxrAG7aKdbncGsiMExuY3HZ1qZki3pk=;
  b=TpRyUOglIggmBffZBbaqhgLaAOieyPBN0tyR9jRxVh7bPA5eYIshYpu4
   /AX3MOxRly+g2LFRviYlQ9aCO8qYe9lr0en0GDTf8zTyahXFNEWOAnqUZ
   73YQE2f1v6WqKFn6G70iBXm5WxhlYlDtgTqpj0BG8Gh9uK9Ax6wqbZG83
   J12Mg9zVTdR+fFcqLWoPiKQ42nhbY3O5j2jXdTRIOOqseEIeL87P0WI1O
   cYNlX87DBjajF/ycmV388Res13v7OHszJnXMLG3CUbZNDgp+cj/KRDsL9
   td6Lz2ASfrdfNngarFb2cGcAzwySJvXGV7bra1JfgeSbf8xYdnaYjc3s2
   g==;
X-CSE-ConnectionGUID: knSBAcncRwCLjkRpS6sXwg==
X-CSE-MsgGUID: L64iSt0JSRO8baIL2iloEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72605968"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="72605968"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 14:34:30 -0800
X-CSE-ConnectionGUID: O3RJ1xFlRxSNlEFz5LVzNg==
X-CSE-MsgGUID: P83/YeeCTq2K+0PHpU7QwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="237326209"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 14:34:27 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: RavitejaX Veesam <ravitejax.veesam@intel.com>
Subject: [PATCH 1/1] PCI: Account fully optional bridge windows correctly
Date: Thu, 19 Feb 2026 00:34:18 +0200
Message-Id: <20260218223419.22366-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pbus_size_mem_optional() adds dev_res->add_size of a bridge window into
children_add_size when the window has a non-optional part. However, if
the bridge window is fully optional, only r_size is added (which is
zero for such a window).

Also, a second dev_res entry will be added by pci_dev_res_add_to_list()
into realloc_head for the bridge window (resulting in triggering the
realloc_head-must-be-fully-consumed sanity check after a single pass of
the resource assignment algorithm):

  WARNING: drivers/pci/setup-bus.c:2153 at pci_assign_unassigned_root_bus_resources+0xa5/0x260

Correct these problems by always adding dev_res->add_size for bridge
windows and not calling pci_dev_res_add_to_list() if the dev_res entry
exists.

Fixes: 6a5e64c75e82 ("PCI: Add pbus_mem_size_optional() to handle optional sizes")
Reported-by: RavitejaX Veesam <ravitejax.veesam@intel.com>
Tested-by: RavitejaX Veesam <ravitejax.veesam@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 32aa72456a44..0c8cbbfaf8d7 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1217,31 +1217,34 @@ static bool pbus_size_mem_optional(struct pci_dev *dev, int resno,
 	struct resource *res = pci_resource_n(dev, resno);
 	bool optional = pci_resource_is_optional(dev, resno);
 	resource_size_t r_size = resource_size(res);
-	struct pci_dev_resource *dev_res;
+	struct pci_dev_resource *dev_res = NULL;
 
 	if (!realloc_head)
 		return false;
 
-	if (!optional) {
-		/*
-		 * Only bridges have optional sizes in realloc_head at this
-		 * point. As res_to_dev_res() walks the entire realloc_head
-		 * list, skip calling it when known unnecessary.
-		 */
-		if (!pci_resource_is_bridge_win(resno))
-			return false;
-
+	/*
+	 * Only bridges have optional sizes in realloc_head at this
+	 * point. As res_to_dev_res() walks the entire realloc_head
+	 * list, skip calling it when known unnecessary.
+	 */
+	if (pci_resource_is_bridge_win(resno)) {
 		dev_res = res_to_dev_res(realloc_head, res);
 		if (dev_res) {
 			*children_add_size += dev_res->add_size;
 			*add_align = max(*add_align, dev_res->min_align);
 		}
+	}
 
+	if (!optional)
 		return false;
-	}
 
-	/* Put SRIOV requested res to the optional list */
-	pci_dev_res_add_to_list(realloc_head, dev, res, 0, align);
+	/*
+	 * Put requested res to the optional list if not there yet (SRIOV,
+	 * disabled ROM). Bridge windows with an optional part are already
+	 * on the list.
+	 */
+	if (!dev_res)
+		pci_dev_res_add_to_list(realloc_head, dev, res, 0, align);
 	*children_add_size += r_size;
 	*add_align = max(align, *add_align);
 

base-commit: 1c2b4a4c2bcb950f182eeeb33d94b565607608cf
-- 
2.39.5

