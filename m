Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA576DF72;
	Sun,  4 Oct 2026 00:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791072093; cv=none; b=r4ktcCuGxqW4kiW4NwTZ7khfYLypPVc0nIJLZnXsSJMGnM6CJswPGv+hSUhBGuXccz9tJJqHRQsirpGUHf/NbiZczlp42it8C3OW0EGQZ1mcP9dzOwi2Wnz8VpYd3ja5D+Vbe/XCqGjvKzMbui0hvQVuynO09OmjxoVVbj8W7CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791072093; c=relaxed/simple;
	bh=BB3dY7w2udijkL2SPhNw527xhzbVxYG/D/w5bx+FgjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ViEFN4T3SEmOAM/KsLAvFW/EuQPCbmAiVKHOWKkYRHUCremAwdm3cb13EYgjFIWnB6Nf0cKVdSGLEquZrsuC/KMc/ZKlzuX/84Ot609gwWfSLkbckV8frhAcjfbOFWLIDnjs0ihoNQ5bCsypX342Q3uJJ/w9zCx2IyXzWEcsjks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xIs5wVch; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=lc5vJ0ZQ; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xIs5wVch";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lc5vJ0ZQ"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hy2Zf3Hm0zKnVb;
	Sun, 04 Oct 2026 01:55:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791071706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slqX+WjK0Tjp1lT4SSs+PNG/IHGQjnzzvQcqNRda4HM=;
	b=xIs5wVch3xEU13pQJraIEHkc+VrFNC/fgS4btEizpjms6TYnwH1XtmK1WT3FwP8puDD/RW
	xukCWNZ1vPmE9hqFqyiHTT6bN6xvyRAN1DtbbdG1aOQh5iGpBe2TTTZ889533EznShnSKB
	PRlq6Nt7RVd+KT/NAHmklbPOHAmImlY6+xXb4uQTcnEaeNSE1fvShrOJ7AtSce1jrKuqaf
	1KP690mXG8NEMcIyoJRBXzwARMJkz2jCYph2ZexTy9INB2hzlUCWgJlbdb04Fb/CJegLcK
	mrFNc7EwY5AZ5yP1m8j6J23GiyN4Rjm0DJ5gpz1gqslilxruBYIkCX6YSIcttw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=lc5vJ0ZQ;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <6e10fdf0-956a-4ec7-9f24-fa82317be297@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791071704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slqX+WjK0Tjp1lT4SSs+PNG/IHGQjnzzvQcqNRda4HM=;
	b=lc5vJ0ZQJCuz0cClSBLT8KMJdFBWJwpOdLaiQZ1lwFfrVWO8MowzxaMwEi5N7bD7dcDlSU
	5fbMw9yTw0TyJGLq/k8ocI32LT0nRTvIXQGdym68WjaS8entqhZ4AecgVX0fb18fxqX7XC
	d3mscu/pOQYmL+utn6zu5E0P6u/a9TMwRnjaDrqkktSLlHO4hCqxijOo1ZyVuVfC1MwkEX
	jpMeYV9tmgH51hbd96vcTYaf5xpXPYY4B1GSWetAquegsHb8UMAKbyjIoi9k4YzDcQYKah
	eHx3m197SaFFOD9rQcImhoLJQPA0RMC+reDGO9p5xC7kbTkY8R+kJ74QvB4cjQ==
Date: Sun, 4 Oct 2026 01:54:59 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] PCI: rcar-gen4: Add a controller
 reinitialization callback
To: Koichiro Den <den@valinux.co.jp>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-9-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260928165230.3397664-9-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 23b47877a416e3900bc
X-MBO-RS-META: x9zhtq4bd8pesxzdqnhtmwtbmoyicida
X-Rspamd-Queue-Id: 4hy2Zf3Hm0zKnVb

On 9/28/26 6:52 PM, Koichiro Den wrote:
> Root Port recovery needs to reset and restore the controller while
> keeping the clocks enabled and the Gen5 PHY initialized. Reusing .init()
> would acquire these resources again, while calling .deinit() first would
> make the APP registers inaccessible to interrupt handling.
> 
> Add a per-SoC .reinit() callback that repeats the power reset and register
> setup without acquiring or releasing resources. Use the same reset and
> register setup helpers as .init().
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v2:
>    - Adapt to the per-SoC .init()/.deinit() callbacks in next-20260925.
>      Add .reinit() for recovery without changing their resource ownership
>      or taking another PHY initialization reference.
>    - Move hardware setup extraction and Gen5 initialization cleanup into
>      preceding patches. This patch only adds the callback and its
>      implementations.
Could we introduce .configure callback instead, and deduplicate the two 
rcar_{gen4_v4h_v4m,gen5}_pcie_reinit() functions ? What do you think ?

