Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D502BDC0B;
	Fri, 10 Apr 2026 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845134; cv=none; b=axCrGcX4NmW8tiOlqoqKP758qPWzyhygEeW8zTTRAhf7deB4lJTZAvHrS2pe2H7F3QdfdqUC46ghhmLpdZEbknD/n/3Ar+drfCx/R0eYASYl2zTNg+JmV1nr8ij60TcU6cb0K7CRF/oLhgqgb1k8NPVixA9gIdhR8KNTnVHvWr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845134; c=relaxed/simple;
	bh=B/z6n4ykUpZ/HjNoDe8F4OtGtMpRbRRvw3eJfnpBZJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjvzrW76PI5bZWEKB0L0EN3bLNkWU3ooPJ0HS98HmrVTTEDeoNcAVMeXpn66euIskI2USsIJARUFEpG4N4nnNk8FeKPESlIOJ8dK1QVrT6H3AzSLWWjkDUcc4KPMWR7k1Vu+0RNeD+cMRAk3criNcTCEsoYZdyI32KMaalsz9uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaSFsMZP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaSFsMZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B684C19421;
	Fri, 10 Apr 2026 18:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775845133;
	bh=B/z6n4ykUpZ/HjNoDe8F4OtGtMpRbRRvw3eJfnpBZJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JaSFsMZPOXPIakbkFhWLfjJ1YhKfMivp4DhIwdGS1qVrUWcvoQ9+G8jwAj9ljnd59
	 7gGG4EZEDpSD5jDvCzs4kveqo6GybnDPF+fu8kaZP0J6FbUMAd2L9ki5XQCMmoZsGC
	 KlO5VwkIHq/RpzPHVPT0tkEmmMUw801VkdNGtxI2rCoY4FVf6u0Rb5CeTjbJBv/LcG
	 7chjR3v528PzWJzC0CwOoC8BGARCR0oKxm99m4RH3JC5sdqEu6dMptsS8m2F5Dagh2
	 jhw7ZOmx2eozA2QXucHpY9Z05/t7MgcnQCTUO7PBBWbUbQBUI3Hu+wOV91la9NmYJ0
	 ByD/C6hFLlc0w==
Date: Sat, 11 Apr 2026 03:18:51 +0900
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
Subject: Re: [PATCH 00/20] PCI: Convert all dynamic sysfs attributes to static
Message-ID: <20260410181851.GA1951283@rocinante>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410055040.39233-1-kwilczynski@kernel.org>

Hello,

> This series converts every dynamically allocated PCI sysfs attribute to
> a static const definition.  After the full series, pci_sysfs_init() and
> sysfs_initialized are gone, and every sysfs file is created by the
> driver model at device_add() time.

A note on testing:

  0-day bot (recent test runs; newer builds will arrive later):
    - https://lore.kernel.org/linux-pci/202603170336.zSLrDvlj-lkp@intel.com/
    - https://lore.kernel.org/linux-pci/202603122052.tMV5rzNq-lkp@intel.com/
    - https://lore.kernel.org/linux-pci/202603081334.b91RGVS6-lkp@intel.com/
    - https://lore.kernel.org/linux-pci/202603060207.pnGfKgGa-lkp@intel.com/

  KernelCI (for the "for-kernelci" branch):
    - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/

  Sashiko's feedback:
    - https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40kernel.org/

I sadly do not own any Alpha or PowerPC hardware, so when I was testing
these architectures while working on the series, it would be only under
QEMU.

Thank you!

	Krzysztof
