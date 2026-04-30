Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC27B2C236B;
	Thu, 30 Apr 2026 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777572538; cv=none; b=dPtlV3OToki9j4D/wHSvfvYX+FyxI4jh7LyFoLNcqxNczMMrU+F2uF+IY6HI1XqiQW4359sis6EjboGtNx3ifSFrhSlIpVqUBfKXJVvhsEzEi/pcdAZeE+PUSl3xy++R2PLegHntgY/kaHFla6wxi6rH9KDz/hv6LleHDzYJbg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777572538; c=relaxed/simple;
	bh=dZ6rh6cH5EmBYhYJEewoXLuYpzoZltyzjdN7FwOzwBY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YAtm2E2S2NlgR3ljk4DDsvFETUdk2aXCQxUKr+XWhoP9cCyy9Wlml+feIbt8JVr3L1DDSB/itjxAXV47K5erNXmZSEekvsFW3ObVDkqZmQMKWGbdZdz1vhUVvb/FAbDK9wZJSoz6OC6AT6IK6sWi1HgK2bBBTudJhtwLp1Hi49k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mf7yxmPi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mf7yxmPi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0BFC2BCB3;
	Thu, 30 Apr 2026 18:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777572538;
	bh=dZ6rh6cH5EmBYhYJEewoXLuYpzoZltyzjdN7FwOzwBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mf7yxmPiZ9ob9t5hV5sX/auWhagcP7LJMXFMynPTHG0Ocut5yj+M44wst2Z4LoDHK
	 hrMqi7NeMNcqzRhkbrXirCSfAFnvC0t92AehomLYqRNiI/a0QsIjbVp+lWd4K7ljG0
	 LFijlpNsa+HfMVeVuXN6MmzF2of2SZxgMM2butlp3vk+5vbtr1QZN8kvJbkShJnsce
	 smuaxEnNGuWmzJ2iMHGjwnupNRdNfBU02cLsIw8yNpkA6u3c9Wu4AuY8M71JP8i58z
	 i3g2nbjvFBSZ1NZm8dEuU78r161o5itEwpa4wszaZX7gJIcauQqk8U9HhWYjHPI8Ru
	 k7vwcFNnCXO2Q==
Date: Thu, 30 Apr 2026 13:08:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, jingoohan1@gmail.com, robh@kernel.org, s32@nxp.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 00/16] PCI: Use FIELD_MODIFY() to simplify
 bitfield operations
Message-ID: <20260430180857.GA421892@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430162420.42839-1-18255117159@163.com>

On Fri, May 01, 2026 at 12:24:04AM +0800, Hans Zhang wrote:
> Replace open-coded bitmask clear + FIELD_PREP() sequences with the
> dedicated FIELD_MODIFY() macro.  FIELD_MODIFY() performs the same
> operation but is shorter, less error-prone, and includes compile-time
> checks to prevent field overflow.
> 
> This series touches the PCI core, PCIe extended capabilities (PTM, IDE,
> TPH, MSI, REBAR, IOV, CardBus), and several DesignWare-based and
> other PCI host controllers.  No functional change is intended.
> 
> The patches are split per subsystem or per driver to ease review:

A "resend" implies that this is the same series as posted earlier but
forgotten for some reason.  But the original was only twelve minutes
earlier, and this adds more instances.  This should be a "v2" with a
note about what changed from the original posting.  In any event, I'll
ignore the original posting in favor of this one.

Looks like a good candidate for coccinelle.

> Hans Zhang (16):
>   PCI: Use FIELD_MODIFY()
>   PCI/PTM: Use FIELD_MODIFY()
>   PCI/IDE: Use FIELD_MODIFY()
>   PCI/IOV: Use FIELD_MODIFY()
>   PCI/TPH: Use FIELD_MODIFY()
>   PCI/MSI: Use FIELD_MODIFY()
>   PCI/REBAR: Use FIELD_MODIFY()
>   PCI/CARDBUS: Use FIELD_MODIFY()
>   PCI: al: Use FIELD_MODIFY()
>   PCI: eswin: Use FIELD_MODIFY()
>   PCI: s32g: Use FIELD_MODIFY()
>   PCI: tegra194: Use FIELD_MODIFY()
>   PCI: qcom: Use FIELD_MODIFY()
>   PCI: dwc: Use FIELD_MODIFY()
>   PCI: mvebu: Use FIELD_MODIFY()
>   PCI: mediatek-gen3: Use FIELD_MODIFY()
> 
>  drivers/pci/controller/dwc/pcie-al.c          | 12 ++----
>  .../controller/dwc/pcie-designware-debugfs.c  | 23 ++++-------
>  .../pci/controller/dwc/pcie-designware-ep.c   |  3 +-
>  drivers/pci/controller/dwc/pcie-designware.c  |  3 +-
>  drivers/pci/controller/dwc/pcie-eswin.c       |  3 +-
>  drivers/pci/controller/dwc/pcie-nxp-s32g.c    |  3 +-
>  drivers/pci/controller/dwc/pcie-qcom-common.c | 40 +++++++------------
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  6 +--
>  drivers/pci/controller/dwc/pcie-tegra194.c    |  8 ++--
>  drivers/pci/controller/pci-mvebu.c            |  3 +-
>  drivers/pci/controller/pcie-mediatek-gen3.c   |  3 +-
>  drivers/pci/ide.c                             |  6 +--
>  drivers/pci/iov.c                             |  3 +-
>  drivers/pci/msi/msi.c                         | 11 ++---
>  drivers/pci/pci.c                             |  3 +-
>  drivers/pci/pcie/ptm.c                        |  3 +-
>  drivers/pci/rebar.c                           |  6 +--
>  drivers/pci/setup-cardbus.c                   |  3 +-
>  drivers/pci/tph.c                             | 10 ++---
>  19 files changed, 51 insertions(+), 101 deletions(-)
> 
> 
> base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b
> -- 
> 2.34.1
> 
