Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2BD3A7193;
	Mon, 19 Oct 2026 06:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392442; cv=none; b=mBFQG3r+nbQoOMsxUHSa67YPPTWpWYxsTTCYINHsBx+YU7sOdge1dlndJ9jpA8inhUmxAcaUhApmuUs9yQ7iFxkU2QlhAxv/3XyDLY3Gp9zV0ysf3Nl8QaKEazEov6z9J9bsrTmcCTV6E+C3UL7d2pnRuEOizyrcsWZYlZkc3sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392442; c=relaxed/simple;
	bh=Jx+tZOBjWgak424sCB5uyhVPgpJ40zsFG7LYIPpf6+Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E03MJoRSnPeF1OEyLSkXEci1CMIJRtOHPsmGkC+w8sT1zJIxVk5oja7bgbLjEbPa++N3vvVctEdU5Pn2eb629SV7TkfUt3UgI8kKqsuK26amMjs1xMSXs/QjZxKGCZdxzriWH2r0rQJl62gfRsLQmK0e1b49FRe1X/pncTGiRlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=aUtJvXvt; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="aUtJvXvt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:Subject:Date:Message-Id:
	MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc; bh=gP
	NbAxjpVOKYzA4WvVbuFWOnaiN6Yj/z0JRn6fNoTbs=; b=aUtJvXvtT/nizKzql4
	51bbJ7GE+0RWCF6b7OXm1Q00S9+qyh2bE9r7dkgeEisVvJLX14a07FuBGyECtRkp
	zqbWKc+8mX3BSJC0TVPR7RTbwHtHvlcnA3dtFsct9o4/6hI7b67qByKvLcaMrR93
	HVcBqyNYsvMXaG+SkCDQ9rgew=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwC3cwXnvNVqC28CAA--.728S2;
	Mon, 19 Oct 2026 14:47:05 +0800 (CST)
From: Xincheng Ji <jixincheng@ultrarisc.com>
Subject: [PATCH 0/2] PCI: dwc: Fix MEM outbound iATU setup
Date: Mon, 19 Oct 2026 14:47:01 +0800
Message-Id: <20261019-dw-pci-fix-v1-0-9b7860f919b9@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOW81WoC/yXMyw5AMBCF4VdpZm2StkLEq4gFNWUskI5bIt5ds
 fxOcv4LhAKTQKkuCLSz8DxFmESBG5qpJ+QuGqy2udEmw+7AxTF6PtEVlBlfpC1pC/GwBIrzF6v
 q37K1I7n1LcB9PzZEBOluAAAA
X-Change-ID: 20261015-dw-pci-fix-c8e51f83be02
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792392423; l=1310;
 i=jixincheng@ultrarisc.com; s=20260922; h=from:subject:message-id;
 bh=Jx+tZOBjWgak424sCB5uyhVPgpJ40zsFG7LYIPpf6+Y=;
 b=qNYrXee8wTSETKHo88M/ZxXDERRDzVCWgfB9IuDTJtAX38V/tVLZ3IDF+tDlA0Mc3/6LfukxA
 mHy2RePtV8hA0fzRlvzBwj2jnO9VX2yA+i7yYDk6iFl+EbxKFCBzoff
X-Developer-Key: i=jixincheng@ultrarisc.com; a=ed25519;
 pk=n848dcS5D6g0vLad/rjp4Gf/1eedTe1a3pYUrkt2260=
X-CM-TRANSID:AQAAfwC3cwXnvNVqC28CAA--.728S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF47WF1DKr1ktr4DKw4UJwb_yoW8Jw4xp3
	WagFy7AFy8ArZIyr4ay3WUZ34jya1kAayjgF4Dtw1xCF1rua4UXr98Kw1rtas8GryrZr45
	Kr1YqryxGanYya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAIcxvE14x267AKxVWUJVWUGwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-s
	yl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUbgAzUUUUU
X-CM-SenderInfo: pml0x0xfkh0wg6xo325dul2uoofrz/1tbiAQAJDmq-VKkAAgAzsf

This series follows up on the recently applied MEM outbound iATU support.

The DesignWare outbound no-match path does not translate addresses. Skip
MEM outbound iATU programming whenever atu.parent_bus_addr matches
atu.pci_addr, rather than relying on a driver-specific flag. CFG and I/O
accesses, as well as non-identity-mapped MEM ranges, continue to use
outbound iATU windows.

Patch 1 removes bypass_ob_mem_iatu from the generic DesignWare PCIe host
code and directly compares the parent-bus and PCI addresses before
programming a MEM outbound iATU window.

Patch 2 removes the now-redundant bypass_ob_mem_iatu assignment from the
UltraRISC DP1000 driver.

Signed-off-by: Xincheng Ji <jixincheng@ultrarisc.com>
---
Xincheng Ji (2):
      PCI: dwc: Skip MEM outbound iATU setup for identity mappings
      PCI: ultrarisc: Remove bypass_ob_mem_iatu variable on DP1000

 drivers/pci/controller/dwc/pcie-designware-host.c | 17 +++++------------
 drivers/pci/controller/dwc/pcie-designware.h      |  1 -
 drivers/pci/controller/dwc/pcie-ultrarisc.c       |  6 ------
 3 files changed, 5 insertions(+), 19 deletions(-)
---
base-commit: 0a2602de077462d3111eb9fd3da5b12a57fc6c93
change-id: 20261015-dw-pci-fix-c8e51f83be02

Best regards,
--  
Xincheng Ji <jixincheng@ultrarisc.com>

