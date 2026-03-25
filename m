Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DA8350A1F
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774431127; cv=none; b=Gx9wm4twDdfyAvlyReVoOp0uPdt3pDJ2WmRXWMGWAagpeOSpwGtLx+++SWV6kR3HRrQFV688Xu3gTK0EZxK4J+FeWWQBO49qHxY2ia8RHuewaDOQqAjzN8SoIv5n4y2Ay/PHM+ul1v0dxKrZpcvi1pBV+pmDkfNlCswRPjtdzAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774431127; c=relaxed/simple;
	bh=UV41qUpbXMbPJ8oKt5RHwR1kOG1v2llCMlZ+SAex9to=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nMjpbQ03VV/5CIr9j4SNca1Mg0G96z1wnp/HET8iHZR5O3x6YNEaut1EaxmxsvLO85jjCOnOWcDpnIAeI3sl7Vcl6tPtcJtt2ntRAvqB6JKoL4oKAZD4cHA5KAoBe51brl21tPtabeE6OCHqpyBBkx92TzReBGvIhBVOm3Q8Dxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hckSUcy8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hckSUcy8"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48702d51cd0so49231895e9.2
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 02:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774431124; x=1775035924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aIsbSfS605Q4eTkbTgnxZvgMorhnFDaqZxn3f2tTBFI=;
        b=hckSUcy80k8ckKuBdK6VOzqEbGcMty/9LRQEs2EJn7ojDc3iadZIRb4LYlRhtK/2j9
         S/Y8Oj4wbausnRL5Ptk2ci6ebqMeJhZoBfwxwy7SX5stXT/O5IrC3BlUqiVtDDrvq/vS
         IGzSWAZ6JPnNmmi065AjwZhnhrY5e3zF7MlREy/mg/9akHM+SagJJGdJanABwxwAuXcQ
         MfU+hgXRASNstGarHJOV6bj9pJ/eNr9vVvhwoTkuN7wE1L3JBwfjhass8fHz1VDANsUi
         gLyPXu+anZK/44SkPVhHqYX985T/75sAPqNnMkAMvn9cY5+BzHQaQyXPXWEySBEu1V3x
         i3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774431124; x=1775035924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIsbSfS605Q4eTkbTgnxZvgMorhnFDaqZxn3f2tTBFI=;
        b=WEu3rkWAL50c3ay9F0YMhBVqJBCqKWxjjGNZMWYCb3ukDcbxYwfbQbF+CQbueGJ94B
         AZeGRMXgsTMgxGbEdLV7QhB3a7e0TZKvL2ybxhbBdmsYNERMM+C6zGVPY8hn0KtLBcEv
         xDhD3qTVpLFEvtKliK6dG90N/V+AMpsac60WgvvLSgVYIYYEiJFGVxaepfpqoci93fPB
         JjgMZuEPX7psEqpp8/LyPr6H1p5vHVHpnAysRLS39XXJsPv0FAvcNIq8L5Q5iRo5fQbB
         TTkq4eVqHQ8NLAnOGik89YB6MWo2NzhvydqQobG/6sUuP4DD6Rcm7tXuiXvWcNcVN0hS
         9UTg==
X-Forwarded-Encrypted: i=1; AJvYcCWPBKXo5VLP6d0qB0jTwpBp1tOBaLbFBWW8Aj2rbXkIRyfMfHCUM+ohW5MxPyG4rhA+pZmtVg3vU6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzokSlXd3KMVXnqf4Vej/fizBSmT7zDyz2nUEn2BoGy1/gdmtWN
	BoMw57Xx2128PARHZCPMhS06dxEnOAPiec+x5BVJXloW+AwmrEMoMFEG
X-Gm-Gg: ATEYQzxfm0bcAK1tObOCjCqtDdezW1MyesgTpnVcPTxYvf1T16LCdOoXVF5SGO2dOst
	cDYc/k2SKejuXhToFBW1fvGGQ8Ucl+Jp8DtJrvb9AGKtBRoKv+quQmU/g10V5YFcP9EjyXl4PP/
	WrG/53cOupelWR73F1zcfCZiU/P/xPdQDwZCcbYGRklcCiTfc03al6ubLVsfWCL1rQivbRq/ZWT
	Zc+O/Ki2r4Ao4KHeCTI2XmtWLdTDyIPaiRGvmxKElKQfqXaShbFnYRlYvgga01vghLhs8RJyutA
	00dIOuFtAu9NyTpbrkhBy8F7JKY7z/AQO/jf1gLFUxbKizIa02OhRrTDEs5aUUvRhPOpTfK4Rk2
	bI0norJteHl1YUs4Ad5R8gRUIJjCybaxvghul2Q7G5lf/lpV7h3NudEbMZdfZM3zVVaA4qNr1kt
	f8M/gQjKJoDNJL+VFYiMTBoiy/GMWIw7JJlTsUCQ3T45Rc4Cul+QqBmO5kZ4LtBq5IcMAK2Zzy3
	ZlKdKrCgDvHzHO86e7SBtXhB8Le0tXtkqI0x9LeZNVVYokNZASx+dvrh0wlZDXVVI6FkNsrrRcw
	FLlPTQ+Kxnv5QkDbG3cH
X-Received: by 2002:a05:600c:8b88:b0:487:1c2:6a4c with SMTP id 5b1f17b1804b1-48715fbf6a6mr44191015e9.4.1774431123985;
        Wed, 25 Mar 2026 02:32:03 -0700 (PDT)
Received: from franzs-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711764625sm120724195e9.14.2026.03.25.02.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 02:32:03 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Franz Schnyder <franz.schnyder@toradex.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] PCI: imx6: Fix reference clock source selection
Date: Wed, 25 Mar 2026 10:31:16 +0100
Message-ID: <20260325093118.684142-1-fra.schnyder@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Franz Schnyder <franz.schnyder@toradex.com>

In the PCIe PHY init for the iMX95, the reference clock source selection
uses a conditional instead of always passing the mask. This currently
breaks functionality if the internal refclk is used.

Pass always IMX95_PCIE_REF_USE_PAD as the mask and clear the bit if
external refclk is not used.

Fixes: d8574ce57d76 ("PCI: imx6: Add external reference clock input mode support")
Cc: stable@vger.kernel.org
Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 81a7093494c8..e0580d6efa57 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -268,8 +268,8 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 			IMX95_PCIE_PHY_CR_PARA_SEL);
 
 	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
-			   ext ? IMX95_PCIE_REF_USE_PAD : 0,
-			   IMX95_PCIE_REF_USE_PAD);
+			   IMX95_PCIE_REF_USE_PAD,
+			   ext ? IMX95_PCIE_REF_USE_PAD : 0);
 	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
 			   IMX95_PCIE_REF_CLKEN,
 			   ext ? 0 : IMX95_PCIE_REF_CLKEN);
-- 
2.43.0

