Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDBB3C9EEF
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784243137; cv=none; b=DTMdAoZCwZTac9af22Z6fWkX6PLQqOLShEX3tY2unA/Xsi2HruJFZS1FN8RBFwdcGLy834KhjcWjfT8aY5s+jipg/a1Xkuqco0xJrghHReI0IU0rT9VJdNCVDuEqewN5f1Wf6pbIIin/2rDwBXrhLahgceRHBfui7Jj5fELxbGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784243137; c=relaxed/simple;
	bh=4QUJGefeX7v0wFAUJrkXQvo4SJ0LD6S+CCRwZONXwZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cdGZhqbQpwP+nKJsFbf0c5MnyT2+2Tlfu+rxCV+HI/3FEHIUvk0ujgxy203aOwKWnaN01l7Nl62WWUro2Ho7JZNKQl0u6GEsSVlpdr7mpegay4GnZnabjRpJGHmnyXaBlnm/HC+0MzMA/Ws8mNy2Eqh0WfHFgZzZTgcHeA6SwG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=X8ZsV6Q9; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="X8ZsV6Q9"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81e9d8f3289so49390147b3.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1784243133; x=1784847933; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XhKY29My7f0UHkdvHti6xaUzqbFLMYcjf/PtSfS7aGk=;
        b=X8ZsV6Q9dzI5hhx4kLbM6C1l9XKDSw14CeDpDbUN4vW5i2WJF0Rt2Yn+rPiZA03Eg0
         xWKUiP5zSjTRIVnRTrvk1Lq8DpaPGaM1OQXeUmJvoKMkJ0V5qt1HnIcU9tNRq8j351tD
         EbcYWpdnn6xzQTAC/+MTHOCTL/Kad3WPe/Vifp56xmdkf7F6ivoWz8AL/AUbIF48Cctq
         ZQeNfsd72m4IM7S9tSBPplxzSYVYmYM6m9f6Y3tk+gJQOKuM1Zz3YPo0CNjNevYgY5MN
         bRNyArOm9t3YS9pZuaymYbqImzqW2BlHS3/2L6apfvBbctjk17pMoC9YgX3GD9Kooa9L
         IHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784243133; x=1784847933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XhKY29My7f0UHkdvHti6xaUzqbFLMYcjf/PtSfS7aGk=;
        b=nBSpfwCv/iTlwCF4l8jq8DI1d4tP+vk5SVjqMt9Kyp1G0axqM1m7KZJ64bMQuSFUVk
         uHch6N+bcsk+cGxFyzAYjkpFGa/4RGsVmu+OK078IVgGeicsUkNfzs8nX7icCbIDAWWs
         aJr75msPYwcNW283vwsyve/4EwIlScI+zR6HZgL9BF8ZY9n2/a9hIHsyxYzfU1jox57c
         MNWeiO7CGK94ss3xB3Jmw4+g9WfEkJsA5gQErbVJzPhRJw8XSVqLBuQ84VadXlesNgQF
         sITVyC3UAdoPHsUMr44NS3UxOcu4OpENY6TZVJdM1VVacfIoS8SZvn+V1/WrXEz0XkYW
         ZyGA==
X-Gm-Message-State: AOJu0YzntB6sSaFRGtgYHl534CdSGk1mBjY2HxtCjMCYiSlD7vfrQyS6
	JJiOreb3jRyuBfQr+4dKHd7lEd6vYTc5extiaDlp2UOUAV9drmIai7g7lVv04OFnZag=
X-Gm-Gg: AfdE7cm5tzzMVZVReUYCSezmowLbY1T5uMer/AqQblF/oUfgJBUeiwACJ+HSBaSjRAa
	FfL35rmpdjsusj8C/n7Ypcx27xKm9uxt8+4Shj6+y5UzseltzEO++GLs8g/PRrnCg8YAREJx0CC
	sGqtvAthMS4gKHC6yrhPve5n2U1fMWkVXIQJQSGaPUlC0OcsEHsTHy71QKIGfMk9BjnO6qGxr/7
	BDB9v2h0CGSwUm75pKvCifQ66Ts7k0Ah5U4u/ZjohzWM7jRJ1FtAuqoj2Z67hQqEGrFHMLAzhmu
	RYWYWR4Knxhm+K5rDaWpEZwxNaUkHtaY0wm+3VIYxkewZiuqIkw99mINmnML2ij6RY2ZrUAg+U2
	Llc3t2JvZhjJfP9EFUJZeM19mBCSIXNYQTaQwTqJIOkdWxRUTOcNAw0+fejmlBMbP6X9n4ULrEn
	VSMvcH4slOaYf12NmH71m7L95X0Aq51mFjA5+IkbiUeyIRQ9SXzJg/ueGAWLK1rvTHqjWG
X-Received: by 2002:a05:690c:998e:b0:81e:c998:9c9a with SMTP id 00721157ae682-81ecf7eef26mr66141867b3.17.1784243133409;
        Thu, 16 Jul 2026 16:05:33 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:40df:d071:3a06:1c14])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6be90499sm207006837b3.5.2026.07.16.16.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 16:05:33 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Thu, 16 Jul 2026 18:05:10 -0500
Subject: [PATCH v2 1/2] PCI: Move Spacemit vendor and device IDs to
 linux/pci_ids.h
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-rtw89-spacemit-k3-v2-1-392b577ebf75@oss.tenstorrent.com>
References: <20260716-rtw89-spacemit-k3-v2-0-392b577ebf75@oss.tenstorrent.com>
In-Reply-To: <20260716-rtw89-spacemit-k3-v2-0-392b577ebf75@oss.tenstorrent.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Yixun Lan <dlan@kernel.org>, 
 Ping-Ke Shih <pkshih@realtek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-wireless@vger.kernel.org, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1

Move the vendor and device ID for the existing Spacemit K1 PCIe Root
Complex to include/linux/pci_ids.h. Also add K3's Root Complex device ID
to this header. This is done so that these values can be referenced in
the rtw89 driver to enable 36-bit DMA ability in it for WiFi to function
on the K3 Pico ITX board.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 3 ---
 include/linux/pci_ids.h                       | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index be20a520255b6..f89c6d46c7684 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -21,9 +21,6 @@
 
 #include "pcie-designware.h"
 
-#define PCI_VENDOR_ID_SPACEMIT		0x201f
-#define PCI_DEVICE_ID_SPACEMIT_K1	0x0001
-
 /* Offsets and field definitions for link management registers */
 #define K1_PHY_AHB_IRQ_EN			0x0000
 #define PCIE_INTERRUPT_EN		BIT(0)
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1c9d40e09107d..d6f26cacc8e35 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2640,6 +2640,10 @@
 #define PCI_VENDOR_ID_SUNIX		0x1fd4
 #define PCI_DEVICE_ID_SUNIX_1999	0x1999
 
+#define PCI_VENDOR_ID_SPACEMIT		0x201f
+#define PCI_DEVICE_ID_SPACEMIT_K1	0x0001
+#define PCI_DEVICE_ID_SPACEMIT_K3	0x0002
+
 #define PCI_VENDOR_ID_HINT             0x3388
 #define PCI_DEVICE_ID_HINT_VXPROII_IDE 0x8013
 

-- 
2.43.0

