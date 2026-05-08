Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413451EFFB7
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778272608; cv=none; b=IfiDOn0wdrWxysa7XAvxHv5TyG1Gc1vH8yyyuGjhcCMiKKJjtQgQZH4QlmOh653H2jE+4k/UdpfD1UkxCXTTZ5qrEU9EVd9M5mprSY0gxvlkI4bKcg8jmwrWl9t0098yJJslDe+QXA8pAf1ae4bHlUNbEXwEl8z2pUm3JLfCoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778272608; c=relaxed/simple;
	bh=r16uspIZznIhMXpG4T/bkzN1F3PDMKLiIzc6CunoQAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OP7tksFpGvNhmvwNnGsGIssPE1WaP5bzxt/NoKS0E+eSUi24O1R6oO0uTVvmul3s9dmMWu3zc+ev+mONvsrvTQSEw/APCJaJyiKyE9g+8vGLODbvxSZgKhf8sf/O1rZ8OuWwWKOcB8IgLP6Qp3ViHuxK2g+5wBN3wRXIC3zRDOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JL3ZJ39o; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JL3ZJ39o"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so6326911eec.1
        for <linux-pci@vger.kernel.org>; Fri, 08 May 2026 13:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778272605; x=1778877405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=it9s5SDS+9FA8rWlzgMlowzHbZDxtLnrq7mFV1fkn1U=;
        b=JL3ZJ39oRHxYbgVSZMAxGm2Fke9GB4gduf9FOIT8iInsuGmpoGHU5haJKHFO/p/0Mh
         Vc1RyaycpOw6bzgjR5S526NrkpjLlyUNvzzNPMqVrFxQh1w+sc5M4+DfipbFOhcBD2GB
         CY92TQ+NNh5og8L66Pdv7vGhQ1L23Hww5opjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778272605; x=1778877405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=it9s5SDS+9FA8rWlzgMlowzHbZDxtLnrq7mFV1fkn1U=;
        b=EP7tVRKDOnnCthTT6BWGUzuzbpwxNez9ek4cJ4Gbbnd+oGE9PECRZtFZfSfw36HKZV
         ojXQNMpb+4aOyt3rdXjp2mZwgWWwFLHC0nZxLS0P9Vopit4j2V6emGluHifzYnJRfWMh
         huem216wc4yC0pOzwSzUMmsLXfu0O8QkgIu3+Rk6Fu3jLKzCaI8GFn5nwh/c9fl26Yr5
         gHaw3AxWl4Bjq1O7eWFpXnyaZzM/Hqf1vEETAFR8MR7MuRHVkj88r58PydAVwcd0Y621
         pCS4u5iGLesaUn5GvFywK7XOYl6egoJY/I3IvHpfpu8gEJCuJB+QFJkNTUhyzOzS5oh4
         Wegw==
X-Gm-Message-State: AOJu0YxG9OewshDIye8nhBZHm+YMl1nAdfVVEKzjuC+nyzid7JvLf9Dp
	/s4gNnsZPQPQ2lkvhiCsIMtUN9CIiaKSVp6Ay4XC/4rMOTyIN5n0d/uqg/N/H4YGig==
X-Gm-Gg: Acq92OFgOTeNCtiATgATN1IzFJ9AHGtPjWs06zfnCfajTN8v/BAPLRRSb+KEU9S0cyD
	CU/XuStMETyVN0E9rWM7DGhgm9K6IkbpnnU7NgzWXHhFKqV0aV1cZi8Kn4v7EfD3Fk5oc+eDGBm
	1mUTwy+SlcHGdyEd5U2ZHSJa0+kdDbmlY4C46SYkTI3Sasxbk1h1ju1LNBE5n0XCWpYQPlBzpvu
	SFQHgaYYaCJNg1Xy6pv+VLsYmwTVyQ4I6WY7o2zHKg084ymSQ2gov2MPg6sLXB4B1LG8Pep7Uf7
	oI6sDbmBRxg2yQ2E8xd+mS+wgQfboyWKyIidjpbm0xbNNGlemM9glmC2S1FbOu9YggrrFosbm5Q
	2Hj+95XNszV0YzGLs/wNIqozxf0vFsaMxD237oY2qQkFeLOnewjJbGqHRWB94iyzRWb/XuSMvuK
	wEO5kfeJOITp3uqBK7iTq+pV5aKu1WXin1Z8f29B+qLhrgA9Mfw0egS8rQvpUI6w==
