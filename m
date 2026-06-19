Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3A731B80D;
	Fri, 19 Jun 2026 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859169; cv=none; b=TA3eAfnCaSM9NWw2PCnQG8i9WHMN5hn6UO1b/0tDBOWEyTmF6vjGDkfPPbrrYfAyR6dlmxo0gNryiU7pKgUJUK+U1kihbi8fmXPwRS7gysyXJJJRt1Xngk6h51o4fdDbsALAobVFKMP02lqLvBvuYDgm3v5XuKMjcWvycfXlPPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859169; c=relaxed/simple;
	bh=86SWTGlflPteXCK+wxGvPGfNTyesuQhL/HSSPH62JAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEJwEsrAlGjnUXfcJ8VAV3qK4A09IAzzD4E+Sc8tU5GLdqHg3amYin8K49Ntcypxv96GpkYREAvblscrsRCxSWZFDiwP+BcDsTRphIZ2NweWDKT18dUxJ7JOsqC2zNJZod4YKoZbuQAQuNpdSrVPFN+GURkH7e5d1cA63pkm3xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPSyt+PI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPSyt+PI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE361F000E9;
	Fri, 19 Jun 2026 08:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859168;
	bh=1TCq4HRRJaHfxCGez1eXES+uvzFJvswxpkFT9pP4678=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CPSyt+PIAHizrhsXtBI8nWxq8YYSFIXhMJpqbmax3b/4wNiO2/9SswwyHa8Qz1/P/
	 LsOZ+a3qxZwII/w5nAYeTwlA1+BDuwH28N8IppApKpm5rmZcZBpmVmGUu45dDhB1XJ
	 R7w9FSpA5zztLmaVYF2hGdS5iTZ1GQKmhWOHlt7MyUeANyVk6V8IY+iaTBErMjMmX0
	 QFKRZXaiL+FEjafD1cYI/6W0MYWOge3jqumzBWKz/eix+Pi86Vwf2pNQWxQGvKCS/s
	 eilUtFJncGmT94OwcDepxuWreHTLK/vIMCGintIaxc53EXzJD7Z+Njp03pFKhmu063
	 hSjn2uuw6Keag==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v8 12/25] alpha/PCI: Use BAR index in sysfs attr->private instead of resource pointer
Date: Fri, 19 Jun 2026 08:51:47 +0000
Message-ID: <20260619085200.3729431-13-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619085200.3729431-1-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, Alpha's pci_create_one_attr() stores a resource pointer in
attr->private, and pci_mmap_resource() loops through all BARs to find
the matching index.

Thus, store the BAR index directly in attr->private and retrieve the
resource via pci_resource_n().  This eliminates the loop and aligns
with the convention used by the generic PCI sysfs code.

The PCI core change was first added in the commit dca40b186b75 ("PCI:
Use BAR index in sysfs attr->private instead of resource pointer").

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 2324720c3e83..2330ab84d59c 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -69,25 +69,20 @@ static int pci_mmap_resource(struct kobject *kobj,
 			     struct vm_area_struct *vma, int sparse)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
-	struct resource *res = attr->private;
+	int barno = (unsigned long)attr->private;
+	struct resource *res = pci_resource_n(pdev, barno);
 	enum pci_mmap_state mmap_type;
 	struct pci_bus_region bar;
-	int i, ret;
+	int ret;
 
 	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < PCI_STD_NUM_BARS; i++)
-		if (res == &pdev->resource[i])
-			break;
-	if (i >= PCI_STD_NUM_BARS)
-		return -ENODEV;
-
 	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
 		return -EINVAL;
 
-	if (!__pci_mmap_fits(pdev, i, vma, sparse))
+	if (!__pci_mmap_fits(pdev, barno, vma, sparse))
 		return -EINVAL;
 
 	pcibios_resource_to_bus(pdev->bus, &bar, res);
@@ -170,7 +165,7 @@ static int pci_create_one_attr(struct pci_dev *pdev, int num, char *name,
 	res_attr->attr.name = name;
 	res_attr->attr.mode = S_IRUSR | S_IWUSR;
 	res_attr->size = sparse ? size << 5 : size;
-	res_attr->private = &pdev->resource[num];
+	res_attr->private = (void *)(unsigned long)num;
 	return sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
 }
 
-- 
2.54.0

