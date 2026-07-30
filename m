Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C693314A1;
	Thu, 30 Jul 2026 06:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394548; cv=none; b=XSdwKq3OBD43bmsU8vNXbT6xPB/IJc0wSVbewTHyXI0Q4GfebnOUBtRV86y5Y+er7J59/sJwpZeV7ScjZ9u4uGK/eo8CqyVFixdXi6GlJHxFXED4p3TbfJcmGpQyFPLiTABeBiIkiHN3wRBOfKgu+86SOTXBZ5xiAgX7kHdowF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394548; c=relaxed/simple;
	bh=sJmrLJSXdTxvZrpYq8tGAa+n0QjwHJI/7PEbLcP/qd0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=E4Vg6bXaXz1MXfS1M+xzb/ufavF0pZNEfpfHFsmFE42EhSETtMSHljoxKvyDySGN/v11y1H6156RV+V2RYd4jR3ra/rn6zYp3uqcXDvG0Ts1QAWJs4StOOYJj5TIP4P+91y6IlbqGkAZmV8bRZ5IohKqDTvmgRr14o3oMnQutqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=eid5mjEy; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="eid5mjEy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=DjOhS1AbQveIs/ZUATd1rLdbJ/AmaxGDq
	WtjpsHTG60=; b=eid5mjEyBZqEoRh7qpOCUCdeYob+frCpjbWPn/NSZT3/z+cxE
	Zyv5taiY+Z0DRmGrTK1g6jbK6S5OomZtscaYK0jbTy9KZBeKRtbEnHdAE/mzGpXf
	SL+rygUOu7OyP/LscrdICyFO2TThY64ouoMsOFpHG24OdMNrqA8HsNP/IQ=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwA3cUKE9WpqFMgVAA--.18167S2;
	Thu, 30 Jul 2026 14:56:04 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 3/3] PCI: ultrarisc: allow DP1000 driver to build as
 module
From: Jia Wang <wangjia@ultrarisc.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: wangjia@ultrarisc.com, Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <dz43ty5hgpefk67lmgxfn2tmppng4ws6oy66zns5ajt3qwdfai@k3exaapdqvxh>
References: <20260714-ultrarisc-pci-clk-v3-0-e72723fc0ef1@ultrarisc.com>
 <20260714-ultrarisc-pci-clk-v3-3-e72723fc0ef1@ultrarisc.com>
 <dz43ty5hgpefk67lmgxfn2tmppng4ws6oy66zns5ajt3qwdfai@k3exaapdqvxh>
Date: Thu, 30 Jul 2026 14:55:36 +0800
Message-Id: <178539453673.553273.3197955075422858659.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785394537; l=2133;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=sJmrLJSXdTxvZrpYq8tGAa+n0QjwHJI/7PEbLcP/qd0=;
 b=sgolaqZdqW1e94nHlCGSkn1rP+MgbBZFq47LVOcgGAImBRhyN6Eyjjq52LjdNfdUzA2rRdX28
 pyzQcQljnzwDQnLJjIIDFlfRKlKfqI+E3g/UUkBlPZOAVLMiHE3CdDZ
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwA3cUKE9WpqFMgVAA--.18167S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFykGw4fuw48Kr4xJFWfGrg_yoW8uF13pa
	yUGayYkF1kJF4YyanFk3WUZ3WYy3ZxtryjgasFgwnIvF9xuryDXrykKa4YkF92yw48Cr12
	ka1Yka43GF45Xa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAEEWpqylMAAwAAsO

On 2026-07-29 15:49 +0200, Manivannan Sadhasivam wrote:
> On Tue, Jul 14, 2026 at 09:11:04AM +0800, Jia Wang via B4 Relay wrote:
> > From: Jia Wang <wangjia@ultrarisc.com>
> > 
> > CONFIG_PCIE_ULTRARISC is a tristate option, so the driver can be selected
> > as a module when COMPILE_TEST or platform configuration allows it.  Using
> > builtin_platform_driver() leaves the module build without the module
> > init/exit plumbing and causes modpost failures for the generated .ko.
> > 
> > Use module_platform_driver() so the driver works for both module and
> > built-in builds while keeping the existing tristate Kconfig entry.
> > 
> > Add a remove callback and call dw_pcie_host_deinit() during removal so the
> > root bus is torn down before devres releases the controller data.
> > 
> > Fixes: 5fc35740c3b3 ("PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root Complex driver")
> > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-ultrarisc.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > index 72ba5840b62d..9bee522a20e9 100644
> > --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > @@ -193,6 +193,13 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +static void ultrarisc_pcie_remove(struct platform_device *pdev)
> > +{
> > +	struct ultrarisc_pcie *ultra = platform_get_drvdata(pdev);
> > +
> > +	dw_pcie_host_deinit(&ultra->pci.pp);
> > +}
> 
> Since this driver registers an internal MSI controller, it is not safe to
> remove it due to irq disposal concern. But you can build this driver as a
> module though.
>

Right, I missed that this was intentionally changed to
builtin_platform_driver() to prevent irqchip removal. I will drop this
patch entirely in the next revision. Thanks!
 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
> 

Best regards,
Jia Wang


