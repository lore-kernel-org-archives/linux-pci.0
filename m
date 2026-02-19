Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A352405ED;
	Thu, 19 Feb 2026 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771536364; cv=none; b=N8oOm6i3fyNa634XNPAQFsUcTkRURLXbLdCfL2+fNokG2VMVS5EecGg+vLeEIvWM5FoB9M0lh9kwpXJMkHYV8OC1zQmRKUIYFf6JSPGW6hRIJjsTApWkPqbpNP2awf5d9xUFEhIgAVICIx4UMGwOfu0s71Xuqun98KfNG+w6AzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771536364; c=relaxed/simple;
	bh=YIDjjCT8VlKCDwPmSc/JOrd11FT8NFis22ah5fZFVWc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Soh2oNuxKWw+XNxaHtCR0f443XYu7a62oun4qkNpyp9DT6jzLm7zByOU3BHCclnq5KtHzILRl2uckqq9DNuiM8FYzr2c9ybUC8KBtybbRLmp06ydwl0YeBJmU0Uh5Bafh7RqxEyhUN3ZMvTWw/uGjsG/1bUtFxlF8Uwo4bj3hiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnDHfqAl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnDHfqAl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71334C4CEF7;
	Thu, 19 Feb 2026 21:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771536364;
	bh=YIDjjCT8VlKCDwPmSc/JOrd11FT8NFis22ah5fZFVWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VnDHfqAl28ewj6l+URSiwtYAg0COPhvU2xDL/9kqpn6A1gVe8Xh3XtNOyXaA6Seoj
	 sUyTnfvB2tsE5Dq5dQhzsj/MIDTaOk5yOl6FhwaL3rSZJnr8SH9Gqj8NziQx1mK+gk
	 Xeflc+vNRaTv9C5a2eqcOoUe8jFR7XFdzoY7XlW9UFJnbYGoS05atiYZLDwOzKqUrb
	 ESFJet/g54Z+EbsCoO9B1WPx5jWPZG1ii1TSh9i+B9xIr0nAI8ehH2xzK4eLPl8EIg
	 Q6/HZRafbWPG/krOjqAt7B+t9aBpt2c0fGL5lRxCio7Qgmb7hgH7ZrJqQ/kpw5jVNt
	 OWbd6u9KjYacQ==
Date: Thu, 19 Feb 2026 15:26:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Matthew W Carlis <mattc@purestorage.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>, ashishk@purestorage.com,
	msaggi@purestorage.com, sconnor@purestorage.com,
	Lukas Wunner <lukas@wunner.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jiwei <jiwei.sun.bj@qq.com>, guojinhui.liam@bytedance.com,
	ahuang12@lenovo.com, sunjw10@lenovo.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI: Always lift 2.5GT/s restriction in PCIe
 failed link retraining
Message-ID: <20260219212602.GA3498590@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2512072345220.49654@angie.orcam.me.uk>

On Mon, Dec 08, 2025 at 07:24:23PM +0000, Maciej W. Rozycki wrote:
> Hi,
> 
>  I've figured out that backporting will be less intrusive if an update to 
> use `->supported_speeds' is posted as a separate follow-up change.  So it 
> is now 2/3 in this series, after 1/3 comprising the original patch, only 
> trivially updated.  Then 3/3 moves the maximum link speed determination 
> earlier on for an early exit in the PCIE_SPEED_2_5GT case; maybe unlikely, 
> but essentially free now, now that we retrieve the speed anyway, and makes 
> code a little simpler yet.
> 
>  Please let me know if you'd prefer me to fold 2/3 into 1/3 after all.
> 
>  Previous iterations:
> 
> - v1 at: <https://lore.kernel.org/r/alpine.DEB.2.21.2511290245460.36486@angie.orcam.me.uk/>.

Applied to pci/enumeration for v7.1, thanks.  This will be rebased
after v7.0-rc1.
