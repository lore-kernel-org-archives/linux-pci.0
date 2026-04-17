Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597EC382398;
	Fri, 17 Apr 2026 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414981; cv=none; b=ttyGbZLddk+fXjb9640YwTbYB/0KnVWcq+vm2RwWCfMomZtgrGNzeyxVGh4ybKxKkmT9SXrRt6u4Ws72tIHWAKVi2L7/WOaRGgjMAy2NoYW4Pj4exOi8TwAwal+g9qfzmVRYaOBkTuGQa/uBYYf8pOUQH3bDbWhL4lvgDUxmR58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414981; c=relaxed/simple;
	bh=9EFkreYEFt8jz6Z1NkYfjCRoqkyaofsUqKdhyek/ti4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=lv/ojzdgFeVu1J3wRKIl2vbqXmRpIDEG4HxW/LW+C+t6/TR52/qlSQpks69SHpk8p86deiw4USCw0y7YcDxXJgAbxqTsBforNu9A2w8Bl+3FFvGA1LmUv+4wdEz2FYzAwcssrY4OHmZn7o3KhkvAeEom3rV5TI287llXSyhYkig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=t3BsXscc; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="t3BsXscc"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=75813159fe=fe@dev.tdt.de>)
	id 1wDegN-00Bg7d-CP; Fri, 17 Apr 2026 10:36:11 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1wDegM-008Sa7-Sg; Fri, 17 Apr 2026 10:36:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1776414970;
	bh=k0RzhtyN2lEDzgUVLjPsscw7natQWQb/iXLZdZSRiKo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t3BsXscc2EYfkVKclPkvocQ/8xJux+OFCmuxFuAzjWi7rT7aaIq3ZGxBI8F4DvSAB
	 E1s7wHKu//0sqWZNJX8bYH5oQ6Yp5+oZhsqdDccTlq9puIaJ6c6CpDaV0B4vXDcK0v
	 bPAweyGmhjG5Iljkr0XQh1tqZI+5IVGLYayKlHwKE4IulS3G00/m2gDie5gb1QxXPe
	 j91kaUjB616s33WnLbEiJgM1fJwigE/dw+XFMk1q2DoozsEIxohOeQGZlDsjecdlZM
	 HlpyuRqnVGZjnslIG0P2hIUVHtftPcen/bp7cjFu6GHdEH7xB6pVxftq3opFVSKfGo
	 tF6myYyiXi9Hw==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 781CD240042;
	Fri, 17 Apr 2026 10:36:10 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 70926240041;
	Fri, 17 Apr 2026 10:36:10 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id DE7DB242E4;
	Fri, 17 Apr 2026 10:36:09 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Fri, 17 Apr 2026 10:35:47 +0200 (CEST)
Subject: [PATCH v5 3/7] PCI: intel-gw: Move interrupt enable to own function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-ID: <20260417-pcie-intel-gw-v5-3-0a2b933fe04f@dev.tdt.de>
References: <20260417-pcie-intel-gw-v5-0-0a2b933fe04f@dev.tdt.de>
In-Reply-To: <20260417-pcie-intel-gw-v5-0-0a2b933fe04f@dev.tdt.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Sajid Dalvi <sdalvi@google.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>,
	Eckert.Florian@googlemail.com, ms@dev.tdt.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776414969; l=2926;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=ZYKI9htHzLsLWQm9mMvJbP0KpPmuZ1vngPu0F8zCXMI=;
 b=vUYaTk3W4GeOmISuxVHH3knqZgg5q3s6hoeACz9jE3Pcy8WRqRe95TFpuF0KrDintt70mjNlV
 j1SYRk0cpcTBVWFnkJY+oazLVJpxiALfgNvv2SIxuOgNcKqf3E+DXR6
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1776414971-2B429049-6B521993/0/0
X-purgate: clean
X-purgate-type: clean

To improve the readability of the code, move the interrupt enable
instructions to a separate function. That is already done for the disable
interrupt instruction.

In addition, all pending interrupts are cleared and disabled, just as thi=
s
is done in the disable function 'intel_pcie_core_irq_disable()'. After
that, all relevant interrupts are enabled again. The 'PCIE_APP_IRNEN'
definition contains all the relevant interrupts that are of interest.

This change is also done in the MaxLinear SDK [1]. As I unfortunately
don=E2=80=99t have any documentation for this IP core, I suspect that the
intention is to set the IP core for interrupt handling to a specific
state. Perhaps the problem is that the IP core did not reinitialize the
interrupt register properly after a power cycle.

In my view, it can=E2=80=99t do any harm to switch the interrupt off and =
then on
again to set them to a specific state.

The reason why the MaxLinear SDK is used as a reference here is, that thi=
s
pcie dwc IP is used in the URX851 and URX850 SoC. This SoC was originally
developed by Intel when they acquired Lantiq=E2=80=99s home networking di=
vision in
2015 [2]. In 2020 the home network division was sold to MaxLinear [3].
Since then, this SoC belongs to MaxLinear. They use their own SDK,
which runs on kernel version '5.15.x'.

[1] https://github.com/maxlinear/linux/blob/updk_9.1.90/drivers/pci/contr=
oller/dwc/pcie-intel-gw.c#L431
[2] https://www.intc.com/news-events/press-releases/detail/364/intel-to-a=
cquire-lantiq-advancing-the-connected-home
[3] https://investors.maxlinear.com/press-releases/detail/395/maxlinear-t=
o-acquire-intels-home-gateway-platform

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/con=
troller/dwc/pcie-intel-gw.c
index 80d1607c46cbbb1e274b37a0bb9377a877678f5d..e88b8243cc41c607c39e4d58c=
4dcd8c8c082e8b0 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -195,6 +195,13 @@ static void intel_pcie_device_rst_deassert(struct in=
tel_pcie *pcie)
 	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
 }
=20
+static void intel_pcie_core_irq_enable(struct intel_pcie *pcie)
+{
+	pcie_app_wr(pcie, PCIE_APP_IRNEN, 0);
+	pcie_app_wr(pcie, PCIE_APP_IRNCR, PCIE_APP_IRN_INT);
+	pcie_app_wr(pcie, PCIE_APP_IRNEN, PCIE_APP_IRN_INT);
+}
+
 static void intel_pcie_core_irq_disable(struct intel_pcie *pcie)
 {
 	pcie_app_wr(pcie, PCIE_APP_IRNEN, 0);
@@ -316,9 +323,7 @@ static int intel_pcie_host_setup(struct intel_pcie *p=
cie)
 	if (ret)
 		goto app_init_err;
=20
-	/* Enable integrated interrupts */
-	pcie_app_wr_mask(pcie, PCIE_APP_IRNEN, PCIE_APP_IRN_INT,
-			 PCIE_APP_IRN_INT);
+	intel_pcie_core_irq_enable(pcie);
=20
 	return 0;
=20

--=20
2.47.3

