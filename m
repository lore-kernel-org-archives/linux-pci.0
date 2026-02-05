Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715C431AF14
	for <linux-pci@vger.kernel.org>; Thu,  5 Feb 2026 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297802; cv=none; b=oOOiGBzjyTUL2GoQ31b6dmfY8xbMdDa0pYJBt/ZchUj7sO8ptKpizRzAZk1nCde02xR7MhkhrUQ35u/Hx8li5xb9gJ/cvznULcBeZtshOaTy/yyFCI2IViAUt7cGsFWV7sPv8eTGqt72Qqrm/zf/f72MsJwnmNyOoynJtHaHCMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297802; c=relaxed/simple;
	bh=0Qy1ijXsB+HZGzQyGSFw34vCiCHyNocG/RJOOJBHAuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMuGPRzizaBR3ez7TEfMOJDjcsebM4LTRFEAC8sda9fwp+svwUgL6fOubqwsvUek5wyau4ERJlMFxYcud90O525tbClAhEqhvM0d3UfGE6IFm9sMtmsr/+Kxe7v0+jn3tx0zoUpAd9nPE8zPXzdPyedykFs57v/YvcY9GCJIHBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUDUgsgR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUDUgsgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037D7C4CEF7;
	Thu,  5 Feb 2026 13:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770297802;
	bh=0Qy1ijXsB+HZGzQyGSFw34vCiCHyNocG/RJOOJBHAuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUDUgsgR87Q6mzebChvOiq75jEg/Cc1mXuCArTl6Y45MeBNtp80HLQmQtexvlloTW
	 c1llGZpPro9Q2WiEB4F3d0puqNIWFcswdgZDd8sXLZoJI588AZICGlaI/r+lm0x5fn
	 lU4GgHk55zRIliaAZoOupQ1hefxIOkDseCeixgTngtzmWlTNtNOGbPkegy3Ip3Hw6+
	 QYPGuSZ12z1pS1ZFIm3NZq7acH/sEVXs+RKlKQbHAcG1/cn1yuBZRL4U10/xNaUyo7
	 cTEmqxAiiQUXDEpHKZEQbP75Nhv8V6bG3XRWRLBanT/prf1kQ2S8K3VgrWzI4qXyph
	 BPLaqndonsmLw==
Date: Thu, 5 Feb 2026 14:23:16 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com,
	dlemoal@kernel.org, "Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 0/3] PCI: dwc: Clean up iATU index mess
Message-ID: <aYSZxCtACmQyC0XT@ryzen>
References: <20260127151038.1484881-5-cassel@kernel.org>
 <177029621115.8023.3797281385109418780.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177029621115.8023.3797281385109418780.b4-ty@kernel.org>

On Thu, Feb 05, 2026 at 06:26:51PM +0530, Manivannan Sadhasivam wrote:
> 
> On Tue, 27 Jan 2026 16:10:38 +0100, Niklas Cassel wrote:
> > This series tries to clean up the iATU index mess, by treating
> > iATU indexing for outbound and inbound address translation in
> > a consistent way (increment the index after assignment, and only
> > if the function call succeeded).
> > 
> > 
> > Changes since v4:
> > -Squashed patch 1 and 2, as suggested by Damien.
> > -Added Cc: stable+noautosel for the ECAM patch, such that stable
> >  maintainers will see the dependency needed by this patch.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/3] PCI: dwc: Fix msg_atu_index assignment
>       commit: 58fbf08935d9c4396417e5887df89a4e681fa7e3
> [2/3] PCI: dwc: Clean up iATU index usage in dw_pcie_iatu_setup()
>       commit: b5dab9b38da0a05949458276dde9227c38aa1b39
> [3/3] PCI: dwc: Fix missing iATU setup when ECAM is enabled
>       commit: 43d324eeb08c3dd9fff7eb9a2c617afd3b96e65c
> 
> Best regards,
> -- 
> Manivannan Sadhasivam <mani@kernel.org>
> 

Thank you Mani!

If possible, I think it would be nice if we could get:
https://lore.kernel.org/linux-pci/20260202145407.503348-1-den@valinux.co.jp/T/#t

Since it is fixing some minor things with the new feature inbound subrange
mappings.

You can probably even squash it if that is preferred.
Although, if you squash merge it,

this commit


commit 72cb5ed2a5c6d87f71a409347f7d3b228fee6bee
Author: Aksh Garg <a-garg7@ti.com>
Date:   Fri Jan 30 17:25:15 2026 +0530

    PCI: dwc: ep: Add per-PF BAR and inbound ATU mapping support

    (...)
    
    Fixes: 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support for DWC")
    Fixes: cc839bef7727 ("PCI: dwc: ep: Support BAR subrange inbound mapping via Address Match Mode iATU")


has a Fixes that that references the commit that adds subrange inbound
mapping. (So if you squash merge it, you probably want to update the Fixes tag too.)


Kind regards,
Niklas
