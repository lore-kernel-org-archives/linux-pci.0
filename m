Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=218.76.62.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822152;
	b=xaC4sJY+O1sVr1kC/URzo32WomWe10VvZ5XJtlEDjuZnleUDJilw11PC3CyX9D4edXZ0
	 KEpRfeopD2RwooF51me7Vl4CLNb9YfAsWJ2VV95cfhEbxv0hIR+fhcJvg+yChxM6uQOgS
	 HpsBiIKnnnFVrY23VgmnJ6ci5HK5XrLXD+tp7NjpECnrZiSYPxPlu1GyM+/DsVW1vqxg5
	 36DjppC4UIXIvhoAI8jOHdRp+53cK7kucJbAqiv0q5YPNs/LDLBNCnaUn4R+iUGuunfl6
	 JnSQlyEpLVDJDU19jcI+OT+fY+kdj+TFyS0I3S30tf0WDw/NJMSC0BhTGiLgIPvANXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822152;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=An7UuIxp03IASJQVhCkrJ11j5LJvQXg6N+oWMG7q8QQ=;
	b=F60g6BydugNe5jL8lJk7h/JZwt56ZE+Oaj8HQNkkn6WfeMEeLVF6H0275x1URgomGWJu
	 aozA6lxtytiAA5qJQDSx8gBOWnzw1WUo49Y1sIXJS99/UplwwETi/7jKI4Oq5RkBSGnsR
	 hPE+ytxEXTxLnie3ckvQJ2ho5XHcckQkgTX7oPObAx2XTEeKjfkXvU70BNv7Uj4uRjLk/
	 abZCYEEXiQ8m9pOI8JiLfdWsL7IiPAl78CZiovpDMAvGdNFjl/SpF60ss4CuOavVrSAjg
	 LLfJRfrkGk2nxv0lLunNTHIgsbhRKEKOzVk19iBfZcZt6j67lHfwFO0jAwsInMu96GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ultrarisc.com;
	spf=pass smtp.mailfrom=ultrarisc.com;
	dkim=pass header.d=ultrarisc.com header.i=@ultrarisc.com header.a=rsa-sha256 header.s=dkim header.b=f9ipurVX;
	arc=none smtp.remote-ip=218.76.62.146
Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40C5606A31C;
	Mon, 16 Nov 2026 09:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C40C5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ultrarisc.com header.i=@ultrarisc.com header.a=rsa-sha256 header.s=dkim header.b=f9ipurVX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	To:Cc; bh=An7UuIxp03IASJQVhCkrJ11j5LJvQXg6N+oWMG7q8QQ=; b=f9ipur
	VX/UghcfN/mb558IYBHJS+c63qswbFranYLmCjgbj/iokuRDa0D2fMmMXEZueWi8
	4eBZKfLOqSYxXm8kMIeCMGHRmkhN+xGSgrLDdOQiMs/VbJBY5KpGBlRni+TMjA33
	K+NLZ9kXCoIvYrziIQsGg88KXVcP/SPVFS4sg=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDnrwbGz_pqSvUDAA--.1734S2;
	Mon, 16 Nov 2026 17:41:26 +0800 (CST)
From: Xincheng Ji <jixincheng@ultrarisc.com>
Date: Mon, 16 Nov 2026 17:41:31 +0800
Subject: [PATCH] MAINTAINERS: Update UltraRISC driver maintainers
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ultrarisc-maintainer-v1-1-f58706ae438c@ultrarisc.com>
X-B4-Tracking: v=1; b=H4sIAMrP+moC/yXMQQqDMBCF4avIrBtwIkr1KqWLGEc7oqnMRCmId
 2/UxVt8i/fvoCRMCk22g9DGyt+QgI8M/MeFgQx3yWBzWyFibtYpihNWb2bHIaaRmLoqu2dZo3V
 FC+m6CPX8u7Kv921d25F8PFtwHH+phzXFeAAAAA==
X-Change-ID: 20261110-ultrarisc-maintainer-965d85912a3b
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Linus Walleij <linusw@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
 linux-clk@vger.kernel.org, netdev@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Fei Chen <chenfei@ultrarisc.com>, 
 Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Xincheng Ji <jixincheng@ultrarisc.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794822092; l=3017;
 i=jixincheng@ultrarisc.com; s=20260922; h=from:subject:message-id;
 bh=ISg1g4ONyICVsyMrVHbkY7NCHgvfTE297DDq/TSYiOU=;
 b=nczyInXsPH5sXfo1MLZNPno9PuLSKd3gFkJQMiE/xCgmrwPeQuSEY8uiC49TYcn3m9dHbb7IP
 QWW6JkKynTlAaOBT2GxoeMmkYPYBFn/kkvxpTc/A8PIQFWZtE/f5n+S
