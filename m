Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FE82441B8;
	Thu,  2 Jul 2026 05:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782971935; cv=none; b=BGciS5pOLvtpAuHCrYV7NuXYeIiWflLyfCvCxMlO+4kdUNRrkccWnkWOT5mzjRTBhgg5fJ+qTlN9dkdlIS7cexJV2UUAmK1/ja++1ncO7+Ueuk3RQlRxQUP9pFcbkI43TO0Fk498TeSTsil0ZVuGzaRldw1NeU3P9K3xWdbKsCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782971935; c=relaxed/simple;
	bh=y2p0gjiPOwrEc3XzZXHJ62SUJPKrNMOkfmMY/0J6koM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=cIFMKhB7U4cL9m84l0xwCCoGDbXgUm0NBwjU92IniRcFmOjOz2eI/DgRDGNT0kzTqMA14QtEFrIqTCbHlnPMGDEpwYGTODJxRPoct6WBvW1S3yibiv6fiOMx4z3jzO9Fsf5W9TDo2u8c5g9NT/lMOJ76xuF2cKrwpJUu/BLaCfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=aq94dnQl; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="aq94dnQl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=ORVIGs5+w2VfIVxGHbwVMrjmoIw9Iy4Bl
	uP20V3Fm9Y=; b=aq94dnQlnSrUemOPW8MSyPBiIaZOK2lZAtTIhUiqtz3BdNLUI
	r7O2zQo4H/G9SYUKnU7ADp7mqCvcUHfwqlNERUlZp8Sb4dcicb+/0+N3NRP9lp3w
	uBkZ8sJYiZXZ2GVQ0ye10gUBnmv6tnBcY6xggdSE2Qy59jAAYGALyGP3BE=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnYUIy_kVqNpcOAA--.14655S2;
	Thu, 02 Jul 2026 13:59:14 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] PCI: ultrarisc: get and enable DP1000 PCIe clocks
From: Jia Wang <wangjia@ultrarisc.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: wangjia@ultrarisc.com, Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260630165550.GA131410@bhelgaas>
References: <20260630165550.GA131410@bhelgaas>
Date: Thu, 02 Jul 2026 13:58:41 +0800
Message-Id: <178297192123.1082377.12406016413212102294.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782971921; l=1312;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=y2p0gjiPOwrEc3XzZXHJ62SUJPKrNMOkfmMY/0J6koM=;
 b=rZMl+Of2QSZsGWMGj2JCHw9MkfA/u5sZMfv6bp0els7RfydAXj98Q1B+fYqay8h/XJMnEzBZ8
 CDifbVk8s9YCfqnkFGDjdEg27ee/CXCmsw/8v+nDceS5EdjdZphG7xi
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwAnYUIy_kVqNpcOAA--.14655S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWxGr18Ary3Zw1UJrWDArb_yoW8JF4DpF
	W8G3WYkayDAa45Kwnaqr1fZFnxtr10yFWUKa1FgasayFW5uFZ7tw4rG343Xa4v9r1vy3Za
	qF4Y93WfAayYgaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU13ku3UUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAQEWpF4E0ABwABsE

On 2026-06-30 11:55 -0500, Bjorn Helgaas wrote:
> On Mon, Jun 29, 2026 at 01:59:51PM +0800, Jia Wang via B4 Relay wrote:
> > From: Jia Wang <wangjia@ultrarisc.com>
> > 
> > Add the required core, dbi, and aux clocks for the DP1000 PCIe
> > controller and enable them before initializing the DesignWare host.
> 
> > +static int ultrarisc_pcie_init_clks(struct ultrarisc_pcie *ultra)
> > +{
> > +	struct device *dev = ultra->pci.dev;
> > +	int ret;
> > +
> > +	ultra->clks[0].id = "core";
> > +	ultra->clks[1].id = "dbi";
> > +	ultra->clks[2].id = "aux";
> > +
> > +	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(ultra->clks), ultra->clks);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to get clocks\n");
> 
> This would be the first use of devm_clk_bulk_get() in drivers/pci.
> There are several users of devm_clk_bulk_get_all(), which looks pretty
> similar.  Unless there's a specific reason to use devm_clk_bulk_get(),
> could this use devm_clk_bulk_get_all() instead?
>

Thanks for the review.

I used devm_clk_bulk_get() intentionally because I wanted the driver to
enforce the fixed clock names required by the binding.

That said, if you prefer following the existing drivers/pci pattern, I can
switch to devm_clk_bulk_get_all() in v2.

Best regards,
Jia Wang


