Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5C33264C3;
	Thu, 30 Jul 2026 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399409; cv=none; b=CiUPYRMtqPaeat80Y8tFsclk7BQ5z65i+emqJSmUzNBqEwupoBHZDZ8GZcHrted3VnEA29Zzs0u3i9Qathrx9QLia1gk9CDv5SDHS7Vj9UeynM7/WWLWb5u8E0KDj4+8BaoEdu5jStI+38Bq5UZaRmb41mLiB73IYIfmmU6qG7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399409; c=relaxed/simple;
	bh=owZ44+kMAKcFP6ncPVxG6cLmJGQ85Knopjrfa26tnyg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Gtg6RMQz6ybl1jjEjTRSFuwaPLpTWnVjhAJeBKs76K+8nfh1YotfQeqhdopWX3WPM4kAzlyLI0YDSNl1WTzS+d3vOJRSuVNkDPcONynNaEY1eA2FScRr/dnigftkNdYssnIC8jaDlhGmWZoznS6im2e/4K9xTw6WtdhSlXPOGsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=SywfEC+S; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="SywfEC+S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=3940JcE5ZkcguIpPsEefZYfbmpbsm7UdX
	bQA8p0jrXc=; b=SywfEC+SouA+12j8AlqjKDMcIB2Cw0Egmc8SMoUWJIBeqFjLg
	n9vqPOs0+e4bb5I3PNknHJjHFHFFMzdRWzgd30Q4djuJcJFfYtT05MhaLJq/rzct
	ixNUZav6+V5K10Mxbtq/REukE/Xr6C3C/TMEF42bBj5txCfE7Y6UD6ZHjo=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwA3cUJ8CGtqKMsVAA--.18291S2;
	Thu, 30 Jul 2026 16:17:00 +0800 (CST)
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
Cc: Jia Wang <wangjia@ultrarisc.com>, 
 Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <dvarzmhaakmz5qycowdwxqggkwvezijjestz5miv2cqy4b3ilw@zek66ydqjo5l>
References: <20260714-ultrarisc-pci-clk-v3-0-e72723fc0ef1@ultrarisc.com>
 <20260714-ultrarisc-pci-clk-v3-3-e72723fc0ef1@ultrarisc.com>
 <dz43ty5hgpefk67lmgxfn2tmppng4ws6oy66zns5ajt3qwdfai@k3exaapdqvxh>
 <178539453673.553273.3197955075422858659.b4-reply@b4>
 <dvarzmhaakmz5qycowdwxqggkwvezijjestz5miv2cqy4b3ilw@zek66ydqjo5l>
Date: Thu, 30 Jul 2026 16:16:32 +0800
Message-Id: <178539939270.1582149.5148262134429405169.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785399393; l=2716;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=owZ44+kMAKcFP6ncPVxG6cLmJGQ85Knopjrfa26tnyg=;
 b=eiUDKyofwmfHo/0iIZzmz3Ixc85XDmU2P5kVplzlnDujO+Y2hUx8yRivvlNAugT/qtGB/LO24
 j5e5oLSYu9eD8iCLwPQb0YiUsUT+zt4onGs4fvGz/fTwKnre90t2WaK
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwA3cUJ8CGtqKMsVAA--.18291S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAryfXw1xWF43Kw1DAw4fKrg_yoW5GF4kpF
	WUGa4YkF4kJF4aya17K3WUZ3WYywnIqrWYg3ZIgwnIvF9I9ryUXryDKa4YkF92yr48Ar12
	vw4Yka43GF45Z3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAEEWpqylMAEAAAsd

On 2026-07-30 09:46 +0200, Manivannan Sadhasivam wrote:
> On Thu, Jul 30, 2026 at 02:55:36PM +0800, Jia Wang wrote:
> > On 2026-07-29 15:49 +0200, Manivannan Sadhasivam wrote:
> > > On Tue, Jul 14, 2026 at 09:11:04AM +0800, Jia Wang via B4 Relay wrote:
> > > > From: Jia Wang <wangjia@ultrarisc.com>
> > > > 
> > > > CONFIG_PCIE_ULTRARISC is a tristate option, so the driver can be selected
> > > > as a module when COMPILE_TEST or platform configuration allows it.  Using
> > > > builtin_platform_driver() leaves the module build without the module
> > > > init/exit plumbing and causes modpost failures for the generated .ko.
> > > > 
> > > > Use module_platform_driver() so the driver works for both module and
> > > > built-in builds while keeping the existing tristate Kconfig entry.
> > > > 
> > > > Add a remove callback and call dw_pcie_host_deinit() during removal so the
> > > > root bus is torn down before devres releases the controller data.
> > > > 
> > > > Fixes: 5fc35740c3b3 ("PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root Complex driver")
> > > > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-ultrarisc.c | 10 +++++++++-
> > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > > > index 72ba5840b62d..9bee522a20e9 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > > > @@ -193,6 +193,13 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +static void ultrarisc_pcie_remove(struct platform_device *pdev)
> > > > +{
> > > > +	struct ultrarisc_pcie *ultra = platform_get_drvdata(pdev);
> > > > +
> > > > +	dw_pcie_host_deinit(&ultra->pci.pp);
> > > > +}
> > > 
> > > Since this driver registers an internal MSI controller, it is not safe to
> > > remove it due to irq disposal concern. But you can build this driver as a
> > > module though.
> > >
> > 
> > Right, I missed that this was intentionally changed to
> > builtin_platform_driver() to prevent irqchip removal. I will drop this
> > patch entirely in the next revision. Thanks!
> >  
> 
> No, you can still load the driver as a module, that is fine, but just do not
> allow removing it. So your module_platform_driver() change is fine.
>

Understood. I will keep module_platform_driver() and drop only the remove
callback in v4. Thanks for the clarification.
 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
> 

Best regards,
Jia Wang


