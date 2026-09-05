Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C420E2D5408;
	Sat,  5 Sep 2026 02:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788577038; cv=none; b=oXdmkfV3k9LoGqdCgMrXh4hnPmOivIlmnsZ5ZhrJM5a2pVujzYj2rOaIyHQLzcVUvZgDRZn4RMvEVwCIEwmQ9enKziVwoSPlqyfpDsklM8QzDTeLt4tb2yc4IT/DnqbY8WLb8mh+A5wBoxWhiLqB0kWxY/v+hN5Dl2ZVXwrlne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788577038; c=relaxed/simple;
	bh=ob7QuhbJ63gQqWr132BmqMN3wAfyZFZvYUC2UhD3Y9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KlfPBCCNZns3FWbsXL8H44S387lf+3GcfX7W94SfQMzo9/I/mKWnKfybt1i9XNT7QU6mYlFC41rGyDERdSg5/1AE7EOP5iprhrmdoLmP5+JpFG9e1Z1j8SjmSCzIyzEZ48bVR00YPaZcPd77oc5/s5qj3gSOYI9ausxV0UNeEuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=apizX729; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="apizX729"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=SVE5CYD1xj
	2zgu55kR8VD+aJ2woz2nHNWLxmmQdm7cQ=; b=apizX729bYZCcjVuuLnlp0WSPT
	j5Btedi7CZ/yBtqCYD7IbAMGDioCCl7t4i9i+3sINOqCXvT8TcdBZJOeWgq9ZcpU
	ci649n/tmcoIzNzKZWmLQ69kDzCVtO2wX5q4G2eu6DsaK0INgpT5A6OdxvuqUwBk
	R+CYywFKxfufHmvLk=
Received: from leopard.. (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDHQAcKhZtqDUQAAA--.300S2;
	Sat, 05 Sep 2026 10:57:14 +0800 (CST)
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
Subject: [PATCH v2 0/2] PCI: dwc: Support large BARs on UltraRISC DP1000
Date: Sat,  5 Sep 2026 10:56:33 +0800
Message-Id: <20260905025635.211390-1-zhangxincheng@ultrarisc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDHQAcKhZtqDUQAAA--.300S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw13Gw4ftw4xKw15Jry8Grg_yoW8WF1Upa
	4xKFWYyrWDJFZIyr43K3WIy34avFs7AFZF9FZ8tw18Zrn3CFW7trn5Ka1YvFnxXr4xZr4j
	qF1YvFykWF1rJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: x2kd0wp0lquxxhqjq3powut2xlvfhudrp/1tbiAQAADGqZGSQAUgACsT

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

Changes in v2:
- Validate skipped MEM ranges are identity-mapped before bypassing outbound
  iATU setup.
- Document the DWC PCIe RP Controller Databook v6.00a no-match pass-through
  behavior.
- Clarify that the DP1000 bypass is MEM-only; CFG and I/O iATU setup is
  unchanged.

Link: https://lore.kernel.org/r/20260827055448.1818858-1-zhangxincheng@ultrarisc.com

Xincheng Zhang (2):
  PCI: dwc: Allow drivers to skip MEM outbound iATU setup
  PCI: ultrarisc: Skip MEM outbound iATU setup on DP1000

 .../pci/controller/dwc/pcie-designware-host.c   | 17 +++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.h    |  1 +
 drivers/pci/controller/dwc/pcie-ultrarisc.c     |  6 ++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.34.1

