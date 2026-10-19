Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5343D23BCED;
	Mon, 19 Oct 2026 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392444; cv=none; b=IMjQN7kmA1dq4nByfBHVDILpaSptMJMHpdkvf3mMWxOYyjgWMSgpu8tZASx1GOEYuVQgEE2CBJk+5sQ089UBArhLG9MNcZ3NY290S8z/BoqXU39ijcCo89cD2+4GA9xwSIbIBVDUSE+Un+JR4S68LnAYSo0o9yi4Y1htLM5vI58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392444; c=relaxed/simple;
	bh=4VsvykK54zLvmmRtvQohmyKwI+tf+4VX/Q7c5bj+6Zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=brnbC2TZwfpjUmoaMNlHas70Ld3lDn2GuqMhu7U2Mev+WtN8OkmI3NwGwPXmo/VXfcBh50eac6NuFVSR3WsZF/O/oOxyvJg9fcWhvYO3FLbDb8LSTVXjGbVamHzSLHGOSGqOnLiJJbl+Tg3gLelyo5hMWiGy68/gFA6/7ARvU+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=TUefa68z; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="TUefa68z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=BCZhmT2V/2Yi/A+XDxOBor2BzyhdmT7
	YWkibE4bCXak=; b=TUefa68z+HtcGjU4+Cq/oECJfM5kvpafVynRDHvRZvkbld+
	hOmyDNuXBV2z+mTKON1IGRSvd21ihH4JlNC6Hwe56ONIG6GiEDIeMxzy5VoxYAZW
	17pRPzxoZdY0tKQk3mNP3/9Vi4W0lVYG+C5g78JuFqBWv0WEzr2osJZRjV+Q=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwC3cwXnvNVqC28CAA--.728S4;
	Mon, 19 Oct 2026 14:47:09 +0800 (CST)
From: Xincheng Ji <jixincheng@ultrarisc.com>
Date: Mon, 19 Oct 2026 14:47:03 +0800
Subject: [PATCH 2/2] PCI: ultrarisc: Remove bypass_ob_mem_iatu variable on
 DP1000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-dw-pci-fix-v1-2-9b7860f919b9@ultrarisc.com>
References: <20261019-dw-pci-fix-v1-0-9b7860f919b9@ultrarisc.com>
In-Reply-To: <20261019-dw-pci-fix-v1-0-9b7860f919b9@ultrarisc.com>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Niklas Cassel <cassel@kernel.org>, 
 Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Jia Wang <wangjia@ultrarisc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xincheng Ji <jixincheng@ultrarisc.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792392423; l=1066;
 i=jixincheng@ultrarisc.com; s=20260922; h=from:subject:message-id;
 bh=4VsvykK54zLvmmRtvQohmyKwI+tf+4VX/Q7c5bj+6Zg=;
 b=EcnT92ZANmqfA46KMt4NxMzC5396h8SjVVvIvA9KbV2/J8qJ3SqVQyLj+O5dXfmul3YpF3z/N
 BgqWPscJSPfCe2NEXoh9ZFbrmFTg4IiturVpCBCSjMoODuN9LEscdEy
X-Developer-Key: i=jixincheng@ultrarisc.com; a=ed25519;
 pk=n848dcS5D6g0vLad/rjp4Gf/1eedTe1a3pYUrkt2260=
X-CM-TRANSID:AQAAfwC3cwXnvNVqC28CAA--.728S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1fAF1fZF1xWF1fGFy8Zrb_yoWkJrgEv3
	4kKF47Aw1DCr97GFsF9w1IyrZ0ywnrZw1kC3Wkt3WxAa4Sqr1UXryvvrZ0ya4jqw15Jr97
	Kr92yF1jkrWrtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbH8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
	x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1l0xvY
	67AC8VAFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
	8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCF
	s4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFI
	xGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjF1vDUUUUU==
X-CM-SenderInfo: pml0x0xfkh0wg6xo325dul2uoofrz/1tbiAQAFDmrUbKwAHgAAsq

The DP1000 PCIe address space is the same as the CPU address space.
In this configuration, the DWC controller supports bypassing the
outbound iATU window, so a separate variable is unnecessary.

Fixes: 8da2b970ed4c ("PCI: ultrarisc: Skip MEM outbound iATU setup on DP1000")
Signed-off-by: Xincheng Ji <jixincheng@ultrarisc.com>
---
 drivers/pci/controller/dwc/pcie-ultrarisc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
index 523f454c6c52..a0d328c0c09b 100644
--- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
+++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
@@ -154,12 +154,6 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
 
 	pp = &pci->pp;
 
-	/*
-	 * DP1000 routes MEM transactions without outbound iATU windows, which
-	 * avoids the 16-window/4GB-per-window aperture limit.
-	 */
-	pp->bypass_ob_mem_iatu = true;
-
 	platform_set_drvdata(pdev, ultra);
 
 	ret = ultrarisc_pcie_init_clks(ultra);

-- 
2.34.1

