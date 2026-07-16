Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9813330B32
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 03:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784172142; cv=none; b=sIPUgD1hOgZ24/JBJDtFsmHst3U2Fac+5gHau9DvR9zZmfFlGdD5M6oqXw9KQYyCJQMQTaqsiC1aN2X2xVkRfuh/ElM2+I1tB4jW+b5hx8LgMLSedngvFwu1ocbE+nEhILcSU8P5mHCOkbOlDhslICbk2wSpaE938qDJfsjZ8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784172142; c=relaxed/simple;
	bh=5D1qVSBbWfn7Tpv6gHBIf1HEIkdpFl8pWYg+EmhZk/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OgCUWASrmBANZIST/cn9tyqehZ/+rMxpmFBtHCCEtqiI4Q9i/XNoFbUYmskD/hp75iPn6qQrNbscVNuozj4Jt/BM91n6FRm3kiE8SIoDky26zHyMkXE0t9QEmzFE3jj1dXl6aJCPT0xF+1hReQj6EueEOXk3QELsQ0e5zX6M0Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=APx6jKgy; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="APx6jKgy"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81ed2a00f12so24446877b3.2
        for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 20:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1784172140; x=1784776940; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=48efBL+/zgjdRX5eeYvPyEwynq80yeCCfHgWW6gkRZI=;
        b=APx6jKgy3e3irQbP7akXPxudNatD3FbH8rTwQY1L/YzoFVygepfHdKg/wqPdaqfmCi
         zN1ETIo9hWn7pteW4wWRp4zosDU4GlBe5oIX1LnX/su/HzCSOlME+x6exnuhGhVsD5ER
         vxLudYLeGPOQvPVVkI13tdZOpTho+aVGpNsJpBLx++997HaD+Yl27Re5VbqdXIWecVlV
         UmI2ixb7+wYYcRg6QMiAS7Kaw3dJWkrUalHWlPsVL7p310zEk6oLv4A4i0R/xV0754cU
         Ivs5EYGtMA0IqNNj6bTGOm0EjuF4coy8r8mPT51FIjmgojD+3Na6qOzdCJ9YULe7WbTa
         /F+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784172140; x=1784776940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=48efBL+/zgjdRX5eeYvPyEwynq80yeCCfHgWW6gkRZI=;
        b=JgY9UHMulC6wbrD3WH4ihG6zv+3E2wqZlhp34icFlxjS6pxTAXSTrc+Mow8R6bQQft
         zh/XiDhM/jfCKc1zStk2kUUwWhByx/Y4buQ+MHXSAgkQQeBJpy3pYRxP/oRpEpY4R0Sl
         Ej+iKBCHmAl5MjmX8AGGZOulbWsz8OZmGboku6BBlB8V3rCyWNgi6RTziIpprjzThFkr
         RHVhvU6OZxCHeKTxeQNZktRS2JvPfsxHFGYZaEBKARITYFnGEAev0ZUn8+riJxMKnl15
         RKukVqvl0Z8MVLDlH/t3BdesEW0TNM8E/QxUxEi9zph/PmVMeMNTvy3t2UbkiK4LO3RD
         oXbQ==
X-Gm-Message-State: AOJu0YwwIPOlCbbYyIhBcjNbcZKGIPmQJ+ho02sI6MFfA33SdYrHxXXw
	h2DbqScnHEDULlHfJj/50UvGae2dQXwD7M/HDuvI2KLFJQBpAEDCEfsh0E2+hKSkTzI=
X-Gm-Gg: AfdE7clWZM5VxZJIwmqQlph3Ry/F9F4lzVPCkqic3STsqlvxSDtrh4jXU0Hz4m6G7u/
	LQ+dTIWpaljzqmjKpR4jFtBRM5AznRAmFFJLbBp5uv9sliQP4heTIPmNT+VVcl57+OwqE9OhjIK
	TUP2kUp98tbTw3E0cvTOm2rdk2zCuM8eqrCql6tzQEXg2RRCXzYDpgofLAIMMwLyUvAsKsOmANz
	pTyel0UaTeXWTkOiZ8EpjLl3XLuLlErgVuSot+ve5UZYEgfV920Qp9nD6/ffnuqgu/ZYF2fQojm
	B+McxFEMApm9C3lZ+ooFtg2hHQNh0n2CfUGxU9uzavKSd1LUikgKck3OQ8CcwleHREJRfLlD3qN
	sq4GbCnKfvLnyXJqHVkmIQGSfUDjhUBr2KVloHYrk+WAMpyS5PpYQFgGQXt29RNjgz4GVRdx7eC
	8ookQiME8YmgERZ6cWR6FwcviiHE84viiJGI5CYAnGLFmK4zHS+YFc4Cc1ug==
X-Received: by 2002:a05:690c:9313:b0:81e:d300:f427 with SMTP id 00721157ae682-81ed300f4f5mr29106957b3.5.1784172139650;
        Wed, 15 Jul 2026 20:22:19 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:56e1:f9cd:8869:2218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6befb688sm185039127b3.14.2026.07.15.20.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 20:22:19 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Wed, 15 Jul 2026 22:21:55 -0500
Subject: [PATCH 2/2] wifi: rtw89: pci: enable 36-bit DMA on spacemit K3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-rtw89-spacemit-k3-v1-2-e577bc63706b@oss.tenstorrent.com>
References: <20260715-rtw89-spacemit-k3-v1-0-e577bc63706b@oss.tenstorrent.com>
In-Reply-To: <20260715-rtw89-spacemit-k3-v1-0-e577bc63706b@oss.tenstorrent.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Yixun Lan <dlan@kernel.org>, 
 Ping-Ke Shih <pkshih@realtek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-wireless@vger.kernel.org, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1

The Spacemit K3 Pico ITX Board has a RTL8852BE pcie card behind a PCIe
root port, but the SoC doesn't have any 32 DMA addreseses which the
rtw89 seems to use by default. Enable 36 bit DMA ability that the driver
has when this particular root port is detected so that the driver can
probe on this SoC.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 102bae4881805..c5b82fc46d063 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3326,6 +3326,10 @@ static bool rtw89_pci_is_dac_compatible_bridge(struct rtw89_dev *rtwdev)
 		if (bridge->device == 0x2806)
 			return true;
 		break;
+	case PCI_VENDOR_ID_SPACEMIT:
+		if (bridge->device == PCI_DEVICE_ID_SPACEMIT_K3)
+			return true;
+		break;
 	}
 
 	return false;

-- 
2.43.0

