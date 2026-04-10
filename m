Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B381A304A;
	Fri, 10 Apr 2026 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775800252; cv=none; b=mLVNf+doGa+8sR6nCwGbBlgJhlYcBbNhLADCRKNiDB9PnNQGiv04RCRw1MbudNl/eG/xwKT2mD+kD854UqKujkBbCqzpnUgT8ck9b8N/+YOz+mOgC3UNn01HL4dvViqqN2dyd3fddWGGcFiFrCYSfK8Qhclr7/1fRKIF6ECUFe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775800252; c=relaxed/simple;
	bh=O8kQ8QkL9LHeQ/3N8ubS2U25zz9aBbM59rexDGwqeT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBkIOn54qkgBgzMhq+dX1aw9p/0In0uYc4fP9mmTfTEyZOp1R5qiGs+R64vLS/jNTGDINS0IVhMmDoFZFc+fk3+aQU3ef8JUQ1i5584EV0rV21VnM8Rc4KGYH6JcL/JBSnutF2nTPo4WiFMbn1ai1kSOprCXkBEms0e/ocXkTfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mvd/ZBK4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mvd/ZBK4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BADC19421;
	Fri, 10 Apr 2026 05:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800252;
	bh=O8kQ8QkL9LHeQ/3N8ubS2U25zz9aBbM59rexDGwqeT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mvd/ZBK4JZ3ugDIqD8qBy9RypOd44POFR5UdO2aVnaeCsYRDmuj7xaRUOqjsWJBTO
	 GKZCmPgluWSMZJSXSHZ4ZG1A8/CV8NehkGas7ShsLMUzybBt07DN5tw5TnBIXHZgFK
	 h8AZJqyveq2bqqPIp+fLbR9AeQp7vPrrPDGBWpq1SNDlC+IY42RcOaZSzMkw2RCcTq
	 jYqAT8AyDaC6GOXMoBFzqgTvieBBR4e2C1xa/RWHZr0uIB24wUEeNkvj0NBy92uFCY
	 JjiSIiKkJMIrqbd3jG8jW+xkOUfcSoEXbi+qCssvyWEZSXl94bNtD3cSubUswsl8jz
	 aQyqTwfkdjkkQ==
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
Subject: [PATCH 02/20] PCI/sysfs: Only allow supported resource types in I/O and MMIO helpers
Date: Fri, 10 Apr 2026 05:50:22 +0000
Message-ID: <20260410055040.39233-3-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410055040.39233-1-kwilczynski@kernel.org>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
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

While at it, add parentheses around the bitwise flag test in
pci_mmap_resource() to make the precedence explicit, and to
match the preferred style.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index ad3c17f86c7f..008e0dd0de36 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1115,13 +1115,17 @@ static int pci_mmap_resource(struct kobject *kobj, const struct bin_attribute *a
 	if (ret)
 		return ret;
 
-	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
+	if (!(res->flags & IORESOURCE_MEM) &&
+	    !((res->flags & IORESOURCE_IO) && arch_can_pci_mmap_io()))
+		return -EIO;
+
+	if ((res->flags & IORESOURCE_MEM) && iomem_is_exclusive(res->start))
 		return -EINVAL;
 
 	if (!pci_mmap_fits(pdev, bar, vma, PCI_MMAP_SYSFS))
 		return -EINVAL;
 
-	mmap_type = res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_io;
+	mmap_type = (res->flags & IORESOURCE_MEM) ? pci_mmap_mem : pci_mmap_io;
 
 	return pci_mmap_resource_range(pdev, bar, vma, mmap_type, write_combine);
 }
@@ -1149,6 +1153,9 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 	int bar = (unsigned long)attr->private;
 	unsigned long port = off;
 
+	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_IO))
+		return -EIO;
+
 	port += pci_resource_start(pdev, bar);
 
 	if (port > pci_resource_end(pdev, bar))
-- 
2.53.0

