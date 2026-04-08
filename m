Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099343D9027;
	Wed,  8 Apr 2026 17:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671067; cv=pass; b=C4lGVo80r+TiCj5D8jC+CNfXhwGivwRDi3zjitXtmnDim/QXq7jow7nVMTNU439hiXZtAWWrM8oAu06lxWvqfwosnCYrihyCa4ZA5IKZyecA+vo1xgXwG3JaQ34GFPzEu10+8Y9YGLA1mgq4xi/0l3edjzspUaklQ1QOUeNhceo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671067; c=relaxed/simple;
	bh=Y6T0jbAcKzSvw6cN8qw0CztXkKVreZpkXHAOkeyyZWI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K7BC30Fsx7LqvB1IMIwn+yNogb2hcBO2OzGUYxu6O1beeGPSyA1gjQ7IdNC/Xzilm+UGH2r6VDcbTPY2TcIjUzR4m/YEXEoUfhNfkKtFueGcG5JaadCUf3Q90YjzxWLzfsWstR678ErLht2/dFB2xDxr9CtMEPX/BlDTfOyvqJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=GjPFp+7z; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="GjPFp+7z"
ARC-Seal: i=1; a=rsa-sha256; t=1775671041; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=exeaXtbr2Hw43s8iGcGd8frkjNj4yj5XJuuj0IkGZSXOuGB7zvyPAIBatElcaelomnOTgZRBvRUhmzfybOfRJKhyzfL+YiS/Bl/WD60IKSLRcNr4vUyqAtjLjdmj4bTZlmLOFHTuI9eR/H/TBznxvtHKOfJI1dabfWuL+5/JgkE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775671041; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=p4pF/F9iArMybAchaDSsfxBcz1TRYzAHsA/fPnJEh7Q=; 
	b=d12wKUnwCGdTCK/7902RZ6G3Dup4QMXi8XbZDvuAuN2URcoxDqVHYMs6r8I9JAUq0LwKc7Wn4KoQi+AUL5nGYR2slrXzmytiGqBRg8Yu8r3qkcjDPLnbuAlIQVty9cZE6/po5yrGMDEuZ+dX1rYC8XjSosnpIWeupMf35/n50WU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775671041;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=p4pF/F9iArMybAchaDSsfxBcz1TRYzAHsA/fPnJEh7Q=;
	b=GjPFp+7zMBflyY0tAme4KCFoFIJ3+aQ5+f9umJ7zDW5OkOTwjU0yTRIO7dh20y3I
	KXgaoUZcWfNt2PhezJ5Aa4t6Ke+ewQUTDw67D5hx3xx0/3mjorD09BiS4YDIFB4A6Hx
	NVMquKKxiveILly4aK4f3m6WhiGu9WUtAXBM0YRKsqH6ksfUYJKujsD12l0DGVe6+Wl
	F8TwGA30YqMjmazWPwwEBKstrap6GTyfEGsm9iuUQT2qhK3WvI598B3gqn8P1xlbjXF
	U5cOOA+HOZk3x6n6ivcWGhQKuTTIve2dYg6RCxNLtul8pPuLZD7X5w0Bpwtj7lQEIOm
	mQhE95Butw==
Received: by mx.zohomail.com with SMTPS id 1775671038793514.9253555983514;
	Wed, 8 Apr 2026 10:57:18 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Subject: [PATCH 0/2] PCI: loongson: Do not ignore downstream devices on
 external bridges
Date: Thu, 09 Apr 2026 01:56:56 +0800
Message-Id: <20260409-ls7a-bridge-fixes-v1-0-3650fedf1afc@rong.moe>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOiW1mkC/yWMywrCMBAAf6XsuYEY0pj6K8VDHquulCjZKkLIv
 3fV4zDMNGCshAynoUHFNzE9isBhHCDdQrmioiwMRhunrfZq5WNQsVIWdaEPsvJhjpMNLjqTQLp
 nxZ+QbDn/mV/xjmn7jqD3HWQdQph1AAAA
X-Change-ID: 20260408-ls7a-bridge-fixes-8a9b54a6b62c
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Huacai Chen <chenhuacai@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 "Lain \"Fearyncess\" Yang" <i@lain.vg>, Rong Zhang <i@rong.moe>
X-Mailer: b4 0.16-dev-7777e
X-ZohoMailClient: External

