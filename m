Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C108A349AF4;
	Wed,  4 Feb 2026 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770225165; cv=none; b=TytAZw83DE/v2hUsNrx9RF0ZDF8fUnxPFFLiD/HJ8mx4spFijIXnqLOK6Nu4VnJkyw8CCNnjSivSL3hiaQEmHwYb6qlY21BUjzctQhcHChr82xyYgC48b/8MQw6Bn66CzTv0HGJNn43/szdb+yd7lcI32/HeS6SkdTPvl6VeY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770225165; c=relaxed/simple;
	bh=CczwpdJpKi9anUoA2Grmzs48yg+1ZLwYqTdWyeEEp/s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ltKaPIWHZKZ9m+cN1OCPp2V1R9JjsCNc4s50nFapL+ZcVddn1jfNNS8qitvxB0PeiVl/CLrzEuERtCqto2gP4/s0cfqxlPuzjjihPyoKfkxbkEh/zoArNuxQCS0n0XRe8MsIt6w8gzA8OXcnM3Qr56YO7oRrcmazfdu6wwrvdpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 3832092009D; Wed,  4 Feb 2026 18:12:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 3218392009B;
	Wed,  4 Feb 2026 17:12:43 +0000 (GMT)
Date: Wed, 4 Feb 2026 17:12:43 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Bjorn Helgaas <bhelgaas@google.com>, 
    Matthew W Carlis <mattc@purestorage.com>, 
    ALOK TIWARI <alok.a.tiwari@oracle.com>
cc: ashishk@purestorage.com, msaggi@purestorage.com, sconnor@purestorage.com, 
    Lukas Wunner <lukas@wunner.de>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Jiwei <jiwei.sun.bj@qq.com>, guojinhui.liam@bytedance.com, 
    ahuang12@lenovo.com, sunjw10@lenovo.com, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: [PING][PATCH v2 0/3] PCI: Always lift 2.5GT/s restriction in PCIe
 failed link retraining
In-Reply-To: <alpine.DEB.2.21.2512072345220.49654@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2602041709010.12532@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2512072345220.49654@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 8 Dec 2025, Maciej W. Rozycki wrote:

>  I've figured out that backporting will be less intrusive if an update to 
> use `->supported_speeds' is posted as a separate follow-up change.  So it 
> is now 2/3 in this series, after 1/3 comprising the original patch, only 
> trivially updated.  Then 3/3 moves the maximum link speed determination 
> earlier on for an early exit in the PCIE_SPEED_2_5GT case; maybe unlikely, 
> but essentially free now, now that we retrieve the speed anyway, and makes 
> code a little simpler yet.

 Ping for: 
<https://lore.kernel.org/r/alpine.DEB.2.21.2512072345220.49654@angie.orcam.me.uk/>.  
Re-verified with 6.19.0-rc7.

  Maciej
