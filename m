Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DE13469E7;
	Wed, 18 Feb 2026 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771437629; cv=none; b=l2FkBpfYMtLc6mor2LQNDu1Pr0XDBXYLlV6zoOP9c5EU/rrBioMk626EhD1u8Wh3qmzpoayjfXa3G5RPiwPIayxMcHZW8pFgH5Cy4mv8GOk1q8HXSCohAQpoPdvlb0EYv8PeIfpC4aAlRjfWmXB3FPttLBhYZJUhOjTwidri2m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771437629; c=relaxed/simple;
	bh=gWynbg/VKXQAN9aPqjzcgveEiP+CJr3CvzoGhf27Dtc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hJW9oREvqPcBA61/tdLG/3+jgaPN4wHhXlLvbtLQuyGqwK+K7YDzyj2sp52Jmytd6dii7yLSOMbP2Ea7yk8wy9ahg7KFXbJFjUJse8pEkmuJ77TZXOBIC+ZbHKAsfGH47yB13W7dz0HeXyAPp1V3kVg1qiaFXJG9glqaBMT9joI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxkqO7b8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxkqO7b8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475D1C2BC86;
	Wed, 18 Feb 2026 18:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771437629;
	bh=gWynbg/VKXQAN9aPqjzcgveEiP+CJr3CvzoGhf27Dtc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PxkqO7b80ne5wuhrmUUQNrv7/MBryrXdJdxCU+09U8q3K6tNhHD83v21CBe9F1AvX
	 46TJuqiBV9dzdqXg4C829nqXs1MOX4WjCouCOo4f6QvRWPFFDaGYJ/mO1Sh4PuWwqC
	 op2NbjaaBY3+xc3wscgOwOwcdUstBWS8pKRgYP6X50V0ii/iEJ9yGvUzk0jD+zYM0y
	 sJ34MZsrySQ/y46Hmmwdg3bQy5PtiTmsxDrB5kcNc5daXHt2857c/b7/21lIuacCVX
	 Zd7ZQ4kwbRWs2vR3Y5zXfxm3D79lmud60TiU+mzmslxTNOBJPCdlC2AJkJZcnzmDU4
	 QL08lUXy928zQ==
Date: Wed, 18 Feb 2026 12:00:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Arnd Bergmann <arnd@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: select configfs
Message-ID: <20260218180027.GA3435176@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY7wXJQJsfdqJ4j9@ryzen>

On Fri, Feb 13, 2026 at 10:35:24AM +0100, Niklas Cassel wrote:
> On Fri, Feb 13, 2026 at 08:39:34AM +0900, Damien Le Moal wrote:
> > > I think at that point we would instead drop PCI_ENDPOINT_CONFIGFS
> > > as a Kconfig option, since it is never user selectable. Otherwise
> > > this is probably a sensible solution as well.
> > 
> > +1. That option is mandatory, so it is not an option at all :)
> > If PCI_ENDPOINT is set, we must have configfs.
> 
> A quick git grep:
> 
> $ git grep PCI_ENDPOINT_CONFIGFS
> Documentation/PCI/endpoint/pci-ntb-howto.rst:If PCI_ENDPOINT_CONFIGFS is enabled::
> Documentation/PCI/endpoint/pci-ntb-howto.rst:If PCI_ENDPOINT_CONFIGFS is enabled::
> Documentation/PCI/endpoint/pci-test-howto.rst:If PCI_ENDPOINT_CONFIGFS is enabled::
> Documentation/PCI/endpoint/pci-test-howto.rst:If PCI_ENDPOINT_CONFIGFS is enabled::
> Documentation/PCI/endpoint/pci-vntb-howto.rst:If PCI_ENDPOINT_CONFIGFS is enabled::
> Documentation/PCI/endpoint/pci-vntb-howto.rst:If PCI_ENDPOINT_CONFIGFS is enabled::
> Documentation/nvme/nvme-pci-endpoint-target.rst:CONFIG_PCI_ENDPOINT_CONFIGFS, and CONFIG_NVME_TARGET_PCI_EPF enabled.
> Documentation/nvme/nvme-pci-endpoint-target.rst:If PCI_ENDPOINT_CONFIGFS is enabled::
> arch/arm/configs/multi_v7_defconfig:CONFIG_PCI_ENDPOINT_CONFIGFS=y
> arch/arm/configs/omap2plus_defconfig:CONFIG_PCI_ENDPOINT_CONFIGFS=y
> arch/arm64/configs/defconfig:CONFIG_PCI_ENDPOINT_CONFIGFS=y
> drivers/pci/endpoint/Makefile:obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)       += pci-ep-cfs.o
> drivers/pci/endpoint/pci-epf-core.c:    if (!IS_ENABLED(CONFIG_PCI_ENDPOINT_CONFIGFS))
> drivers/pci/endpoint/pci-epf-core.c:    if (!IS_ENABLED(CONFIG_PCI_ENDPOINT_CONFIGFS))
> include/linux/pci-ep-cfs.h:#ifdef CONFIG_PCI_ENDPOINT_CONFIGFS
> tools/testing/selftests/pci_endpoint/config:CONFIG_PCI_ENDPOINT_CONFIGFS=y
> 
> 
> I think we should just merge and send Arnd's fix to Linus for the 7.0
> release cycle.
> 
> If we want to remove CONFIG_PCI_ENDPOINT_CONFIGFS, it will require changes
> in the docs, defconfigs, etc., so it does seem like something that would
> have to target 7.1 rather than 7.0.

Are there other undefined references lurking that we just haven't
tripped over yet?
