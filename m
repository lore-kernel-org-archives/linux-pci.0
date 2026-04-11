Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E583823C8C7;
	Sat, 11 Apr 2026 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775894528; cv=none; b=G6MMlQlLNbBFyTt8H/TbAe5/jqm+I0gt1fmhdbK9D3n0gLYinA6Ol0ptU7ALfHB/31FU+KRlj2LuHpHma4uhVGhbqAY6MjkgGuvXh2rPwKE3p16WHXq4lUdClLhcq1AuPpHynLfL9hsyO00REpq2DNX2DmhfSRgW+BL2tcrcG4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775894528; c=relaxed/simple;
	bh=H0WndVWw8wLHCufLJXaP5uTZO+d0TQtPZDWQ71hp9UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajLO2qVFkK/H+YuknrePhjEHLgwwc09S01KbtObkty9+zObzIbXq4CbvReom5IQKypi+QC7vKGs/DOqVH0rvz4x9mIO7F7vra38qevcXOySGGdFN4Mw0L7ns3OJQhVs5zy5HYlxkaMMG/rnlkE8IPX9/N3tXqJ+DTPZCm9kH2kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sX9GlRlQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sX9GlRlQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1B0C4CEF7;
	Sat, 11 Apr 2026 08:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894527;
	bh=H0WndVWw8wLHCufLJXaP5uTZO+d0TQtPZDWQ71hp9UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sX9GlRlQKtlstIWMrItda1yAZOGEnfnSjqtpwwnLNuixgU3SGTeNF86UNKiozdy0C
	 0IAUB7UqsCWAh9i9HuQoB6SSB+Q8HWCXMechhh6DrJkoIgqwOJVOLz6YMmiFsjIG+M
	 o9bbauN+U3p5NyMOO80/8WsgQYvLAT2zl/ZgifW08FY/FN/0bj1lO66nr+Mx6idF4w
	 QNDBX3nyozlW5Clf3LDuzHYphYFEcdvasmoKrUVNOA1JyGINKZpvx7s6PhFT++Ioqd
	 j9y6wyt2yauwWw6fM/HbX7zAP7yHQpAIS+Ygtu3JRev0drhg9kKgcUK7T/3x8cGH9j
	 7WWtFinv/wWIg==
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
Subject: [PATCH v4 04/24] PCI/sysfs: Use BAR length in pci_llseek_resource() when attr->size is zero
Date: Sat, 11 Apr 2026 08:01:28 +0000
Message-ID: <20260411080148.471335-5-kwilczynski@kernel.org>
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

Both legacy and resource attributes set .f_mapping = iomem_get_mapping,
so the default generic_file_llseek() would consult iomem_inode for the
file size, which knows nothing about the attribute.  That is why this
custom llseek callback exists.

Currently, the legacy and resource attributes have .size set at creation
time, as such, using the attr->size is sufficient.  However, the upcoming
static resource attributes will have .size == 0 set, since they are const,
and the .bin_size callback will be used to provide the real size to kernfs
instead.

Thus, update pci_llseek_resource() to derive the file size from the
BAR using pci_resource_len() instead of reading the attr->size directly.

The custom pci_llseek_resource() helper has been added in commit
24de09c16f97 ("PCI: Implement custom llseek for sysfs resource
entries").

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 6783c6168445..73a9ae9d289b 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -909,11 +909,21 @@ static const struct attribute_group pci_dev_config_attr_group = {
  */
 static __maybe_unused loff_t
 pci_llseek_resource(struct file *filep,
-		    struct kobject *kobj __always_unused,
+		    struct kobject *kobj,
 		    const struct bin_attribute *attr,
 		    loff_t offset, int whence)
 {
-	return fixed_size_llseek(filep, offset, whence, attr->size);
+	struct pci_dev *pdev;
+	int bar;
+
+	if (attr->size)
+		return fixed_size_llseek(filep, offset, whence, attr->size);
+
+	pdev = to_pci_dev(kobj_to_dev(kobj));
+	bar = (unsigned long)attr->private;
+
+	return fixed_size_llseek(filep, offset, whence,
+				 pci_resource_len(pdev, bar));
 }
 
 #ifdef HAVE_PCI_LEGACY
-- 
2.53.0

