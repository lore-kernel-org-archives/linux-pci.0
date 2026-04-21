Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487A63DD513;
	Tue, 21 Apr 2026 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776800538; cv=none; b=jLJefcHNmdVWjnCdCzDkkxOa479Y6s2lRtL+Prj+go2M/WiUX70nDbehPRNAzZQ0jtGrJI/OtG9gZ5Rg5Ce5ntxg4CzZAihA4sQjVKzCpLjBpPCDHiKNSbVfCGL/GZ1jEjpMyvqjAN7P9VhjDvlr9Buc6+n6p0XMjCM+eXhHN60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776800538; c=relaxed/simple;
	bh=xmNghYGrPS7aPnR9Fe2A0c3Av//2yBrrb9EMpzvM8+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRnDF+/E1Ep42wmLZa2IgWGRF0++ZZGRPs71HG//7Vcvt8GhOorNINcjqSdVfzwCWCyGaGSMqAefOp13PAnomxWMF7OBdMNteEOwgLfE0ZJY9ad1m/94OPhdDy+BicXdB2puIUoC9co8uTLiBYHXFimxEuJT2+e/ouIjUlbu+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dU4ij2Q8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dU4ij2Q8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59753C2BCB0;
	Tue, 21 Apr 2026 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776800537;
	bh=xmNghYGrPS7aPnR9Fe2A0c3Av//2yBrrb9EMpzvM8+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dU4ij2Q88BapDuHDIZ0EvWzRjerjWcRD2plESQJMgaZTUL0aIFNovwtrRqNKA3ugf
	 eoIcmU1bOv50WdUsaaNP4RpkU+LKK5kEJTTe2DNvcgSdGt5SWkyd07v0xkVULrgtQh
	 VneMWWQpMiFBgNFZuDu9d9Dm7Oge7EA7DIn9wZlJRv6q+LZrht9XX1tyreLccYsy8B
	 NshzYTdRpvYB6ofg6JEC5w46QE+PSjjITJKp84oIb/g67ElZfH1SjbqUo9ONqNzB2F
	 xgAKMogtdPQb6Pee/Xj7dZM+MRIkHtm74+T6YdA3KLJfs78MpSut4PvBzWMVsYvm3t
	 uvIhwa1wrf2IA==
Date: Wed, 22 Apr 2026 04:42:15 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	Oliver O'Halloran <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 07/23] PCI/sysfs: Convert PCI resource files to static
 attributes
Message-ID: <20260421194215.GC1684602@rocinante>
References: <20260416180107.777065-1-kwilczynski@kernel.org>
 <20260416180107.777065-8-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416180107.777065-8-kwilczynski@kernel.org>

Hello,

> @@ -1685,14 +1700,14 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
>  	pci_write_config_word(pdev, PCI_COMMAND,
>  			      cmd & ~PCI_COMMAND_MEMORY);
>  
> -	pci_remove_resource_files(pdev);
> +	sysfs_remove_groups(&pdev->dev.kobj, pci_dev_resource_attr_groups);
>  
>  	ret = pci_resize_resource(pdev, n, size, 0);
>  
>  	pci_assign_unassigned_bus_resources(bus);
>  
> -	if (pci_create_resource_files(pdev))
> -		pci_warn(pdev, "Failed to recreate resource files after BAR resizing\n");
> +	if (sysfs_create_groups(&pdev->dev.kobj, pci_dev_resource_attr_groups))
> +		pci_warn(pdev, "Failed to recreate resource groups after BAR resizing\n");
>  
>  	pci_write_config_word(pdev, PCI_COMMAND, cmd);
>  pm_put:

Moving __resource_resize_store() and everything else related to resizable
BAR resources behind the HAVE_PCI_MMAP and/or ARCH_GENERIC_PCI_MMAP_RESOURCE
check, where either is required for resizable BAR support, would stop this
from being included on architectures that offer no support for resizable
BARs.

Something for the next version.

Thank you,

	Krzysztof
