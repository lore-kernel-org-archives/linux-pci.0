Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D1413D8B1;
	Sat, 11 Apr 2026 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775894584; cv=none; b=BZF3nvwQTSWRvVqEuWsCqxnsT+OFy2JmCWG1nvY6/tvluxLvV4KxZlUTJnJGKhYTNPRlREWKKshF6reilte0DXN9+1a49dNlJyvwDDe5iSkt+tPsjeUjhHNSjZMAzIeM9ZwReCEz+OV2V5g3u50kXMq6YNo3Fob0C0Wo9NY+L50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775894584; c=relaxed/simple;
	bh=NQbD4J4pW0nv3pRn8qOen291nD4aqRAslHLpEUCpmsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G65yy/4dSREeXzmraW1yNWw/xhH+YMP5v6VqJvwNdHXLG5QqECJC8jjAuEBckqU5a84cKu7k0bQdRpKI26vmoCp1pUNyN8d7jXTShXcRpI0rApGxNZ1aaUVnktEi0c8Ic3KYg1tfeVnCrQR4n+qaRztqyMs/Qg6yeFkKKLO40Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iX1XxyzZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iX1XxyzZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5784DC2BCAF;
	Sat, 11 Apr 2026 08:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894584;
	bh=NQbD4J4pW0nv3pRn8qOen291nD4aqRAslHLpEUCpmsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iX1XxyzZtqKzCL0ahK6AWgElhHPuPuyOHWa9d/+HOFVVKtbjE+xKwnc0JGVFFLZ8h
	 N5pvTAHpTMoIEv3ymLzCrp6eiwk0R2BHfp4FW+ZaDechXPTyPrXsxKz0wojLeRWwHz
	 BfzUV5hPFQV91mdGJ26GqPI4l+i49qltuKoVztpsspn3O0pnEfXGMKchfD9byZxVuu
	 IvuVZhg9ZGGLQ/UBAHs1emg57SVYqT0zD9nO3xLt0oMIlDHyH6M84s89QT0+GcMFQ0
	 9tL2aRe5NmkgbluWEFs/Swg9MNFhd702pNoHgCGvVbg5obXy8s4AmKhbPpxLywC5Ub
	 YN3oxfhwowR7A==
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
Subject: [PATCH v4 20/24] PCI: Add macros for legacy I/O and memory address space sizes
Date: Sat, 11 Apr 2026 08:01:44 +0000
Message-ID: <20260411080148.471335-21-kwilczynski@kernel.org>
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

Add defines for the standard PCI legacy address space sizes,
replacing the raw literals used by the legacy sysfs attributes.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 include/linux/pci.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index f6f55005f82d..6b630bac8c08 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -27,6 +27,7 @@
 #include <linux/mod_devicetable.h>
 
 #include <linux/types.h>
+#include <linux/sizes.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/list.h>
@@ -1167,6 +1168,10 @@ enum {
 /* These external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
+/* PCI legacy I/O port and memory address space sizes. */
+#define PCI_LEGACY_IO_SIZE	(SZ_64K - 1)
+#define PCI_LEGACY_MEM_SIZE	SZ_1M
+
 extern unsigned int pci_flags;
 
 static inline void pci_set_flags(int flags) { pci_flags = flags; }
-- 
2.53.0