X-Developer-Key: i=jixincheng@ultrarisc.com; a=ed25519;
 pk=n848dcS5D6g0vLad/rjp4Gf/1eedTe1a3pYUrkt2260=
X-CM-TRANSID:AQAAfwDnrwbGz_pqSvUDAA--.1734S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy8ZFWDKrW5JFWxuw1rZwb_yoW5Cw1fpr
	45CF15Cr97Jr13Wan7Ka4fZas5X3W0krWUCasrKw1jyF1Fkw18Jrs5Kw15u3Wq9F48AFZI
	yw13urnrta109a7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRM6wCDUUUU
X-CM-SenderInfo: pml0x0xfkh0wg6xo325dul2uoofrz/1tbiAQAKDmr2s7AAAQALsQ

Jia Wang and Xincheng Zhang have left UltraRISC and are no longer
maintaining its drivers. Jia's listed company email address is
no longer available.

Replace Jia Wang with Xincheng Ji and add Fei Chen as a co-maintainer
for the DP1000 PCIe, clock, DWMAC and pinctrl drivers. Remove
Xincheng Zhang from the PCIe maintainer entry.

Having two maintainers provides continuity for maintenance and
patch review when either maintainer is unavailable, as suggested
by Conor Dooley during the UltraRISC maintenance handover.

Link: https://lore.kernel.org/all/20261112-legend-outcast-c2226b5e02a1@spud/

Signed-off-by: Xincheng Ji <jixincheng@ultrarisc.com>
---
Hi all,

Jia Wang and Xincheng Zhang have left UltraRISC and no longer
maintain these drivers. Jia's listed company email address is
no longer available.

Fei Chen and I will share maintenance and patch review for the
UltraRISC DP1000 PCIe, clock, DWMAC and pinctrl drivers. Having two
maintainers provides continuity when either of us is unavailable,
as suggested by Conor Dooley during the maintenance handover.

Thanks,
Xincheng
---
 MAINTAINERS | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ccbcdc0799b9..994c3555c423 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21869,8 +21869,8 @@ F:	Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
 F:	drivers/pci/controller/plda/pcie-starfive.c
 
 PCIE DRIVER FOR ULTRARISC DP1000
-M:	Xincheng Zhang <zhangxincheng@ultrarisc.com>
-M:	Jia Wang <wangjia@ultrarisc.com>
+M:	Xincheng Ji <jixincheng@ultrarisc.com>
+M:	Fei Chen <chenfei@ultrarisc.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
@@ -28749,7 +28749,8 @@ F:	drivers/usb/common/ulpi.c
 F:	include/linux/ulpi/
 
 ULTRARISC DP1000 CLOCK DRIVER
-M:	Jia Wang <wangjia@ultrarisc.com>
+M:	Xincheng Ji <jixincheng@ultrarisc.com>
+M:	Fei Chen <chenfei@ultrarisc.com>
 L:	linux-clk@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/ultrarisc,dp1000-clk.yaml
@@ -28757,13 +28758,15 @@ F:	drivers/clk/ultrarisc/*
 F:	include/dt-bindings/clock/ultrarisc,dp1000-clk.h
 
 ULTRARISC DP1000 DWMAC GLUE LAYER
-M:	Jia Wang <wangjia@ultrarisc.com>
+M:	Xincheng Ji <jixincheng@ultrarisc.com>
+M:	Fei Chen <chenfei@ultrarisc.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/ultrarisc,dp1000-gmac.yaml
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-ultrarisc.c
 
 ULTRARISC DP1000 PINCTRL DRIVER
-M:	Jia Wang <wangjia@ultrarisc.com>
+M:	Xincheng Ji <jixincheng@ultrarisc.com>
+M:	Fei Chen <chenfei@ultrarisc.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pinctrl/ultrarisc,dp1000-pinctrl.yaml

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261110-ultrarisc-maintainer-965d85912a3b

Best regards,
--  
Xincheng Ji <jixincheng@ultrarisc.com>

