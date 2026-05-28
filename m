Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C5F30C34A;
	Thu, 28 May 2026 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957259; cv=none; b=cROZgPdEHga8SUwHOAUkQv7xTPXl/h5Hp7qUqZo6NjozW6c1qfzM4Bba6mV3c0Oshb+FOYHt1tOMW/RygYVjFT5f19DSHtMhsOgsIdX7zKBkt7x73Plf157ipI2K9irUV3dOAn+gY6duq1WlgyMgjr3ZzmlKrkqEIIj1WwXCygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957259; c=relaxed/simple;
	bh=0ICNeFIm3QulAQBECc/zVhs9k07hhCBE2QMUbw+B9EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b07UXhCcfTL43HfdHFvR+V1UD8xLgsu2pQq4gbldsZ9vleEt8OB6twh0hXmiGkgkqGR+Hkv7top+qVAaZdNf6qEB/guPsNXxeThCgc7kAPOE9o1jhfMnWG65nkCj2H3p51/CtgOxGhrYZXLEIp1HTfxXWG2WZvQopHKCd9aXjs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTapeyan; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTapeyan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361241F00A3D;
	Thu, 28 May 2026 08:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779957258;
	bh=TfdtxbM/G6Jj5iHu60KzrFB+6duR9vo0YlX85yid0cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WTapeyanxDujFpy/LRvlwNgX7EtdyQvTEBfTJAL9WwNP22PsBGDvkmzBnqxtKMNuW
	 mev/eUGSPgA/zonqekF9IG+td3Rvc/q363V7pv0ICgY06D8qqOycadhwbzGUrIPhOO
	 ZXsPNVqli4x2ocJ6huy9gkwJXHrE8yqFFsU/EeVYCp+h+XXGOgtQu3K1xoJdnTHZGo
	 e++8UrC+bwo4Z+pNqOzER2BWdEkAIN+O3UchB/seRURYYo5+eMJ6TERtQzMz4D0B6O
	 ezoTL/9GrlCZ7nlG3r8iSx6ktl+aA2GQiyW2RUBXgPQ/tDHPT6E+9iQZZD66dBS6nS
	 fmb0XRQ8zzPZg==
Date: Thu, 28 May 2026 10:34:11 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Thierry Reding <thierry.reding@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczy??ski <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Kevin Xie <kevin.xie@starfivetech.com>, 
	Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v5 2/4] PCI: Use standard wait times for PCIe link
 monitoring
Message-ID: <hhf6aj4fwpwqczqsa7q76bcdtqdrpluk62mcivioivuiizc557@z543yluxnow6>
References: <20260526-tegra264-pcie-v5-0-84a813b979d7@nvidia.com>
 <20260526-tegra264-pcie-v5-2-84a813b979d7@nvidia.com>
 <ahV_r6NJWnmJptT2@wunner.de>
 <ahanoZgDwq3v6x8M@orome>
 <ahcob7HMbyGvFgxc@wunner.de>
 <ahfj-uhNTlk-byvU@orome>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahfj-uhNTlk-byvU@orome>

On Thu, May 28, 2026 at 08:44:07AM +0200, Thierry Reding wrote:
> On Wed, May 27, 2026 at 07:22:55PM +0200, Lukas Wunner wrote:
> > On Wed, May 27, 2026 at 10:28:51AM +0200, Thierry Reding wrote:
> > > On Tue, May 26, 2026 at 01:10:39PM +0200, Lukas Wunner wrote:
> > > > On Tue, May 26, 2026 at 10:53:11AM +0200, Thierry Reding wrote:
> > > > > Instead of defining the wait values for each driver, use common values
> > > > > defined in the core pci.h header file. Note that most drivers don't use
> > > > > the millisecond waits, but rather usleep_range(), so add these commonly
> > > > > used values to the header so that all drivers can use them.
> > > > 
> > > > Hm, why not just replace usleep_range() with msleep() and use the existing
> > > > macro instead of defining new ones?
> > > 
> > > I'm trying to somewhat unify the implementations across drivers without
> > > changing behaviour. I don't have a way of testing any of these drivers,
> > > so keeping the existing implementation and just switching out the symbol
> > > seemed like a good compromise.
> > 
> > It looks like the code was copy-pasted from one driver to the next
> > and I applaud every effort to deduplicate, unify and simplify things.
> > 
> > I don't quite see how using msleep() instead of usleep_range()
> > should result in breakage.  The drivers are just polling for
> > link up for an amount of time and as long as you're not decreasing
> > that amount, everything ought to be fine.  Moving to msleep()
> > should never decrease the amount.
> > 
> > > Then again, I count 2 drivers (in linux-next) that use the existing
> > > PCIE_LINK_WAIT_SLEEP_MS, one of which multiplies by MILLI to get at the
> > > US version (so it could easily be converted to the US_MIN version). Only
> > > pcie-designware.c uses msleep() with PCIE_LINK_WAIT_SLEEP_MS, so it is
> > > clearly the outlier.
> > 
> > Konrad Dybcio went ahead and replaced usleep_range() with msleep()
> > in that driver, kudos to him.  Cf. b262518262f5 ("PCI: dwc: Use msleep()
> > in dw_pcie_wait_for_link()").  If you could just carry over that change
> > to the other drivers that would be great.
> 
> Alright, I see you really don't like usleep_range(), so msleep() it'll
> be.
> 

The rationale behind commit b262518262f5 was to comply with the documentation
that recommends using msleep() for delay larger than 10ms:
https://www.kernel.org/doc/html/next/timers/timers-howto.html

So I would also recommend going with msleep().

- Mani

-- 
மணிவண்ணன் சதாசிவம்
