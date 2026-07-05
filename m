Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5FE372B39;
	Sun,  5 Jul 2026 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289321; cv=none; b=niRUjHbx+LPWU9gSmL425JVt6TL5pqnl87oSWHX09w41siWxd0HpxML+CiRYb7XoCMQn3mMBZUlGRTaMguXobGw4SLpHG0h4s4ACL9CQ5V+lWdGVQtnExKKOyHa8Q4nYmG0iyw1n+iOY1livedKtsuCwjYcenXpeu1v0tbjBcKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289321; c=relaxed/simple;
	bh=jOgsQtJb9rUn6vfB6spUyKYRCkRH2ploCiLEW7BcnFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TL8dfkJAxS3pIbZQAEoTTgBc8sgCNZZ8LWGHKiQTgmjQDOMGsNIcSbBylcnC8f4JRsQSwIMhTUl7eOpnSQFl2sVWJCvYv5nY/KHeTurnrJ4mfeFwsr3GoBLdQoR+R112LzLrc06XkrkxS27x9JaC6u6CFVRgCLKoM+6a0eANTT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPeBOyYg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPeBOyYg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871AC1F00A3F;
	Sun,  5 Jul 2026 22:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783289319;
	bh=x9ONkZn0eLV5YFBxTtcmqqSNGprGGrlOYOwavfsalM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JPeBOyYgoY6Qf7oq9R1MYW44w3dKkv+LmUo2mlaP+i+6Iq84CKP+yBzCPBf7l9Gek
	 g4b8Mag53w+5I2jk/C4aLyzJwz9/5nFbxEUs5CI5agx5H4XT/CvPcXVbpg/UIIZIqy
	 kCfJnI75lOT+mFHcesVWpCrkV9O7YeTkSaofx1eCTnTmXmyH0P04RLku1pWGzzo9Hg
	 ynxqWtkUf9TZiIg6OzScH1dcxuVmc2qWf2BVtRBYUvidZArL79QwLQ7SnA3WsIHePp
	 At3ypeze77TUiM/B++FPCSLV71+2CyiAZAsVyokUyGkPB7Bj8tM78v0dv0y9mmnZqJ
	 Ha7kW9cH1Lx8g==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id C4845F40068;
	Sun,  5 Jul 2026 18:08:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 05 Jul 2026 18:08:38 -0400
X-ME-Sender: <xms:5tVKai6wCBR2jE9mUzwhZ0v-S9f7YWFdXwmBW6IkdyLjsmgjOC9Wjw>
    <xme:5tVKaoc-MBzq-1NkCo5pxqCMFpyN845v2eQFJTppnU8jt4rxGKssJlYM21md1TPz3
    l6FQZoqvtYUB5gUz-gDFPVxeHV73VQru06L1D9_6wIs-57PcEBAo1g>
X-ME-Received: <xmr:5tVKal4i0oK1JPsu2HbDj77Yv5yrG8bwDXkw2klKOKKh55Mgsn7xMj2Nqfr6gzVzfWLJrxFj4ccoUF278xfmkPb58uMouuihjRw>
X-ME-Proxy-Cause: dmFkZTF2CxcdmwrxebXR8Uh/8f3SerSR2w8QdVVWHW0lTOM4kjOx43dTqdTDftqfkR60cV
    MsZyPY8IXH8m6Ngg/GEn4C3L7PoKWyVwrnB+saarm/xrr0ZxLu7TOhv8oAnf6nwBkP1CPZ
    wjLXFjZfJWNk1DGlyNlrpryGruoFCwL7K8bLeVBzIWXnU2v+g8Zlrzl1e9iRPahhWhsFzR
    mAKIqB9+Ell2b9o0Iqc1BMfVbakPv24ahpyfz6xsKzJ4pafJr87TPN6odcA/agu2TGfWvh
    +Oavi2rrivaN0zlQLjFScRTKtGixCNmpyrHe0/w0yM3jstiRKhcVz53vtUwBb1DxQFolsS
    oJe3SqcV0x+7Cql7Q3+1u3kr742UEzQi7RKAcFEARVdq5CQ1xVJzyYWeTqVR4m/P8gqKhn
    I+vN937u78ZKniLshS+BdOxnKche4sfOym2ykVx/9xn+HZQqg+rFBVVogQzKSIqHcbGT2J
    +G1rUhpuZJD7nQb1GjCkjuZxSqmgQTOfcshk71UB5BII5HzhxNOwsN5viBcn2WIQtFOTw/
    NF2xS6EzU6dHw34E4FRPg3C/figugC4CiYuwqtkAQA3gcdMwEASEV0CHGoynjII0g+jJPX
    OZmNhqDnDUz48x6fUfmq25md1MDpGSKfbCF2DBX5Gq8Kjr4cgIcdpshq0oHA
