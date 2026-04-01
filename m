Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8AF3C73EE;
	Wed,  1 Apr 2026 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035915; cv=none; b=YEXbV4/Gy5t6Lzk5V8MaP8F3cFWMn+iyHrzZzHvEvo9GY9QtOm25+/dcSkK+G1fUh5mK7jffaPPUiERiRWEl41IyfOI8Rp5BfKGl7+h95Cyk7nVqvL7zM39/lyXpD6CBWZfzYrzL6qhJouTq3p+IXS1Cg3QO9L1pKL46oM2kxaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035915; c=relaxed/simple;
	bh=xn9R5Y4c2FVuxWGJ+XDVZ0hhgrzdWZnr3TAJrrkBg1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=hGf+mJTgyM5Rb8EIGu7KvR3/kHzEMUyq81fMjobap2ZIbiQysXNQqcbHmhJjvoz+FTTxUuoBhaHNoCcwb46zTvsSOXoku2mxVbRwDuXggR6Tnb4jhhdX27TBQQHbxnNQa8jPzjYTx95MyOTd52XIYHF7KG4/aaZ95Pqw+c6pT9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=sk1xcz7h; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="sk1xcz7h"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=65659f006e=fe@dev.tdt.de>)
	id 1w7rvM-001Syu-Hj; Wed, 01 Apr 2026 11:31:44 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w7rvL-002lFV-Uh; Wed, 01 Apr 2026 11:31:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1775035903;
	bh=dqCPK//hWZVdcc5L/u7Ya15VIfulvFBTzBi5FMRGLF0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sk1xcz7hcMeP8yVrZGstlquJ81tiUix2EVjTHPtdadbfdH+k8hXOp8nAEjc8Z2zek
	 FBYbz+reEt5t3BXbEKcOWgWNn73m5vgCxgQFjN8Q0FI7iSYvRrIBZsNlWnCtqj+zVd
	 CtIWZAYXZEiQguddjZ3p/HiEnTVqbfTJQXipoImxumJIlkdUYm3JJ17NC2iucR1O52
	 hhWY8eKWEJ2y3/4SO6J+NWcQWA5RhBIAnW5rnqv5Kq4gnYNc7pVNdhBDZM5vcaVxUx
	 T7iF+UN5odxB3pWeoKaO+yUegV5tc9Ie3ATFRe25aSOkOCWrCvtcdNIzi76/Z8fu7m
	 XvCssbtqk2XWg==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 7691E240040;
	Wed,  1 Apr 2026 11:31:43 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 5B4A5240046;
	Wed,  1 Apr 2026 11:31:43 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 4015C23C6F;
	Wed,  1 Apr 2026 11:31:43 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Wed, 01 Apr 2026 11:31:38 +0200
Subject: [PATCH v3 2/7] PCI: intel-gw: Remove unused define
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260401-pcie-intel-gw-v3-2-63b008c5b7b2@dev.tdt.de>
References: <20260401-pcie-intel-gw-v3-0-63b008c5b7b2@dev.tdt.de>
In-Reply-To: <20260401-pcie-intel-gw-v3-0-63b008c5b7b2@dev.tdt.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Sajid Dalvi <sdalvi@google.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rahul Tanwar <rtanwar@maxlinear.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>,
	Eckert.Florian@googlemail.com, ms@dev.tdt.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775035902; l=814;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=xn9R5Y4c2FVuxWGJ+XDVZ0hhgrzdWZnr3TAJrrkBg1E=;
 b=2n6rYRrtMwOwx81lCIFQ0W2AWhvf3q4RacIeQ4eSmakSA57Y2RYgnsiphTqpojqcAeFN3gi3T
 JGZYtQgwfUoDaf4VGLIa+WWV3ceULfJ8VyJ9cHLk1AEy2JkPiyVooCT
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1775035904-4AFC9233-062AD981/0/0

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

