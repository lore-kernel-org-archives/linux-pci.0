Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A6E1A275;
	Sun, 12 Apr 2026 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775975886; cv=none; b=ORd4f25Y6pOo69FHMrqW5Nah8CuQZCf92IsVmFPhmE+ox6KIU3AhXv43zDpaEjBai0srTG+pG6n/VmC4Etvp+jOC7yMdRHZLS5qYaA7oiqfoxnmq6UUCI2Af97QQ6opD1+anxfU8xjZE9Ac1cNpXV4qSdn0VrJoVWTyptlhDGdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775975886; c=relaxed/simple;
	bh=sTTFTGEFAtVBl1AdOtumfXjQUbSRjk8/CzL0mvAKNBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0uU0+KrmOB+331DQhB4QGsrgstjCkgEJMw2yDhakZcBxAsuoqL/g9vRymBiAh7H5bJgqKxg7MKQHWV7fiPSwBOr961jUlO4C+XcpwtL+xTVE1vKBgM9//dWpF58kdrQcbBcuC82ucQiCkxcHuU/vjMtuX1A/P7aFlEyn+TOlhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5VfRa+f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5VfRa+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24957C19424;
	Sun, 12 Apr 2026 06:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775975885;
	bh=sTTFTGEFAtVBl1AdOtumfXjQUbSRjk8/CzL0mvAKNBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P5VfRa+f8Bq9oWoKaDhwdknQhKG1iG4zqj8NDKZCwDkCRnFuMMtzbLsYJ8ZAkCO7J
	 1NTU9Ns9AyZ78ETJA5JsSiDLVJTjWhRly1gI7ROcrNjI5svAVdmCuzivmqDB+/sf2+
	 gn6YLD8CzuODxIw77WI72qIfRwsz8M6xWenUrgrvgwFHnZO9KLKf6EOG5wGDNmv9+/
	 VFuxPdCyAMqun5yluXF/5J2+vJyY2e6IKlBGFVJh3OEUEGFAtHvvdYQNVsT8imj8qr
	 gNk5WoFPNJ6bQ8vrKRzLl9Uv8jYidJCInvkefrkbLmapzgVFWX5RQ0dGB+V2FcS0e5
	 2K2SF97vJwIoA==
Date: Sun, 12 Apr 2026 15:38:03 +0900
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
Subject: Re: [PATCH v4 00/24] PCI: Convert all dynamic sysfs attributes to
 static
Message-ID: <20260412063803.GA2085076@rocinante>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411080148.471335-1-kwilczynski@kernel.org>

Hello,

> This series converts every dynamically allocated PCI sysfs attribute to
> a static const definition.  After the full series, pci_sysfs_init() and
> sysfs_initialized are gone, and every sysfs file is created by the
> driver model at device_add() time.

A note on testing:

  0-day bot (recent test runs; newer builds will arrive later):
    - https://lore.kernel.org/linux-pci/202604121312.sF0Ua4gP-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202604111631.lrwAylMM-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202603170336.zSLrDvlj-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202603122052.tMV5rzNq-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202603081334.b91RGVS6-lkp@intel.com
    - https://lore.kernel.org/linux-pci/202603060207.pnGfKgGa-lkp@intel.com

  KernelCI (for the "for-kernelci" branch):
    - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/209e2cfd205a8aad4bae32e6f82b96b20902aa74
    - https://dashboard.kernelci.org/tree/linux-pci/for-kernelci/70293477e2c0ae8cbc250098818e726e1d658b53
    - https://dashboard.kernelci.org/tree?ts=pci

  Sashiko's feedback:
    - https://sashiko.dev/#/patchset/20260411080148.471335-1-kwilczynski%40kernel.org
    - https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40kernel.org

I sadly do not own any Alpha or PowerPC hardware, so when I was testing
these architectures while working on the series, it would be only under
QEMU.

That said, Magnus Lindholm was able to test the series on the Alpha
hardware he owns, see:

  - https://lore.kernel.org/linux-pci/CA+=Fv5Q1tZQwnanw99NbvzT-QenfYz7vUdY02_TuPqHX32ZAiA@mail.gmail.com

Lorenzo Pieralisi did some testing reported outside the mailing list (we
talked on IRC), on the platform he had issues before, and while the issues
were more with procfs races, similar to the sysfs ones this series aims to
fix, he didn't notice regressions when having this series applied.

Thank you!

	Krzysztof
