Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC00027A462;
	Tue,  7 Jul 2026 02:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783392520; cv=none; b=ZM4zqgC72IIQZEY47e4SlFyfNy+SzXE1cS3wz8wChCvnMTqIwyveuneyhhiTjh2es9v9qSDe/zfQQ3N3WrVNVaBmkt2h7a+3bi7Pwva0VZnuylv5q73ko2tublTTE5B0S1udOIhrKlWMZ0hHeVF3xeIdTtV7y3QtQ8iCVoPbmNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783392520; c=relaxed/simple;
	bh=UHOO4VmU4maezaXvt3QgjY+ylPttNFy7aCiDkY1w8Rg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=QHLkmgKW4FwJaqQmMyXScOQ79sUcwPSbV8I/Hi/VPmrKTRE5V6Ftez6O+lBhsreIaNv7sAM/T5ne+A6Y2x8S7CFZZ/vPxfEbaQJ+pjvJIx8NC0V7pl+MZffjcEDRryGxljK/531kMV1SeaPytpjuhJXDt1oQKrz9LWBEW3JCWdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=Iq8f9O5a; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="Iq8f9O5a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=QpQP5EQPpoyHFGTz2GHAm9OaHV/iBw1BU
	XaxtSiyGVI=; b=Iq8f9O5amhtIaRoWlDoV+tChVOHxYTYX9GjFP9eibtdy3kKA9
	ZO2W5WRRLSCEK2XEXpBTfhZ4Jdj0Rd3Zhj7hFbvyyKKv8XthdNmoU4n8NisI5IvM
	as8oAcTy+RfDSdjde3tM+fp5yN//ejXwp5I0tN4fWcgfRmNhTMXyLHBQTI=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnYUIRaUxqoTIPAA--.15065S2;
	Tue, 07 Jul 2026 10:48:49 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 3/3] PCI: ultrarisc: allow DP1000 driver to build as
 module
From: Jia Wang <wangjia@ultrarisc.com>
To: sashiko-reviews@lists.linux.dev
Cc: Jia Wang <wangjia@ultrarisc.com>, linux-pci@vger.kernel.org, 
 conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260706100746.1673F1F000E9@smtp.kernel.org>
References: <20260706-ultrarisc-pci-clk-v2-0-2f3fb6fba66b@ultrarisc.com>
 <20260706-ultrarisc-pci-clk-v2-3-2f3fb6fba66b@ultrarisc.com>
 <20260706100746.1673F1F000E9@smtp.kernel.org>
Date: Tue, 07 Jul 2026 10:48:17 +0800
Message-Id: <178339249750.3836076.2659050467958951262.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783392497; l=2203;
 i=wangjia@ultrarisc.com; s=20260515; h=from:subject:message-id;
 bh=UHOO4VmU4maezaXvt3QgjY+ylPttNFy7aCiDkY1w8Rg=;
 b=zcFin1mdsqef59d+Uhmbzwy73GBKruIPmloMLC1gJ5bU/GjBIbVTRluw170KjbWrfYtfWFcOV
 Z+uEY4md1WcCB8ZnpkWxnjIVLp4m5CE+9T8fYlyy99hodgh/8hHAXmD
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=wGVm18siRScehKOkOz0WKxgxDy7IezHEszhnN4/TUCY=
X-CM-TRANSID:AQAAfwAnYUIRaUxqoTIPAA--.15065S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW8Xr4kWF18uFWDAr1rtFb_yoW8tF18pF
	45GayUAF1kJr45Xanrtw4UuFyjqan3JrWFgFnrKw1avrn09r1UurykK34Yy3ZrAr18Xr12
	k3yqkw1DCa1jvw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvI14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
	9x0JUSNtxUUUUU=
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAAEWpLJk4AIgADs4

On 2026-07-06 10:07 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Missing `.remove` callback leaves the PCI root bus registered, causing a use-after-free on module unload.
> --
> 
> commit 14ef8e08324f6393567996c3e1dc0b2cadbcfc0a
> Author: Jia Wang <wangjia@ultrarisc.com>
> 
> PCI: ultrarisc: allow DP1000 driver to build as module
> 
> This commit changes the driver registration from builtin_platform_driver()
> to module_platform_driver(). This allows the driver to be built and
> dynamically loaded or unloaded as a kernel module.
> 
> > diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > @@ -225,7 +225,7 @@ static struct platform_driver ultrarisc_pcie_driver = {
> >  	},
> >  	.probe = ultrarisc_pcie_probe,
> >  };
> > -builtin_platform_driver(ultrarisc_pcie_driver);
> > +module_platform_driver(ultrarisc_pcie_driver);
> 
> [Severity: High]
> By switching to module_platform_driver(), this driver can now be unloaded
> dynamically. However, since ultrarisc_pcie_driver lacks a .remove callback,
> will unloading the module leave the active PCI root bus, IRQ domains, and
> child devices registered?
> 
> If devres automatically frees the struct ultrarisc_pcie memory and unmaps
> MMIO registers on module unload while the PCI subsystem still retains
> pointers to them, could this result in a use-after-free and kernel panic
> during subsequent PCI config space accesses?
>

Thanks for pointing this out.

The driver does support `CONFIG_PCIE_ULTRARISC=m`, so it should provide a
proper teardown path for module unload. I'll add a `.remove()` callback in
the next version to clean up the PCI host resources accordingly.
 
> >  
> >  MODULE_DESCRIPTION("UltraRISC DP1000 DWC PCIe host controller");
> >  MODULE_LICENSE("GPL");
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706-ultrarisc-pci-clk-v2-0-2f3fb6fba66b@ultrarisc.com?part=3
> 

Best regards,
Jia Wang


