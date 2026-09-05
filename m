Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A53378D9A;
	Sat,  5 Sep 2026 02:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788577042; cv=none; b=UF6DBtrgShTIayIIYJMi6IgNfMZfyYcBd5in/8JoxXsrHnD6iHeEcBw2zCf+Ut34MEOebhuSbC4fPJSty7tvN6qlc7lRljcn6bPRAG+SSRvJT7G3M9pzjm271ClOcdJKqK12m92up3cpHHrsyPa5Lftdpqu5FNt59R0UkFJum1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788577042; c=relaxed/simple;
	bh=Cz9oKUCkripl1kkQ1ee76SmB+4V9VAbTDsRNhilQOHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gHqbAVV+XWynRt4gk2uaBlGXl/RhhQ3AKhwOHnyGSwslIlkugfOynWy2kz6FJSWmMNuhaGQDsM8rM6DOh3v8SJ0id05pOwDnThRCFnKUHcekkvW+KQxixgrq0RkZuSg/VbO7n0YJG7rr1R6pbiuXTzccbqFo7zX75tRx3OpHL+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=jezoKvSM; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="jezoKvSM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=IdTG/sFDU/AU2CnhuWPPTMvHsTi/sQ5W6S
	Q8NCJt8Lk=; b=jezoKvSMyXMDfiAw6VmH19orZpgdRjEFcs0fNcJYFDmhz7PNU+
	UKkxyFz2zeUo+zDsqZtV2TBmiU8IxFXyDu5tOIQv/lqyUTeHlZefembuOhgb35Em
	e5vnB4HCFFz3UpxrK52P6YIW9dF8W1sQGYTiSY6kCoXQ8oeByPxAqnuFE=
Received: from leopard.. (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDHQAcKhZtqDUQAAA--.300S3;
	Sat, 05 Sep 2026 10:57:28 +0800 (CST)
From: Xincheng Zhang <zhangxincheng@ultrarisc.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jia Wang <wangjia@ultrarisc.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>
Subject: [PATCH v2 1/2] PCI: dwc: Allow drivers to skip MEM outbound iATU setup
Date: Sat,  5 Sep 2026 10:56:34 +0800
Message-Id: <20260905025635.211390-2-zhangxincheng@ultrarisc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905025635.211390-1-zhangxincheng@ultrarisc.com>
References: <20260905025635.211390-1-zhangxincheng@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDHQAcKhZtqDUQAAA--.300S3
X-Coremail-Antispam: 1UD129KBjvJXoWxArW3Cr4Utw15Ar1kWF17Jrb_yoW5CFykpa
	y7tFWSyF1kJF43Zr43Z3WkZryYyas3AFWUGFZa934IvrW3uryjqr1rtFy7try3Gr40vry5
	Kr4Yva4kGFs8J3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmm14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
	1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
	JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
	YxBIdaVFxhVjvjDU0xZFpf9x0JU2dgAUUUUU=
X-CM-SenderInfo: x2kd0wp0lquxxhqjq3powut2xlvfhudrp/1tbiAQABDGqaaqQALgAAsc

Some DWC-based controllers do not require outbound iATU windows for MEM
transactions. For those platforms, programming outbound iATU windows for
host bridge MEM ranges is unnecessary and may constrain the available MEM
aperture.

The DWC PCIe RP Controller Databook v6.00a, section 3.12.2, describes the
default outbound no-match behavior as pass-through. Section 3.12.5.6, "No
Address Match Result", says the address is not translated and programmable
TLP header fields come from the application transmit interface.

This no-match path cannot translate between different parent-bus and PCI
addresses, so require skipped MEM ranges to be identity-mapped.

Add dw_pcie_rp::bypass_ob_mem_iatu so drivers can skip generic MEM iATU
setup while using the common DWC host init path.

Existing drivers keep the current behavior because the flag defaults to
false. The I/O iATU setup does not use the MEM resource iterator, and the
iterator may be uninitialized when MEM setup is skipped. Avoid using it in
the I/O iATU error path.

Signed-off-by: Xincheng Zhang <zhangxincheng@ultrarisc.com>
---
 .../pci/controller/dwc/pcie-designware-host.c   | 17 +++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.h    |  1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f5a38e6fd8d79..b06797b4e31d2 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -918,6 +918,20 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
 		atu.pci_addr = entry->res->start - entry->offset;
 
+		if (pp->bypass_ob_mem_iatu) {
+			/*
+			 * The no-match pass-through path preserves the correct
+			 * PCI address only for identity-mapped MEM ranges.
+			 */
+			if (atu.parent_bus_addr != atu.pci_addr) {
+				dev_err(pci->dev,
+					"Cannot bypass outbound iATU for non-identity MEM range %pr\n",
+					entry->res);
+				return -EINVAL;
+			}
+			continue;
+		}
+
 		/* Adjust iATU size if MSG TLP region was allocated before */
 		if (pp->msg_res && pp->msg_res->parent == entry->res)
 			res_size = resource_size(entry->res) -
@@ -964,8 +978,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
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

