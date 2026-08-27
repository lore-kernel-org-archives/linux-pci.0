Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BD0311592;
	Thu, 27 Aug 2026 05:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810142; cv=none; b=YPMtFYyRz5PEFqxPf+0w6fKUTxYyfxxRBFuPffE5gHLXaJRAS5/MWP2RbWwqA5UY468+yRpHg/NqGJwMCOBW87bh15R2oClctEQXs0F0LUHfGZVU2oArn2GC9uF/PeGdrnf0QXEr3VlFanOUhxALr1dJfOqFUtlYdelwJJ2IRNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810142; c=relaxed/simple;
	bh=mg0YAhWFwY65UPBPGQbIMOj5vs+rPnVny+rUVFDEFKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h88zehIHH9osNLnZD4ANc2r3jztB8Gkd87YF/qwLE/v09MJr4GjzQnb4F5MOAMIzGOrkpcKwQrDTNnQAgWAEqaOD3CoeoBdnawDDtkUjwCjUaZcvbWLUGRH3gBgvy0+HUNikD38U3FwiJ1X+53Fq3npd2gaDUrciMeJQ2qOgbqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=I/LIUOGy; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="I/LIUOGy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=NZjnQriiOxtzw2uVqIjhf4wlJPsPK2mEZb
	vQ5yCCAPo=; b=I/LIUOGyBECTKUyizK8+AURUruUjLzycWFTsH92CTkkkBE81c8
	Yp69CbhV9bn/9mxy0FOIewJAqbZo1YvxqRxPTPe+R2qFzO/0QXbHNcA4eqWLAWiH
	2/QJgR+4iiazOf2fsqn89uUpfhI54fm41wDO0fyU3RLu/3QTyeyjm/42U=
Received: from leopard.. (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwCXxs1X0Y9qwlkBAA--.439S4;
	Thu, 27 Aug 2026 13:55:49 +0800 (CST)
From: Xincheng Zhang <zhangxincheng@ultrarisc.com>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	bhelgaas@google.com,
	wangjia@ultrarisc.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>
Subject: [PATCH 2/2] PCI: ultrarisc: Skip MEM outbound iATU setup on DP1000
Date: Thu, 27 Aug 2026 13:54:48 +0800
Message-Id: <20260827055448.1818858-3-zhangxincheng@ultrarisc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827055448.1818858-1-zhangxincheng@ultrarisc.com>
References: <20260827055448.1818858-1-zhangxincheng@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwCXxs1X0Y9qwlkBAA--.439S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AF18Kr1kKw1UAFy5JF48tFb_yoW8Gr1xpa
	srKw1UCa4qqF4Yka1Iy3WkA3WYva1DAF98KFZFk347ua13u34UJryfKa4Fy3WDCw4UXr1Y
	kr1Yy34xJF45X37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUml14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
	JbIYCTnIWIevJa73UjIFyTuYvjfUbfO7UUUUU
X-CM-SenderInfo: x2kd0wp0lquxxhqjq3powut2xlvfhudrp/1tbiAQAMDGqPrHsAFQAAsm

DP1000 has 16 outbound iATU windows and each window can map up to 4GB. One
window is used for CFG accesses, one for I/O space and one for the 32-bit
MEM aperture, leaving only 13 windows for the 64-bit MEM aperture.

This limits the 64-bit MEM aperture that can be described with outbound
iATU windows. DP1000 routes MEM transactions without using outbound iATU
windows, so skip generic DWC MEM outbound iATU setup to allow a larger
64-bit MEM aperture.

Set dw_pcie_rp::bypass_ob_mem_iatu for this controller.

Signed-off-by: Xincheng Zhang <zhangxincheng@ultrarisc.com>
---
 drivers/pci/controller/dwc/pcie-ultrarisc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
index 51e89180490d4..0d4989a0f3afc 100644
--- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
+++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
@@ -154,6 +154,12 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
 
 	pp = &pci->pp;
 
+	/*
+	 * DP1000 routes MEM transactions without outbound iATU windows, which
+	 * avoids the 16-window/4GB-per-window aperture limit.
+	 */
+	pp->bypass_ob_mem_iatu = true;
+
 	platform_set_drvdata(pdev, ultra);
 
 	ret = ultrarisc_pcie_init_clks(ultra);
-- 
2.34.1

