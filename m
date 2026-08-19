Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2690306744
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143448; cv=none; b=Vn3Mj6NBENnBSdYDN2iwmnfYxkQ4hir4gTHyo/e2KX/QZl0kk96We7jeCLTO/N4wi68eQZwZ7dGHVSalOe76lOPjcV+zGw27m4OKaaZtKeV+6UAmyzVOsYpKvFiqEaMj15F3ox2/xCeH3r2R1xiAqVsAiWeT3nDQlQNXhmki9z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143448; c=relaxed/simple;
	bh=W407ChCnhP/v+ZGkJQPC1qqf5wL2ia/l4iQolLSkd9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mE7WZsQY6KLn+fY63d7GCR6A7EmtIJA8WOYRPj8b1fQoTzaj9sIaWKIS7W1KWsBg2TSLNBRZ4shKPYZV41CfXlse0vB/nq78qNQ4/bpa3pCyZBP1lWad9iicJkTee42Nh0AnifPDWeD+l1Ir4Lu8huq9FY+9pAlqMiEjqiOgRPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UirvIaOL; arc=none smtp.client-ip=209.85.208.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UirvIaOL"
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a1e3cfc8d3so962822a12.3
        for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 05:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787143445; x=1787748245; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9C0y7TvBKpzQlhXfTgiBd4YtOIaPrxO67kIoX8b8oug=;
        b=UirvIaOLD54sFxmQAWnlN7jkz06e24VOwYrb2HObsx92DT7actarRvyhDZLxNe5fW5
         YKlRCFcPhs6xE8L39k/6oNNG/zYNGPpSAhp/MXr8IWliiko46fJafk3ZrycNGkgpMtzS
         D5lcSU5Qqs+/JX5lsTq6czx42BHVfS92KiyU5HI2AZYgcpaIcCzoraCQsZsZRt+dIhOy
         M0W73KCsDP52ptASZq3vck6LSE21zsV/LWfgqfTrQiD6nbEoiYCofgMYg4LlVc0rcRXX
         IphYghAX29QZb/l22NtcnaUZTs3a/9RoRyYzvovHzDFKsRDsC/APY9VDR+4u8/+eYVd8
         k9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787143445; x=1787748245;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9C0y7TvBKpzQlhXfTgiBd4YtOIaPrxO67kIoX8b8oug=;
        b=ltOxuKDPyfcciqxA7k83JSI766ncpXXIaEOkKpnCFgJ0kZFChZJWtAbZzEwUlbPnLf
         UnbZ27HqP1o/r2igaSJpcZs1MLFQQF+6Mt6jx+M4lJ0fXLh+Ct/JVUb2nCaf2uvimaYt
         D9OV6UhaMzEyZkOZTQG28T9YQBTMeIXXJa2IUi+alrY2cWBOHPFgsV3xwsZMnAsozNsm
         rtXR9/iRgbGo1+A3WGSigTzNKFsW3Mc+AxPRuIz/e0PErR9MMgCsqoRf1CkBW+7iZx7m
         qUa5tjsfO9lCcK6Tj/5E5MSU87RNb/5ov5Y+/RRypC70g0zfTEeIVq/uhNlR0OmUaAjx
         3K0A==
X-Forwarded-Encrypted: i=1; AHgh+Rrq19rAPNt7I2kma/M+UJTSpi8bzUmT/bEQfvBXweSWTDwWHqOVKf9QMDtoI1kXksThRyeVkrOthWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRPSIDXG+9jIbsTEqfNjHZEa/NXnU8sf/XGWHiHrJeg2Dzjrou
	6ls/PNcN2fU6gVTGbr4fA6Q0KP7+zGmzEqe51x1qsG3wlsmtzw1vET9WRu+40sDyjgwJAbnBGTv
	G9gpW7w==
X-Received: from edsn13.prod.google.com ([2002:aa7:c78d:0:b0:6a3:8183:78d5])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5298:b0:698:6084:db7f
 with SMTP id 4fb4d7f45d1cf-6a4032f21c3mr2807598a12.10.1787143444457; Wed, 19
 Aug 2026 05:44:04 -0700 (PDT)
Date: Wed, 19 Aug 2026 12:43:41 +0000
In-Reply-To: <20260819124341.4185621-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260819124341.4185621-1-lrizzo@google.com>
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
Message-ID: <20260819124341.4185621-8-lrizzo@google.com>
Subject: [PATCH v5 7/7] PCI/MSI: re-enable conditional parent mask/unmask with
 sw moderation
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Recent commits removed masking of interrupts at the PCIe level when
the masking is also done at the parent (e.g. on ARM with GIC).  This
optimization saves the PCIe write, and especially the expensive readback,
but causes the device to still send MSI interrupts that are ignored.

As a result, it very harmful on platforms (many, for multiple
architectures) that are unable to deal with too many MSI interrupts, and
defeats GSIM (CONFIG_IRQ_SW_MODERATION), which is esplicitely designed to
address this problem, but depends on masking interrupts at the PCIe level.

Revert to the old behavior when GSIM (CONFIG_IRQ_SW_MODERATION)
is compiled in.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/irqchip/irq-msi-lib.c |  8 ++++++++
 drivers/pci/msi/irqdomain.c   | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 45e0ed3134ce1..453a5d5a2c106 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -116,6 +116,14 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 	if (!chip->irq_set_affinity && !(info->flags & MSI_FLAG_NO_AFFINITY))
 		chip->irq_set_affinity = msi_domain_set_affinity;
 
+	/*
+	 * The problem addressed by software moderation depends on actually
+	 * masking at the PCI level. irq_mask() can be optimized separately
+	 * for the common cases outside the move/teardown paths.
+	 */
+	if (IS_ENABLED(CONFIG_IRQ_SW_MODERATION))
+		return true;
+
 	/*
 	 * If the parent domain insists on being in charge of masking, obey
 	 * blindly. The interrupt is un-masked at the PCI level on startup
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 6e65f0f44112e..44b022fee7f1a 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -80,6 +80,22 @@ static unsigned int cond_startup_parent(struct irq_data *data)
 	return 0;
 }
 
+static __always_inline void cond_mask_parent(struct irq_data *data)
+{
+	struct msi_domain_info *info = data->domain->host_data;
+
+	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
+		irq_chip_mask_parent(data);
+}
+
+static __always_inline void cond_unmask_parent(struct irq_data *data)
+{
+	struct msi_domain_info *info = data->domain->host_data;
+
+	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
+		irq_chip_unmask_parent(data);
+}
+
 static void pci_irq_shutdown_msi(struct irq_data *data)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
@@ -102,12 +118,14 @@ static void pci_irq_mask_msi(struct irq_data *data)
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
 
 	pci_msi_mask(desc, BIT(data->irq - desc->irq));
+	cond_mask_parent(data);
 }
 
 static void pci_irq_unmask_msi(struct irq_data *data)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
 
+	cond_unmask_parent(data);
 	pci_msi_unmask(desc, BIT(data->irq - desc->irq));
 }
 
@@ -160,10 +178,12 @@ static unsigned int pci_irq_startup_msix(struct irq_data *data)
 static void pci_irq_mask_msix(struct irq_data *data)
 {
 	pci_msix_mask(irq_data_get_msi_desc(data));
+	cond_mask_parent(data);
 }
 
 static void pci_irq_unmask_msix(struct irq_data *data)
 {
+	cond_unmask_parent(data);
 	pci_msix_unmask(irq_data_get_msi_desc(data));
 }
 
-- 
2.55.0.737.g08866a6d13-goog

