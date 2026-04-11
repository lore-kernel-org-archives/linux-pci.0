Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4011223C8C7;
	Sat, 11 Apr 2026 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775894552; cv=none; b=WsniJRAidsL1xcuG8eqsBkZJy+Z1c1GurSub37MGdVloC5/v1iefYnjrdY3Oprab8sDSdBlIh0yfr8TSrxxPWZhNqHCNwYyol+KEainPQACNK7SWE7SGXItGEZkbgNAjB9/Tn9Rp6fvK5LSYWSrnGnGuPZaXkA5bSWlMyNbdMmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775894552; c=relaxed/simple;
	bh=hnKN8ZM0yGcrm2yNmaVqMKt5Sul3nxMsmvK0n61ign4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=biF5hPyvguQUHEtUW1gfc5J5ksx2TDUenArvbn08tuPTmnJ4dF1tGJkiLeRhPsLnk3Ye2m8PJotnfasWFlzx7dHoily80wwZR7DGapj8DAsxqx1pPCwyQ3ldT3KyFw+AHgqc4VH8lOu8mnPjO02/3bL0sGHJwd0HCM1XyilCzio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7dA5Uu+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7dA5Uu+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8495C4CEF7;
	Sat, 11 Apr 2026 08:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894551;
	bh=hnKN8ZM0yGcrm2yNmaVqMKt5Sul3nxMsmvK0n61ign4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K7dA5Uu+kcIZ1LR3asshfBY0oE0RRywbGafj10BdAHCu3m7lmUm20cgZkVbN7m5CR
	 77UVnfczgyUo3XiAirellX7MXnjNIdx8TWFqhroxl9NVChwlSLNnhuTez3nYEEJIln
	 sJoXUK6QouEY7wc8jKRJ+GJBQgfVI/McQLbGSusMruJ7ridohWDZrNJLN3Nxh38g+E
	 fc3vrGAPWuArKL+ML3Q/AgCofeQGCtGrctUaRY1uXUAPMAGAkt4A0v62BH6Ey+3HOH
	 26cuelHVDqXOZn24E0uD8kWVn30VkwPNxc6IdE8Bou5ncsHK1n5kSnIiTfPWdQ8MZW
	 VAf16PnabcDuA==
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
Subject: [PATCH v4 11/24] alpha/PCI: Add security_locked_down() check to pci_mmap_resource()
Date: Sat, 11 Apr 2026 08:01:35 +0000
Message-ID: <20260411080148.471335-12-kwilczynski@kernel.org>
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

Currently, Alpha's pci_mmap_resource() does not check
security_locked_down(LOCKDOWN_PCI_ACCESS) before allowing
userspace to mmap PCI BARs.

The generic version has had this check since commit eb627e17727e
("PCI: Lock down BAR access when the kernel is locked down") to
prevent DMA attacks when the kernel is locked down.

Add the same check to Alpha's pci_mmap_resource().

Fixes: eb627e17727e ("PCI: Lock down BAR access when the kernel is locked down")
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 3048758304b5..2324720c3e83 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/sched.h>
+#include <linux/security.h>
 #include <linux/stat.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
@@ -71,7 +72,11 @@ static int pci_mmap_resource(struct kobject *kobj,
 	struct resource *res = attr->private;
 	enum pci_mmap_state mmap_type;
 	struct pci_bus_region bar;
-	int i;
+	int i, ret;
+
+	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++)
 		if (res == &pdev->resource[i])
-- 
2.53.0

