Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5FA3368BF;
	Mon,  6 Apr 2026 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775479062; cv=none; b=iIWHArlAqok0o5aMF1/YxsnKH/NKDZ81B46ViTJ3wX49nmI2FGfGFZA3UnYw7cR0fw6UpeCjHbBAPok/19E9JoTVdS6k7z1f9JZ8puK7fmNRWuw4BN8eLQTlnZdRQGu3+EGcAYJ5Yg8BiiNKrjs3moDMkQhz+f8y5LukPXIlaQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775479062; c=relaxed/simple;
	bh=jDWo6+SjLg0ECrFBwUS2wSfSOs3ThAS24loBQlJOI9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+lsCRj558Q/mhUEpRj0ABvQdLAUSaQJjyrdmskeYeTm3tAlszoMn/JbOMCWFzDpgz3EtrMsRqMq3uZ1/AMQOi6Izhtj5dMZLKp8q61ufrktDy++ijzv4KdL1Ks3ZUbOH9Gmit3Z06rGsZ6io9a4AuLCNsPWpYUN2tCVfjInz8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1w9jD1-000441-00; Mon, 06 Apr 2026 14:37:39 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 1F503C0256; Mon,  6 Apr 2026 14:37:11 +0200 (CEST)
Date: Mon, 6 Apr 2026 14:37:11 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: linux-mips@vger.kernel.org, naseefkm@gmail.com, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, bhelgaas@google.com,
	vkoul@kernel.org, neil.armstrong@linaro.org, p.zabel@pengutronix.de,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	nbd@nbd.name, ansuelsmth@gmail.com, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 8/8] mips: dts: Add PCIe to EcoNet EN751221
Message-ID: <adOo9xZxXT3FkufM@alpha.franken.de>
References: <20260309131818.74467-1-cjd@cjdns.fr>
 <20260309131818.74467-9-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309131818.74467-9-cjd@cjdns.fr>

On Mon, Mar 09, 2026 at 01:18:18PM +0000, Caleb James DeLisle wrote:
> Add PCIe based on EN7528 PCIe driver, also add two MT76 wifi devices
> to SmartFiber XP8421-B.
> 
> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
> ---
>  arch/mips/boot/dts/econet/en751221.dtsi       | 114 ++++++++++++++++++
>  .../econet/en751221_smartfiber_xp8421-b.dts   |  21 ++++
>  arch/mips/econet/Kconfig                      |   2 +
>  3 files changed, 137 insertions(+)
> 

applied to mips-next

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
