Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFB9309F09;
	Thu, 27 Aug 2026 05:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810138; cv=none; b=kUEc9RHM5C2euK2rQRL9YtAwx0+0glis9TYNCPe6FtL70o/UXpYD6kQB8HsrGg1YBs/ui0ZoclfLtjSADPx3l04fZFZDAkSjqJdkFex3As5uK/bxC6SF3HzVwe9HmCe7ExsR1EUGUrPJEz9RMj1vUtAaxTA1Eecb2eTHIiH2ePk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810138; c=relaxed/simple;
	bh=DJuCgI4jFUUnRkzJ4ExvyPfFGIlzGX82nWJYn4WNjfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J0LcE1QVvtS+oxoUMUlUD1g2fiFOP2CJ6b4BFwwSVwK1xW9lAjF6oIPayRyMhm7+K/+9A0KMvOyJxGuxP0OhcZKGUjpx4z2MFDmYNUgX0T6tmKiQHABzxwDJKc06A0V0lpUxoP2QohOBnzlSAqlLr6f0Klj/YftWtjtsm1s2GNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=H3VKoLgC; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="H3VKoLgC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=ZoM1jLARMD60HOOUxRrFJINQSlrnoc4OSt
	nrK7u1spE=; b=H3VKoLgCyllmffaZQFdgLgnyauXrH3yVFu1JqoK2qqGXLx+ZWB
	PUEjtYdVI002n6O4nafyi/iu26H8LKMl/wp95rZh9enJnotsTyYHQJks3CbyYTEO
	rS3dCUJpKRDmBsaglV3aFZM36GRFd88hEQrkDOixOZ+B79dUUq0JVdo1U=
Received: from leopard.. (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwCXxs1X0Y9qwlkBAA--.439S3;
	Thu, 27 Aug 2026 13:55:45 +0800 (CST)
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
Subject: [PATCH 1/2] PCI: dwc: Allow drivers to skip MEM outbound iATU setup
Date: Thu, 27 Aug 2026 13:54:47 +0800
Message-Id: <20260827055448.1818858-2-zhangxincheng@ultrarisc.com>
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
X-CM-TRANSID:AQAAfwCXxs1X0Y9qwlkBAA--.439S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1ftrW8tFWDZr4DCF4fAFb_yoW8Kr45pa
	yDtay0y3WkJa15ZF4ay3Z5Zr1Yv3ZrAFWUGa9a934I9Fy3Zryjqr18tFyayry7Gr4jqr13
	K3W7ta4kGFs8JFUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUml14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
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
	JbIYCTnIWIevJa73UjIFyTuYvjfUn2-5UUUUU
X-CM-SenderInfo: x2kd0wp0lquxxhqjq3powut2xlvfhudrp/1tbiAQAMDGqPrHsAEwAAsg

Some DWC-based controllers do not require outbound iATU windows for MEM
transactions. For those platforms, programming outbound iATU windows for
host bridge MEM ranges is unnecessary and may constrain the available MEM
aperture.

Add dw_pcie_rp::bypass_ob_mem_iatu so drivers can skip generic MEM iATU
setup while using the common DWC host init path.

Existing drivers keep the current behavior because the flag defaults to
false. The I/O iATU setup does not use the MEM resource iterator, and the
iterator may be uninitialized when MEM setup is skipped. Avoid using it in
the I/O iATU error path.

Signed-off-by: Xincheng Zhang <zhangxincheng@ultrarisc.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f5a38e6fd8d79..3c5f5ff080818 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -911,7 +911,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 	resource_list_for_each_entry(entry, &pp->bridge->windows) {
 		resource_size_t res_size;
 
-		if (resource_type(entry->res) != IORESOURCE_MEM)
+		if (pp->bypass_ob_mem_iatu ||
+		    resource_type(entry->res) != IORESOURCE_MEM)
 			continue;
 
 		atu.type = PCIE_TLP_TYPE_MEM_RDWR;
@@ -964,8 +965,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 			ret = dw_pcie_prog_outbound_atu(pci, &atu);
 			if (ret) {
-				dev_err(pci->dev, "Failed to set IO range %pr\n",
-					entry->res);
+				dev_err(pci->dev, "Failed to set IO range\n");
 				return ret;
 			}
 			ob_iatu_index++;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0735ae9409240..d89badcca2689 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -469,6 +469,7 @@ struct dw_pcie_rp {
 	struct pci_config_window *cfg;
 	bool			ecam_enabled;
 	bool			native_ecam;
+	bool			bypass_ob_mem_iatu;
 	bool                    skip_l23_ready;
 	bool			skip_pwrctrl_off;
 };
-- 
2.34.1


