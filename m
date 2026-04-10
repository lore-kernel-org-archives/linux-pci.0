Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0A030BF5C;
	Fri, 10 Apr 2026 05:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775800280; cv=none; b=NWBLnTeV82EnHWUVOB8FTuuZvQ9CNNjLHBu3wVHk8WcJ8q8jqo/LX140obaPbK9wNIdfgp72o7z5UF5ZwIKhHz7f4wgYH+zKEQxkA+CnawTA69noRI1R3sfr/8USijJPbRHCHV1+jHSQyekx8F1g6WWHaLeabA2edqcXv165Xg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775800280; c=relaxed/simple;
	bh=RJIbkZ2vyHUaEoq5eiCMqBUxiew4KtMmfoufXoK9vfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXBuMrf9UBgMVAmvSuZmBhtHpalcimnvQh+U4BKZb+JlK3QswUzMHFpZwXB6q9jAdx2C5e9phaw89cyFt13n3GCuIwSw2wfv/iZyAHCt2F0I2Zba6vxq+xVoFhzUVv6ttS9DLZRz7aG86KandO3a2QMcEBjJp+C3eA9DQzGD9YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liCvDkXg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liCvDkXg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD2EC19424;
	Fri, 10 Apr 2026 05:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800280;
	bh=RJIbkZ2vyHUaEoq5eiCMqBUxiew4KtMmfoufXoK9vfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=liCvDkXgv7IA7HXmjFq8dJ0WMbYu6MZvNqB4kiD0BSaMgAPd/2c2zB2OX9kHJ0ATy
	 W+PnIPy3kIG686pSrdTPCUcgVjtAkVa8Oh0JtY0Z+wMgZyuJGoUqxYFKX5yxKhvUeT
	 XXpIHUgpXZsp08QWBXesvroou4mvzJgHjvboX9BSjAWUAko9ZP2LtK+gQCIlHo2G0x
	 FTfMh+sPelY4HKAsauSsunCiWVGWmcmtN25ky16oOFQbBeldoblTxD5NQulR2WvUxy
	 N0Jk8jQxi1XZldp8ovRL1OlUzUz6l6biiioMY4LkFVC0S2Dvy2Mu2w4fKRmbF+bwwz
	 Zwoesx3LRDWMw==
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
Subject: [PATCH 10/20] alpha/PCI: Add security_locked_down() check to pci_mmap_resource()
Date: Fri, 10 Apr 2026 05:50:30 +0000
Message-ID: <20260410055040.39233-11-kwilczynski@kernel.org>
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

Currently, Alpha's pci_mmap_resource() does not check
security_locked_down(LOCKDOWN_PCI_ACCESS) before allowing
userspace to mmap PCI BARs.

The generic version has had this check since commit eb627e17727e
("PCI: Lock down BAR access when the kernel is locked down") to
prevent DMA attacks when the kernel is locked down.

Add the same check to Alpha's pci_mmap_resource().

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