X-Received: by 2002:a05:7301:3f16:b0:2c9:1943:e7ff with SMTP id 5a478bee46e88-2f54b35fb00mr6500611eec.10.1778272605216;
        Fri, 08 May 2026 13:36:45 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:68c8:9c69:b0fb:a687])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2f88885b820sm3683873eec.20.2026.05.08.13.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 13:36:44 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3] PCI/portdrv: Allow probing even without child services
Date: Fri,  8 May 2026 13:36:29 -0700
Message-ID: <20260508133629.v3.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIe port driver fails to probe if it finds no child services,
presumably under the assumption that the driver is not useful in that
case. However, the driver *can* still be useful for power management
support -- namely, it still configures the port for runtime PM / D3,
which may be important for allowing a bridge to enter low power modes.

Thus, allow probe to succeed even if no IRQs and no child services are
available. This also mirrors existing behavior for ports that have no
PCIe capabilities, where we'd also probe successfully.

This change is a bit more important after commit f5cd8a929c82 ("PCI:
dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI
controller"), because it's common for some DWC-based systems to:

1. have only have the "aer" and "pcie_pme" port services available and
2. not define legacy INTx interrupts properly in their device tree.

After commit f5cd8a929c82, such systems may fail
pcie_init_service_irqs() and so exit with -ENODEV.

Link: https://lore.kernel.org/all/nyada24tqwlkzdceyoxbzitzygvp4elvj5oajnqdwb33xkcdwk@76vnrx45fsfd/
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
I didn't get an answer to my responses to the last review feedback:
https://lore.kernel.org/all/adg5IPWdCSv1UqFE@google.com/
So I've attempted to address the feedback without churning all the port
service drivers.

Changes in v3:
 * defer pci_set_master() until we really know we have some child
   service

Changes in v2:
 * clear master when we have no child services

 drivers/pci/pcie/portdrv.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 2d6aa488fe7b..a79a52560849 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -330,7 +330,7 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
  */
 static int pcie_port_device_register(struct pci_dev *dev)
 {
-	int status, capabilities, i, nr_service;
+	int status, capabilities, i;
 	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
 
 	/* Enable PCI Express port device */
@@ -343,7 +343,6 @@ static int pcie_port_device_register(struct pci_dev *dev)
 	if (!capabilities)
 		return 0;
 
-	pci_set_master(dev);
 	/*
 	 * Initialize service irqs. Don't use service devices that
 	 * require interrupts if there is no way to generate them.
@@ -355,29 +354,20 @@ static int pcie_port_device_register(struct pci_dev *dev)
 	if (status) {
 		capabilities &= PCIE_PORT_SERVICE_HP;
 		if (!capabilities)
-			goto error_disable;
+			return 0;
 	}
 
 	/* Allocate child services if any */
-	status = -ENODEV;
-	nr_service = 0;
 	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
 		int service = 1 << i;
 		if (!(capabilities & service))
 			continue;
-		if (!pcie_device_init(dev, service, irqs[i]))
-			nr_service++;
+		pcie_device_init(dev, service, irqs[i]);
 	}
-	if (!nr_service)
-		goto error_cleanup_irqs;
 
-	return 0;
+	pci_set_master(dev);
 
-error_cleanup_irqs:
-	pci_free_irq_vectors(dev);
-error_disable:
-	pci_disable_device(dev);
-	return status;
+	return 0;
 }
 
 typedef int (*pcie_callback_t)(struct pcie_device *);
-- 
2.54.0.563.g4f69b47b94-goog

