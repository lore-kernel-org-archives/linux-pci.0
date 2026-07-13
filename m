Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21493A4F5B;
	Mon, 13 Jul 2026 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930102; cv=none; b=V/cXBWk6pkfx8GDFnAQwBRtVUBlcSLUfQ9Ki3V1dO1wWvSi5SbhdvU1Ln5b857TlKROV2vJ2Ac0h0G1jY87r7awDWFprR4/1Y8qhyrr6IgaBKguDptlqC8srDaZPQoxi5K0L0OOXovbVCQU3PB4gaYmQsR2/dwG09r7JyY9zJ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930102; c=relaxed/simple;
	bh=UZApS2edS3SSOM+33WEWbFeln7ja49nPlyAsMIHUXp0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=L8DhA0yurOKZ8+XUoBib5TroODtPzs5DUG0hhjQPoFsmjspOhXfdQczfImt+ZL05Z072pv07ginq+hp9VSWjds8xwM/HrAkyriM9m51pZmGYVl8JE76EaJxcxzQi+xWGdOZfikJt/AosKHtmg9PZwuiYc8I7KtD8CwzkyVi2840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=ISb09sNl; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="ISb09sNl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=5HSRZYpzw686Gi3jE+bqow4FMeu78S17L
	wEmfrBMKi0=; b=ISb09sNlFehG1pO+ZyPh3jmBO/qRH03wQaIrEGoTYHsyyiz8w
	tT8oYcXpF6iEGU5kmKc6nTFmv3YyzJk4z0AIJXM/ZVpPC0xEwp64fS24Udz5WPjh
	japzfcathctHDxcMMgl7QhL+lfoFPQzZb8Lfj64kCoomF0lx4B0ipqC+IU=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDXEEIKnVRqNYYQAA--.16652S2;
	Mon, 13 Jul 2026 16:08:43 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 2/3] PCI: ultrarisc: get and enable DP1000 PCIe
 clocks
From: Jia Wang <wangjia@ultrarisc.com>
To: sashiko-reviews@lists.linux.dev
Cc: Jia Wang <wangjia@ultrarisc.com>, linux-pci@vger.kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260706101114.129681F000E9@smtp.kernel.org>
References: <20260706-ultrarisc-pci-clk-v2-0-2f3fb6fba66b@ultrarisc.com>
 <20260706-ultrarisc-pci-clk-v2-2-2f3fb6fba66b@ultrarisc.com>
 <20260706101114.129681F000E9@smtp.kernel.org>
Date: Mon, 13 Jul 2026 16:08:11 +0800
Message-Id: <178393009191.2317413.11810474348602616541.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783930092; l=3045;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=UZApS2edS3SSOM+33WEWbFeln7ja49nPlyAsMIHUXp0=;
 b=HY+p46CO4RmVZUfgUsP5pOE9FpfH/FO8Itkx/yzvGOikh7pZJPmPek+3CUUqaDIcbFrgbSNd3
 H5OACgbvAhWC/i1KSV6jAeWT/vxTnP8YoO6zTRnktJgF8aF9gKV/LOa
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwDXEEIKnVRqNYYQAA--.16652S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurykZFW3tFyxZryxGFyfWFg_yoW5AFWxp3
	yUKayFkF4DJryY9rsIvw18ZF1YvrnIkry3Aa97Kr12vw1a9rykGrWrW34aq3Wvkr4j9wnF
	kF4UC3WxCw1j9FDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUva14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
	uYvjfU8miiUUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAHEWpUYNAAJgACs9

On 2026-07-06 10:11 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Unconditional register access in suspend after a prior resume failure causes kernel panic.
> --
> 
> commit 91b0a79d0e5b5b1e0d3c9731fd011273f668f0a9
> Author: Jia Wang <wangjia@ultrarisc.com>
> 
> PCI: ultrarisc: get and enable DP1000 PCIe clocks
> 
> Add the required core, dbi, and aux clocks for the DP1000 PCIe
> controller and enable them before initializing the DesignWare host.
> Also manage the clocks across system suspend and resume.
> 
> > diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > index 6ee661ceff67a..6ed244770d538 100644
> > --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> [ ... ]
> > @@ -135,14 +174,31 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
> >  
> >  static int ultrarisc_pcie_suspend_noirq(struct device *dev)
> >  {
> > -	struct dw_pcie *pci = dev_get_drvdata(dev);
> > +	struct ultrarisc_pcie *ultra = dev_get_drvdata(dev);
> > +	struct dw_pcie *pci = &ultra->pci;
> > +	int ret;
> > +
> > +	ret = dw_pcie_suspend_noirq(pci);
> 
> [Severity: High]
> What happens here if a previous resume attempt failed to enable the clocks?
> 
> Looking at ultrarisc_pcie_resume_noirq() below, if clk_bulk_prepare_enable()
> fails, the function returns an error while the clocks remain disabled and
> pci->suspended remains true.
> 
> If the system then undergoes another suspend cycle, this function will call
> dw_pcie_suspend_noirq(), which accesses hardware registers via
> dw_pcie_link_up().
> 
> Since the clocks are disabled, could this register access cause a bus error
> and subsequent kernel panic?
> 
> Should we check if the device is already suspended (or if the clocks are
> already off) before calling dw_pcie_suspend_noirq()?
> 

Thanks.

This will be fixed in the next version by handling the already-suspended
case before calling dw_pcie_suspend_noirq(), so no register access is made
with the clocks disabled.

> > +	if (ret)
> > +		return ret;
> > +
> > +	if (pci->suspended)
> > +		clk_bulk_disable_unprepare(ARRAY_SIZE(ultra->clks), ultra->clks);
> >  
> > -	return dw_pcie_suspend_noirq(pci);
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
> >  
> >  	return dw_pcie_resume_noirq(pci);
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706-ultrarisc-pci-clk-v2-0-2f3fb6fba66b@ultrarisc.com?part=2
>

Best regards,
Jia Wang 


