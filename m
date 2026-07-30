Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ABB417D6C;
	Thu, 30 Jul 2026 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411141; cv=none; b=YB5IBXbUlJQz5t8CfBHsC+XzfIj2irjASBcRZ+fFmsuYTNCuu9lvegswMw+Ji1VFvgkDNiCozfN1zGFVYHS3OnyXCkFNTV3Z1S7o5pUhs3UoAxya1iTaZ5l/meEPjSe5hfph9rPnwgPpT1UHVQBPf7EKWJKzu6X3hj6PKUBFdU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411141; c=relaxed/simple;
	bh=m1ExKWgi718ZprBimzloJzqWKB6yzODetoUWTdDAx1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdJKHUXwbB1MJn/gzC9ejp7q6mTwkoFw2T6W66gfrqmdTdBwIK5wb1iuVcWA+fCORjJINIDZMD2iZgsaKWKNStAqAY/8vGW2Qaxk6vtxE1piimIPLKfxL1tiO/5UL1A+6Y5uAbo5Cq3woQY0Ug14eHlQ/krrMioDwd4xaZRIQHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CHEgFYsK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHEgFYsK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785411138; x=1816947138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m1ExKWgi718ZprBimzloJzqWKB6yzODetoUWTdDAx1c=;
  b=CHEgFYsK7v04YqN45s3JR1jt52ui2PHNe6ncvoqUQTaPOOIk5Q8qfKlr
   tIhk6CMnw9bT0iisoz6f7OWfLeEX9DV/rHEec8y+PBdyPKPJqLdXJQ2PA
   mXiD/EW5SEwvZuI/TIom3M1tkQ/emmgDr/N5Pq4rXLTs4AlW+gMs8d3hm
   Qu5kdGwJu7oSWPaaF78WThooQP7IsAxOzXiUJFR5niKM97hc0zE1nQK2M
   K2NYZ6jt3d77XMHfHzmfUQwlqFYO8yNIL9LGM8RM4jEd9j1W3XfQoI9OT
   YI4BMmSVncm0LRUT2oRh2n51SUjg9lu3QSithnNcfvxsAp/6CibtuOwDB
   g==;
X-CSE-ConnectionGUID: q+o3ZJESRHCA/hJ+6uwcIw==
X-CSE-MsgGUID: RrHV7KGOSF6Bs4zYW0i1IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="96387253"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="96387253"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 04:32:16 -0700
X-CSE-ConnectionGUID: zUnt6nDSRoyMT5L5M8xpPg==
X-CSE-MsgGUID: YplSsbrUS8escrrvME1oDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="283628940"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 30 Jul 2026 04:32:10 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id DD87399; Thu, 30 Jul 2026 13:32:09 +0200 (CEST)
Date: Thu, 30 Jul 2026 13:32:09 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: YehezkelShB@gmail.com, andreas.noever@gmail.com, bhelgaas@google.com,
	bp@alien8.de, dave.hansen@linux.intel.com, dev@deq.rocks,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	hansg@kernel.org, hpa@zytor.com, ilpo.jarvinen@linux.intel.com,
	jarkko@kernel.org, jmorris@namei.org, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-usb@vger.kernel.org, mingo@redhat.com, paul@paul-moore.com,
	platform-driver-x86@vger.kernel.org, roberto.sassu@huawei.com,
	serge@hallyn.com, tglx@kernel.org, westeri@kernel.org,
	x86@kernel.org, zohar@linux.ibm.com
Subject: Re: [PATCH v5 2/2] thunderbolt: Add device links for Apple T2 NHI
Message-ID: <20260730113209.GF20844@black.igk.intel.com>
References: <20260728044841.GP2365036@black.igk.intel.com>
 <20260729183524.1199-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260729183524.1199-1-atharvatiwarilinuxdev@gmail.com>

Hi,

On Wed, Jul 29, 2026 at 02:35:24PM -0400, Atharva Tiwari wrote:
> > We should not be calling PCI functions anymore from the SW CM core. We have
> > pci.c for that.
> 
> That is outside the scope of this patch, this should be another patch.

Agree. It should be preparatory patch for the series.

> > I wonder if we can put this to pci.c, rename it to tb_pci_add_links()
> > instead.
> 
> Same thing as before, its outside the scope of this patch.
> 
> > BTW, why you need to differentiate T2 vs. the rest of Apple x86? Don't this
> > variable do?
> 
> Because the Patchset is specifically for T2 Macs.

Yes but don't x86_apple_machine is true for T2 macs as well? Why need a
separate variable?

> > I'm not fan of __free() and the like so let's not use it here.
> >
> > Also you don't need to scan all the slots. Just look for the tunneled
> > downstream ports based on their PCI IDs like we do already.
> 
> Could you please point me to the "like we do already" code you're referring to?

Yes see below.

> > This is unrelated change.
> 
> Its not. the patch specifically says T2 macs, and Titan ridge is only on T2 Macs
> so we dont need to use has_apple_t2_chip for that.

I meant the extra empty line that your patch adds.

