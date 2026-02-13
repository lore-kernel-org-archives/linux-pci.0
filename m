Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8561734BA5B;
	Fri, 13 Feb 2026 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770975329; cv=none; b=Ppnm00MHEkTm8rTqytUpN9hSmlxnDROfybCaN9CCYFFChMU2q4+N4McwynIa8G9l2snXkqqNlwP0iKLhD79MYti90RnKe8MO8D/YLqNcpIKIpDEs21TfR1jpISIuLtWvdjwfhzdX6KgCQFvCThRFjfr9OMrdnK+G0WgcaY9irnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770975329; c=relaxed/simple;
	bh=qKq+hjCP/YJat1ucupR+w2uMI2+t1Cp7kusKObm4dck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mX23Z/O9O49APNw3t7vlYTMygty44fp87TUmc6SyfxWBta1D17JNouMgMklTXd+JzQMfIAy7bvI7Wl1axTymIA10SewHEtQxkZ3uCYwK1umIoMb1Jk/bwzZZI4ubO5Lvg0c+foO2Eg4nR7xVu+65W1QEhHPy+3SRRR7ArYUWOKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/UOvFPP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/UOvFPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B19CC19424;
	Fri, 13 Feb 2026 09:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770975329;
	bh=qKq+hjCP/YJat1ucupR+w2uMI2+t1Cp7kusKObm4dck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X/UOvFPPOc8frp6/45QymlXZ7/bBWSzo1ucJf0uolXCJhjAtOOPURGbcA9heLUC2D
	 at7KRzzHFRbZc2J1onpp/XoBP6ZT1XBb1luJJHB+Tc78Tdln+WlAiNQL/lK4/eXP9P
	 5ql2j7uaE6fACogVzAYP3/19vdh3Vxg5G4rW2g4WceL0XnMbittMGE/d8kMOJlQp9P
	 qPRItHDDiu/CzaVlkQLorUTSbJcud5qu0s/0meUSNRnhpo4jQQ0xWRJ3tuOd9Mhwqm
	 ecjELTrIh5bgGiVZQ4nMmxMABKDNP9Fst+7yPlZcyPsRaEo5am6f3KkXr73zezw8Xl
	 ER05r70ErXtIQ==
Date: Fri, 13 Feb 2026 10:35:24 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: select configfs
Message-ID: <aY7wXJQJsfdqJ4j9@ryzen>
References: <20260211070812.4087119-1-arnd@kernel.org>
 <aYxGR-x3lGt7H1dp@ryzen>
 <8db96e1b-2559-4966-87d9-171854c6ce19@app.fastmail.com>
 <554897dc-1cd6-461d-9248-cc491b984a9e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <554897dc-1cd6-461d-9248-cc491b984a9e@kernel.org>

On Fri, Feb 13, 2026 at 08:39:34AM +0900, Damien Le Moal wrote:
> > I think at that point we would instead drop PCI_ENDPOINT_CONFIGFS
> > as a Kconfig option, since it is never user selectable. Otherwise
> > this is probably a sensible solution as well.
> 
> +1. That option is mandatory, so it is not an option at all :)
> If PCI_ENDPOINT is set, we must have configfs.

A quick git grep:

$ git grep PCI_ENDPOINT_CONFIGFS
Documentation/PCI/endpoint/pci-ntb-howto.rst:If PCI_ENDPOINT_CONFIGFS is enabled::
Documentation/PCI/endpoint/pci-ntb-howto.rst:If PCI_ENDPOINT_CONFIGFS is enabled::
Documentation/PCI/endpoint/pci-test-howto.rst:If PCI_ENDPOINT_CONFIGFS is enabled::
Documentation/PCI/endpoint/pci-test-howto.rst:If PCI_ENDPOINT_CONFIGFS is enabled::
Documentation/PCI/endpoint/pci-vntb-howto.rst:If PCI_ENDPOINT_CONFIGFS is enabled::
Documentation/PCI/endpoint/pci-vntb-howto.rst:If PCI_ENDPOINT_CONFIGFS is enabled::
Documentation/nvme/nvme-pci-endpoint-target.rst:CONFIG_PCI_ENDPOINT_CONFIGFS, and CONFIG_NVME_TARGET_PCI_EPF enabled.
Documentation/nvme/nvme-pci-endpoint-target.rst:If PCI_ENDPOINT_CONFIGFS is enabled::
arch/arm/configs/multi_v7_defconfig:CONFIG_PCI_ENDPOINT_CONFIGFS=y
arch/arm/configs/omap2plus_defconfig:CONFIG_PCI_ENDPOINT_CONFIGFS=y
arch/arm64/configs/defconfig:CONFIG_PCI_ENDPOINT_CONFIGFS=y
drivers/pci/endpoint/Makefile:obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)       += pci-ep-cfs.o
drivers/pci/endpoint/pci-epf-core.c:    if (!IS_ENABLED(CONFIG_PCI_ENDPOINT_CONFIGFS))
drivers/pci/endpoint/pci-epf-core.c:    if (!IS_ENABLED(CONFIG_PCI_ENDPOINT_CONFIGFS))
include/linux/pci-ep-cfs.h:#ifdef CONFIG_PCI_ENDPOINT_CONFIGFS
tools/testing/selftests/pci_endpoint/config:CONFIG_PCI_ENDPOINT_CONFIGFS=y


I think we should just merge and send Arnd's fix to Linus for the 7.0
release cycle.

If we want to remove CONFIG_PCI_ENDPOINT_CONFIGFS, it will require changes
in the docs, defconfigs, etc., so it does seem like something that would
have to target 7.1 rather than 7.0.


Kind regards,
Niklas
