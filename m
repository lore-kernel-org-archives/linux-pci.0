Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56877396D2C;
	Thu, 13 Aug 2026 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786612779; cv=none; b=ZKxqio8NyXZhv3Hiam56ddMmUInH9dVlzevqpktJbRnIf+nmbtWrXQ+4P+ZQC8x9lSUIDDFQqer/PUbg6+pGpTQNnCnPkpv2HBK0na1p51iaPj2uSHl4b1DOpNZ3GLMnRIO2aRuz3gL8SV28i3U0fZKphCskmfy3oQRhHKQTbnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786612779; c=relaxed/simple;
	bh=xUmHSXWF3IF+WspwitWwK7tWZgLoivVgyiD05OWn6zw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W1ftBo5OYxZbFOj0EtERj0zP9JuCrkqptGVu2bdapx9G2hA2A1kh21YkrgXuR/67/klFfEoGXZDuKzCnOaKtoA0kAIhZTV3xU5SMlhe4N/bomd0AXbgnlVdZ3swvHl0Nr7F7evVRWnK9mBckJWranQcSuLC9Q0Cddc9IKkNkGuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=OnkPdBef; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=NiRREdyY; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OnkPdBef";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NiRREdyY"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hLKYy4c24zKvtL;
	Thu, 13 Aug 2026 11:19:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786612774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lJ3GNxPWasdsRHWKiRTbRAsEizox1JwvfRTBpK+mnAk=;
	b=OnkPdBefiQMMysZMm/om1oi2KYBv1lL6fGXX/TRUDgiKaG5AjjRqD29TVkWB7KTEqoMBl8
	1TMDDNO+lgWN9je9bCpFeB4eud0sxNIarJ3t/E4JvaoZmrqZQrNRMTAagQeHG2N4QXQT7q
	Ogjpxea4w/PAspqyOGOmLH/lmge1sqrhCPVzDgqqXudh62yO6N9cDPIJmPj3M8/Kge3BL0
	NDmV/bAyZAXXwPWujU9X22hmnNBkN6A7tSC4onvshqmUMelNpvKxJ9A6aK/Tgg9nKK62+g
	VmAw7wYlEiNj4BGfjQRnoc6VWo+rLL+i92S6gEc24Ois6BD9WR+Z+EsD+ot9Uw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=NiRREdyY;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786612773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lJ3GNxPWasdsRHWKiRTbRAsEizox1JwvfRTBpK+mnAk=;
	b=NiRREdyYbI500fRKfz4vHIJg0hb/mgjoi74JLseAl3iWKVcjAz2fc9SAJaP66JVfdMjXvZ
	kBeWymxgA9k1AI3+EIn0AzxRvtdQX37U8qwbkeRrR2i0zT/YTE2/NVdWP83yMXmITa5feo
	4Cq5kUOpHxePKjMYy8s0+lezn36YxaXX6KBWqMEIv5LsO6hlmCtL/dTQwtWNTjW0dMb4NI
	F84GUi1E5oyRhmip3yS4e6/GUchRXTDaVOKryV1fJ5BpUWMyf1B1SXCawhxzniKW2SyuOi
	c+hyeV3RrSRO+EXPncznITO+C+AomXH7NMyoHAz1VmhPc3I3g6Y50N8qRQHxDQ==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Koichiro Den <den@valinux.co.jp>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] PCI: dwc: rcar-gen4: Fix potential unclocked access in rcar_gen4_pcie_ep_deinit()
Date: Thu, 13 Aug 2026 11:18:22 +0200
Message-ID: <20260813091925.71363-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f4c87077c89a59d5b39
X-MBO-RS-META: xkquoubrhhj97cxrbqi9zkuuk8tajb3b
X-Rspamd-Queue-Id: 4hLKYy4c24zKvtL

Initialize PCIEDMAINTSTSEN in rcar_gen4_pcie_ep_pre_init() to 0,
and in case rcar_gen4_pcie_common_init() fails and the result
propagates to dw_pcie_ep_init(), the invoke common deinit instead
of endpoint deinit, because we are certain the PCIEDMAINTSTSEN
register is already 0 and the common deinit does not do any register
accesses.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Koichiro Den <den@valinux.co.jp>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index fbe465a29068f..b47281b30db96 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -487,6 +487,8 @@ static int rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 	int ret;
 
+	writel(0, rcar->base + PCIEDMAINTSTSEN);
+
 	ret = rcar_gen4_pcie_common_init(rcar);
 	if (ret)
 		return ret;
@@ -571,7 +573,7 @@ static int rcar_gen4_add_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
 
 	ret = dw_pcie_ep_init(ep);
 	if (ret) {
-		rcar_gen4_pcie_ep_deinit(rcar);
+		rcar_gen4_pcie_common_deinit(rcar);
 		return ret;
 	}
 
-- 
2.53.0

