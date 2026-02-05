Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824461F63CD;
	Thu,  5 Feb 2026 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298100; cv=none; b=NDF2UfSJ3R51nmKMSujzq1uBo7OhYx9hNB5dizh2wnkAjU2zCD7FrpxkVKKPQ8FltAwddWQR9YHAHREnY+XEXHki9o5BYI0/ea9LVx6SMFlVyfYx5Z8qKL8moN0s5qU3dm0RFUPbRsHRIJQgCa+/+Sesxud5NAtLuKFOVDQCncQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298100; c=relaxed/simple;
	bh=RVwIHojJPFtR1L6mECLDirnCU93wad5+Ug+yqXZvlGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVGArsoKzMAZ0Z8nwr9GbbpXt/oJNUZtTWIBMPAPNtvdKczF0kP4fZh6LPz4CNUceHagYNuAr7e2QtriztF+Y6pFhEPJQXBfApAPbNbHx/o4ky+7SiOSYmlcrrRQGUMDDzmjQcFsGSWSWvMfrU0OgdmWVvYorqNRnC/GBunbCRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCy9lXRU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCy9lXRU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10184C4CEF7;
	Thu,  5 Feb 2026 13:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770298100;
	bh=RVwIHojJPFtR1L6mECLDirnCU93wad5+Ug+yqXZvlGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hCy9lXRU7VwFbtpEzZC8tJW3BxP0Y+kkOtXRSjO0Y/EbAqe2ZZTbmD3BTi+LY6IvV
	 3VDoNHBAthurR5saMIBgCknSgSKPY2kGtXATsfjShk+vrtTpIeuOCp/3+PRWt4h+7V
	 NfsIGMCSL9N8FHQWjGcnLmRfl9x363lCi8STV4b2xUCDb+V5S7N4RZFBFOyHW5eVAh
	 p+nrJ0Y1mgPjQ2mbhzLmSLjkiqokuvr17PC7JJzYeMGiQeTE4nPNaH4ako1HCiqwT/
	 303Cny++W7VOs+ai2NNL3LA5Vh9EvxCBWwE1HqldlEbOWmjNfjQjG11uvFZZKfRlIm
	 Z5WIAf475MuMg==
Date: Thu, 5 Feb 2026 14:28:13 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: Ricardo Pardini <ricardo@pardini.net>, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, helgaas@kernel.org,
	heiko@sntech.de, mani@kernel.org, yue.wang@amlogic.com,
	pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v7 0/2] PCI: Configure Root Port MPS during host probing
Message-ID: <aYSa7d8G1adGho0z@ryzen>
References: <20251127170908.14850-1-18255117159@163.com>
 <f5322597-c6dd-494a-863b-2caf24363f2d@pardini.net>
 <1ff0d069-14f0-439a-afca-4ecc1b569834@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ff0d069-14f0-439a-afca-4ecc1b569834@163.com>

On Sun, Jan 18, 2026 at 09:26:45PM +0800, Hans Zhang wrote:
> On 2025/12/31 10:58, Ricardo Pardini wrote:
> > On 27/11/2025 18:09, Hans Zhang wrote:
> > > Current PCIe initialization exhibits a key optimization gap: Root Ports
> > > may operate with non-optimal Maximum Payload Size (MPS) settings. While
> > > downstream device configuration is handled during bus enumeration, Root
> > > Port MPS values inherited from firmware or hardware defaults often fail
> > > to utilize the full capabilities supported by controller hardware. This
> > > results in suboptimal data transfer efficiency throughout the PCIe
> > > hierarchy.
> > > 
> > > This patch series addresses this by:
> > > 
> > > 1. Core PCI enhancement (Patch 1):
> > > - Proactively configures Root Port MPS during host controller probing
> > > - Sets initial MPS to hardware maximum (128 << dev->pcie_mpss)
> > > - Conditional on PCIe bus tuning being enabled (PCIE_BUS_TUNE_OFF unset)
> > >    and not in PCIE_BUS_PEER2PEER mode (which requires default 128 bytes)
> > > - Maintains backward compatibility via PCIE_BUS_TUNE_OFF check
> > > - Preserves standard MPS negotiation during downstream enumeration
> > > 
> > > 2. Driver cleanup (Patch 2):
> > > - Removes redundant MPS configuration from Meson PCIe controller driver
> > > - Functionality is now centralized in PCI core
> > > - Simplifies driver maintenance long-term
> > > 
> > > ---
> > > Changes in v7:
> > > - Exclude PCIE_BUS_PEER2PEER mode from Root Port MPS configuration
> > > - Remove redundant check for upstream bridge (Root Ports don't have one)
> > > - Improve commit message and code comments as per Bjorn.
> > Hi Hans,
> > 
> > I've tested on an Odroid-HC4 with a SATA SSD (via an ASM1061) by
> > applying your v7 on v6.19-rc3 + Bjorn's 20251103221930.1831376-1-
> > helgaas@kernel.org ("PCI: meson: Remove meson_pcie_link_up() timeout,
> > message, speed check" which is required to get the meson PCIe to work at
> > all since 6.18). With that setup I get:
> > 
> > # hdparm --direct -t /dev/sda
> >   Timing O_DIRECT disk reads: 832 MB in  3.00 seconds = 277.33 MB/sec
> > 
> > I've an identical machine, with a similar disk (even slightly faster, on
> > paper), running plain 6.12.y and there I get:
> > 
> > # hdparm --direct -t /dev/sda
> >   Timing O_DIRECT disk reads: 764 MB in  3.00 seconds = 254.26 MB/sec
> > 
> > I repeated those a few times, not very scientific, I know; but anyway:
> > 
> > Tested-by: Ricardo Pardini <ricardo@pardini.net> # on Odroid-HC4
> > 
> > I've also feedback from another user running with this series with
> > success on a different meson PCIe machine, will ask them to TB as well;
> > they had reported a significant drop in performance since v6.18 without
> > this.
> Hi,
> 
> Thank you very much for your test. Let's wait for Bjorn's reply.

Probably too late for the 6.20 / 7.0 merge window...

But.. it would be nice with some kind of feedback from Bjorn.

Is there any chance that this gets applied for 6.21/7.1 or is there
any fundamental objection against this series?


Kind regards,
Niklas
