Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111FE377A94;
	Mon, 21 Sep 2026 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005291; cv=none; b=B8fAgYQxd0JctKxY067mf2nIOQMBQohYnAyOsyeMW+lBmkqLsV9USYy0pa2L3OSsUwPdv0gDu6tmm7wZorB/4C/43VwZcqt5Bg3+PdJHnHBl8QJZFH/1w9qtL6ZI96z3l1GmnuPl8qEV4UQgEt/O+2fDO/xE9EtTuYak6FHei38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005291; c=relaxed/simple;
	bh=MaCpI/YtHYcsM2wFMlqo1VbHyGefTQC4Z5hzP+0B+eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiAjp8zg3f3iWT2oQK2jvuicRokuKg7nB2pa6chpy1Um0L8GLSH55pKYy2kAzbA3OaErCehYmGLB75XZt+CVuVndZMRPRMKrCAYX2sIdXnCeCVNc02yPplXRxCzAfjJKKf1OqnR6WAlQtfA5R8gND7HITs+jBZZ1Dlq7XkqA5JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 1B6DD4CEE;
	Mon, 21 Sep 2026 17:41:20 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D316A60E6339; Mon, 21 Sep 2026 17:41:19 +0200 (CEST)
Date: Mon, 21 Sep 2026 17:41:19 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] PCI: pciehp: Make poll mode parameter read-only
Message-ID: <arFQH_PE29XEsMbi@wunner.de>
References: <20260921142608.270312-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921142608.270312-1-runyu.xiao@seu.edu.cn>

On Mon, Sep 21, 2026 at 10:26:08PM +0800, Runyu Xiao wrote:
> pciehp_request_irq() and pciehp_free_irq() select different resources
> based on the global pciehp_poll_mode parameter. The parameter is
> currently writable through sysfs, so changing it while a controller is
> active can make teardown stop a nonexistent polling thread or call
> free_irq() for an IRQ that was not requested.
> 
> Keep the parameter available for boot and module configuration, but
> prevent runtime changes to the registration mode.
[...]
> Fixes: 2aeeef119995 ("pciehp: Clean up pcie_init()")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM Codex
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

The Fixes tag looks odd to me because the module_param has existed
before the tree was even converted to git, as has the irq usage.
I'd just drop the Fixes tag and use only the stable designation.

Thanks,

Lukas