This kind of a change (this would likely require folding this patch into 
09/15):

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c 
b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 3d667f25fb32e..3691c2ddbf6bc 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -100,7 +100,7 @@ struct rcar_gen4_pcie_drvdata {
         int (*init)(struct rcar_gen4_pcie *rcar);
         void (*deinit)(struct rcar_gen4_pcie *rcar);
         /* Reset and restore registers while clocks and PHY remain 
initialized. */
-       int (*reinit)(struct rcar_gen4_pcie *rcar);
+       void (*configure)(struct rcar_gen4_pcie *rcar);
         int (*ltssm_control)(struct rcar_gen4_pcie *rcar, bool enable);
         int (*speed_control)(struct rcar_gen4_pcie *rcar);
         enum dw_pcie_device_mode mode;
@@ -326,6 +326,20 @@ static void rcar_gen4_pcie_common_deinit(struct 
rcar_gen4_pcie *rcar)
         clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
  }

+static int rcar_gen4_pcie_common_reinit(struct rcar_gen4_pcie *rcar)
+{
+       int ret;
+
+       ret = rcar_gen4_pcie_reset(rcar);
+       if (ret)
+               return ret;
+
+       if (rcar->drvdata->configure)
+               rcar->drvdata->configure(rcar);
+
+       return 0;
+}
+
  static void rcar_gen4_v4h_v4m_pcie_configure(struct rcar_gen4_pcie *rcar)
  {
         struct dw_pcie *dw = &rcar->dw;
@@ -343,19 +357,6 @@ static void rcar_gen4_v4h_v4m_pcie_configure(struct 
rcar_gen4_pcie *rcar)
         writel(val, rcar->base + PCIEPWRMNGCTRL);
  }

-static int rcar_gen4_v4h_v4m_pcie_reinit(struct rcar_gen4_pcie *rcar)
-{
-       int ret;
-
-       ret = rcar_gen4_pcie_reset(rcar);
-       if (ret)
-               return ret;
-
-       rcar_gen4_v4h_v4m_pcie_configure(rcar);
-
-       return 0;
-}
-
  static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_gen4_pcie *rcar)
  {
         int ret;
@@ -400,19 +401,6 @@ static void rcar_gen5_pcie_configure(struct 
rcar_gen4_pcie *rcar)
         writel(val, rcar->base + PCIEPWRMNGCTRL);
  }

-static int rcar_gen5_pcie_reinit(struct rcar_gen4_pcie *rcar)
-{
-       int ret;
-
-       ret = rcar_gen4_pcie_reset(rcar);
-       if (ret)
-               return ret;
-
-       rcar_gen5_pcie_configure(rcar);
-
-       return 0;
-}
-
  static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
  {
         int ret;
@@ -1133,7 +1121,6 @@ static int rcar_gen4_pcie_ltssm_control(struct 
rcar_gen4_pcie *rcar, bool enable
  static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie = {
         .init = rcar_gen4_pcie_common_init,
         .deinit = rcar_gen4_pcie_common_deinit,
-       .reinit = rcar_gen4_pcie_reset,
         .ltssm_control = r8a779f0_pcie_ltssm_control,
         .speed_control = rcar_gen4_pcie_speed_control,
         .mode = DW_PCIE_RC_TYPE,
@@ -1142,7 +1129,6 @@ static struct rcar_gen4_pcie_drvdata 
drvdata_r8a779f0_pcie = {
  static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie_ep = {
         .init = rcar_gen4_pcie_common_init,
         .deinit = rcar_gen4_pcie_common_deinit,
-       .reinit = rcar_gen4_pcie_reset,
         .ltssm_control = r8a779f0_pcie_ltssm_control,
         .speed_control = rcar_gen4_pcie_speed_control,
         .mode = DW_PCIE_EP_TYPE,
@@ -1151,7 +1137,7 @@ static struct rcar_gen4_pcie_drvdata 
drvdata_r8a779f0_pcie_ep = {
  static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
         .init = rcar_gen4_v4h_v4m_pcie_init,
         .deinit = rcar_gen4_pcie_common_deinit,
-       .reinit = rcar_gen4_v4h_v4m_pcie_reinit,
+       .configure = rcar_gen4_v4h_v4m_pcie_configure,
         .ltssm_control = rcar_gen4_pcie_ltssm_control,
         .speed_control = rcar_gen4_pcie_speed_control,
         .mode = DW_PCIE_RC_TYPE,
@@ -1160,7 +1146,7 @@ static struct rcar_gen4_pcie_drvdata 
drvdata_rcar_gen4_pcie = {
  static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
         .init = rcar_gen4_v4h_v4m_pcie_init,
         .deinit = rcar_gen4_pcie_common_deinit,
-       .reinit = rcar_gen4_v4h_v4m_pcie_reinit,
+       .configure = rcar_gen4_v4h_v4m_pcie_configure,
         .ltssm_control = rcar_gen4_pcie_ltssm_control,
         .speed_control = rcar_gen4_pcie_speed_control,
         .mode = DW_PCIE_EP_TYPE,
@@ -1169,7 +1155,7 @@ static struct rcar_gen4_pcie_drvdata 
drvdata_rcar_gen4_pcie_ep = {
  static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen5_pcie = {
         .init = rcar_gen5_pcie_init,
         .deinit = rcar_gen5_pcie_deinit,
-       .reinit = rcar_gen5_pcie_reinit,
+       .configure = rcar_gen5_pcie_configure,
         .ltssm_control = rcar_gen5_pcie_ltssm_control,
         .speed_control = rcar_gen5_pcie_speed_control,
         .mode = DW_PCIE_RC_TYPE,

