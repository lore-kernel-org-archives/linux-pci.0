Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948393BF67A;
	Mon, 27 Jul 2026 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785137453; cv=none; b=kSD6DAu4LIMUD5ksgKMVi4Lsx1dLNWcXFDbkrTfZhA2cv/2w41DQ8wvQPU8I/qaXQhqy9ObrLEFQttzA6WtAruthedQbbLBMuNDUVVLwpXOYWAZS+OpZqQPAxSj/sXY8w6mE1C2PVMmpj8nd082AybwfFys23ApyXLpCkpfRlRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785137453; c=relaxed/simple;
	bh=BN/7u1RDhzaBoj3z0ngQA0Npsz4l1E2CbjcfMpZTLnw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aiw8YZSvJhJiNmS7vvBFzOHDndVW3BYOCmHGKGbmHqEXz4hScHzHY5mZHFyyhYvuOooEHIehtWUXsCujZfMJ/bB3WlqopDMBaT3gmsqOXG4xihrJhA29QB4BAGRc7iw50ErxW/KN2XAShXZ83ASKuZmQch2YJlmBGfdH3yPJqUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VHTn9iJl; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="VHTn9iJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785137386;
	bh=FFmKn3srqN9rwRnEYG7Yz6aJ0/DVHKEC8icXnph+wOM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=VHTn9iJlvlTxPiccOBeZIQQFJ4VPYhvCzF634ACyaqJhmSainSJLs56xuKtMKuOmv
	 f2p/L8lYOkeWC3NFDY4OdEgEcquC806c/bZ4DaiecVmefciQuqW++jitQaNLOnzfK0
	 TfhyW0qgLpIuvaD0UBQXjw33tw+W5IkWmsEEhaoA=
X-QQ-mid: esmtpsz19t1785137366t81e73029
X-QQ-Originating-IP: O1M4ZhG6VPEZLQf0pBEBu847WFBtxu8EBNKTyWPeYgg=
Received: from localhost.localdomain ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Jul 2026 15:29:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2899203314501623827
EX-QQ-RecipientCnt: 10
From: ZhaoJinming <zhaojinming@uniontech.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Kees Cook <kees@kernel.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	ZhaoJinming <zhaojinming@uniontech.com>
Subject: [PATCH] PCI/ASPM: Add missing NULL check for link in sysfs show/store callbacks
Date: Mon, 27 Jul 2026 15:29:15 +0800
Message-Id: <20260727072915.3954329-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NMuAyYK0STFJT+aHUXdvekdaZ1kprQSUdupyMBYVLJSINiBXKuG8CBvX
	z2NemZg88iRSG41SD8x1i/soiJx/wFV5xHUS7AQmz56wx9XBk44/+5BlLVC4H27CcbhC2GI
	YEcacwgXTjOv73dVF/aVkoSaP1TTXewDNNvZJvDDCOF1MV9DOW9nBWZBByTkgTgMXq6ZdI3
	T/5UgzwaveP0pB1smcl4aI2ltFUOgNCgOxcMWf8O3GfnyfhSrC+aIcUcQDVMCkzquqXOxg9
	nQyLFYd5CYI3+1h27eHrrA38XJeVIuTvANgTCn7IqKOCxKbaFGiMsj5U+9OHryb5IbEg3Jz
	BJe5GdGbiRcp3xsd+RIssr8HO0FB3yZdw8v9xGUhFwIfZYMnGLqVs27Lk19mwY3SGPUP9oc
	vGM/Ugy6yXjnOcwWdujgnJfB83DxeBwMwDGWddYgvw1ZHdJTklueK0YVYGllaF4So8jbI62
	hUhZuImxGUGFcz8XpfnvEVgoZO8ttgilyxYbQOzjeJ0ZYwwWfnIVBTp4nQzGa+9cxzHGsL+
	Lo2oo5J1q6A5yvauRtHyxNI0CgUQXvq+cS3icL1kxRuw14xbG/m0OrJ5xEvwiFBq0shyHaC
	YiEYt2wYbp5QanFKX/sD5B0/30FyLBi42lEU5bXpwSt0YNz17AHxH2OqbLpjStf8QSzXOVD
	OOYvmEIW2q7LGCawL1259p02Yrilkuoj6Ml1PdisjdwdGl4uz3De1B32kg3/PjhUxutTUH+
	x4Gvw9OHwBNoju0R4MHg0a3flN7aTl8IEQrVQr96iJRsF3MBiOhWtMeX6wsnfs0omyowtJ2
	5SL22i8gh0dQcoiPU/StD9mD9ghjjVfFvw8t2mhqAPeDB/a5pWK6Bz0NBIv1aPh4k38bO6c
	S8upuZH2YydBAO+OOtm14cf7mD3NgdFiz1IDuOnvsW8h0qpp60ByTjMZE/pYtNfAs+OtJ/F
	6ZoDlSk4sMlurd+/tw5y6r7pIO4JNuZ6KyYzZWWDaVhudAV2Ney3IpeoT0/pFZgl6HpfS9n
	u5INQNi4JCf1SK3m6ujarRM4ak5pIlv9jOdL9UtQ==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

The aspm_attr_show_common(), aspm_attr_store_common(), clkpm_show()
and clkpm_store() sysfs callbacks call pcie_aspm_get_link() without
checking the return value. A NULL return would indicate the device is
not PCIe, has no upstream bridge, or the link state has not been
initialized.

While the aspm_ctrl_attrs_are_visible() is_visible callback already
hides these attributes when link is NULL, add the NULL check for
defense in depth and consistency with other callers of
pcie_aspm_get_link() in the same file (__pci_disable_link_state,
__pci_enable_link_state, pcie_aspm_enabled).

Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/pci/pcie/aspm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 172783e7f519..108d151a786e 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1654,6 +1654,9 @@ static ssize_t aspm_attr_show_common(struct device *dev,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 
+	if (!link)
+		return 0;
+
 	return sysfs_emit(buf, "%d\n", (link->aspm_enabled & state) ? 1 : 0);
 }
 
@@ -1665,6 +1668,9 @@ static ssize_t aspm_attr_store_common(struct device *dev,
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 	bool state_enable;
 
+	if (!link)
+		return -ENODEV;
+
 	if (kstrtobool(buf, &state_enable) < 0)
 		return -EINVAL;
 
@@ -1713,6 +1719,9 @@ static ssize_t clkpm_show(struct device *dev,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 
+	if (!link)
+		return 0;
+
 	return sysfs_emit(buf, "%d\n", link->clkpm_enabled);
 }
 
@@ -1724,6 +1733,9 @@ static ssize_t clkpm_store(struct device *dev,
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 	bool state_enable;
 
+	if (!link)
+		return -ENODEV;
+
 	if (kstrtobool(buf, &state_enable) < 0)
 		return -EINVAL;
 
-- 
2.20.1

