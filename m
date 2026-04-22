Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC59325495;
	Wed, 22 Apr 2026 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874466; cv=none; b=Xiz/x0DGrb6wEO1prb6yLvqniuzWXRUkY+ZXKlheAkwJvJ76DFUZ2H3EsieSxrkMo7D61TIbE2v5JbK4laM1183b6izq+n/8RIikI7v2PlkC9B0EPcVokOm3DGrUJmsuW/nAmhvZwDyWO5tKyU24olOEYUZ1RGMRi5rRQh+0YMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874466; c=relaxed/simple;
	bh=GioqcjyAYkzeNaoaWV/yTLAqCcEigQz8/u7cr2rMnc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MyyH7HFuhGyfzsDc+eUSlPXWd1rUAaxdFsGYhjozd1lGnQs84NBOS56ljrrOKrB8gzUXeidOCmG5USm6FoswZfpI9z/69uNW+JCxTGsJGBcf9PWlpfBGiO5lAawqbxojnAR5er75Y2C00j29XtWOPCRItWyNLtN/F8YIg+Z2Tnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZmYMt3v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZmYMt3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8425C19425;
	Wed, 22 Apr 2026 16:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874465;
	bh=GioqcjyAYkzeNaoaWV/yTLAqCcEigQz8/u7cr2rMnc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oZmYMt3vSkz56Z8rLpH+K90dmXwn4BUAeWHGiJ3ndH9Y4yMhWvUGb+dlqqmuv2Mr0
	 9PgI21cgFqzb+orUd5x7KUqBuAFX6vnVlqWob3bKuNa0hXlzfsVm+dOmQ0TJa/ohG/
	 s56wRDye0/px4B0LpXxk9LnKOP6ichgChl4igX/XjycyIxfCPKeynyVf22UOhugUmM
	 WLtaz5Yxzu4tsjV0z+TdTwwnHc0eHgj86rPbDuMxacRAIkrRzQgaZ6mENEbQf9YAPk
	 XQnWfjdaZwucRFoHTGHMJdgmH4Fg5jpmv8iScWI1UJkfEA5hFShfmk1SIWZ6s12Y08
	 bwjJJknO5ptcg==
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
Subject: [PATCH v6 04/24] PCI/sysfs: Use BAR length in pci_llseek_resource() when attr->size is zero
Date: Wed, 22 Apr 2026 16:13:47 +0000
Message-ID: <20260422161407.118748-5-kwilczynski@kernel.org>
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
2.54.0

