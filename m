Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3733A451E;
	Thu,  9 Apr 2026 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775753740; cv=none; b=Kk+lId4DWdHF3AzzfDTVb4LgWUh38ief3BIg74n08E/ttprTZvgTo1qvZ6gZuPfxtc+cITGZ34QMnAKYzu8olwbS8mwYrt1vbNhYLcx7POOhrJv7TMENH6lhdsh3cC1owO7ZqieZB9zekJQ8IvMxIicjQNdjkxMn2hLIxc/MORo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775753740; c=relaxed/simple;
	bh=Sy7rh5K1WBTB9rOE/PjDplirdBoBlh6Bjfh7+yc2P/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tx1kIq742WumLMJCzPhcswOeoMDkbNlTsvhD8jMlyTueX/oDGXDKhPEWlCdPUG39hJeLfbt1DN/YqFcxZN/Vzyqalfhdtq9ccmADcJG4VRxdTWElQYQFfHdib3nRMazok7jkaPQb/a7KsGZxsjMAKg3A+ydIXTFlptS5+6sKQ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJCBDzcP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJCBDzcP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EACFC4CEF7;
	Thu,  9 Apr 2026 16:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775753739;
	bh=Sy7rh5K1WBTB9rOE/PjDplirdBoBlh6Bjfh7+yc2P/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJCBDzcPDhcxKn1d7oK69PzRtX30A2zUtGBR0gsygWNDtOHgFmsLCv+EuAoghlzY/
	 njrHesDGxa62iNPWF9b8tp5THRqN2FUM/1KH8bkoMySs/8pfoF4hMDVjNEXHzzjSxI
	 pM+eG4u3dnag3MlYEy6sSJ7CUWyGtVnJolWFMDYyq6l58YGSZ0hnrhepb8RcuZGpYv
	 fOlzB2iMJVYkdjowkcTPAn/GT+lfJN3J1uJJ0r1YOiBXOxOXpWLyKJiPjAI+mSqE96
	 /E7OGDbCQ5ygCPQyyQN8o8Xh26lT0sdNKk0ygqxtTgj2ekhC1YDZdRLi9NgaXWEkRN
	 AOdRQVbJQY8XA==
Date: Thu, 9 Apr 2026 22:25:28 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com, 
	jonathanh@nvidia.com, kishon@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, 
	Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com, jingoohan1@gmail.com, 
	vidyas@nvidia.com, bhelgaas@google.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, cassel@kernel.org, 18255117159@163.com
Subject: Re: [PATCH 1/1] PCI: tegra194: fix min() signedness when capping
 ASPM L1 entrance latency
Message-ID: <dlt7wnuuhxvkuzw4fqtprvkoagxibb3hsw5epqtj4l2yms6yku@pejcof2p3vg2>
References: <20260407145749.130753-1-mmaddireddy@nvidia.com>
 <61133700-7024-4f72-98bf-ac8cc94b3a56@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61133700-7024-4f72-98bf-ac8cc94b3a56@nvidia.com>

On Wed, Apr 08, 2026 at 11:27:28AM +0530, Manikanta Maddireddy wrote:
> Hi Mani,
> 
> I added W=1 argument to make command to reproduce the issue, but I am not
> able reproduce the issue at my end. I made this change based on the issue
> description in
> https://lore.kernel.org/oe-kbuild-all/202604051407.AODe3ddZ-lkp@intel.com/,
> but I couldn't verify the fix since build is working fine with or without
> this change.
> 

You need to use the same config/compiler that was used by the bot. In this
case, it used parisc-allyesconfig and hppa-linux-gcc (GCC) 15.2.0.

- Mani

> Thanks,
> Manikanta
> 
> On 07/04/26 8:27 pm, Manikanta Maddireddy wrote:
> > The DT property "aspm-l1-entry-delay-ns" is converted to microseconds,
> > then encoded for the L1 entrance latency register field as ilog2(us) + 1,
> > clamped to the hardware maximum of 7.
> > 
> > ilog2() returns int type, while the upper bound is 7U (unsigned int).
> > The min() macro is implemented with __careful_cmp(), which rejects mixed
> > signed and unsigned operands at compile time via BUILD_BUG_ON_MSG in
> > minmax.h; that check trips on this pair, notably when building with W=1.
> > 
> > This combination fails to build (e.g. parisc allyesconfig, GCC 15, as
> > reported by the 0-day bot).
> > 
> > Use min_t(u32, ilog2(us) + 1U, 7U) so both sides of the comparison are
> > unsigned and consistent with aspm_l1_enter_lat.
> > 
> > Fixes: 4a44cd65c9dd ("PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1 entrance latency")
> > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202604051407.AODe3ddZ-lkp@intel.com/
> > ---
> >   drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > index 393f75ce3df3..93d3452ac117 100644
> > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > @@ -1147,7 +1147,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
> >   	if (!ret) {
> >   		u32 us = max(val / 1000, 1U);
> > -		pcie->aspm_l1_enter_lat = min(ilog2(us) + 1, 7U);
> > +		pcie->aspm_l1_enter_lat = min_t(u32, ilog2(us) + 1U, 7U);
> >   	}
> >   	ret = of_property_read_u32(np, "num-lanes", &pcie->num_lanes);
> 
> -- 
> nvpublic
> 

-- 
மணிவண்ணன் சதாசிவம்
