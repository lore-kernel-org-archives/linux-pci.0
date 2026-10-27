Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117913;
	b=bLmvbxA+FLLbLGqocElU7loNoTQQE91vjn/+luMgt4XnQ0F0v/Kb0BJzt1z8Nz24i2mL
	 TfWZYcMTotYJApvPNjl2o79lhhmHfLHrKcfKISXDPrOdY+adOk8pScLoKptp9P0XQh8sU
	 Jyh8Hif0M3gt3WG95euOr5XxJiRpcAevu9tIA3ZtUclryEo0ERz203UizUutjEy+0Hqd/
	 zaFPuK/rAlbCMNOpL3jWMOYhFrzwDMAFy57iQj664uIDzyYEk/0B+o1k2NQ4mPQuJGgR9
	 QXNS94i0tUMfcCaYzn83CM9HxY9h0f6Txpwj6jJReDohkQvHy+DSmo2bcJsof36cmKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117913;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=NZP4+g8cbJwvLPXGZqK2nCJdDydjx96/dOIknx0/jO4=;
	b=Oi2x2A2ZephvfRRG3/POXwRtwhGcm2cwu6yYNefMAQFbP7vqeiU8rwCrwDJba3nxMYIt
	 cJPRjBk0WOqj3EpQkb6gWZHj8HFLehHxEczadM/RbtGU6ZFxxQePVfU1H6NySQM6zvNEM
	 VsAnW243JOnAQ7VJXTImej1r8LaF3FJcJmbVi/KbIIB3p/gO5jywgLysB6bghBvQUvjyy
	 chNuc4GybCEOLlXys6NUHvsfWM28hpqTPK+PBcDx4gm4HE9K2aNIfdcsJj5qK40erTTcn
	 utz/ZIRjIP2vVm3iO9SZLhWdLjThLAFc9FPaAoNWfx21Hbv8K/aaxCPHIIxr+uIweow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90B4606A32D;
	Tue, 27 Oct 2026 16:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8971F01825;
	Tue, 27 Oct 2026 16:18:30 +0000 (UTC)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] PCI: qcom: Implement .reset_root_port() for
 firmware-managed controllers
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org
In-Reply-To: <sashiko-outbox-174374@kernel.org>
References: <20261016-pcie-controller-reset-v1-0-51779736cf12@oss.qualcomm.com>
 <20261016-pcie-controller-reset-v1-1-51779736cf12@oss.qualcomm.com>
 <sashiko-outbox-174374@kernel.org>
Date: Tue, 27 Oct 2026 21:48:21 +0530
Message-Id: <179311790152.16692.4133912456520918774.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=782;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=NZP4+g8cbJwvLPXGZqK2nCJdDydjx96/dOIknx0/jO4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq4M7Qi6BT9zN3Q1333g+vU/ak+UFt9vu7Hd3kG
 cWkRmV9uGOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauDO0AAKCRBVnxHm/pHO
 9X6lB/9JBaZ3XUZDRW34DJh0++P5IZkMpJNGbfZ64AF4MBO0dun979SlrD3yCHxNGrh+wmDLpsp
 0qgPL++olvgCwUDgGCRIJkfc6a0gGTxm0P6CAaho7tfNVVERDY+DiHxTLQlTu5Qrw4vElpMDKt4
 YoI2umnO7A7DuehFR9TOa2pFjxM0uiCC9OWh6E3CUH47quebwYiPrCd5/Vz7m0Je8fM3Ch1TT1m
 YOBTjyWK+6NLUwzpnSZRRs1FcOnGz24t2jRVkwsIUq5jdshj+BaB26ghF8pAUa4KfrI5YjEEQsj
 QBojQi3h+uw8i3ewzXzalleZUqlQ9/yNyzt1X0v4UBK7FBGO
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-16 13:13 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] pci: qcom_pcie_fw_reset_root_port fails unconditionally if CONFIG_PM_SLEEP=n
> - [High] pci: qcom: MMIO crash due to PM state corruption via pm_runtime_force_suspend()

These two seems to be valid.

> - [High] pci/ecam: memory corruption due to cfg->win assignment on 32-bit

This is not applicable as all Firmware managed platforms are 64bit.

> - [Medium] pm: async pm_runtime_put() races with pm_runtime_disable() on probe error path

Pre-existing and should be fixed separately.

> - [Medium] pci: dwc: lockless dw_pcie_msi_init() races with IRQ mask updates

Looks like a false positive.

- Mani

