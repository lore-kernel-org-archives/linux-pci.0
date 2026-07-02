Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545191A267;
	Thu,  2 Jul 2026 05:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782971214; cv=none; b=Ck0Tvyt3Ob2y5iMahcm6ISsuUjBeIlWLtKQNZuBRkXd7F4lfBiEZbSsSd1/oM5DwKeKIR7PZwUeC+fC9dEWeflFbYSP536K5+GFlmCBE1stpl3z6oaxxkCaHtzsjExqwRZle6SIO+b/Qr32IVVfT1pyKBBnSLdetJzl2RUPPsIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782971214; c=relaxed/simple;
	bh=2/UPohXtF/RlpLf0bukLvCQ2jrR0nDgq2a/0z8yUTk8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=hjW1XSm93M0pbnYDUkQqiVhmVpCH8D2wFy2ST0uFxitGP01OeIm1xyM7Q5fdk0KPiHpxkpizIfQ2tBIJG9T/pR0EZ58qgXtC+IaNXlNPGBjrc8kcwNP6SNT0SOLQpFj9APQc1qfAmrtFcXjnGbp3/K2EFuIRgJYKxJKFlpmN9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=NAVGcx6T; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="NAVGcx6T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=Dp5I5nX/cyO1ESS5RZKGaCiXFk+SLn9TG
	BatcMDF9pk=; b=NAVGcx6TritpuUrFAgClgboDDIZXyo/d+voPXFgu5GYqxTco0
	SSr2R00dUj83+AH/bz8kL0b+n3lpx1MVlRMdbUZXNUgV8a4S6xTbstbLSIZvmQmt
	7k+TsgFzcy86oo8gIvI3uUmGdgkZPqFi9SJpFp8K8j/duIkGM3lHnIUSg0=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwA3cUJl+0VqvZYOAA--.14864S2;
	Thu, 02 Jul 2026 13:47:17 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 2/2] PCI: ultrarisc: get and enable DP1000 PCIe clocks
From: Jia Wang <wangjia@ultrarisc.com>
To: sashiko-reviews@lists.linux.dev
Cc: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>, 
 conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 robh@kernel.org
In-Reply-To: <20260629060959.7A2201F000E9@smtp.kernel.org>
References: <20260629-ultrarisc-pci-clk-v1-0-5ea3308fdab3@ultrarisc.com>
 <20260629-ultrarisc-pci-clk-v1-2-5ea3308fdab3@ultrarisc.com>
 <20260629060959.7A2201F000E9@smtp.kernel.org>
Date: Thu, 02 Jul 2026 13:46:44 +0800
Message-Id: <178297120412.1082377.7888497236569602999.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782971204; l=3301;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=2/UPohXtF/RlpLf0bukLvCQ2jrR0nDgq2a/0z8yUTk8=;
 b=24+o748ePAtDV33ZqcsxnzBTFNcqLDe9gfflAqw+Q1qYllBaPvj5XfWuSvBY7+F8VKN8wwVyT
 GF6AzGTC26FAdfWeD/MZovdSq9fTuWqksAgkKR7ni9Lp1YSSt7LYqDX
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwA3cUJl+0VqvZYOAA--.14864S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDJr43Zr1rJFWkJry5Jwb_yoW5Zw4fp3
	yUGayFkF1DJrWY9rsav3WrZ3WjvrnIkrZ8AFZrKr12gw1a9r97Gr15W34agF92kr1qkw1q
	kF4UKa4UAw1jyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l
	c2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
	twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5
	kxhtUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAQEWpF4E0ABwAAsF

On 2026-06-29 06:09 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] If dw_pcie_resume_noirq() fails, the driver disables the clocks, which will cause a bus fault and kernel crash on the next system suspend when the DWC core attempts to read the DBI registers.
> --
> 
> commit 7bdde7bd97edc4ae25c337b51b52e18bb46e6424
> Author: Jia Wang <wangjia@ultrarisc.com>
> 
> PCI: ultrarisc: get and enable DP1000 PCIe clocks
> 
> This commit adds the required core, dbi, and aux clocks for the DP1000 PCIe
> controller and enables them before initializing the DesignWare host. It also
> manages the clocks across system suspend and resume.
> 
> > diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > index 6ee661ceff67a..74010a86244e7 100644
> > --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> [ ... ]
> > @@ -135,16 +174,37 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
> [ ... ]
> >  static int ultrarisc_pcie_suspend_noirq(struct device *dev)
> >  {
> > -	struct dw_pcie *pci = dev_get_drvdata(dev);
> > +	struct ultrarisc_pcie *ultra = dev_get_drvdata(dev);
> > +	struct dw_pcie *pci = &ultra->pci;
> > +	int ret;
> > +
> > +	ret = dw_pcie_suspend_noirq(pci);
> > +	if (ret)
> > +		return ret;
> >  
> > -	return dw_pcie_suspend_noirq(pci);
> > +	if (pci->suspended)
> > +		clk_bulk_disable_unprepare(ARRAY_SIZE(ultra->clks), ultra->clks);
> > +
> > +	return 0;
> >  }
> >  
> >  static int ultrarisc_pcie_resume_noirq(struct device *dev)
> >  {
> > -	struct dw_pcie *pci = dev_get_drvdata(dev);
> > +	struct ultrarisc_pcie *ultra = dev_get_drvdata(dev);
> > +	struct dw_pcie *pci = &ultra->pci;
> > +	int ret;
> > +
> > +	if (pci->suspended) {
> > +		ret = clk_bulk_prepare_enable(ARRAY_SIZE(ultra->clks), ultra->clks);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	ret = dw_pcie_resume_noirq(pci);
> > +	if (ret && pci->suspended)
> > +		clk_bulk_disable_unprepare(ARRAY_SIZE(ultra->clks), ultra->clks);
> 
> [Severity: High]
> Will this cause a kernel crash on the next system suspend if
> dw_pcie_resume_noirq() fails?
> 
> If dw_pcie_resume_noirq() fails (for example, due to a link training
> timeout), it returns an error but leaves pci->suspended as true. This error
> path then disables the clocks.
> 
> However, the PM core continues and marks the device as resumed. On the next
> system suspend, ultrarisc_pcie_suspend_noirq() will unconditionally call
> dw_pcie_suspend_noirq().
> 
> Since dw_pcie_suspend_noirq() accesses DBI registers by calling
> dw_pcie_link_up(), and the clocks were left disabled, does this read
> trigger a synchronous external abort and crash the kernel?
>

Yes, good catch. If dw_pcie_resume_noirq() fails, pci->suspended remains
set, so disabling the clocks here can indeed cause problems on a subsequent
suspend.

I'll fix this in v2 by keeping the clocks enabled on the resume failure
path.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260629-ultrarisc-pci-clk-v1-0-5ea3308fdab3@ultrarisc.com?part=2
> 

Best regards,
Jia Wang