Loongson PCI host controllers have a hardware quirk that requires
software to ignore downstream devices with device number > 0 on the
internal bridges. The current implementation applies the workaround to
all non-root buses, which breaks external bridges (e.g., PCIe switches)
with multiple downstream devices.

Fix it by only applying the workaround to internal bridges.

Tested on Loongson-LS3A4000-7A1000-NUC-SE, using AMD Promontory 21
chipset add-in card [1].

  $ lspci -tnnnvvv
  -[0000:00]-+-00.0  Loongson Technology LLC 7A1000 Chipset Hyper Transport Bridge Controller [0014:7a00]
             +-00.1  Loongson Technology LLC 7A2000 Chipset Hyper Transport Bridge Controller [0014:7a10]
             +-03.0  Loongson Technology LLC 2K1000/2000 / 7A1000 Chipset Gigabit Ethernet Controller [0014:7a03]
             +-04.0  Loongson Technology LLC 2K1000 / 7A1000/2000 Chipset USB OHCI Controller [0014:7a24]
             +-04.1  Loongson Technology LLC 2K1000 / 7A1000/2000 Chipset USB EHCI Controller [0014:7a14]
             +-05.0  Loongson Technology LLC 2K1000 / 7A1000/2000 Chipset USB OHCI Controller [0014:7a24]
             +-05.1  Loongson Technology LLC 2K1000 / 7A1000/2000 Chipset USB EHCI Controller [0014:7a14]
             +-06.0  Loongson Technology LLC 7A1000 Chipset Vivante GC1000 GPU [0014:7a15]
             +-06.1  Loongson Technology LLC 2K1000 / 7A1000 Chipset Display Controller [0014:7a06]
             +-07.0  Loongson Technology LLC 2K1000/2000/3000 / 3B6000M / 7A1000/2000 Chipset HD Audio Controller [0014:7a07]
             +-08.0  Loongson Technology LLC 2K1000 / 7A1000 Chipset 3Gb/s SATA AHCI Controller [0014:7a08]
             +-08.1  Loongson Technology LLC 2K1000 / 7A1000 Chipset 3Gb/s SATA AHCI Controller [0014:7a08]
             +-08.2  Loongson Technology LLC 2K1000 / 7A1000 Chipset 3Gb/s SATA AHCI Controller [0014:7a08]
             +-09.0-[01]----00.0  Qualcomm Technologies, Inc QCNFA765 Wireless Network Adapter [17cb:1103]
             +-0a.0-[02]----00.0  Etron Technology, Inc. EJ188/EJ198 USB 3.0 Host Controller [1b6f:7052]
             +-0f.0-[03-08]----00.0-[04-08]--+-00.0-[05]----00.0  Shenzhen Longsys Electronics Co., Ltd. FORESEE XP1000 / Lexar Professional CFexpress Type B Gold series, NM620 PCIe NVME SSD (DRAM-less) [1d97:5216]
             |                               +-08.0-[06]----00.0  MAXIO Technology (Hangzhou) Ltd. NVMe SSD Controller MAP1202 (DRAM-less) [1e4b:1202]
             |                               +-0c.0-[07]----00.0  Advanced Micro Devices, Inc. [AMD] 600 Series Chipset USB 3.2 Controller [1022:43f7]
             |                               \-0d.0-[08]----00.0  Advanced Micro Devices, Inc. [AMD] 600 Series Chipset SATA Controller [1022:43f6]
             \-16.0  Loongson Technology LLC 7A1000 Chipset SPI Controller [0014:7a0b]

Fixes: 2410e3301fcc ("PCI: loongson: Don't access non-existent devices")
Link: https://oshwhub.com/wesd/b650 [1]
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Co-developed-by: Lain "Fearyncess" Yang <i@lain.vg>
Signed-off-by: Lain "Fearyncess" Yang <i@lain.vg>
Signed-off-by: Rong Zhang <i@rong.moe>
---
Rong Zhang (2):
      PCI: loongson: Move bridge device ids to file scope
      PCI: loongson: Do not ignore downstream devices on external bridges

 drivers/pci/controller/pci-loongson.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)
---
base-commit: 3036cd0d3328220a1858b1ab390be8b562774e8a
change-id: 20260408-ls7a-bridge-fixes-8a9b54a6b62c

Thanks,
Rong

