Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125DF340D91;
	Thu,  5 Mar 2026 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714660; cv=none; b=H9Nyg5hjyBu0iALnFK3A27SV06zxRC4ClK4bjExQDCFGh4NYVo/tz4F7N4DS90avPIQTBZIh8W6jWGWQqrlcTdIdlVGr+uBF10Q96xX+XPW9m32B/fVQyt4WEAdnPNJl4SrLJk9fWvfcfNrWf+jYc9BG0mowMmYA+3GDTM1H6wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714660; c=relaxed/simple;
	bh=VvhCTWZ3793M6/O335k62TbJTkcqRXxJQLzgve7zKlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHFb7ag/EIjOVpk61ktGn5LzjTRP4lqDdotNFQUFTBkipYFidbclnYQLTWXpKzSAfYXNg3NhiltUVgiMg9tA8Iimj5hKpY65i4n0ZGAtZTGIHYNGG7HnecmioBemI72Fu6Bchm2pqFj6T3cqiq6zbhehAJPBJG3jf2JOfAMXorA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=l50LaDmj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="l50LaDmj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=L3RgJ7ay7e4JV2CizcjZPXE74NAx+EJwuTVFkQMPa0A=; b=l50LaDmjwGawLaPx5tzHoFyGj9
	uGN8SEcW1FWI6giSjN9Agdyb79Tf3OMhQXp/1gLi0v88hElChCRRTsLpqVYtIZK+paqMnlyltD32A
	LQ0AhdD22P4ujgDapZgRXFYGLCZrA45NiSH8me9Kg1PaTgCmj/ZWbGhtviqwB04DVbNPwnLa8dKI9
	9mxRpqIu1HtkdGIRvZLX3sD9iAPjMIC43yTRproxomlma7C/XuD/8yQmfeCSYHF/SWDmMp1a0l3AJ
	wMvKbs4k9v54egyciEG7tZ4AAqzht7nPQY0ActrFtJhzqMRqqOw4aTsCQSik4pbjnzIjQ7ivxUwR2
	mURwhBjQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54444)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vy83h-000000007wT-3LTg;
	Thu, 05 Mar 2026 12:44:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vy83d-000000000Sp-2FwN;
	Thu, 05 Mar 2026 12:44:01 +0000
Date: Thu, 5 Mar 2026 12:44:01 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Joe Perches <joe@perches.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH phy-next 22/22] MAINTAINERS: add regex for linux-phy
Message-ID: <aal6kWDx_3XRGB4K@shell.armlinux.org.uk>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-23-vladimir.oltean@nxp.com>
 <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
 <20260305085148.7cwo3yflp7vcfldf@skbuf>
 <f3a5aa3df78553ffc0fd0024f5fd36a4e2158c88.camel@perches.com>
 <20260305114352.2f7btqixg4tu5bzl@skbuf>
 <20260305121532.GA1649635@rocinante>
 <20260305122957.GA1652563@rocinante>
 <20260305123956.ojkt4k3ly64xz7fu@skbuf>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305123956.ojkt4k3ly64xz7fu@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 05, 2026 at 02:39:56PM +0200, Vladimir Oltean wrote:
> On Thu, Mar 05, 2026 at 09:29:57PM +0900, Krzysztof Wilczyński wrote:
> > For content match, it could also be:
> > 
> >   K:    phy
> > 
> > I believe this would match everything of interest?
> 
> Yeah, and way more. Think USB PHY, network PHY, etc. Don't want to drown
> the linux-phy mailing list in unrelated patches, either.

Also phylink, any memory management / DMA stuff that happens to mention
"physical", and probably numerous other examples.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
