Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC17313527;
	Thu, 27 Aug 2026 05:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810130; cv=none; b=VnC5wKjgEY4EDHgvSFwqeEfktvCppI3cK2DxI1oUMP2eHRlNjXRc1WaR1bVRcjcm/twiZ1CENXS18uWCRH2zrwYq0AsS7lm/xYJU5T5yRNqdxB/UsoiofeDiQ7MrnnHFBKK+CnKwACtAh+rbB2HM2QwXwdIA4bxKjB1BJYDYQ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810130; c=relaxed/simple;
	bh=trsOUdd1lRZ7XKpvfK7l9uGEW4PxgZ43ZJS3GWLF2J4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nTf/+2JuXsBObNrRxgTKfllFlMRB9Sxo0AW1CgQwDZEs+UPFaZeReOh1VBaUq6wPhnLT2ex2Hq+IMTwsWhJNkOtWkZkhUuNVOWE4o3u1pGgwRcMi/KUvd5m2ffd8ep9yDopGvyQOyX93eV1ZMCOk2p4YMRF7V/OH7voEDr8wM+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=oQOurvzk; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="oQOurvzk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=MlyOhvWALv
	LnWN9U74xBKSAjnL/SVou1RLHEKTxPF2M=; b=oQOurvzkev1am5cNXzIIpRHIoL
	6tF9SJV9761HrZkhAMFKT9pGScjVBLvX+t7qZEuY4fRtufCxxnDI9+UMQRvjrfTW
	VSi5uJQQ3+5pffqUj2GelYcZ6nddcpJ7MImlGCHwEk5KvDvGtIPAy2sHVQ0Ryv2J
	fa1Aor+8lBd+wmhiM=
Received: from leopard.. (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwCXxs1X0Y9qwlkBAA--.439S2;
	Thu, 27 Aug 2026 13:55:35 +0800 (CST)
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
Subject: [PATCH 0/2] PCI: dwc: Support large BARs on UltraRISC DP1000
Date: Thu, 27 Aug 2026 13:54:46 +0800
Message-Id: <20260827055448.1818858-1-zhangxincheng@ultrarisc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwCXxs1X0Y9qwlkBAA--.439S2
X-Coremail-Antispam: 1UD129KBjvJXoWruF1Utw13Wry8tr1rArWxCrg_yoW8Jr4kpa
	4xKFW0yryDJFZxAr17K3Z2y34avan7Aa9FkFZ0q348ur13CFZ7trnYkay5tFnxJr4xXr4F
	qFn0vFykGF1rtaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbzpBDUUUUU==
X-CM-SenderInfo: x2kd0wp0lquxxhqjq3powut2xlvfhudrp/1tbiAQAMDGqPrHsAEQAJsr

This series lets DWC host drivers skip generic outbound iATU programming
for host bridge MEM ranges, which is useful for some compute cards' very
large BAR size demand (>100GB).

DP1000 has 16 outbound iATU windows, and each window can map up to
4GB. This limits its allocatable MEM64 BAR size to 4GB*(16-3)=52GB
(-3 for CFG, I/O and MEM32).

But some EPs like compute cards demand large BAR size that exceeds the
mapping limit of the 13 iATUs. DWC IP spec allows RC to skip MEM iATU setup
and simply uses a direct mapping. By introducing a `bypass_ob_mem_iatu`
flag at the RC level, this patch enables large BARs on UR-DP1000
RISC-V CPU.

Tested on UltraRISC DP1000 EVB and Titan board. The system booted
successfully with PCIe links up on all three controllers and NVMe rootfs
mounted. MMIO read/write speed test within the large BAR space goes well.

Xincheng Zhang (2):
  PCI: dwc: Allow drivers to skip MEM outbound iATU setup
  PCI: ultrarisc: Skip MEM outbound iATU setup on DP1000

 drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 drivers/pci/controller/dwc/pcie-ultrarisc.c       | 6 ++++++
 3 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.34.1

