Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5013F4973B3
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398761; cv=none; b=Ea8TvUgsdeTjkVbOHLrk71SWLMMUQtS3/lzkKLmQ9ow9XKaQ+lm92ZyRC0MQjUt/iL4PF+26Miqqs4cXiBST8kI7lPTE1o/Ur6uP7L+uRKzv4C3VJ6yuwk4zZ4hCRVS7ERSsd0miD/DRVp+zlXLgQjla9unC412yNG+AcjuVU5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398761; c=relaxed/simple;
	bh=C3Wo810EdBB10iK1uBbMiXmj/v/hK0B6msFWHYLJJjs=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=cQVypo/h8Q6TmA3EM2CRAs+kRVIVydfNuaJdsSyBLLQI30KQuz/Qld0RrEwRC6dxhlg7EBUf9QWBMIpnkGUYdmKs8hcSaN/crf0SFKakDkImGAghRDil4iijP/jyJs5U+s/SgzPkBpgYfs7mDb0CwgPMC49JCSS0g00B1ARO+v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=rih+jcjl; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="rih+jcjl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=UzCsr8OmabNPRLNV57VAtwreQr3Iep4b4
	cSFl7E8h6k=; b=rih+jcjlR3dxi4LqykjYu/E0CEn1fTfDa6Xypejt+KZYBnaWe
	lA9J3DDEYDzuaWAbHdaZKVW+/Ztto/tTrUYL3rjbRhD0CckjBMlPJFy9pefpaEQf
	PCpLJuMS+0vvihd0ERt1wHf1uA9BoYsg3JXZSc54XHQ5tuy/lrJ50up6KA=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwC3cwWh1dVqeHACAA--.730S2;
	Mon, 19 Oct 2026 16:32:33 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] PCI: ultrarisc: Remove bypass_ob_mem_iatu variable
 on DP1000
From: Xincheng Ji <jixincheng@ultrarisc.com>
To: sashiko-reviews@lists.linux.dev
Cc: Xincheng Ji <jixincheng@ultrarisc.com>, linux-pci@vger.kernel.org
In-Reply-To: <sashiko-outbox-176707@kernel.org>
References: <20261019-dw-pci-fix-v1-0-9b7860f919b9@ultrarisc.com>
 <20261019-dw-pci-fix-v1-2-9b7860f919b9@ultrarisc.com>
 <sashiko-outbox-176707@kernel.org>
Date: Mon, 19 Oct 2026 16:32:33 +0800
Message-Id: <179239875333.3277712.11479056245012803076.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792398753; l=2333;
 i=jixincheng@ultrarisc.com; s=20260922; h=from:subject:message-id;
 bh=C3Wo810EdBB10iK1uBbMiXmj/v/hK0B6msFWHYLJJjs=;
 b=MPtbO0oyhBFXhc2hLSnDm7cre/riMUwLgYT0QhaSu0hYws9dpuJM8soSw4FQJ+MDct6Q+rJbq
 V1yNmTdySa/BxBxyUAaGkW+XvUp75SwNuIf9uUEXs9VtgSztYDzC7Qn
X-Developer-Key: i=jixincheng@ultrarisc.com; a=ed25519;
 pk=n848dcS5D6g0vLad/rjp4Gf/1eedTe1a3pYUrkt2260=
X-CM-TRANSID:AQAAfwC3cwWh1dVqeHACAA--.730S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tryxtr15tr4xWFyrtw43Wrg_yoW8tw43pa
	y8Ga1jkF4DXFs09r42v3WDAa4Svwn7Aa4kWFnIgw17uFnxuFyUtFyxK34av3WDGw4kWr15
	KF1Yg34fJa17Wa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk214x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE-syl42xK
	82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
	C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48J
	MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
	IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUUUUU
X-CM-SenderInfo: pml0x0xfkh0wg6xo325dul2uoofrz/1tbiAQAFDmrVviwAAQAFsj

Hi,

On 2026-10-19 06:53 +0000, sashiko-bot@kernel.org wrote:
> > diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > index 523f454c6c524..a0d328c0c09b7 100644
> > --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > @@ -154,12 +154,6 @@ static int ultrarisc_pcie_probe(struct platform_device *pdev)
> >  
> >  	pp = &pci->pp;
> >  
> > -	/*
> > -	 * DP1000 routes MEM transactions without outbound iATU windows, which
> > -	 * avoids the 16-window/4GB-per-window aperture limit.
> > -	 */
> > -	pp->bypass_ob_mem_iatu = true;
> > -
> 
> [Severity: Low]
> Does splitting this removal from the preceding commit ("PCI: dwc: Skip MEM
> outbound iATU setup for identity mappings") break bisectability when
> CONFIG_PCIE_ULTRARISC is enabled?
> 
> The preceding commit already removed the bypass_ob_mem_iatu field from
> struct dw_pcie_rp in drivers/pci/controller/dwc/pcie-designware.h:
> 
> struct dw_pcie_rp {
> 	...
> 	bool			ecam_enabled;
> 	bool			native_ecam;
> -	bool			bypass_ob_mem_iatu;
> 	bool                    skip_l23_ready;
> 
> while ultrarisc_pcie_probe() in drivers/pci/controller/dwc/pcie-ultrarisc.c
> still sets pp->bypass_ob_mem_iatu = true until this patch, causing a build
> failure at the intermediate commit.
> 
> Should this change be squashed into the preceding commit (whose commit
> message already states "Remove bypass_ob_mem_iatu and the UltraRISC-specific
> setting"), or ordered before the struct member is removed from
> struct dw_pcie_rp?
> 
> >  	platform_set_drvdata(pdev, ultra);
> >  
> >  	ret = ultrarisc_pcie_init_clks(ultra);
> 
Thanks for pointing this out.

Am I correct in understanding that the issue is with the dependency 
between the patches,as the intermediate commit would fail to build 
when `CONFIG_PCIE_ULTRARISC` is enabled?

Would you prefer that I reorder the patches so that the UltraRISC-specific 
assignment is removed first, or squash the change into the preceding commit
that removes `bypass_ob_mem_iatu`?

I'm happy to revise the series accordingly to ensure that each commit 
builds independently.

Thanks for your guidance!

Best regards,
Xincheng

-- 
Xincheng Ji <jixincheng@ultrarisc.com>

