Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FD4372B3B;
	Tue,  7 Apr 2026 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567162; cv=none; b=J/at1MzhuZ9FpTcvhdH4KuoB+UiApv/OnaC13l9TYzMZkVhN1iUNHU5+A1gArM8Sw3Xg227RNToPbNN/ly7soJ76DWleq1fo/OiUk2LfM++eTVpeui9DkGNvzmZAcobA4FWIERNp4Sjwqbd0/H7nOB0khlLrPOHnJMz9WNUohws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567162; c=relaxed/simple;
	bh=7yrnFa4LypoWmyLoJMHns6rimbkNQJbTMh4i9gJyCN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WbTojsMME2184KGnI6yq4riZ+wiFwsvC7NFCXlYCg7+M+i+f86kDY3QFjg8IGj0GMu/4DKWArNaq/cnt2oGwUidhUrQVkkRzgF6bI2fmfePi45hULeDcWkD67Pp2YREREz+2mlOkcTq4YiyNaC+iAqsKUVL5LSfgJ8ew6gO8evQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=J4SjkdJf; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="J4SjkdJf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=7A
	g8f/lEAoiqX1Hou+dDPidModpR0G2RIZx73bt52bU=; b=J4SjkdJfZXT9nyIXX9
	FzTogPSRsDe/ZJT0i22ZzulGrs9WwKEM36R/Ns2V07peHM5iEUqyBtsMk2AlLxIq
	MPow0ZyDyHkwr18SofHxEsQNeFQAgxzrMNfWpL3je06XZLi6QOqJgreuWOTyyH5L
	iINLoi3o8eJpLGfJz/ssPV7O4=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wC33bQHAdVpBqSeDg--.5276S3;
	Tue, 07 Apr 2026 21:05:14 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	kwilczynski@kernel.org,
	mani@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jingoohan1@gmail.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v7 1/3] PCI: Add public pcie_valid_speed() for shared validation
Date: Tue,  7 Apr 2026 21:04:48 +0800
Message-Id: <20260407130450.1489318-2-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260407130450.1489318-1-18255117159@163.com>
References: <20260407130450.1489318-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC33bQHAdVpBqSeDg--.5276S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW5CF43uw45Xw15Cw1rJFb_yoW8Ww18pa
	yDAa45AF18Aa15XF4Dt3W8ZFy5WFZ3JrWjkrW3u39xZF13A3s3Ja43tay8try2qrWIvF1U
	Ja1YyF18Ca1jyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRsa9fUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6woStWnVAQqqBQAA3e

Extract the PCIe speed validation logic from bwctrl.c's static
pcie_valid_speed() into a public static inline function in pci.h.

This allows consistent speed range checks (2.5GT/s to 64.0GT/s) across
multiple drivers and functions, avoiding duplicate code and ensuring
validation consistency as per PCIe specifications.

Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/pci/pci.h         | 5 +++++
 drivers/pci/pcie/bwctrl.c | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..f0a082bfd6f1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -606,6 +606,11 @@ void pci_bus_put(struct pci_bus *bus);
 	 (speed) == PCIE_SPEED_2_5GT  ?  2500*8/10 : \
 	 0)
 
+static inline bool pcie_valid_speed(enum pci_bus_speed speed)
+{
+	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
+}
+
 static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
 {
 	switch (speed) {
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index c4c8d260bf96..ea82e326f164 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -48,11 +48,6 @@ struct pcie_bwctrl_data {
 /* Prevent port removal during Link Speed changes. */
 static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
 
-static bool pcie_valid_speed(enum pci_bus_speed speed)
-{
-	return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
-}
-
 static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
 {
 	static const u8 speed_conv[] = {
-- 
2.34.1

