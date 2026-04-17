Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974E37C109;
	Fri, 17 Apr 2026 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414981; cv=none; b=Ona/0E0/LqlVFXN2OPx6cFizC+pZ/ECI3z+zS9XL0RxJDfHcYgo+6SBK8pDLJpVIYXxHxHptEG5GjgdLP7tNqmN7DnRhCqIh8ElwsqYCShlnb68N5J7ufrp4q2TvI1FxjbOqM1+ZdoVSO0LIHcHKSuCv4qpe46QM5wNWN/U4+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414981; c=relaxed/simple;
	bh=xn9R5Y4c2FVuxWGJ+XDVZ0hhgrzdWZnr3TAJrrkBg1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=n3kArR5EOZ2UfNvOJbDS2GLcJVYCZdyRiZpGbg0SfLu93fyyXNULjSEyHd1YOYMlH7m8vxJ74D9nYJKVWu4nxHdj0rwod7tEuDeqLgs/8TF6C+qAc1B+uyje/YvEcj17rZhEW9CF5gK+yu0pj4VPEdB+02nCyoYJC4VAG66d3kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=jwHWq+T2; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="jwHWq+T2"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=75813159fe=fe@dev.tdt.de>)
	id 1wDegN-00Bg6j-3N; Fri, 17 Apr 2026 10:36:11 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1wDegM-00A0Nv-Ju; Fri, 17 Apr 2026 10:36:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1776414970;
	bh=dqCPK//hWZVdcc5L/u7Ya15VIfulvFBTzBi5FMRGLF0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jwHWq+T2q/xklHc+xsq0BQcikPvtjqVmn9Qk1MK5rEj/2RVLQv0QbXfADFX6jxW3g
	 +MyDqNbKTIWw/N5EOCzHI8og8KhKgvLJtJMBmvpxn/6L0FXYA/vdyPf0IPmeGRWuLb
	 ZbIM6e/o8bQ62mOVH4XuKL/UG0/Iu85+zQ8XWzyqzWycALGyybW2mVNq41Jh96lxun
	 oy3DEihPpzeixY5mUeHzgCKntAbrGfGn2PelaHP5/sK+UXgkhiy1FGt9J57WwHY1s2
	 X6J2OBS45o/CO+21K9decNtC/94FtBArlicu+aknC6wKw7ULm3d2V77KweF50ddymc
	 WmNobJkeoTcoQ==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 0118A24004F;
	Fri, 17 Apr 2026 10:36:10 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id DFD54240047;
	Fri, 17 Apr 2026 10:36:09 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id C5D3023BD7;
	Fri, 17 Apr 2026 10:36:09 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Fri, 17 Apr 2026 10:35:46 +0200 (CEST)
Subject: [PATCH v5 2/7] PCI: intel-gw: Remove unused define
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260417-pcie-intel-gw-v5-2-0a2b933fe04f@dev.tdt.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776414969; l=814;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=xn9R5Y4c2FVuxWGJ+XDVZ0hhgrzdWZnr3TAJrrkBg1E=;
 b=cZ8ik4QHSpK5edsnADCxvQmasi61AYTd4JRzww7lKoY0EiR3l9qGVIO8FyCH+jMnin0Kdw1CV
 GsL8fGrBcUWDu2wTRxFkGIJJaSEOAf0MJR1Uocc6597gOEQEBRaZNN7
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate-ID: 151534::1776414971-196C4049-9B8CBE30/0/0
X-purgate: clean
X-purgate-type: clean

The C preprocessor define 'PCIE_APP_INTX_OFST' is not used in the sources
and can therefore be deleted.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index c21906eced61896c8a8307dbd6b72d229f9a5c5f..80d1607c46cbbb1e274b37a0bb9377a877678f5d 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -47,7 +47,6 @@
 #define PCIE_APP_IRN_INTD		BIT(16)
 #define PCIE_APP_IRN_MSG_LTR		BIT(18)
 #define PCIE_APP_IRN_SYS_ERR_RC		BIT(29)
-#define PCIE_APP_INTX_OFST		12
 
 #define PCIE_APP_IRN_INT \
 	(PCIE_APP_IRN_AER_REPORT | PCIE_APP_IRN_PME | \

-- 
2.47.3

