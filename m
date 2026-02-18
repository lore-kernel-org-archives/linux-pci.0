Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595562E888C
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771410824; cv=none; b=ZuSV3e/rdTK0RTgV110fQzzf1zEPgbyMzZ5Cxze8tSVUPX+5rNkAhH6sUWFIY4TQdz4SvOr6qdBQxHC63xbdH3QDTGrfLJZ+KzcVJxgNoksIK7HTvzwIsfDGQOm5F2ZFaOXilBfpUmbOUwHTiuweYrIzuaEfWD89ZldxSyAGLq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771410824; c=relaxed/simple;
	bh=fCM6E0Q4rm6GC2e/QupXeBoowNr6ZoW/sIaT/FalB0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1K10xbbmZa13QGWpex/BDUIWfkC4s5TwnMJ0B3LnoSVmGp/cVrr+4n5Nw/V7lkl6UIzr8W59REYCxqT1+wt9XMjppBVNo9Jmvq+YM4xmkbtoZJnLsVBiHEYT/l0uFD7FARYztmD4nKcvQlyWXRiXmockfaU4WJmLQiaODP68dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtmoGAPI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtmoGAPI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB771C19421;
	Wed, 18 Feb 2026 10:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771410823;
	bh=fCM6E0Q4rm6GC2e/QupXeBoowNr6ZoW/sIaT/FalB0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UtmoGAPIBmfgaMTcaRC6x+UBsUy4H/oTRNJvbyqfR3PvL1LRIUk7m+j/TsvHp8w9I
	 rzIYPDGq0Pb521mCtG2yiq+Y49oocd0H+KczSioAUfwIfwm+eCQfb5BNiCD9qgKF1w
	 T2pQBuCrCPE3PcANhHELGFrmAGnCConQbstq8N0Ct3MtfnyP/mQM6GA5kbGD2pAyTv
	 cTaqSP3m083tBg76R2aLSaGnNV05MifoAH/uO8NU3DJY99usZyMBAInceuFPZ0MIWj
	 p8b3tl49T4LxCA3XYguv14KcLH8QE/ImumcLHyUIuWJQwm6uKJSDbWfc2nZ+lCF7Fd
	 s0UDAc1j3LnVw==
Date: Wed, 18 Feb 2026 11:33:39 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/9] PCI: endpoint: Introduce pci_epc_bar_type
 BAR_DISABLED
Message-ID: <aZWVg2S00uRajBR_@ryzen>
References: <20260217212707.2450423-11-cassel@kernel.org>
 <20260217212707.2450423-15-cassel@kernel.org>
 <aZTlsQedwzvGtD7K@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZTlsQedwzvGtD7K@lizhi-Precision-Tower-5810>

On Tue, Feb 17, 2026 at 05:03:29PM -0500, Frank Li wrote:
> On Tue, Feb 17, 2026 at 10:27:10PM +0100, Niklas Cassel wrote:
> > Add a pci_epc_bar_type BAR_64BIT_UPPER to more clearly differentiate
> 
> s/BAR_64BIT_UPPER/BAR_DISABLED/
> 
> > BAR_DISABLED from BAR_RESERVED.
> 
> from BAR_RESERVED.
> 
> >
> > This BAR type will only be used for a BAR that the EPC driver should
> > disable. (Unlike a BAR_RESERVED, which is still enabled.)
> 
> confused. it looks, "this bar type will be never used by EPC drivers"

I could write it as:
"This BAR type will only be used to describe a BAR that the EPC driver
should disable, and will thus never be available to an EPF drive.
(Unlike BAR_RESERVED, which will never by be disabled by default by an
EPC driver.)"

Is that more clear?


Kind regards,
Niklas
