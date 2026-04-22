Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAA71A3164;
	Wed, 22 Apr 2026 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874463; cv=none; b=hneg9gc3Q5bhQnShK2Km8Mo5v2YtSGjDY9gvqRY9dpD6qt9XUMFEB1Omk8TzE4+ydQT/UPwbWty/t6PHAaY88fkGPtuWZd+6LeCbf7JuFZSUTcVZP37Hk64fFuF0JJ1ZYjLu7Wnqmx/0ay3DOmjt9ldrtXXKlXe0QfvWKOZlyEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874463; c=relaxed/simple;
	bh=HZ5aHhQsiLFl5RPG8uUtLsO5XRsRiFkacQ/7Zktybgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PF8btzwlVqNGtR2GxbPfd3m3z5Ic7Jih4WEbZbg/DXS2u1GxtFIZ6vfRL0+heeLqh3tCj+7tr/qtJWpATD9seKS4usATAOPsvKG0m5vVM7onMhz1/EveWJNwlERJqCW4RZo4/FlfVtSCytgmu9p9K3/CXNIipzWjJ/UtZ+S6+iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4afykfe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4afykfe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532B9C2BCAF;
	Wed, 22 Apr 2026 16:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874462;
	bh=HZ5aHhQsiLFl5RPG8uUtLsO5XRsRiFkacQ/7Zktybgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q4afykfe3MmcSwnaafIlC8sSC8KADiLzDLhZemBm67uz3dQkAihde5mmJdWWPQ3w6
	 tjIBZ9k3YlOZtUn8dzXTaIoC8kOvMGeLL6xQo9SACOgpo8eRbU3ET+T8VLKlnvQKpI
	 gKHaAHCXDiN485XXloqrLxd/P3UAiGh+LjcEmT8YZr0YVMSnbf8hNW6eqbcD5Douxh
	 8pLKKJiwOrf//N2fQdhijqsJFvGHDiS9BxkGrHOSU1w6SJSaZ5FrnAQdaU/vSB2TT2
	 Daw09QSrLCmFMA0WkuCjBNdOP0PGnafeBbHQF/QzeTbj7YFtL6SuNAsjjIHAbjFA/j
	 wQcus2e7AJMjA==
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
Subject: [PATCH v6 03/24] PCI/sysfs: Only allow supported resource types in I/O and MMIO helpers
Date: Wed, 22 Apr 2026 16:13:46 +0000
Message-ID: <20260422161407.118748-4-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260422161407.118748-1-kwilczynski@kernel.org>
References: <20260422161407.118748-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, when the sysfs attributes for PCI resources are added
dynamically, the resource access callbacks are only set when the
underlying BAR type matches, using .read and .write for IORESOURCE_IO,
and .mmap for IORESOURCE_MEM or IORESOURCE_IO with arch_can_pci_mmap_io()
support.  As such, when the callback is not set, the operation inherently
fails.

After the conversion to static attributes, visibility callbacks will
control which resource files appear for each BAR, but the callbacks
themselves will always be set.

Thus, add a type check to pci_resource_io() and pci_mmap_resource()
to return -EIO for an unsupported resource type.

Use the new pci_resource_is_io() and pci_resource_is_mem() helpers
for the type checks, replacing the open-coded bitwise flag tests and
also drop the local struct resource pointer in pci_mmap_resource().

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index ad3c17f86c7f..6783c6168445 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1108,20 +1108,24 @@ static int pci_mmap_resource(struct kobject *kobj, const struct bin_attribute *a
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
 	int bar = (unsigned long)attr->private;
 	enum pci_mmap_state mmap_type;
-	struct resource *res = pci_resource_n(pdev, bar);
 	int ret;
 
 	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
 	if (ret)
 		return ret;
 
-	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
+	if (!pci_resource_is_mem(pdev, bar) &&
+	    !(pci_resource_is_io(pdev, bar) && arch_can_pci_mmap_io()))
+		return -EIO;
+
+	if (pci_resource_is_mem(pdev, bar) &&
+	    iomem_is_exclusive(pci_resource_start(pdev, bar)))
 		return -EINVAL;
 
 	if (!pci_mmap_fits(pdev, bar, vma, PCI_MMAP_SYSFS))
 		return -EINVAL;
 
-	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
+	mmap_type = pci_resource_is_mem(pdev, bar) ? pci_mmap_mem : pci_mmap_io;
 
 	return pci_mmap_resource_range(pdev, bar, vma, mmap_type, write_combine);
 }
@@ -1149,6 +1153,9 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 	int bar = (unsigned long)attr->private;
 	unsigned long port = off;
 
+	if (!pci_resource_is_io(pdev, bar))
+		return -EIO;
+
 	port += pci_resource_start(pdev, bar);
 
 	if (port > pci_resource_end(pdev, bar))
-- 
2.54.0

