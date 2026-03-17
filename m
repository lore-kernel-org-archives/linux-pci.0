Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A5D33BBC6;
	Tue, 17 Mar 2026 06:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773730012; cv=none; b=X0wHKmLe3xoqU8qX6p/YSmBUd+ZdRIdAkl3WGmzAZQ9WObXDD9cvAHw2dtqiLkM6N43mnDaQcD/AMWS4smRGtRk+7Tl+v/fuqa5oWk+MKH1RECI11QFREUncnoagnyVYZklzuPvZLtbvxrxA1QTrt0EZFQaCtNYUUMR+YkfB0R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773730012; c=relaxed/simple;
	bh=Wh4r1tJxW/lcrM+5/s3mKCV9XBfeqG6hKDHxb5EPDGw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ONU0Jwxvd7EYjdeoHJhTSQqkBfzY02NbseRl7HJFHGk6DvoHpOTk7wWN7YiO7UFqxyDN8uL8oFsu5YzBo1RRz8TyJXjIGKP95D8pKhVfzOPv5tH1yaWPSSA1L4IfI/2VggYrgfztsgXnwjorduLI2QrHjVR8dD4kfvglwhH9D28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=D0au6Zbv; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="D0au6Zbv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=gIoVGh7it5fMYUkkNLHp8OH2p11aLnm6q
	S09VmO8Afg=; b=D0au6ZbvipQmgQNRbvlxf2uZ8Ml+cTM36jHoo5umNmfQ8QwgF
	VfdEXq7RkCDI2C3cKihBZeQI7ETx0dZJQWQFEdrAootKoX8uGDyp65rL2HY1HNW5
	BY+NeKxuRcv55W77ImFvfnr38gFl7fCgCN/VeOG1jqr0kdjZRB/RTQ4xO0=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAXxSTy+LhpU0cBAA--.1123S2;
	Tue, 17 Mar 2026 14:47:14 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] riscv: add UltraRISC SoC family Kconfig support
From: Jia Wang <wangjia@ultrarisc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jia Wang <wangjia@ultrarisc.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20260316-powdery-unbundle-b1166d13f53b@spud>
References: <20260316-ultrarisc-pcie-v1-0-ef2946ede698@ultrarisc.com>
 <20260316-ultrarisc-pcie-v1-1-ef2946ede698@ultrarisc.com>
 <20260316-powdery-unbundle-b1166d13f53b@spud>
Date: Tue, 17 Mar 2026 14:46:24 +0800
Message-Id: <177372998464.49340.13796019002628537253.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773729985; l=1669;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=Wh4r1tJxW/lcrM+5/s3mKCV9XBfeqG6hKDHxb5EPDGw=;
 b=ILj7unpHtMHqWmjlLI7/tPGnunhwSsS8Xtq1iZbRucVP8vowTNh4jyI+qbH5QarPUFQzPy/4t
 oNPEPJb4jhzCT7Eu7JSn7WY9jScPJmDP1wK6D+CRtY1UamBX4EkSEux
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAXxSTy+LhpU0cBAA--.1123S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF48Xr1UAryftFyUZFWkZwb_yoW8Wr17pF
	s5CF1rCFsxGr1fCa9aqw45urWI9F4v93y5Zr1Duw18AFs8Cry5C3s7tr13X3WDZFZ8Crna
	gFyru3W3ua15uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRNJ5oDUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAJEWm47wkAAgAAss

On 2026-03-16 14:39 +0000, Conor Dooley wrote:
> On Mon, Mar 16, 2026 at 03:06:57PM +0800, Jia Wang wrote:
> > The first SoC in the UltraRISC series is UR-DP1000, containing octa
> > UltraRISC C100 cores.
> > 
> > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > ---
> >  arch/riscv/Kconfig.socs | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index d621b85dd63b..f49d3ccaacde 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -84,6 +84,16 @@ config ARCH_THEAD
> >  	help
> >  	  This enables support for the RISC-V based T-HEAD SoCs.
> >  
> > +config ARCH_ULTRARISC
> > +	bool "UltraRISC RISC-V SoCs"
> > +	depends on MMU && !XIP_KERNEL
> 
> Why do you depend on "MMU && !XIP_KERNEL"?
>
Hi Conor,

Thanks for the review.

The dependency on "MMU" was added conservatively, but the DP1000 hardware
does not strictly require MMU. I will remove this dependency in the
next version of the patch.

The "!XIP_KERNEL" dependency is retained because the platform does not
support executing the kernel directly from storage, so the kernel
must be loaded into RAM before execution.

Best regards,
Jia 
> > +	help
> > +	 This enables support for UltraRISC SoC platform hardware,
> > +	 including boards based on the UR-DP1000.
> > +	 UR-DP1000 is an 8-core 64-bit RISC-V SoC that supports
> > +	 the RV64GCBHX ISA. It supports Hardware Virtualization
> > +	 and RISC-V RV64 ISA H(v1.0) Extension.
> > +
> >  config ARCH_VIRT
> >  	bool "QEMU Virt Machine"
> >  	select POWER_RESET
> > 
> > -- 
> > 2.34.1
> > 


