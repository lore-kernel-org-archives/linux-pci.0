Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B122E4247;
	Wed,  8 Apr 2026 01:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775612841; cv=none; b=tcs5DAf2ihJav5cfTs0HsSnn9zhCfkLs97UPvOipNOquoRwOpycQMFMWeNRHOVphmZYXLtwQ+5J6W0psj/TxwLdyCWX7USOM7FWDupjegaDrEYzAvjueeOmHXMe1vgb3yhMcUPiaugyzSxBePwQj7ik8ROYewd0rvHsS5mAZWJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775612841; c=relaxed/simple;
	bh=i0dYsL4yUueJ1cAqUP1xzFPT+0rfwfboD6UwNL4rbjc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=JHBGkZdVN0pWB+4gt4Or6jVJbIFHKwEAXi1VB6bggTcQjRbNVExhPNf9FfgnxGlODJ8pQfwWb5XI9ixxg99uZqytb5Fh7oV9PL/Hm/KkmvZrRl3+tFZoXSICz+1SmHo7lG/zzy5/8hyZ09otYxXCPnmZe4u6iIbSWLFe/syftBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=gnxAX7Uu; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="gnxAX7Uu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=v2ZpFKZ/AQsdYQlk9IBkKHx5XqLUslRX6
	ByqCZmbkEU=; b=gnxAX7UuBfJ1Cmi6979zEjTRxBFPE5BC4BbJ7sFxJ0VGCoL55
	LD/FAe1VImik0zBDYqS413oC66xMZy+5dvo5oac6Hrx3blJWdzuNTPiYZ5zDPyA3
	Kv+waxeqryrSQixZXTDrFVDpLunOJw6QNh9WbcxTBILfEyxTtN1VP2cdIU=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDXEELHs9Vp+6kBAA--.905S2;
	Wed, 08 Apr 2026 09:47:52 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/4] riscv: add UltraRISC SoC family Kconfig support
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
In-Reply-To: <20260407-shown-guileless-5c8b8d94f5e5@spud>
References: <20260407-ultrarisc-pcie-v2-0-2aa2a19a7fb3@ultrarisc.com>
 <20260407-ultrarisc-pcie-v2-1-2aa2a19a7fb3@ultrarisc.com>
 <20260407-shown-guileless-5c8b8d94f5e5@spud>
Date: Wed, 08 Apr 2026 09:47:04 +0800
Message-Id: <177561282495.2731393.9548650582911498336.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775612825; l=1927;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=i0dYsL4yUueJ1cAqUP1xzFPT+0rfwfboD6UwNL4rbjc=;
 b=9i1+wyuOTnFY16LgLMob0IB6IKa/m+ARZPhZWrHM+Tr9j8ZgcpSyhohOfC976wd4wrolWJ3k4
 gzVv0pkedoQB+5Etk8kISb9ErzxusztZpRbkoIS1wIdOy0KhkoWbXH+
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwDXEELHs9Vp+6kBAA--.905S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy3JrW3KF1UKF45Xr1kKrg_yoW8Aw4xpF
	4rCa45CFZxGF1ftF9aqw409rW3uFsaq3y5uw4UJw1rAFZ8Cry5ZFnrKry3W3WDZFWkJryf
	KFyFg3W3uF45Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRNJ5oDUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQALEWnUfzsANAAAsW

On 2026-04-07 17:29 +0100, Conor Dooley wrote:
> On Tue, Apr 07, 2026 at 10:40:52AM +0800, Jia Wang wrote:
> > The first SoC in the UltraRISC series is UR-DP1000, containing octa
> > UltraRISC C100 cores.
> 
> Not gonna lie, I find it odd that pcie is where this platform starts
> off, but sure. What's the plan for adding the rest of the platform?
>

Hi Conor,

Thanks for the question.

Our next step is to upstream the pinctrl driver together with the related
DTS updates. The pinctrl series only affects the SoC’s low-speed peripheral
interfaces. For GMAC, SPI, I2C, and GPIO, we plan to use the existing
kernel drivers, so no new controller drivers are needed 
> > 
> > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > ---
> >  arch/riscv/Kconfig.socs | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index d621b85dd63b..98708569ec6a 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -84,6 +84,15 @@ config ARCH_THEAD
> >  	help
> >  	  This enables support for the RISC-V based T-HEAD SoCs.
> >  
> > +config ARCH_ULTRARISC
> > +	bool "UltraRISC RISC-V SoCs"
> > +	help
> > +	  This enables support for UltraRISC SoC platform hardware,
> > +	  including boards based on the UR-DP1000.
> 
> > +	  UR-DP1000 is an 8-core 64-bit RISC-V SoC that supports
> > +	  the RV64GCBHX ISA. It supports Hardware Virtualization
> > +	  and RISC-V RV64 ISA H(v1.0) Extension.
> 
> Delete this section IMO, doesn't provide any real value. Don't need nor
> want the marketing brochure in the help text. The first sentence is
> sufficient.
>

I’ll drop the SoC description part from the Kconfig help text as you
suggested.
 
> > +
> >  config ARCH_VIRT
> >  	bool "QEMU Virt Machine"
> >  	select POWER_RESET
> > 
> > -- 
> > 2.34.1
> > 

Best regards,
Jia Wang

