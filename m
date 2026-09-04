Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDA5408035;
	Fri,  4 Sep 2026 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788500249; cv=none; b=A/mQhsW0CwxohEoOaiCqGHz3y6SS/o2tdWaCtYgRjukWhPOvH7pvLw0ZHlaDrvlY/TeDKt5VVKEweaO3Sw3s57ba9zAr6Abvl7O/gibFDdu7jD4lpEAZej+dhOH0na7APJlB2Z64QMGd1M5/ip2T2LuMvELODPg4qzWQwGdP1oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788500249; c=relaxed/simple;
	bh=gNBCWygtsgFtdJ2nV0+K5R+MGg6xOee4zPrP57wxl3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+B0Ry6Py2lDGRvPmte0Y+tfcYikqHWFlDVynGhOhFcoQdd6ywQ+vGXbmoy/vnoJ7WK6RrWwE2PEkW2BDEv+I0DwT49keVQt4VpLmrkM7DkR3Bs3Pf0WvP+5RioxzubgHT+b+NDXWPTdigbtVMwIZgpljiJm59qjeQvOUCQ4+pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIsiMbC/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIsiMbC/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F404A1F00A3E;
	Fri,  4 Sep 2026 05:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788500248;
	bh=SFC174a5lM3QA/qkiQ5x58fZ9+pC4R37PqysvPWjuY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WIsiMbC/+hg5/BNjS4Sipx6judUyI5sRZx7fn+QhklUTfhYI2yv/Rq7QLQBOqgQTO
	 ncSG5vBqifyzcXVDVRJ5QApQ50ZdAse7d7qu/mEatOOuCjxxIyQwBjVC6vLjg2x0Xz
	 bQ2ECZiN+ZmZbSNfuC8Zl/9VcMrrV+ItZSZB2gFKOvFX/S1/ly5SKVgpzbTFQc8RI3
	 V50Ps19mudiAx2RiFVGQRRM5NbQ8wQt4JzUOgYKPGpo4RF33VsoH4/LpdBscrJtz/V
	 sS35CJf5YW/ioT5Zj4/LoxGegH7i8A8G+g1IjW9Z464usfBpSo8Y6PmClMWXVk8lo6
	 YHpx7xDq+Vrcg==
Date: Fri, 4 Sep 2026 07:37:23 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Xincheng Zhang <zhangxincheng@ultrarisc.com>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	wangjia@ultrarisc.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@kernel.org>
Subject: Re: [PATCH 1/2] PCI: dwc: Allow drivers to skip MEM outbound iATU
 setup
Message-ID: <appZE_65HKRSoZA4@fedora>
References: <20260827055448.1818858-1-zhangxincheng@ultrarisc.com>
 <20260827055448.1818858-2-zhangxincheng@ultrarisc.com>
 <apmPeZEdanf80HVB@ryzen>
 <apmSiooxKzb9l-TB@ryzen>
 <20260904015134.3740048-1-zhangxincheng@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904015134.3740048-1-zhangxincheng@ultrarisc.com>

On Fri, Sep 04, 2026 at 09:51:34AM +0800, Xincheng Zhang wrote:
> On Thu, Sep 03, 2026 at 05:30:18PM +0200, Niklas Cassel wrote:
> 
> Yes, I agree that the skipped MEM windows need an identity mapping check.
> In v2 I will move the bypass decision until after calculating the same
> outbound addresses used by the normal iATU programming path, and fail the
> host init if a skipped MEM range is not identity-mapped:
> 
> 	atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
> 	atu.pci_addr = entry->res->start - entry->offset;
> 
> 	if (pp->bypass_ob_mem_iatu &&
> 	    atu.parent_bus_addr != atu.pci_addr)
> 		return -EINVAL;

Looks good.
I think it also makes sense to add a short code comment above the
if-statement.


> 
> This should prevent the driver from silently relying on no-match pass-through
> when the DT "ranges" describe different parent-bus and PCI addresses.
> 
> For the databook reference, the relevant text I found is in the DWC PCIe RP
> Controller Databook v6.00a, June 2022. Section 3.12.2 says the default
> outbound no-match behavior is pass-through, and Section 3.12.5.6 "No Address
> Match Result" says the address is not translated and programmable TLP header
> information comes from the application transmit interface. I will cite those
> RP Databook sections in the v2 commit message instead of referring to this
> generically.

Sounds good.


Kind regards,
Niklas
