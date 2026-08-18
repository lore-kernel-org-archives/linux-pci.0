Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD3937F32F;
	Tue, 18 Aug 2026 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042140; cv=none; b=o97hctBijbQwM0DcGr5SN8pVX6OZyU8YiZXD1ouNfK5+aA7hvU3m6rDpuSgu8jZ5hOWp3VR0xwEmYHXp2TvwmVGPZPyMp8tDRO7VpgfZm+xjwocVf/jIMI78cuGSr/Pn+gH6yidb7cahbd0j0NvF8vr1pmxQgUDzimeW4VAqahE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042140; c=relaxed/simple;
	bh=wCOoDTsOjVsg+29ZjA7I9UhZxUbzBdI4AcVTwMMKQqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUzrP5l/c2HyJSUxT6aLlwO/b57/t+f/i1PZNeVUh4EKNUodxR2FN6S/a8yaA8jEleq8aPNDRZHMEWvVsQM6Msy3bNpu+bOu1WDrpe51mGySDeFEAxIgp6guWq7ZbQultQo5AI9xjOjqqKWx9Q/f50IlzuNjpOa0deCfOjNz9FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yp97zbuZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yp97zbuZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA841F000E9;
	Tue, 18 Aug 2026 08:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787042138;
	bh=Nvv67+nY9bOme+CUnDrcPTxP3FOFSO5YtozCzjeuylQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yp97zbuZZS70iACQAUh0Z2Jq7Fp4hcK/X3RGNBYE3wAh/E6fLPBIVtul2/ay1P1Kl
	 i2LsvRGLMHAzTevl+0fhsOaSlnszB/faxDY9qNObaDrH3GRHQFUea822sCV1u61pJa
	 V0EHpr47am8Lp00j1mE38bmwPXnyuxPLXpdMyyhuBIanRaR1mKrSwdfj/VeBtgl8xn
	 lDAHhDufvrl7vNDxdO+vYaOt6srXFGQwMdTJr5bJJb+TeNhRT0/oGZLBlU+pepbH5C
	 t2ufeqMp2zojC+Bj/Zy8SM1GTi+35F+d9EAraVUjDZtv1myVv7dj78RGxw3OxlLLS0
	 l4hsDb4t6s+rA==
Date: Tue, 18 Aug 2026 11:35:32 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH v3 00/17] PCI/P2PDMA: Fix ACS egress control handling
Message-ID: <20260818083532.GE66924@unreal>
References: <20260811-fix-p2p-acs-v3-0-efc488ee7c03@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811-fix-p2p-acs-v3-0-efc488ee7c03@nvidia.com>