X-ME-Proxy: <xmx:5tVKal8XduGQePBLCE6fzBmn5TX7D0AzETuRl8Dx7CqvGHfDzwbjlw>
    <xmx:5tVKanEl-WF-6mQNgtTW_thSF9YWc6UH-fPhYaLksQPh6a7KHqa4KA>
    <xmx:5tVKaqXu5ul1zf4ig-OpUUcP5yw9KkjDKvNKe4FF2NZAzsSKF16KGw>
    <xmx:5tVKaj9DmLt1hexm7N29ZwbNobgmwf4SFWn51MIjUEQ1cz-ZhMfKLA>
    <xmx:5tVKan5MxQ76M9R69A3AGDFGS5B-KD0s1Okf8NcGosWy6v5qRfDgnkHN>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:08:38 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev,
	ankita@nvidia.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Subject: [PATCH 12/15] PCI/TSM: Add device interface security DMA enable/disable
Date: Sun,  5 Jul 2026 15:08:16 -0700
Message-ID: <20260705220819.2472765-13-djbw@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705220819.2472765-1-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the device interface has been switched to the RUN state, the TSM is
still responsible for enabling the device to access private memory. Placing
the DSM into RUN state causes the device to accept T=1 (within TCB) traffic
to its MMIO address space. The enable DMA step has the TSM configure the
IOMMU to accept T=1 traffic to the CC VM's private memory in addition to
all the memory previously accessible with T=0 DMA.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 include/linux/pci-tsm.h | 13 +++++++++++++
 drivers/pci/tsm/core.c  | 42 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 371a7e300a64..397e5d8459cb 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -82,6 +82,8 @@ struct pci_tsm_ops {
 					struct pci_dev *pdev);
 		void (*unlock)(struct pci_tsm *tsm);
 		int (*run)(struct pci_dev *pdev);
+		int (*enable_dma)(struct pci_dev *pdev);
+		void (*disable_dma)(struct pci_dev *pdev);
 	);
 
 	int (*refresh_evidence)(struct pci_tsm *tsm, const void *nonce,
@@ -102,6 +104,8 @@ struct pci_tdi {
 
 /* Private operation acknowledged, future ioremap will use private alias */
 #define PCI_TSM_F_ACCEPT (1UL << 0)
+/* DMA access to private memory enabled */
+#define PCI_TSM_F_DMA (1UL << 1)
 
 /**
  * struct pci_tsm - Core TSM context for a given PCIe endpoint
@@ -247,6 +251,8 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
 			 size_t req_sz, void *resp, size_t resp_sz);
 int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id);
 void pci_tsm_unbind(struct pci_dev *pdev);
+int pci_tsm_enable_dma(struct pci_dev *pdev);
+void pci_tsm_disable_dma(struct pci_dev *pdev);
 void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
 			     struct kvm *kvm, u32 tdi_id);
 ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
@@ -269,6 +275,13 @@ static inline int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id
 {
 	return -ENXIO;
 }
+static inline int pci_tsm_enable_dma(struct pci_dev *pdev)
+{
+	return 0;
+}
+static inline void pci_tsm_disable_dma(struct pci_dev *pdev)
+{
+}
 static inline void pci_tsm_unbind(struct pci_dev *pdev)
 {
 }
diff --git a/drivers/pci/tsm/core.c b/drivers/pci/tsm/core.c
index 1f09ab4e8d4c..372363a39a44 100644
--- a/drivers/pci/tsm/core.c
+++ b/drivers/pci/tsm/core.c
@@ -754,6 +754,48 @@ static ssize_t unlock_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_WO(unlock);
 
+/* pci_dma_configure() helper to finalize access to private memory. */
+int pci_tsm_enable_dma(struct pci_dev *pdev) __must_hold(&pdev->dev->mutex)
+{
+	struct device *dev = &pdev->dev;
+	const struct pci_tsm_ops *ops;
+	int rc;
+
+	if (dev_WARN_ONCE(dev, !dev->driver,
+			  "DMA access only finalized at driver attach\n"))
+		return -ENXIO;
+
+	if (!pdev->tsm)
+		return 0;
+
+	ops = to_pci_tsm_ops(pdev->tsm);
+	if (!ops->enable_dma)
+		return 0;
+
+	rc = ops->enable_dma(pdev);
+	if (rc == 0)
+		set_bit(PCI_TSM_F_DMA, &pdev->tsm->flags);
+	return rc;
+}
+
+/*
+ * pci_dma_cleanup() helper to block private memory access as device is
+ * going idle
+ */
+void pci_tsm_disable_dma(struct pci_dev *pdev) __must_hold(&pdev->dev->mutex)
+{
+	const struct pci_tsm_ops *ops;
+
+	if (!pdev->tsm)
+		return;
+
+	if (!test_and_clear_bit(PCI_TSM_F_DMA, &pdev->tsm->flags))
+		return;
+
+	ops = to_pci_tsm_ops(pdev->tsm);
+	ops->disable_dma(pdev);
+}
+
 /* The 'authenticated' attribute is exclusive to the presence of a 'link' TSM */
 static bool pci_tsm_link_group_visible(struct kobject *kobj)
 {
-- 
2.54.0

