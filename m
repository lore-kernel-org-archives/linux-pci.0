Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6A74CCDC1;
	Mon, 31 Aug 2026 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206500; cv=none; b=AgKRL60Y29pXm2xR4RKHZgkmxMHWOMws3ykXGh1oAG54jlRLveu5WPj24SkfaQLDNE9NM5sf0dX78Cv58NiMEW1WSAiGcxa6GqXzg1cbsYX7S93hiXNW9kCraKri7ZIfMs7IKc71XqaElF2AYzclnkzajVS1yzA9RY3SUCmZY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206500; c=relaxed/simple;
	bh=37ri+mS2J7OBU9BSGk6AePbur0ku4bt1FR/6mIhRK1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7EhmzH9myR0DGbxj1MjxrAuM513LGbhmwt53ganesmcoIaCd+w1GxV8njruOCQk4GmAN5LLYc7WyKYi9kaKSbKnyfKluQj1glh6CAYcurBWgyL4cbK+YuOc/WI7/I7uT6LPXInXgaLOSJ/C6FG8AUARCWVLtjmLHzngH1NY648=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YugaleRA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YugaleRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334461F000E9;
	Mon, 31 Aug 2026 20:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788206499;
	bh=HuXKZEy2/gGYSP0cASGT4oXqgM10s/kica6ZcwczuKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YugaleRAWIZdGULgBKX3mJmnVeLCqhhf4x6+DZ/M5f/lmxmjdcCKsoo24JuxKNJTr
	 J4hyDstawePgx/NwM0qB0musRRnAHBXtoMc7qcgEJp54ZzuqSIbxsiFiuS9YG/TWJP
	 tj7oIQZxpoyC5Ndon67lqG0YYlVD45sq/stx06Jm3CfVI87XOasFSyH2gPikoapNo2
	 swBfl/+AXDCW3ma/hux93iYzwnzQhmGmCM1FthoAn68eRTuwh8b3Q9qJgPhr0j7a/S
	 zOc6ceHwHlppyKu9jyKm5uSgYaOAjbRrGhJJD2jBqGsvgqF2cL79I7g0fs5uGO7N1t
	 hUQgM5lc6SCyA==
Date: Mon, 31 Aug 2026 22:01:31 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Aksh Garg <a-garg7@ti.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	ntb@lists.linux.dev, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI: endpoint: Support hardware-owned MSI-X table
 and PBA
Message-ID: <apXdm2I33edo8kpZ@ryzen>
References: <20260830151948.3547577-1-den@valinux.co.jp>
 <apVWd1u9JjTKQczu@ryzen>
 <pj5vpwwd5tr5tuvhdq3bcpefnq27r6ljvwoysguz2o4tglcqx5@l7zmb6wjnhla>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pj5vpwwd5tr5tuvhdq3bcpefnq27r6ljvwoysguz2o4tglcqx5@l7zmb6wjnhla>

Hello Koichiro,

On Tue, Sep 01, 2026 at 01:11:09AM +0900, Koichiro Den wrote:
> This is not driven by a performance target, so I do not have numbers. The
> immediate issue is correctness. ntb_hw_epf can select MSI-X, but pci-epf-vntb
> currently configures and raises MSI. I want that MSI-X path to work on RK3588
> with the controller doorbell. I will make it clear in the next cover letter
> that, with this series, a doorbell sent from ntb_tool on the pci-epf-vntb side
> of RK3588 reaches ntb_tool on the ntb_hw_epf host side when MSI-X is selected.
> I believe that is the simplest E2E test showing what this series fixes.

Okay, if the main issue is that pci-epf-vntb does not raise MSI-X, even when
ntb_hw_epf host side has requested MSI-X, then I think that the first patch
in the series should fix this, so that the fix can easily be backported.

(Right now you fix this in patch 3/3, and the fix in patch 3/3 depends on
both patches 1/3 and 2/3.)

I think that pci-epf-vntb actually respecting the configured IRQ type by the
host is a separate logical change from adding support for HW defined layout.


> I initially considered making the hardware-owned layout automatic for every EPF.
> pci-epf-ntb (not vNTB!) is the reason I did not. It currently reads
> host-programmed MSI-X entries through epf_bar[] backing and uses them to set up
> peer outbound mappings. A hardware-owned Table has no such backing, and the
> current EPC API has no generic way to read those entries. I suspect that
> supporting it there would require a broader design change. Also, I do not have
> hardware for the pci-epf-ntb bridge configuration.
> 
> pci-epf-test and nvmet-pci-epf should be easier to convert. However, converting
> only those would not remove the per-layout handling while pci-epf-ntb still uses
> an EPF-owned Table. I would prefer to handle those separately when they can be
> properly tested. This is what I meant by this part of the cover letter:
> 
>      [...]
> 
>      layouts. This avoids unnecessary changes and reduces regression risk.
>      They can use a hardware-owned layout later if/when needed.

Okay, if pci-epf-ntb is special, perhaps we should add a comment in
pci-epf-ntb which explains why it cannot support HW defined layout.

But for consistency, if we modify pci-epf-vntb, I think it would make sense
to also modify pci-epf-test and nvmet-pci-epf as well in the same series.

pci-epf-test should be easy to test, just run the pci endpoint selftest.

nvmet-pci-epf should be quite easy to test too, just run the normal fio based
testing that we usually run, and unless you see worse performance, I think we
are good. (If we see worse performance, that could be an indication that one
of the MSI-X for the different completion queues are not being correctly
triggered. By default, the host side nvme driver creates one completion queue
(and one submission queue) per host CPU.


What I suggest that you instead do something like:
Patch 1/7: pci-epf-vntb: Fix to actually use MSI-X when requested.
           This probably includes adding the code that is inside the
	   if (ret == -ENOENT) { }.
Patch 2/7: PCI: endpoint: Support hardware-owned MSI-X table and PBA
Patch 3/7: PCI: dw-rockchip: Support fixed MSI-X table and PBA on RK3588
Patch 4/7: pci-epf-vntb: Add code that calls pci_epc_get_hw_msix_layout()
           and uses that layout, if the function returned success.
Patch 5/7: pci-epf-test: Add code that calls pci_epc_get_hw_msix_layout()
           and uses that layout, if the function returned success.
Patch 6/7: nvmet-pci-epf: Add code that calls pci_epc_get_hw_msix_layout()
           and uses that layout, if the function returned success.
Patch 7/7: pci-epf-ntb: Add comment that explains why it cannot call
           pci_epc_get_hw_msix_layout() like all other EPF drivers that
	   support MSI-X.


This way, patch 1/7 can be backported, and will help all users vNTB users,
even the users that do not use RK3588 as an EPC.


> > I understand that you introduce dw_pcie_ep_msix_layout_is_hw_owned()
> > because you want an EPF driver optionally use the HW defined table.
> > But if all EPF drivers always use the HW defined table if available, I think
> > you can avoid introducing this helper, and let rockchip_pcie_raise_irq()
> > unconditionally call dw_pcie_ep_raise_msix_irq_doorbell() for case PCI_IRQ_MSIX.
> 
> Yes, under that assumption I agree. With the current mix, however, the Rockchip
> callback still has to choose the helper according to the selected layout. That
> is why the DWC code records which layout was selected.
> 
> I will update the cover letter to state the motivation and this boundary more
> directly. Does keeping the layout choice with each EPF for this reason sound
> reasonable?

Yes, since pci-epf-ntb apparently is special, I can see why you need
both ep_func->msix_hw_owned and dw_pcie_ep_msix_layout_is_hw_owned().


Kind regards,
Niklas
