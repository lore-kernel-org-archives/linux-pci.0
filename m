Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829541;
	b=Nei5ZyVYx1YgRc1CzqMbabQVtzri+9cQYytHOvMxNzBXz+yvdc4ZtGUXiJPyr0XsT5Yd
	 lmdEYS1wODr7hcGh1wCPAaBtnIeKL0F7knqmUEFLyG6EYbdKXf7F9Yux32exPgvHM3RNu
	 AErBX6f6v48oAoETvMWYrBBeXHTyG28ZQaSCNjni8SByCKZes3baEvUJNOnLHayK8Ufz6
	 df2Y+PyUHSK70SLSIjmSmkoC2gWgRRCcf3MeZK3IqlgIs0QNeknrWPXG8eQ5mDg7YFfmL
	 J056ihR8d5G4d9Hra3F9GSQT2Es2P7dltu+JDttiERdq3cuM4fGoohWD6qmFXtEsnFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829541;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4G69hUeaYVdLPSM1kzRF/+eQpXIfqCXeSZLLSkxOSAI=;
	b=KRe3clAN3QiERQilc+PlmbZHZJo8sQil9NpI+fva3dW7skZ2xZUAQmgqKYUX7cZC+5C1
	 59dUOwq6q0tQ12bTw8Xuj4onI5cswF4Fr8UB2SyTKFb7oUTyMgZqSc1IylFX155tKQ1PO
	 iSr+qcOXMJCcytMpJ9tOMlbQWFXaSs4ZaFa3vXrHsFMyR5CDn82Z27WFNWNIhSwHvUvGW
	 N+0Ota+BfZAi4GPYS3fUGVDjCuwEBWLDBBvgfN+cDl3yZ6J0qE9QvI3NH6pR6hOi2LYO8
	 fcAaND3j/XSlReM+Z+yPS+c7SNGMHCJkT5nr3JWqd/ioP0lbgd3KCbRnvZu6JnPw6Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="qP/qhezF";
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94646607526A
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 21:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94646607526A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qP/qhezF
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48bbb06e746so770616f8f.3
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 13:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793829540; x=1794434340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4G69hUeaYVdLPSM1kzRF/+eQpXIfqCXeSZLLSkxOSAI=;
        b=qP/qhezFyLDudJhulq2H3wyakC6nUc97fi2aTgYi2B8rJ25oCNTqlSoUtHsL1ml7un
         zhX3qTqnZIU71TISY7RuiDM35b5jzjmk8B0Todsmvo4Fk8XlWd/Kfv5FAd1xqTSr2qlT
         rlNsDVXSahbzvHOZmINWXWkQOcsQOiBQf7MeiOhmdXsVn6KMA/Mzg5qlMDbfQu/oaDFf
         uIjs71rc7xyMLhyYhDojBX0raeX4uzXiwd8vsrZ24qUb2gz+6FcRTzDDOXLJrLkFrURm
         Hj+o7SUJY13haT6CNYMT5bbRhyi3ZuBQY3b3dWzPqRorwxpyc0M5rMg37Ca+09432Irs
         DJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793829540; x=1794434340;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4G69hUeaYVdLPSM1kzRF/+eQpXIfqCXeSZLLSkxOSAI=;
        b=GXkcIo1UxE5eWiL6wMFeAjlFKRXR43EvTIT+nkSABgFpZpDtmrsia57OwWa24Dgh9E
         l8us1Jl+IA8Wfkyx1yqFKsL/WJcSIn85H7BkQAVtTqP28wXesopm6yTVQ5je7JZct+kj
         VaPw7pR4jD6B8al8hyxVqhsiY4AGdZZdxmuuu6ngd9ean/LWuvmIxDQz+EjfiwP3RiB9
         q39dVcjzohanSR22UhagtimA2fPCMrOENk5JR2+a2B7duttEM/ofDV2tCrnQDFEIgPaO
         i+3XTHv61LUT7sgOzvYcDJT2jCtCCAyjnR2EBN1wMv54IFUsVV8YM4IJi6yQi540frpk
         kFmg==
