Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C94C3D3337
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630132; cv=none; b=sFQsCtNlqOgzF8VMbKyO5z4UfIbdP0Gyno4A74XrAbsDDsfTvKtRP6r25GB75FZvL/ZOF1s95/r7sw1b9AMYIRhAtmLfhfhrh6vp/wKJm8tlYCpU3D40LZDHbSOWHTwFkloX0YVMf93U8uh/XPLbn7Nt1nmQNbmPDYrs5dPaDmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630132; c=relaxed/simple;
	bh=DuXwyifht1p5OOBJAt+1EzIQhN/D8uHDlyum/3h1hXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gp30WPEmgmRteNo8rE4FTLZziXXUkalLcpYHA2J6x27yrEJRJ87lPL1AVDmF5/mOheSLDd+MtgVljn4BTQ36nX6dbiFjIqNBKs/mgFip5hrkskTB4Ke82k/Nx5RFHMkkBUm2HQseo87ivYdCw0ZjCBd6Rg3dTuqJEZAy82kUkRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=aj4hVuC9; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aj4hVuC9"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gx6WL509cz8v2B;
	Thu, 09 Jul 2026 22:48:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783630126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zp6buoIPY6d/G+h76UehrOogrmvSPdhVMgLud2G+3Tc=;
	b=aj4hVuC9TVYEm1P0v7sn/IMqoHz0fL0V3L7C9eZfcylcv0c+MhjCTy8R1CKaUgbTzFQKFP
	sHqWAy6ov41MosolGL6naUlqMXyflB4cipgZLLsNk73sQNC/AS0mrWDmaf8iUewOL8ca2K
	VvgnoFidLS20Vtpx33xwEieWVa7sWhBQKVjCP5eLs9cMEkzs6wIEdCdjqWlWBrXHbkh5s4
	CQvJIH18I8msWqMmagUOlorfz1+46ZtiXqPkM39ZTtXwmor4XhXOlXpj9nVQciERVhkNOV
	kGTiBEKOGmsx9hYDeE9Zy6GOqvP02BVju1Rx9PCQqZQ3Sl4O+MPYdwqoLWr6Xg==
Message-ID: <d1fe1c68-a362-4fdf-a493-94b779a31f9f@mailbox.org>
Date: Thu, 9 Jul 2026 22:48:44 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [pci:controller/dwc-rcar-gen4 2/4]
 include/linux/irqchip/arm-gic-v3.h:605:10: fatal error: asm/arch_gicv3.h: No
 such file or directory
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
 Manivannan Sadhasivam <mani@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <202607100424.xo06gLTB-lkp@intel.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <202607100424.xo06gLTB-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c455d0b45bcbf3a6081
X-MBO-RS-META: fzxbmurb5ccb5is93brhko9ickb6rsei

On 7/9/26 10:38 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-rcar-gen4
> head:   14e8394423ffd4fd28884ec8b4d5ba15be6e7e0d
> commit: 8ba5de8db3acd06e35c42ecd0becc38134348df3 [2/4] PCI: rcar-gen4: Configure AXIINTC if iMSI-RX is not used
> config: parisc-randconfig-r071-20260709 (https://download.01.org/0day-ci/archive/20260710/202607100424.xo06gLTB-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 16.1.0
> smatch: v0.5.0-9185-gbcc58b9c
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260710/202607100424.xo06gLTB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202607100424.xo06gLTB-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     In file included from drivers/pci/controller/dwc/pcie-rcar-gen4.c:16:
>>> include/linux/irqchip/arm-gic-v3.h:605:10: fatal error: asm/arch_gicv3.h: No such file or directory
>       605 | #include <asm/arch_gicv3.h>
>           |          ^~~~~~~~~~~~~~~~~~
>     compilation terminated.
> 
> 
> vim +605 include/linux/irqchip/arm-gic-v3.h
> 
> 7e5802781c3e109 Andre Przywara        2014-11-12  604
> 7936e914f7b0827 Jean-Philippe Brucker 2015-10-01 @605  #include <asm/arch_gicv3.h>
> 021f653791ad17e Marc Zyngier          2014-06-30  606
> 
> :::::: The code at line 605 was first introduced by commit
> :::::: 7936e914f7b0827c2dcfe63fbefdc21de2d61dcb irqchip/gic-v3: Refactor the arm64 specific parts
> 
> :::::: TO: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> :::::: CC: Marc Zyngier <marc.zyngier@arm.com>
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Patch is already posted as

[PATCH] PCI: rcar-gen4: Inline GIC_TRANSLATER offset macro