In addition to rename and move to pci.c (as separate patch) something like
this (completely untested) I had in mind. Does that make sense? It does not
add the Titan Ridge IDs, you can add them to the discrete part then.

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index ddeba0861a2b..3ad6ece6b808 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -3397,32 +3397,30 @@ static const struct tb_cm_ops tb_cm_ops = {
 	.disconnect_xdomain_paths = tb_disconnect_xdomain_paths,
 };
 
-/*
- * During suspend the Thunderbolt controller is reset and all PCIe
- * tunnels are lost. The NHI driver will try to reestablish all tunnels
- * during resume. This adds device links between the tunneled PCIe
- * downstream ports and the NHI so that the device core will make sure
- * NHI is resumed first before the rest.
- */
-static bool tb_apple_add_links(struct tb_nhi *nhi)
+static bool add_link(struct device *dev, struct device *nhi)
 {
-	struct pci_dev *nhi_pdev = to_pci_dev(nhi->dev);
-	struct pci_dev *upstream, *pdev;
-	bool ret;
+	const struct device_link *link;
 
-	if (!x86_apple_machine)
-		return false;
-
-	switch (nhi_pdev->device) {
-	case PCI_DEVICE_ID_INTEL_LIGHT_RIDGE:
-	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C:
-	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI:
-	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI:
-		break;
-	default:
-		return false;
+	link = device_link_add(dev, nhi, DL_FLAG_AUTOREMOVE_SUPPLIER |
+				DL_FLAG_PM_RUNTIME);
+	if (link) {
+		dev_dbg(nhi, "created link from %s\n",
+			dev_name(dev));
+		return true;
+	} else {
+		dev_warn(nhi, "device link creation from %s failed\n",
+			 dev_name(dev));
 	}
 
+	return false;
+}
+
+static bool
+tb_pci_add_links_discrete(struct tb_nhi *nhi, struct pci_dev *nhi_pdev)
+{
+	struct pci_dev *upstream, *pdev;
+	bool ret;
+
 	upstream = pci_upstream_bridge(nhi_pdev);
 	while (upstream) {
 		if (!pci_is_pcie(upstream))
@@ -3442,30 +3440,80 @@ static bool tb_apple_add_links(struct tb_nhi *nhi)
 	 */
 	ret = false;
 	for_each_pci_bridge(pdev, upstream->subordinate) {
-		const struct device_link *link;
-
 		if (!pci_is_pcie(pdev))
 			continue;
 		if (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM ||
 		    !pdev->is_pciehp)
 			continue;
 
-		link = device_link_add(&pdev->dev, nhi->dev,
-				       DL_FLAG_AUTOREMOVE_SUPPLIER |
-				       DL_FLAG_PM_RUNTIME);
-		if (link) {
-			dev_dbg(nhi->dev, "created link from %s\n",
-				dev_name(&pdev->dev));
-			ret = true;
-		} else {
-			dev_warn(nhi->dev, "device link creation from %s failed\n",
-				 dev_name(&pdev->dev));
+		ret = add_link(&pdev->dev, nhi->dev);
+	}
+
+	return ret;
+}
+
+static bool
+tb_pci_add_links_integrated(struct tb_nhi *nhi, struct pci_dev *nhi_pdev)
+{
+	struct pci_bus *bus = nhi_pdev->bus;
+	struct pci_dev *pdev;
+	bool ret = false;
+
+	/*
+	 * On intergrated the tunneled PCIe root ports are directly
+	 * under the host bridge.
+	 */
+	if (!pci_is_root_bus(bus))
+		return false;
+
+	for_each_pci_bridge(pdev, bus) {
+		switch (nhi_pdev->device) {
+		case PCI_DEVICE_ID_INTEL_ICL_NHI0:
+			if (pdev->device == 0x8a1d || pdev->device == 0x8a1fb)
+				ret = add_link(&pdev->dev, nhi->dev);
+			break;
+		case PCI_DEVICE_ID_INTEL_ICL_NHI1:
+			if (pdev->device == 0x8a21 || pdev->device == 0x8a23)
+				ret = add_link(&pdev->dev, nhi->dev);
+			break;
+		default:
+			break;
 		}
 	}
 
 	return ret;
 }
 
+/*
+ * During suspend the Thunderbolt controller is reset and all PCIe
+ * tunnels are lost. The NHI driver will try to reestablish all tunnels
+ * during resume. This adds device links between the tunneled PCIe
+ * downstream ports and the NHI so that the device core will make sure
+ * NHI is resumed first before the rest.
+ */
+static bool tb_apple_add_links(struct tb_nhi *nhi)
+{
+	struct pci_dev *nhi_pdev = to_pci_dev(nhi->dev);
+
+	if (!x86_apple_machine)
+		return false;
+
+	switch (nhi_pdev->device) {
+	case PCI_DEVICE_ID_INTEL_LIGHT_RIDGE:
+	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C:
+	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI:
+	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI:
+		return tb_pci_add_links_discrete(nhi, nhi_pdev);
+
+	case PCI_DEVICE_ID_INTEL_ICL_NHI0:
+	case PCI_DEVICE_ID_INTEL_ICL_NHI1:
+		return tb_pci_add_links_integrated(nhi, nhi_pdev);
+
+	default:
+		return false;
+	}
+}
+
 struct tb *tb_probe(struct tb_nhi *nhi)
 {
 	struct tb_cm *tcm;

