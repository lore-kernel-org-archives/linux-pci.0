Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B2E459ACB;
	Thu,  3 Sep 2026 20:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468757; cv=none; b=GZNTeaYDP+Aeo4kMyg4BdyOCbYvCd9xBK06dALi006O33vK0EuIceVHHKEbWE8vE6I8o/4NWtk6wCNsEe7AsLjpqJ0nlC8gGuElMrS+PJwWgHBJ44aNh3XZwizIcbnjrbyshimDs5uGByee7E39G2rnphJ9RnY6JdSlIM6fxHuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468757; c=relaxed/simple;
	bh=bE93zUIVXRR71VFx7oDKKeIIx9ZmSGVJ97cVPNt0eWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoBZm90ii6NsQZ/JMftuMqA0q7C247n0xqN9xyyGwKHuGIfQYRA5JqhxOKyZiDtP7jJuWC46nAFyVFrKlv+c3GfopGwP5nk+f6KWLb4l4QJVY6XHqLnWWPnzaMcd9Eb7pL/p4aBpQDqIG8Q2yoCaVagu6fmH6F7HPOCcypkyryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=weHYT4JS; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ByuQDWHm; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="weHYT4JS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ByuQDWHm"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hbWxp1dLqzKmXt;
	Thu, 03 Sep 2026 22:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788468750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gY4jc6oJ2GgTXE3O2Y7QZQeifWB7jprimmkiTSgncIE=;
	b=weHYT4JSOxxM+/icxSb/7MXOgVExANM5cPC2lQ6XraXx+eg0GhCXLhrGJaLp9lQdzyk9/j
	ZWlLSt2L0pA3heuai5hmfOFM2oJf7CUX9Z71cnhqk7VB24lD6+chgaWIpVFWo07gF+Giam
	+OJsZOtp8lxRQZ0J11JvcsqlQfe2BF6vGrXDOQA0uK+McfMLEHH24ILEpxZQvUwbXgBicn
	OnEX6pyOfagvx1aUQ0rcSfqgVr9UFuVauluCjttZ1P2oBK3DuPZNIdgo9Ynf2wNG3Oic+x
	IpZ+aogJLSnv315erQKwm80axrjyB8Y/VXTmsN9OxUBfa/4bgWArnfKOEQWmNg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ByuQDWHm;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788468748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gY4jc6oJ2GgTXE3O2Y7QZQeifWB7jprimmkiTSgncIE=;
	b=ByuQDWHmJcBYQWfxPXdJ0gO4vu6SBs70BntRL0VDGbP/MZFtJdiUyNwbX8pbd2alItar0C
	EcT4HtwaLlIx5IugcYPV9XWBrUivVKoPkQ0VH/pDEzl1xWmnGeZ5aglsgrric8lJWd5U8W
	5yPYOQHOR0JmsOrYRbKyNuZox8ypaQVnLcM5jhPdgpCaTgs77bqmBtfec4+VdCQsDG88h/
	x0gxrR9q8D3CzxNjMn/AHslgFvcrDVHbximoU80eCJKFv1prUXKWIehmswvtMqNraxv18m
	MMsXU1RpuPaVDy12cUCoOZTPapXcK+GRX7amVPsDCcwAluTaDgZfWnF/Qpu4Fg==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Koichiro Den <den@valinux.co.jp>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 3/6] PCI: rcar-gen4: Add Application/Local register reset control
Date: Thu,  3 Sep 2026 22:50:54 +0200
Message-ID: <20260903205153.283553-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260903205153.283553-1-marek.vasut+renesas@mailbox.org>
References: <20260903205153.283553-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f3f55817c555d887afd
X-MBO-RS-META: atneuysh73t8sxhx51oun3mfnadmo7sy
X-Rspamd-Queue-Id: 4hbWxp1dLqzKmXt

The R-Car Gen4 PCIe controller does contain core reset, which puts
the controller back into well defined state, but it does also tear
down the PCIe link. This is called Application/Local register reset
in the documentation.

Deassert the core reset after the core clock have been enabled, and
assert the core reset in case of error or when shutting down the
controller.

This also fixes reinitialization failure of the controller, where if
the controller driver is unbind and bind again via sysfs attributes,
the controller driver will fail to probe the second time because it
fails to access the controller DBI, which returns all zeroes unless
the core reset is toggled. The following commands trigger this fault
on R-Car V4H:

$ echo e65d0000.pcie > /sys/bus/platform/drivers/pcie-rcar-gen4/unbind
$ echo e65d0000.pcie > /sys/bus/platform/drivers/pcie-rcar-gen4/bind

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Koichiro Den <den@valinux.co.jp>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index f938430644860..ceffaa2e4cf99 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -197,6 +197,8 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 		return ret;
 	}
 
+	reset_control_deassert(dw->core_rsts[DW_PCIE_CORE_RST].rstc);
+
 	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
 		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
 		/*
@@ -247,6 +249,7 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 	return 0;
 
 err_unprepare:
+	reset_control_assert(dw->core_rsts[DW_PCIE_CORE_RST].rstc);
 	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
 
 	return ret;
@@ -257,6 +260,7 @@ static void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
 	struct dw_pcie *dw = &rcar->dw;
 
 	reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
+	reset_control_assert(dw->core_rsts[DW_PCIE_CORE_RST].rstc);
 	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
 }
 
-- 
2.53.0