X-Forwarded-Encrypted: i=1; AKwUvBzS1Lkx3WlcsUjYSE4TSApl0+Ci+htgjPjU7dhsa/AxEZsoD1p8cZVAwpb8RmXv4mSVZfcaQT5m2xc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+m4EhAo+AvA1MylnAQ5GOzxszVYeOjNFn0NYwDMIvIvj6dvj9i
	n0h0uoL9t63K9d9xgVObrYTYAlHGNAK0G3ppRL1h3+bwpz+Fa2w4b6Sb
X-Gm-Gg: AYBFou0uMSZ/ofnbQJH7fmC9znWWz/ldPX4+2fOizIqAHf0Wrp3awVA34RwBApDQGc4
	zKz1VZWoZW+zUp6ZXqwGV3eup9eHJCmbDrrJcr5IaGMtyDWsoJC6nPvx+YNFRti3rmUpwo8ZYyH
	1dZ/beU+VysPaXSBHGsmqWmog+zS2Y7MYdOBpIb0QtCDPAxyXXiisA+Eswf2x9r5qTDiwzNgkqF
	qyh7Lrg3Id1sSDBJKrckSMspnxBy/VcLP2MxF0el8ZNRk7yNWL3dgrkNJpZCs/CHDFd4ht0dxVj
	POWKTXBcRDfXV5EwhnHXyZRM2NbDelzLHMNltVUykXyyftiT+hJ9o5r62KC3TnvM57+8ODTBRbH
	yrKUktFc2iN8CQwWgfHilO9vHOkRuOS6wgRktZZyUJwq75wmJjK/J8o/6GREP/QpEOGRTcdfj5/
	JzPhKx1l4qRWLFTmhzSB31jomS0vKuC5MkQGIS55c+IyHcwaMJLz3CBPRRrc9AjDfL8MmMB8zWK
	RdnM1fMSVooSva7EHx8Nv73tuQ37ix2l+n5++hGo5JCwvRpLWxLt4nlQbBo7hG1Rw8myy28Oz0z
	BZFKjEdInycPUVr5igdLudj+ETgLVo/T6b0Fmg4GzQJZL2S6hEFjqf/U3kOH19ScDQjHwzCmor6
	0enR79oP/Kn7ItKT7vflReLg9rY9XYmiiTLr7pS/FxONpgofbEOrOd8NJlX0EQDphRGU=
X-Received: by 2002:a05:600c:8b04:b0:4a1:fb01:13 with SMTP id 5b1f17b1804b1-4ac17a3683bmr393088445e9.18.1793829535234;
        Wed, 04 Nov 2026 13:58:55 -0800 (PST)