On Tue, Aug 11, 2026 at 12:30:42PM +0300, Leon Romanovsky wrote:
> PCI P2PDMA treats any enabled ACS P2P Egress Control bit as an upstream
> redirect. PCIe r7.0, sec 6.12.3, table 6-11 says the Egress Control
> Vector bit for the target port decides instead: a clear bit routes a peer
> request directly, regardless of P2P Request Redirect. Firmware can
> therefore enable Egress Control with a permissive vector while Linux
> incorrectly rejects a valid direct P2P path.
> 
> Table 6-11, where E is ACS P2P Egress Control Enable, R is ACS P2P
> Request Redirect Enable and V the Egress Control Vector bit for the
> target port:
> 
>   E  R  V  Required Handling for Peer-to-Peer Requests
>   -  -  -  ------------------------------------------
>   0  0  x  Route directly to peer-to-peer target
>   0  1  x  Redirect Upstream
>   1  0  1  Handle as an ACS Violation
>   1  0  0  Route directly to peer-to-peer target
>   1  1  1  Redirect Upstream
>   1  1  0  Route directly to peer-to-peer target
> 
> P2P Completion Redirect lies outside this table and also forces
> host-bridge routing.
> 
> The same interaction affects target-independent ACS isolation checks.
> Request Redirect does not guarantee that peer requests are forwarded
> upstream while Egress Control is enabled because a clear vector bit
> overrides it. Such checks cannot identify every potential target, so
> treat Request Redirect as ineffective while Egress Control is enabled,
> which merges the affected devices into one IOMMU group.
> 
> ACS Direct Translated P2P routes a Request carrying a Translated address
> to the peer regardless of Request Redirect and Egress Control, so it
> voids the same guarantee unless Translation Blocking rejects the Request
> first.
> 
> That last rule holds only for a caller that needs Request Redirect to
> isolate peers. pci_enable_pasid() asks for it so that a Request carrying
> a PASID reaches the translation agent (sec 2.2.10.4), and a Translated
> Request already carries an address the agent produced for that PASID
> (sec 10.1.3). pci_acs_enabled() and pci_acs_path_enabled() therefore
> take a scope, and Direct Translated P2P applies only to
> PCI_ACS_SCOPE_ALL.
> 
> A pre-existing gap comes first. The routing analysis covers only Requests
> carrying an Untranslated address; ACS Direct Translated P2P overrides
> those controls, so that scope is now written down rather than implied.
> 
> It is nearly impossible to test all possible combinations due to limited
> hardware availability, so I added KUnit coverage for ACS routing
> decisions, isolation checks, Egress Control Vector lookups, and
> provider-to-client path traversal over a fabricated PCIe fabric.
> 
> Disclaimer:
> All patches were prepared with AI assistance, with a significant
> difference between the code changes and the KUnit tests. The code
> changes were thoroughly reviewed and rewritten.
> 
> In contrast, the KUnit patches were produced entirely by AI with
> minimal human interaction, and multiple AI tools (Claude, Codex,
> and Gemini) with frontier models were used to verify that the tests
> comply with the PCI specification.
> 
> Thanks
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Changes in v3:
> - Fixed pci_p2pdma_add_resource() error unwinding
> - Made pdev->p2pdma teardown wait unconditionally for RCU readers
> - Restricted pci_p2pmem_find_many() to pool-backed providers
> - Documented the pdev->p2pdma lifetime and RCU rules
> - Fixed calc_map_type_and_dist() handling of the verbose argument
> - Required the ACS port and target to share a bus before indexing the
>   Egress Control Vector
> - Gave pci_acs_enabled() and pci_acs_path_enabled() a scope, so the ACS
>   Direct Translated P2P rule no longer stops pci_enable_pasid() from
>   enabling PASID
> - Dropped "Report ACS ports when the paths share no upstream bridge":
>   the mapping type cannot change without a shared upstream bridge, so
>   the pci=disable_acs_redir= hint was not actionable there and the ACS
>   walk only cost config space reads
> - Folded the Request Redirect rule into pci_acs_rr_ineffective(), so
>   pci_acs_flags_enabled() and the Intel SPT PCH quirk share one copy
> - Renamed pci_acs_egress_ctrl_set() to pci_acs_egress_ctrl_is_set(), it
>   reads the bit rather than setting it
> - Reworded the blocked-path warning: ACS may also leave the direct route
>   indeterminate rather than blocked
> - Added KUnit coverage for the shared-bus guard, a device with no ACS
>   capability and an unreadable ACS Control register
> - Added the missing Fixes: tags, a second one on the
>   pci_p2pdma_add_resource() unwinding fix (the dangling devres action
>   dates to f58ef9d1d135) and one on the Egress Control isolation change
> - Link to v2: https://patch.msgid.link/20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com
> 
> Changes in v2:
> - Added Logan's ROB tags
> - Added commas in Documentation patch
> - Link to v1: https://patch.msgid.link/20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com
> 
> ---
> Leon Romanovsky (17):
>       PCI/P2PDMA: Do not tear down the allocate attribute on registration failure
>       PCI/P2PDMA: Wait for RCU readers before freeing state
>       PCI/P2PDMA: Restrict the p2pmem search to pool backed providers
>       PCI/P2PDMA: Safely terminate ACS redirect lists
>       PCI/P2PDMA: Document the pdev->p2pdma lifetime and RCU rules
>       PCI/P2PDMA: Gate the host bridge whitelist warning on verbose
>       PCI/P2PDMA: Document the Address Type assumption
>       PCI: Account for Direct Translated P2P in ACS isolation checks
>       PCI: Add ACS egress control vector accessor
>       PCI: Account for ACS egress control in isolation checks
>       PCI/P2PDMA: Derive peer-to-peer routing from ACS control bits
>       PCI/P2PDMA: Honor ACS egress control vectors
>       PCI/P2PDMA: Document ACS egress control handling
>       PCI/P2PDMA: Extract pure ACS routing decision helpers
>       PCI/P2PDMA: Add KUnit tests for ACS routing decisions
>       PCI/P2PDMA: Add KUnit coverage for the ACS P2P routing walk
>       PCI: Add KUnit coverage for ACS isolation checks
> 
>  Documentation/admin-guide/kernel-parameters.txt |   9 +-
>  Documentation/driver-api/pci/p2pdma.rst         |  15 +
>  drivers/iommu/iommu.c                           |   8 +-
>  drivers/pci/Kconfig                             |  15 +
>  drivers/pci/Makefile                            |   1 +
>  drivers/pci/ats.c                               |  11 +-
>  drivers/pci/p2pdma.c                            | 218 +++++--
>  drivers/pci/pci.c                               | 115 +++-
>  drivers/pci/pci.h                               |  63 +-
>  drivers/pci/pci_acs_test.c                      | 801 ++++++++++++++++++++++++
>  drivers/pci/quirks.c                            |  62 +-
>  include/linux/pci.h                             |  30 +-
>  12 files changed, 1259 insertions(+), 89 deletions(-)

Bjorn,

Is there anything you need from me to merge this series after the
merge window closes?

If so, I would prefer to spend these two weeks fixing or reworking the
code.

Thanks,


> ---
> base-commit: 43598807f71ac1c9164f26004acf2496d4038daf
> change-id: 20260713-fix-p2p-acs-725f8dd7b0e8
> 
> Best regards,
> --  
> Leon Romanovsky <leonro@nvidia.com>
> 
> 
