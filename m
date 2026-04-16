Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A5F291C10;
	Thu, 16 Apr 2026 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362483; cv=none; b=mIdBIxNswsuoR0Hy2UDKgCaBPmTin7W5C/8XXlUwRqvRYID3B3+x3vX0u1JyulL1JguvDcKoU4u+dXwvhrTpBywr/FgVsbox/rib+7tO2bdj+TPRiZevCPGXhS10qqM+OHZ8yJouhUNv7knOpxbwW3q8yzNZ58tizBB1enxLvN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362483; c=relaxed/simple;
	bh=RmFbxvo7Bj/hud/UhBoRkQf2eC0ZxfrFYB6cjbtRANE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMiSpWOe2hY2vNtPI3Lo4+sC2/Fx7RHAF8xTwW3eCAzB+ANK2REakNGeXKqJDqlbD/aP8Qe91rO0rgkD9dZlRzSOQwog5lB6cIxHXNu20hY7iq8Mf2YUrsyQGugZ5h89Nzo2JDupVsCY19oPSeR7uZhf+1ZjaL8vqVPXz1PnOKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkUmjDr3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkUmjDr3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D777C2BCB7;
	Thu, 16 Apr 2026 18:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776362482;
	bh=RmFbxvo7Bj/hud/UhBoRkQf2eC0ZxfrFYB6cjbtRANE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mkUmjDr3/9ZYeL95iqy9ZqTDnfc9AxEYtijgnV6K2ZCT1eTuIl8bHkzwk0yy3E9iB
	 Eun4ZyB7qZ6+FhL9b0/UaURWsCS+8ff0THH7vQGAc/Bl/9I8rCJTDrruZbDOdNU+Cf
	 L+ry06KZrOBkBx77wFWXDyDOvxq64Bhwabt41LFfNjugYuYBo5SB3aK2D+SQGjJClI
	 S0FQBLnTg3aKHf6cQc+Bg2g05pdZ1kT4DFB3omGdwid+Y+vW8DjB/fLLAJnrrwiWFu
	 g3Ico4QldbadDZGnH3pGkt788/LmHihg6Sv0M6+vn0pQ9C/je6RuoKCd0M6sJCOqYd
	 aemCCPa3Vw7iw==
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
Subject: [PATCH v5 03/23] PCI/sysfs: Only allow supported resource types in I/O and MMIO helpers
Date: Thu, 16 Apr 2026 18:00:47 +0000
Message-ID: <20260416180107.777065-4-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416180107.777065-1-kwilczynski@kernel.org>
References: <20260416180107.777065-1-kwilczynski@kernel.org>
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
2.53.0

