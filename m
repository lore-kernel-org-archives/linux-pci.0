Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A1D13D8B1;
	Sat, 11 Apr 2026 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775894555; cv=none; b=plHLhgOq0k86Y1d76egtO+doL4SDdG4E2G+NdSPD10+Q4q3H8GnatiXwGKWeEmRB58zpYm82L/KDheBoYRmJ4HP+uyzPOBHEvMFjTKP1aLhGl++flQoBBP7yrCn2aSf0GYN2+Hj18o1V0H5E1nmPvHsyeTzgBhmRvoxuGDiDOQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775894555; c=relaxed/simple;
	bh=4+W1kd8ovvTGg2a+x1mXoEZZdmh6JcYJxVFeZ3Yu0xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APuppcddqf1qwC+DaXfB8rK8zjZXHxfLnK2LmTA5bJWdzBC8VMh/JthEI+g+jrWsdJ3e49BRC8kPsPtBCncwSgkEe/lnoVb72GnuTyucISw42UBsH4FOwSdneGhGBHTw5kt7rMZhEErdhSXwsn32XStvZ1I34e2lfkNTH3oAtYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6ti0xpR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6ti0xpR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CA6C2BC9E;
	Sat, 11 Apr 2026 08:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894555;
	bh=4+W1kd8ovvTGg2a+x1mXoEZZdmh6JcYJxVFeZ3Yu0xQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6ti0xpRbuKzeGReO+1yu9MNEg0/ssxI8ndwhH89aUR2pZvrm+Hzf9jXo9RBl8m6+
	 DVLnytiGA+zzwlFrJOOgpEJKodfue9xRonZTTv6wjBJrgNxuV5ssxeMgnhCqaN15W+
	 JtXogcrOmdr1c5Wlg6WCl3C7rSwByygvuAtmxteZZXugIF6bK7rjCivXrrpF5siZ3k
	 tXB0GagfGt/V6nfPBZI5LPVhaPycgvvii9kat0SZNLeUMDYb/u0d4OHlzOyuvVMwx3
	 nXlVzMwqONChr8vyoMMmFwZnBP9NBaueMG197WrTyej0NOcxrRmKs0teomzvSlyTQ9
	 l7gsh7dKK+qIg==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: [PATCH v4 12/24] alpha/PCI: Use BAR index in sysfs attr->private instead of resource pointer
Date: Sat, 11 Apr 2026 08:01:36 +0000
Message-ID: <20260411080148.471335-13-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411080148.471335-1-kwilczynski@kernel.org>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
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

While at it, add parentheses around the bitwise flag test in
pci_mmap_resource() to make the precedence explicit, and to
match the preferred style.

The PCI core change was first added in the commit dca40b186b75 ("PCI:
Use BAR index in sysfs attr->private instead of resource pointer").

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 2324720c3e83..c84867ce31f5 100644
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
-	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
+	if ((res->flags & IORESOURCE_MEM) && iomem_is_exclusive(res->start))
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
2.53.0

