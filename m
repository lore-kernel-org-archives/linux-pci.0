Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E372280318;
	Tue, 14 Apr 2026 03:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776137265; cv=none; b=VJKYZJr6vFC1u/JKvgjsyXAn/x8sfc/ctVXRUm3uROoFwVyHUrMS7XXiXaCV8t0kOb3x/kaT/PT+KT7nM2SvElUNQ3wnUZus38uNxy8SuzZ75XBvIjQer7n7B+T60aQTu/p5K6q2E8rrwBfJijOt7jjwNsV/bXoVUa+EZivUmEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776137265; c=relaxed/simple;
	bh=KUPRhC1x/yzG3Mxn3e7SBxQSss+cduj2TK+sbO13rAE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=HxXpqgRex6Rq489rgv/YWJgZAlfU/wrmQbovmNykyfZbwHYBlF83PUWy5ZGjvvWKYFdcInrlD2ls8opmZVtv9HM1VTc6ZZVHy2FzVXwkF2nfGFe9PLmrii4XkNs52HubNYN4SYUvWgiNUJB08jmQ83oS8YhjU3CIjW+uDtZpbLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=cqk0bxpZ; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="cqk0bxpZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=irEOIAeIzUS6UP0UrzOxi19q2YKjJd8JI
	x+Bx+4jCSM=; b=cqk0bxpZfC9XjKKAPxfXrskDLMTDTcUAbb9sHL31WC9y0I8Au
	z3ZPYs4KgWBBxGsu1oMQlaw4C4HCc0+nVMyJxmRSfPRjUiqEvJPW5LqjtebbwWG6
	k6rKLLAMUR9jZKyqZHp5tgMFbnu5U7ojAZSXekD2HvgnYBap26wGae8S40=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDXEEJItN1pVxYCAA--.1182S2;
	Tue, 14 Apr 2026 11:28:09 +0800 (CST)
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
In-Reply-To: <20260408-wise-dividers-ec8a057d4bd2@spud>
References: <20260407-ultrarisc-pcie-v2-0-2aa2a19a7fb3@ultrarisc.com>
 <20260407-ultrarisc-pcie-v2-1-2aa2a19a7fb3@ultrarisc.com>
 <20260407-shown-guileless-5c8b8d94f5e5@spud>
 <177561282495.2731393.9548650582911498336.b4-reply@b4>
 <20260408-wise-dividers-ec8a057d4bd2@spud>
Date: Tue, 14 Apr 2026 11:27:22 +0800
Message-Id: <177613724276.4104287.2231755690464498119.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776137243; l=3173;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=KUPRhC1x/yzG3Mxn3e7SBxQSss+cduj2TK+sbO13rAE=;
 b=FN+8w632+RkQXyHIU0y3L8wN9tMkhHCx8tpaVj+B9zlfAi+qfwwpTOvz5rtXb5F8GiCopRgna
 CtdYbZ9/o3kBTsDWMGou2C6uggPr28he/g/30VW3jCVsEBqPlH0jQYA
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwDXEEJItN1pVxYCAA--.1182S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFyrur1kAF4DCF4xtF15CFg_yoW5AryxpF
	4rCFyYkFs8KF4ftr9Fqw4UurWavan2qrW5Wr1xJ34rZFZ0kry5XF4DtrWaga4DXrZ8Cw1v
	vFyrK3W7uF45ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQANEWnYc7wAZAAOsJ

On 2026-04-08 18:10 +0100, Conor Dooley wrote:
> On Wed, Apr 08, 2026 at 09:47:04AM +0800, Jia Wang wrote:
> > On 2026-04-07 17:29 +0100, Conor Dooley wrote:
> > > On Tue, Apr 07, 2026 at 10:40:52AM +0800, Jia Wang wrote:
> > > > The first SoC in the UltraRISC series is UR-DP1000, containing octa
> > > > UltraRISC C100 cores.
> > > 
> > > Not gonna lie, I find it odd that pcie is where this platform starts
> > > off, but sure. What's the plan for adding the rest of the platform?
> > >
> > 
> > Hi Conor,
> > 
> > Thanks for the question.
> > 
> > Our next step is to upstream the pinctrl driver together with the related
> > DTS updates. The pinctrl series only affects the SoC’s low-speed peripheral
> > interfaces. For GMAC, SPI, I2C, and GPIO, we plan to use the existing
> > kernel drivers, so no new controller drivers are needed 
> 
> And clocks? pinctrl and clocks would be the bare minimum level of
> support required before a platform should be merged. Obviously, you can
> get device drivers for PCI etc etc merged without clock drivers, but the
> initial dts should contain the clocks too.
>

On our platform, all functional clocks are fully configured and enabled by
the firmware before Linux boots. The kernel is not expected to adjust clock
rates or gate/ungate clocks at runtime.  
Therefore, in the initial device tree we only describe the fixed clocks
required by the standard subsystem drivers, using `fixed-clock` where needed.

Since there is no clock controller accessible to the OS, we do not plan to
add a clock driver at this stage. If future hardware versions expose a
programmable clock controller to Linux, we will upstream the corresponding
driver and update the DT accordingly.
 
> > > > 
> > > > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > > > ---
> > > >  arch/riscv/Kconfig.socs | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > > > index d621b85dd63b..98708569ec6a 100644
> > > > --- a/arch/riscv/Kconfig.socs
> > > > +++ b/arch/riscv/Kconfig.socs
> > > > @@ -84,6 +84,15 @@ config ARCH_THEAD
> > > >  	help
> > > >  	  This enables support for the RISC-V based T-HEAD SoCs.
> > > >  
> > > > +config ARCH_ULTRARISC
> > > > +	bool "UltraRISC RISC-V SoCs"
> > > > +	help
> > > > +	  This enables support for UltraRISC SoC platform hardware,
> > > > +	  including boards based on the UR-DP1000.
> > > 
> > > > +	  UR-DP1000 is an 8-core 64-bit RISC-V SoC that supports
> > > > +	  the RV64GCBHX ISA. It supports Hardware Virtualization
> > > > +	  and RISC-V RV64 ISA H(v1.0) Extension.
> > > 
> > > Delete this section IMO, doesn't provide any real value. Don't need nor
> > > want the marketing brochure in the help text. The first sentence is
> > > sufficient.
> > >
> > 
> > I’ll drop the SoC description part from the Kconfig help text as you
> > suggested.
> >  
> > > > +
> > > >  config ARCH_VIRT
> > > >  	bool "QEMU Virt Machine"
> > > >  	select POWER_RESET
> > > > 
> > > > -- 
> > > > 2.34.1
> > > > 
> > 
> > Best regards,
> > Jia Wang
> > 


