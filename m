Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5F33EBF1A
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 01:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770686228; cv=none; b=WSxCjh6Qsgcv1RaOKndXrJaYM02ftrhU4FAXceJ7bVUxx3NsIuIPYl9NgEoe7nWfCS5ooB9a3Z1pi2XFVf6xitlzRYgc0dDZT0S+QIIR1d6GOU7NvmokVbOeXsKnFv/8gDStapvtiOBpz/DVTcwbNcsykJnm7xaP5wBSod8r0nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770686228; c=relaxed/simple;
	bh=3rQT1ZXwHV/aNuRkhTms30L7bcfKATRXNqULQYhc0+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=haWRQwyYlDqy5FVzp5hozGDaRIJGfx03dUAs5GSbXQjqhCWX+6z3dZCX79oVIzAmTJLyG4F7447cVkrv/96lcWhqwuZ3XUXVPAsU75/eDyIn+EHE+whw81qipLDwEiHU8X7kVm3vCCdsB8Mr4/umWr3Ql/UmvoozPz7UCPF37X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LeUXQE5+; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LeUXQE5+"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b8675d4f93so2141706eec.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Feb 2026 17:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770686226; x=1771291026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sPkH+QdMmWbvs590N9FGAiv6noldst9vpcbNY7dgv2o=;
        b=LeUXQE5+cImPQyUiw4Sc3lTX3y2cip1dfLY9t602DHFx+WHvCzLwotlfnR0ILEZhb3
         bsYuG2MI2pzYQVN+wuMfqYLLJzWoU4bFK+DJMP57pL2AWXMmSJ2Qwi8snzbN6M9haSje
         L5T8CNQb3hCter6jJD2lM35RPAsFJk1nQA+js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770686226; x=1771291026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPkH+QdMmWbvs590N9FGAiv6noldst9vpcbNY7dgv2o=;
        b=hiOQmIvQinCl0Bali4VK6fbJicAXmrEO6K2O8plpQwGqVknRwEcAvyXJVtHyvQEwSa
         7m8iOMIh9GFONP6/MOoJsbRZzJJHqLwNwKjh7Fq3JNBO8OqOHqHUSCKKNTW6Een3OEUB
         G2+LsK1ZIkvm3LJFIjt/T07jEjrj5RfRXkAOw6WSkVO3sAUCa9ejtRtiJ5uiYhniANQV
         jaLJs/KYMhdB9OIclI9yjuqT5m5sl2m1PXwL1XeHr8AzDyJ7h6Y9TMeMJqcWGGSDABR6
         2SLTaVD1ZYo/4F79qOF8+CBMdjKtA426f8VYbpmpWk6AG3zHI5i8i38PIYTu5KZsBwQA
         StmA==
X-Forwarded-Encrypted: i=1; AJvYcCUHcrvdJZHHiVecfX3Mz/C8eMQeFObk6DZcF5n1K5qgAaO1Kcu7aVlHuU6z01mmgnBrdLHfPX4DC5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlaUw7PUqTVoSVIp8CwNZfIwAxirxl8L99Pd1se0K3vJQJYrYr
	UBdOr+gvOH4ALNL/prkhaniNDI4Yxu2kldx1eTnSz/EE7t/NtM8VCQopfPY8ZFdvHg==
X-Gm-Gg: AZuq6aJkOcN8Aq3iMHB/fce1B2DOdmWxS0OR3ND5Ea2cM6i4X31cZq1aN0bDpkIHpPb
	mWP5JWK2lVt5Z2o/60OvSktI+IGrAq/tNxERhTfP4HSowo2jr3+yFgu4F4X44WunJzH/5voYKGY
	k6Bc/+i43Wh1Tj8mZF4dZDC4uup6Moq2pLyfvBQy7009XV02XhcF60za6jIL2exucwK7vyJ4Z33
	xBi1wBO9g1R8+VaO62h3VcQLThmZzJlz3uEAzNnQVjVwxO0DcxKSJwVPOxtld6N2LdltAFb4KJH
	e1W1xE4uS6Otdonz9V7eHs8Xpng//CQvohqv8KLhfNhhixWmJ0+r3nb47FcVUoZ3oDE6/HjKgGF
	QvMzCLajNkI2k0mj7TBFzPD+gZuoFDV48c49BFM8CZ3rcCqp52LjrIt1lGy9gfd5hrFWttudBp2
	eTy+4mx1J0jin/HW5ArQI/e1xMuoBexE9QON+1085SC3W23zg/ikAQTxondOpW6w==
X-Received: by 2002:a05:7300:c9e:b0:2b7:857:db6a with SMTP id 5a478bee46e88-2b85672be26mr6509418eec.21.1770686225789;
        Mon, 09 Feb 2026 17:17:05 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:b8b8:83d8:d937:b0f8])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2b855c8d90bsm8479736eec.33.2026.02.09.17.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 17:17:05 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-pci@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2] PCI/portdrv: Allow probing even without child services
Date: Mon,  9 Feb 2026 17:15:35 -0800
Message-ID: <20260209171535.v2.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
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

Changes in v2:
 * clear master when we have no child services

 drivers/pci/pcie/portdrv.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 88af0dacf351..19b08f3653ee 100644
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
@@ -355,29 +355,22 @@ static int pcie_port_device_register(struct pci_dev *dev)
 	if (status) {
 		capabilities &= PCIE_PORT_SERVICE_HP;
 		if (!capabilities)
-			goto error_disable;
+			goto out;
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
 
+out:
+	/* With no child services, we shouldn't need bus mastering. */
+	if (!capabilities)
+		pci_clear_master(dev);
 	return 0;
-
-error_cleanup_irqs:
-	pci_free_irq_vectors(dev);
-error_disable:
-	pci_disable_device(dev);
-	return status;
 }
 
 typedef int (*pcie_callback_t)(struct pcie_device *);
-- 
2.53.0.239.g8d8fc8a987-goog

