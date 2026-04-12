Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B472BEC2B;
	Sun, 12 Apr 2026 06:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775975970; cv=none; b=hkUIhVJF5Td4l5juz62ZXWqTPCWLusqMSxJHZp1cRj7S1hARaogrGVpz3jbIQ/EV2yRws0skpQlrSYlWr70yPeH0dk7A8YIR8PrBs1OZvLqF70+zt6s+qpddX79SNpn0G4YToBXkjM9bFzvvFTgc/THrqvq2AlosApf59HxnoL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775975970; c=relaxed/simple;
	bh=6Gfvk1vJ2dWhGGDn2YFpAnYsydfbb+BI5a9oo2uq30E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUJA+jHV2uh70lVxqXNGso5h9xXevKLXcnLKsz9os4lJ/Dc7IYlP5PqFX8lQ8NjI9zq8s2MKu673PhgGGEBd3pGARwEsZ+wjs5VA1rFjRNCN++2/EV1CVfh2dJninKLWExZ4tF1xR9OYwGw9OmkekuU0hD2Wk2IG/IdAYfhQOik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzDgUNaO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzDgUNaO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D572C19424;
	Sun, 12 Apr 2026 06:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775975969;
	bh=6Gfvk1vJ2dWhGGDn2YFpAnYsydfbb+BI5a9oo2uq30E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzDgUNaOpqjoITWmDRNxW4jtZPGtgJ7WfRkMr5BJ41p7XiNmc8SOh0oCq4J2j7rTo
	 NLoLDHRbHh0ni4t2ntideLvnua/072uDENzgIqhbS0RaxWVW55BtBmzAFmIzCUU3mn
	 IEPrzVC/2RLvIq8EEBIOw/UwRuls+qzyw9rP21KECkimIYAzCXeGf/29CFFOqIfk1q
	 toob/klVXFfK/YjkeEBJmZrGOZt05PUE1NRMqFqJoYl2gDzwZpzLhJgxzIBkZhe5H5
	 B6RiLd2mV6WsFlTWMuctrbIuLo4s3TxoPbGl0M1VhYnzWpa11NuiBKcFEjUq5504Ff
	 xDQ5Ux/em3l4w==
Date: Sun, 12 Apr 2026 15:39:27 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Message-ID: <20260412063927.GB2085076@rocinante>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
 <CA+=Fv5Q1tZQwnanw99NbvzT-QenfYz7vUdY02_TuPqHX32ZAiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+=Fv5Q1tZQwnanw99NbvzT-QenfYz7vUdY02_TuPqHX32ZAiA@mail.gmail.com>

Hello,

> > This series converts every dynamically allocated PCI sysfs attribute to
> > a static const definition.  After the full series, pci_sysfs_init() and
> > sysfs_initialized are gone, and every sysfs file is created by the
> > driver model at device_add() time.

[...]
> Applied the series on an Alpha UP2000+, built and booted
> successfully. PCI enumeration and device initialization looked
> normal, I saw no relevant sysfs/PCI warnings in dmesg, and PCI
> sysfs resource files for tested devices looked sane.
> 
> >From the Alpha side, this looks good to me.
> 
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Acked-by: Magnus Lindholm <linmag7@gmail.com>

I appreciate you taking the time to test this.

Thank you!

	Krzysztof
