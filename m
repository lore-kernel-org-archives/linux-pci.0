Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FE834E760;
	Thu,  9 Jul 2026 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783627879; cv=none; b=E1E8cBlo8erXbEZkz5r8nJGjX7nvMX2EH6U6BMD01KTi3JIM0se5W6/hC8m8nB91+lUq6DxFVNqyQrwP/iM6by0Kd1MFvNVZoE+wVDC0Lx6I7Cb1jDo4LtS/ITuo1TzyRapdAQfIWlW6JYto9L0ilHDxU3SD6bJHEqDLQgFQgeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783627879; c=relaxed/simple;
	bh=697dOg9otW0jG2CIkQQbYlazKssUUzIfVc8/qYRWTBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qRqx+PxLyD7P7TkApZLiu3VmFCEjm9m3wSOac1Ue9FROr8VqYGwEzZpckDXKpDmStPWmrEEDh06nJJLL2VIh4Gwt731shHiqbI9br1fPq62vDE+M1xTktcNe3cOMPvrLVO/pXpCjSZ1JHVhjTvz0CmbLAqkvNGKcJ66C+sc1Tr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kTKLOhlw; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uIkgdiNH; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kTKLOhlw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uIkgdiNH"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gx5h2054QzMlG0;
	Thu, 09 Jul 2026 22:11:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783627874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y63+X/Dp2CE9yVCvl/H556o9pFY78+UE7i0NS2qgTOQ=;
	b=kTKLOhlw3dsSSCas3hT947tSt8hLZ7VuE67zkz08cCekv0sCG3XK+UWyejs4mZXm/va7Z5
	PdzXUQCODshhkZkBiwgPll1wKekhioHcvTUQIz9rs3CLR/ZdDEGSX/DTTbXl0zT5h/iHGN
	jbV1mFi1kStbkfj5O5/e5ObfZb3kh40msFybnVGzzry5zDXvxqcGVFQUKFpsYjzOjgrevl
	HyyRYodIxwP6J4Ht0a2+2zo0xHqxVHphGbGty9dqMdopKpBm5/P14gAkOr8bTZYqisaA+R
	A+zEv65aQk2Qb2EUlaiYo8r0C7sLkHE7RL31HoRfoQNDhT1ddd0m67wxpOPgpA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783627871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y63+X/Dp2CE9yVCvl/H556o9pFY78+UE7i0NS2qgTOQ=;
	b=uIkgdiNHZKtufAVbUtlD0aL5irzPN8QnGD6gc3U6mD9xmTsOzlYD6M8kNcqq+9lFU8WzxX
	vU5WAZxE9F75QicH1c667VzICAvmEF8hT49vrqjKaDYi7H0JWlHsHYmpNhRhEA9mUTuMzO
	2E94bRKN2g+6nmfBw8z0dUUc6OUZB5FmftpadY4IPB680c+Z7TaDjqWN7/lQV0n0B0hWXV
	uu5R1uYiTa6eS5Ei4LsnsKqtdybZYew9G+YV0B3A8uGPiho2zRYilhAin6GSbglylT48vu
	24ePWv1x7fGKiGtzNHgl1VuqeQui93ZpxmmOnqnjrKBKNdrHLdGbD8hxtdJKiA==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	kernel test robot <lkp@intel.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: rcar-gen4: Inline GIC_TRANSLATER offset macro
Date: Thu,  9 Jul 2026 22:10:03 +0200
Message-ID: <20260709201103.90162-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d77ea4e9cdf5251e9bc
X-MBO-RS-META: 5e9qh5qrbhxy7cjhaabxdnijm8n14tk1

Instead of pulling in the whole linux/irqchip/arm-gic-v3.h , copy the
one GITS_TRANSLATER register offset macro directly into the driver.
This repairs the ability to build the driver on non-ARM non-GIC targets
the way it was possible until now, which retains good build test coverage.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607100310.iQw5m9Uo-lkp@intel.com/
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
Note: The alternative I could think of would be ifdeffery which
      is not nice and thwarts the build coverage, or limit the
      driver to ARM/ARM64 in Kconfig which also thwarts the build
      coverage. I could also split off the register macros in
      linux/irqchip/arm-gic-v3.h into some separate header
      linux/irqchip/arm-gic-v3-regs.h and include that which
      might be OKish and avoids duplication. Thoughts ?
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 5f7211b91ee5b..4b75615c516f0 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -13,7 +13,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
-#include <linux/irqchip/arm-gic-v3.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -26,6 +25,9 @@
 #include "../../pci.h"
 #include "pcie-designware.h"
 
+/* GIC ITS TRANSLATER register offset in GIC ITS space */
+#define GITS_TRANSLATER		0x10040
+
 /* Renesas-specific */
 /* PCIe Mode Setting Register 0 */
 #define PCIEMSR0		0x0000
-- 
2.53.0