Received: from tachyon.internal (2.155.41.158.dyn.user.ono.com. [2.155.41.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56f5e65b0sm15526735e9.11.2026.11.04.13.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:58:54 -0800 (PST)
From: =?UTF-8?q?Enrique=20Hern=C3=A1ndez=20Bello?= <ehbello@gmail.com>
To: shawn.lin@rock-chips.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	dlemoal@kernel.org,
	iav@iav.lv,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Enrique=20Hern=C3=A1ndez=20Bello?= <ehbello@gmail.com>
Subject: [PATCH v5 2/2] PCI: rockchip-host: Make the PERST# inactive delay configurable
Date: Wed,  4 Nov 2026 21:58:47 +0000
Message-ID: <20261104215848.2087944-3-ehbello@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104215848.2087944-1-ehbello@gmail.com>
References: <20261104215848.2087944-1-ehbello@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

rockchip_pcie_host_init_port() waits T_PVPERL, 100 ms, before releasing
PERST#. The GPIO is acquired with GPIOD_OUT_LOW early in probe, so PERST#
is already asserted when that wait starts, and the wait therefore sets the
reset pulse width as well.

That suits a board which powers the slot at the moment it asserts PERST#,
but endpoints do not agree on what they want. On a ROCK Pi 4C carrying a
JMB585 SATA controller, a pulse that long stops the endpoint answering
configuration reads at all. Measured on that board with a single kernel and
two module parameters, one sleeping before the GPIO is acquired and one in
place of the wait, timing the pulse with a ktime delta across the two
gpiod_set_value() calls:

  pre (ms)  post (ms)  pulse      trials  enumerated
  0         0          1-11 ms    5       5
  0         10         ~18 ms     3       3
  0         15         24-47 ms   4       4
  0         20         ~28 ms     3       1
  0         100        ~108 ms    4       0
  200       0          6-11 ms    5       5
  200       100        ~108 ms    1       0

Delaying the assertion changes nothing, while widening the pulse decides
everything. The slot supply on this board is regulator-always-on, so power
had been valid for seconds in every row above, the failing ones included.

Rather than change the delay for every board, read it from the device tree,
reusing the property names the Rockchip vendor driver already carries for
the dwc-based controllers in pcie-dw-rockchip.c. The default is unchanged,
so a board that describes nothing behaves exactly as before. Whatever the
board asks for, PERST# stays asserted for at least the 100 us minimum the
specification sets, which covers T_PERST and T_PERST-CLK.

Suggested-by: Shawn Lin <shawn.lin@rock-chips.com>
Link: https://lore.kernel.org/all/95aeecc0-2794-4cc6-a635-5c042afc1405@rock-chips.com/
Signed-off-by: Enrique Hernández Bello <ehbello@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 26 +++++++++++++++++----
 drivers/pci/controller/pcie-rockchip.h      |  2 ++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 5b071bd..5f78cd6 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -24,6 +24,7 @@
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 
 #include "../pci.h"
@@ -280,8 +281,10 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
 /**
  * rockchip_pcie_host_init_port - Initialize hardware
  * @rockchip: PCIe port information
+ * @perst_inactive_ms: how long to hold PERST# asserted before releasing it
  */
-static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
+static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip,
+					u32 perst_inactive_ms)
 {
 	struct device *dev = rockchip->dev;
 	int err, i = MAX_LANE_NUM;
@@ -315,7 +318,12 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
 			    PCIE_CLIENT_CONFIG);
 
-	msleep(PCIE_T_PVPERL_MS);
+	/*
+	 * PERST# has been asserted since the GPIO was acquired, so this wait
+	 * is also the reset pulse width. Never go below the specification
+	 * minimum, which covers both T_PERST and T_PERST-CLK, each 100 us.
+	 */
+	fsleep(max(perst_inactive_ms * USEC_PER_MSEC, PCIE_T_PERST_CLK_US));
 	gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
 
 	msleep(PCIE_RESET_CONFIG_WAIT_MS);
@@ -587,6 +595,14 @@ static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
 	if (IS_ERR(rockchip->vpcie0v9))
 		return PTR_ERR(rockchip->vpcie0v9);
 
+	if (device_property_read_u32(dev, "rockchip,perst-inactive-ms",
+				     &rockchip->perst_inactive_ms))
+		rockchip->perst_inactive_ms = PCIE_T_PVPERL_MS;
+
+	if (device_property_read_u32(dev, "rockchip,s2r-perst-inactive-ms",
+				     &rockchip->s2r_perst_inactive_ms))
+		rockchip->s2r_perst_inactive_ms = rockchip->perst_inactive_ms;
+
 	return 0;
 }
 
@@ -881,7 +897,8 @@ static int rockchip_pcie_resume_noirq(struct device *dev)
 	if (err)
 		goto err_disable_0v9;
 
-	err = rockchip_pcie_host_init_port(rockchip);
+	err = rockchip_pcie_host_init_port(rockchip,
+					   rockchip->s2r_perst_inactive_ms);
 	if (err)
 		goto err_pcie_resume;
 
@@ -938,7 +955,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		goto err_set_vpcie;
 	}
 
-	err = rockchip_pcie_host_init_port(rockchip);
+	err = rockchip_pcie_host_init_port(rockchip,
+					   rockchip->perst_inactive_ms);
 	if (err)
 		goto err_vpcie;
 
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index b5da156..c773f74 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -315,6 +315,8 @@ struct rockchip_pcie {
 	struct	regulator *vpcie1v8; /* 1.8V power supply */
 	struct	regulator *vpcie0v9; /* 0.9V power supply */
 	struct	gpio_desc *perst_gpio;
+	u32	perst_inactive_ms;
+	u32	s2r_perst_inactive_ms;
 	u32	lanes;
 	u8      lanes_map;
 	int	link_gen;
-- 
2.56.0

