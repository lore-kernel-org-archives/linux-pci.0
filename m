Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8865D3D7D9F
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784243137; cv=none; b=EkNlF8wGHR3xaeQYezaswSAw7o6n7HvmDvZYU7FGc7gbbpf0hFPOO+Ggkz+NGPxVLIeDvULOZ0jrrEDBsXqmHQ5wab/6gbf9xmC9E5cFt1FUBFbBCK6XmlWyLXSTfK+nRAAvAzhme70FGYtP3mqDHe+O+58v5ygVErt4s2D+0jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784243137; c=relaxed/simple;
	bh=5kEJIrTmt6UgJJ9EIAIP1lfd2Jytm7zKjTI/lyAE8bQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KObrPr/ZTE5lkYvj1qybQeci/fscMRl8pWnKx0T3+r4R2IcdGW77+O6ybLhA/KA6Y3ey5Jvc45dKSJ1IHLraay/Wmgzi+a9jtRefd8wVbrYBArazZzDvu6eGHuzNIbS1ONRKVOsoGiPlmKq0Qr4j6zACuNmz9e/DxXi69k5pILU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=USUgnn1f; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="USUgnn1f"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-80bb41f7f3cso38034607b3.2
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1784243134; x=1784847934; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bk3USZv12WGxErumeiIAVcQcqRoeJeqlNLEHc8GMv1c=;
        b=USUgnn1fp6ns2J4HKi2/h/N3cPUV7CioZ65s6Qn5/mObPZfFbsVtQidiriFx5ULViN
         x0lB5OpGrT3qosA5bP7zHf3xyFBnXPBJFvL8TbG8vZAAxCkbLu8IOiwbo9uMpdAQqW8I
         SCcQZ48Fh8yuvALKCMkh/LXkx63Iulr+V8dKM53ckoB4gEInoaJ2SaQL5GjcYQ1wMjDw
         UveH5nBODOgPcV2TVqRneKSRJ7XXi7//uBk95CkmMe96htdZu5EM5OCmobeqYQWG/30V
         +KWTZd5ZeZ7cnwpBdtVE5WrrUCbPW87E2xr0Wn7TcugKjiDpvQM45z7JbkUWQlX1MRcg
         8FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784243134; x=1784847934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bk3USZv12WGxErumeiIAVcQcqRoeJeqlNLEHc8GMv1c=;
        b=AEc6/ju8ZP12xnaVFUHXZAceeOsdG0x9c/91JK+EC3XrpCdAQ2aS3az3jkMcYGIu1o
         i/EdqzEF2ShPgDw8fuyU/nSndBq6lu8aXs2SkiRCkQ7IXzebIp5fgQhHLhwSTbjfkrBY
         XaZ1NAnwQlBJmAdEDio6+euyK/RoVd2PKGa8BsH8zh9/HSVg1PNBh6vHUTlZEvrj/kSU
         kGoDZeiqkHDq2UV0a79LQguCaGQxpCFnz2e9VgLiTzeCx7e4C3056dZjsFu3l+lEKojT
         FIC+VGca111upAAfyEfjQYZ37iWMXsqFhQyyjAnCfvmSjlan++LFwsqpEydLbnOqi3FT
         RpoA==
X-Gm-Message-State: AOJu0YxZmp4Kes+C+AvNaS8/KjzVEPPiZ1XlcAPR+maMKzZQVbTlnX5j
	gWpFIU3eZiobfvZ9PBYFDep3tZO2C4qXLyaNq4fgrQMMd6zB4X2fSw7gSSX1SMru36g=
X-Gm-Gg: AfdE7ck4pyqW444uXNMMCAuMc4Yaa0OfRpWBqzj9p9YZgXPTjlr/8SffbWnI11/HqB+
	Ua+YiStHqTzDbRJpqSTgPNdW1ma0n2B9EPpfQ/r2bp7/zApFOnlCNx3rtJgqGk6mWCbzxnTOEtx
	srBzYiPk/aHSbIJ9wL2XJZC7gNL5Ps6G4VFawmqCqxh6JRfhNt2MhA3SWBiMjodY/eQCjB83se6
	lhgJSLk5qBogUTv36ZSeNy7A3NfKoUUe11cOGRLn3HHEPt093ax51J/4/pFqWzQ6K5+V8CFUDpC
	rgw1R7P619Ljm/WNHig3SA6qgftkAbQIWGES8iM9pqsvyl43//ZKXa3WxkC5f84Ox2aVeOtHAJt
	nDvX0gDUqwt5ttHSbtqZ6TNg0EI46S8m4CJDD1t2aDenN4S5r1pwhnNAvBPoQuWWVRTfIJs+h54
	jqIgXMPu5tL4we/hqIHmp4wlYjKCTCdwCLIvmpcXICZh50FnxkIioVUUE7jA==
X-Received: by 2002:a05:690c:6101:b0:81d:a1e5:a498 with SMTP id 00721157ae682-81eedf06896mr7708727b3.62.1784243134324;
        Thu, 16 Jul 2026 16:05:34 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:40df:d071:3a06:1c14])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6be90499sm207006837b3.5.2026.07.16.16.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 16:05:34 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Thu, 16 Jul 2026 18:05:11 -0500
Subject: [PATCH v2 2/2] wifi: rtw89: pci: enable 36-bit DMA on spacemit K3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-rtw89-spacemit-k3-v2-2-392b577ebf75@oss.tenstorrent.com>
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

The Spacemit K3 Pico ITX Board has a RTL8852BE pcie card behind a PCIe
root port, but the SoC doesn't have any 32 bit DMA addreseses which the
rtw89 seems to use by default. Enable 36 bit DMA ability that the driver
has when this particular root port is detected so that the driver can
probe on this SoC.

Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
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

