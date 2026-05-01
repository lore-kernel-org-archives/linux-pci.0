Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B9A196C7C
	for <linux-pci@vger.kernel.org>; Fri,  1 May 2026 01:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598578; cv=none; b=Uxx9UVptcfubsjeJL1awjNDtopsWiktXxQv7Hd7C6HHpheCOz4vohKkTf0NdUiYveFMRyUC0d6l6kKC4tSKuEFwWh9P8gEUPpEfD8SeusORfz/3XS166iJbkfBRGvp/SP1SOih/ffubv9no9YyOXgTYQXCs11NlW8vDGdptLMY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598578; c=relaxed/simple;
	bh=CJicru/fWCwFUGV/6UVVlaBFv5vn8lon3daaPVOxKwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFsDxUe2gfC8hlQtdUbs2k0EX0WS9dNFny9Jl27TYiK+SRODed+z3SdYjWmg8kn4IbK2JjBtf1LRsrxBdJ/IFKZk8RxNXeEHT7eKm0vVSF6F8mhmkxHvJJNbjRg1eD0d5UXbU37L/YYhknVf9M4Pr/LjZZWM+YcDg/+LjZ3qCN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drWLaSsW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drWLaSsW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E718C2BCB3;
	Fri,  1 May 2026 01:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777598578;
	bh=CJicru/fWCwFUGV/6UVVlaBFv5vn8lon3daaPVOxKwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=drWLaSsWdozW1FMZ8RFoosMiSTob0PlOz+j5Z2kUNB52EG27hATafJKsBbEpCZ95q
	 iwazRiYdjpUlaXwTKL1qBHenbh+VPD1PtF2IcgYUhevHQ757xIROwLWplv4uXA4zMf
	 1d7eB6m4W1xdEug0qkNTLMI+INRVhZGrELb6Y489qt1IBcknWOV/mAW9MmAMP5fXUc
	 urOVSmFSV7HEUZ/+aANmmysV8BMte33g6LZSFdKY73Si4+pbICuQawGg16GCp8qEeL
	 Yezb4vG9/Yk2XIaUNMrrOFUP+3pLzgdCsgDyNzGr3AipDE5uoHv8R2OtaZB78lEUcn
	 FBHd+HnPn9bTQ==
Date: Fri, 1 May 2026 10:22:56 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Shuan He <heshuan@bytedance.com>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/proc: Fix race between pci_proc_init() and
 pci_bus_add_device()
Message-ID: <20260501010127.GA990551@rocinante>
References: <20260430003542.455198-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430003542.455198-1-kwilczynski@kernel.org>

Hello,

> Thus, wrap the for_each_pci_dev() loop with pci_lock_rescan_remove() to
> serialise against concurrent PCI bus operations.  Add an early return in
> pci_proc_attach_device() when dev->procent is already set, making the
> function idempotent and symmetric with pci_proc_detach_device() which
> clears this field.

A note on testing:

  0-day bot (recent test runs; newer builds will arrive later):
    - https://lore.kernel.org/linux-pci/202603162306.2oKy0qcP-lkp@intel.com

  Sashiko's feedback:
    - https://sashiko.dev/#/patchset/20260430003542.455198-1-kwilczynski%40kernel.org

Lorenzo Pieralisi did some testing reported outside the mailing list (we
talked on IRC) on the platform he had some boot issues.  With this patch
applied, the problems seen before were resolved.

Thank you!

	Krzysztof
