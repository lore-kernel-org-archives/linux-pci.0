Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1461D3EBF16;
	Thu, 19 Feb 2026 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771517630; cv=none; b=k8bAUjpMEw4P82JWGLwTRKkqtbYMk57KGt9vs9RCF0k0G8F5giCPwIJpVdZ5txJ+WI6Eekyy1/T1RUWXEghb6AGLk5rxW6Jr3T5+oB/8BR2HqUC+yYXJ2mTrBCdrWwTBkJMZ1TPwvAc6NWAmXlnIGRBp40ZiikzQI2J6+2SiuvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771517630; c=relaxed/simple;
	bh=z5WAESoU7Sb4yHB7TTEz0bth0nj2ZnnSpYyP9Pr8X0I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=t2hGYY1BHbcZwn+8vuWEU6JbFPDtW4g+odcl7cRfIeIyP2XZNOKbqbLEW9W31wa9jLs4JpMHvmcUZbm9KXNaMv6SSkTjVl9Ljl//LTQWRWO1MrmuYbDXhzUDguZgRwy2+JQUx4fzVY3shC0Pcy2G/QuhphgI6+YbIOsIqYg8Yo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5Ly8wDf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5Ly8wDf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C958C4CEF7;
	Thu, 19 Feb 2026 16:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771517629;
	bh=z5WAESoU7Sb4yHB7TTEz0bth0nj2ZnnSpYyP9Pr8X0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=u5Ly8wDfxC6QmohgBT4k2LBfAdO97OjLPo1Y+SfzfUOIrp/I7PtVin47EjCvADdkJ
	 ldkclyzCfzA7gIzxSNcfjH8sWNrUdf4uTi//kHHJs+KxUvYOyp5XH+Yjov0OV7u6sq
	 rh47AlQwP2CvmVyy873luKiX/wP1huPnitX70vVJ1C9Wi5yQRWk3b5ZG3IINkBjT7n
	 IwL6RqekVZ3sr7usI4f8Mtqi5hHH5keVMKdTCq6Np48jWkz+gOu89fqDISWwdonKLj
	 zuQT2+cCZ8/IefxK915YdHRiEcNjdfvP3MdV+xoTwYJRg0B7T/oi/dud0Ab5gnk3oC
	 yJgMFTLWCbFsQ==
Date: Thu, 19 Feb 2026 10:13:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Arnd Bergmann <arnd@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Koichiro Den <den@valinux.co.jp>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: select configfs
Message-ID: <20260219161348.GA3483770@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZcKVLGNSifE60-P@ryzen>

On Thu, Feb 19, 2026 at 02:04:20PM +0100, Niklas Cassel wrote:
> Hello Bjorn,
> 
> Since there now is a for-linus branch, is there any chance that we could
> include:
> https://lore.kernel.org/linux-pci/20260202145407.503348-3-den@valinux.co.jp/
> 
> In the for-linus branch?
> 
> Otherwise, the new inbound submapping feature in the PCI endpoint
> framework, that was added in the v7.0 merge window, will be buggy
> with regards to in-place updates.
> 
> If we include the above series before v7.0 final, all kernel
> versions with this new feature will have non-buggy in-place updates.

The URL you mentioned is for "[PATCH v2 2/2] PCI: dwc: ep: Always
clear IB maps on BAR update", but here you mention "the above
*series*".  Do we need both commits of that series?
