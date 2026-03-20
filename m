Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF6B384250;
	Fri, 20 Mar 2026 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999455; cv=none; b=tk24kV2ozLz6Qv713/bKVyRviyfm28j6d9H6UwlfC3its1wcH+7iMLQPp7FZs+RXA6/GsVZ/XyHlJpMoTVWfx1sOGaiCPUTQBKxE2xi5j8/5OOfric2O+08lZo63qVyisdQNb7QtukS47i8W1IITI3+ZPgOIDkZAjvqpTzjWixI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999455; c=relaxed/simple;
	bh=NdeAJwHndxZkVbweWJXMxDVFBvgZ0d6ruaeJgL3U5Xk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ktC2MriORxqfN/InEGiqQ8pWXIjwFkwGgN1Jh9j8Ztu4s4kclLCSHekxEL9Jc5eaexmEeMjsiXwQFYPX3WiKC0RQmQaE+R6OSZAAZi/dKc9zywxwVqB+MZCOiLOWS0H/cJcPehnQ1EOn85VcVlme1OvJGjkIfRgSXTT2zVXeLw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=jLzX9JB7; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="jLzX9JB7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=UoqLelab2uRRhZMugZLNRzB4MZHfmrDGO
	eiZef67Q1I=; b=jLzX9JB7jUNIu1uG3QqxeTDTZKX2EnOd2aX/t33Z+IyL0e31F
	sTpFimzgwnHklUEVzp69u/esjFUA7VPKvzbwdSIJg+2vyWUMsQd4xsxA+thRGEyk
	7Ff9qDEfj6SWwAfdMxgjgjHbYtxfnbYGg+VSdhR/i7MxvEVwQnTc9I4kwM=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAXxSR+Fb1pMbQBAA--.1433S2;
	Fri, 20 Mar 2026 17:38:06 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/4] PCI: dwc: Add UltraRISC DP1000 PCIe rc driver
From: Jia Wang <wangjia@ultrarisc.com>
To: Yao Zi <me@ziyao.cc>
Cc: wangjia@ultrarisc.com, Paul Walmsley <pjw@kernel.org>, 
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
In-Reply-To: <abjnhn5sqnJv1fYY@pie>
References: <20260316-ultrarisc-pcie-v1-0-ef2946ede698@ultrarisc.com>
 <20260316-ultrarisc-pcie-v1-4-ef2946ede698@ultrarisc.com>
 <abjnhn5sqnJv1fYY@pie>
Date: Fri, 20 Mar 2026 17:37:17 +0800
Message-Id: <177399943728.868832.12341696974887547910.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773999437; l=2134;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=NdeAJwHndxZkVbweWJXMxDVFBvgZ0d6ruaeJgL3U5Xk=;
 b=Ae3Yhm2tB/fH01LoOqHKG2gik5SQv29ZG22KRTceRvFfRgS0vkU/5bOpjsF+st3uMWsqHgmUv
 HTNjzNkf+XbAh9je0AgaIs6VJADl0SS9/KvDWYasLrpzgDQuq/TqfDT
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAXxSR+Fb1pMbQBAA--.1433S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1UKFykJr1rAw4DZF4ktFb_yoW8Zw45pa
	yUKa1akF1xJF4aka1Sva48Ca43Jan7JrWDG39rGw13XF9xC34DW3srt3yFgF97Xr40vr1a
	k3WYg3W7GF43Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sREPrc3UUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAMEWm844oAIgACsA

On 2026-03-17 05:32 +0000, Yao Zi wrote:
> On Mon, Mar 16, 2026 at 03:07:00PM +0800, Jia Wang via B4 Relay wrote:
> > From: Xincheng Zhang <zhangxincheng@ultrarisc.com>
> > 
> > Add DP1000 soc PCIe rc driver.
> > 
> > Signed-off-by: Xincheng Zhang <zhangxincheng@ultrarisc.com>
> > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig           |  15 ++
> >  drivers/pci/controller/dwc/Makefile          |   1 +
> >  drivers/pci/controller/dwc/pcie-designware.h |  22 +++
> >  drivers/pci/controller/dwc/pcie-ultrarisc.c  | 202 +++++++++++++++++++++++++++
> >  4 files changed, 240 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index d0aa031397fa..0a33891bf7ef 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -548,4 +548,19 @@ config PCIE_VISCONTI_HOST
> >  	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
> >  	  This driver supports TMPV7708 SoC.
> >  
> > +config PCIE_ULTRARISC
> > +	bool "UltraRISC PCIe host controller"
> 
> Is there any reason preventing the driver being built as a module? If
> no, it would be better to change it to "tristate", to allow distribution
> to customize the configuration for image sizes, etc.
>

Thanks for the suggestion. I will update PCIE_ULTRARISC to tristate.
 
> > +	depends on ARCH_ULTRARISC || COMPILE_TEST
> > +	select PCIE_DW_HOST
> > +	select PCI_MSI
> > +	default y if ARCH_ULTRARISC
> > +	help
> > +	  Enables support for the PCIe controller in the UltraRISC SoC.
> > +	  This driver supports UR-DP1000 SoC. When selected, it automatically
> > +	  enables both `PCIE_DW_HOST` and `PCI_MSI`, ensuring proper support
> > +	  for MSI-based interrupt handling in the PCIe controller.
> > +	  By default, this symbol is enabled when `ARCH_ULTRARISC` is active,
> > +	  requiring no further configuration on that platform.
> > +
> > +
> >  endmenu
> >  #define PORT_LOGIC_LTSSM_STATE_L0	0x11
> 
> Best regards,
> Yao Zi
>

Best regards,
Jia 


