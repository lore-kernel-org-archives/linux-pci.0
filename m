Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FA033DEC8;
	Mon, 28 Sep 2026 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612297; cv=none; b=ons6SBUA9f4/nZEb+t9cLbygBUpeTWt7Ad6RPkwZDHaWFEj7ZM7J5basNqCSB9pyaCbKyCNI44edaUfNP3DHC5Tr+p84x1rjf4es7grV1Y7HDkAAoxERqEH+/v4A9Uifz+W+c07QLJO0HxQt6JXUO2yGuUf+WFjRmntIhS2Deng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612297; c=relaxed/simple;
	bh=8lB/L25BR0WqiPJRqoFVhhskoHCDIdGlySOme8stKQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oLRXVj/X8L0Qnhw3DoVsv7k9QG/HFKJqiQNfZcSjiSeNTSfL2RH+tlRdNVFWUwkh6y4x/5jcwN1AUWTbDS5pFoe5/AN5EhAWGAgo9SqiJqBFYyruCJ4i1vXO3rnYW3pVq98pdAAW9lWaq5ZF/0DINFy67z70kIIUaGE82UFX4+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5PO6l9V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5PO6l9V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78511F000FF;
	Mon, 28 Sep 2026 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790612296;
	bh=XTBPwNyPvxdYakQHXtSdu9252oBFhwM6n0M7vu0bEyU=;
	h=From:To:Cc:Subject:Date;
	b=E5PO6l9VMyxNWta8oi4xBRrE+MmumR85+jKa+mJUX651NH+P4VHFdLDJA/pfN6dbN
	 LSG8X05HjxHpR4wceAN2ZV9gHrfD4ybbU/i1Lwdfp6WnYlCTaExA5YUb7ReOn+8P1d
	 /ROQye0H0HR6ysCfICy9Z6oV4nDXXF07mdLqBw3dOh5TtaFnB9lHGxoYrRUnJ8uVI0
	 UluNpfi/Rrul2S1XL14+Y+C0jvyJdhPotct1YlVeWfDdhU02sya6XP7aqCd+8L5x5o
	 HTzLe3Ao1cKfkPDvADyaWt7RX9TwsMcKtS9miG3L4wnYyj9n+bHxE5CwM8ZDYT289y
	 E4Igj/9zqlLbA==
From: Arnd Bergmann <arnd@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Odell <loganodell@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dan Williams <djbw@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	David Matlack <dmatlack@google.com>,
	=?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/IOV: fix building without CONFIG_PCI_IOV
Date: Mon, 28 Sep 2026 18:16:39 +0200
Message-ID: <20260928161811.2846627-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added code dealing with virtual functions causes
a harmless build warning:

drivers/pci/probe.c: In function 'pci_class':
drivers/pci/probe.c:1902:12: error: unused variable 'rev' [-Werror=unused-variable]

Move the unused variable into the #ifdef block that uses it.

Fixes: 8a2a9fa37b81 ("PCI/IOV: Read VF config values that need not match PF")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 833ce364f880..1ff07c592857 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1899,9 +1899,9 @@ int pci_cfg_space_size(struct pci_dev *dev)
 static u32 pci_class(struct pci_dev *dev)
 {
 	u32 class;
+#ifdef CONFIG_PCI_IOV
 	u8 rev;
 
-#ifdef CONFIG_PCI_IOV
 	if (dev->is_virtfn) {
 		if (pci_read_config_byte(dev, PCI_REVISION_ID, &rev))
 			rev = 0;
-- 
2.53.0

