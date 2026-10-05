Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7719E49E5E1;
	Mon,  5 Oct 2026 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212433; cv=none; b=ausjmIerZcXwEoe4VvPI4g3UiK9geFib2N7Pwp9YZANB3LCi1A0hhgkzpPHifSVVNYc9YMlWH2umIHkrCqCZGzYPfhZ944bT8SK2y2EgnTC+Dg7NQOO8I+gNepU7ulM0N6TIrJdaPIGlP8AaU+EvfnIsBh3wKqdJ/e2ER5rICG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212433; c=relaxed/simple;
	bh=17/hInjCaCGQski5AbCyy9ckuW8i7gduOpMfznvob5k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Lc+yjwZYj7RxZB4bGmfLHkvfznhyBTrKa2Nu9h9WwVwOMw+OCJGhH5EgujApFkQRgonj4JI4H06JUaNKCIcGVTH3DqCaPcJBCN6DplGsyrtkAl3rsGHjC27pUGb2vExPNcDqpNDHRqTna61qYSXcS8UCvR2+M0yz+RWLoerRGqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir072EoN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir072EoN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE351F00898;
	Mon,  5 Oct 2026 15:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212432;
	bh=dH6sN0LnYBSOfE50N99Hs2I9Loj2GCVD/ql0WqS2MFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ir072EoNOT5IbPrth0l05tY5+DlQS6E0MTDjYKC+IB+GuSxXXVdp3dAyVscOqMJUQ
	 Fzm23lk/u4MI52xotlhtSs70nPkVzMno8nTG6Nd5oxJNcFqaP/c7Uxea+H9yxE254L
	 TmZAWeh6BGFE4ALBQSTHlJwXtw4ttAB6r+x2XqEOLAEhPLwXvprQXoqxZf9EIbgzmd
	 L1M6cQJoI3x+vQxTHLdzTF6Q1gnBgjsvosiyI+zfcLqd9/TYygvnse1Y2Wfv38O6HO
	 JWUsru0UX+iM5woon1VCYhvUOClwxEK2Eq4Wf/Ffe8sd51DEuQqURyhl6pEcfkmuM1
	 RJhc0bqZK1aaQ==
Date: Mon, 5 Oct 2026 10:00:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Scott Lee <dsix123@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Add Intel Haswell client host bridge to the
 whitelist
Message-ID: <20261005150030.GA566065@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005132651.18368-1-dsix123@gmail.com>

On Mon, Oct 05, 2026 at 09:26:51PM +0800, Scott Lee wrote:
> P2P DMA between two devices that do not share an upstream bridge is only
> permitted when the traffic goes through a host bridge that is listed in
> pci_p2pdma_whitelist[] with REQ_SAME_HOST_BRIDGE.
> 
> The Haswell client host bridge (8086:0c08, e.g. H97/H87/B85) is not in that
> list, and cpu_supports_p2pdma() returns false on Intel, so
> calc_map_type_and_dist() refuses P2P for any pair of devices behind
> different root ports of the same host bridge, even though that root complex
> handles the traffic correctly.
> 
> Measured on an ASUS H97-PRO with a Xeon E3-1231 v3 (Haswell, 8086:0c08 at
> 00:00.0) and two GPUs on separate root ports of that host bridge
> (00:01.0 and 00:1c.4):
> 
>   - pci_p2pdma_distance() < 0 before the change; peer access granted after
>     (amdgpu stops reporting "PCIe P2P access ... is not supported by the
>     chipset" and hipDeviceCanAccessPeer() returns true in both directions)
>   - 10 KB cross-device copy: 62-75 us vs 130-131 us host-staged (~2x)
>   - 512 MB cross-device copy verified byte-wise against a known buffer:
>     no corruption
>   - tensor-parallel LLM inference (>25 GB model across both GPUs):
>     +53% tokens/s
> 
> REQ_SAME_HOST_BRIDGE is the correct flag here: the two devices share the
> upstream bridge (two root ports of one host bridge) rather than sitting
> behind a PCIe switch.
> 
> This entry only permits P2P DMA to be used on this platform, it does not
> force it: the existing checks on ACS redirect, on the map type and on
> pci_p2pdma_distance() all still apply. Tested on one board only, so the
> usual caveat applies - broad testing on other Haswell boards would be
> needed before this can be considered generally safe.
> 
> Signed-off-by: Scott Lee <dsix123@gmail.com>

Applied to pci/p2pdma for v7.4, thanks!

> ---
> # --- evidence from the machine this was tested on (stripped by git am) ---
> #
> # Hardware: ASUS H97-PRO (BIOS 2906), Xeon E3-1231 v3 (Haswell), 32 GB RAM,
> #           2x AMD Radeon RX 9060 XT (16 GB each), no PCIe switch
> #
> # lspci -nn:
> #   00:00.0 Host bridge: Intel 4th Gen Core Processor DRAM Controller [8086:0c08]
> #   00:01.0 PCI bridge: CPU PEG port; GPU0 is 0000:03:00.0 behind it
> #   00:1c.4 PCI bridge: PCH root port; GPU1 is 0000:09:00.0 behind it
> #
> # unpatched kernel (7.0.0-34-generic, distro stock):
> #   $ sudo dmesg | grep 'not supported by the chipset'
> #   amdgpu 0000:09:00.0: PCIe P2P access from peer device 0000:03:00.0 is not
> #   supported by the chipset
> #
> # patched kernel (7.0.0-99-generic, same source tree + only this hunk):
> #   $ sudo dmesg | grep 'not supported by the chipset'      (no output)
> #   $ python3 p2p_verify.py
> #     can_access_peer: True / True
> #     peer 512 MiB copy, byte-wise compared against a known buffer: OK
> #   $ python3 p2p_latency.py     (10 KiB, HIP events)
> #     peer 0->1: 62.1 us    peer 1->0: 74.5 us
> #     host 0->1: 130.0 us   host 1->0: 131.0 us
> #   $ llama-bench, 27B model split across both GPUs, tensor vs layer split:
> #     25.05 +/- 0.91 tok/s vs 16.37 tok/s (+53%), greedy output identical
> #
> # Note the second GPU sits behind the PCH (Gen2 x4) - the setup still works
> # correctly despite the asymmetric and slow link, which is what makes it
> # interesting for the whitelist argument.
> #
>  drivers/pci/p2pdma.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 9334eb3..4f58564 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -545,6 +545,8 @@ static const struct pci_p2pdma_whitelist_entry {
>  	/* Intel Xeon E7 v3/Xeon E5 v3/Core i7 */
>  	{PCI_VENDOR_ID_INTEL,	0x2f00, REQ_SAME_HOST_BRIDGE},
>  	{PCI_VENDOR_ID_INTEL,	0x2f01, REQ_SAME_HOST_BRIDGE},
> +	/* Intel Haswell (client) */
> +	{PCI_VENDOR_ID_INTEL,	0x0c08, REQ_SAME_HOST_BRIDGE},
>  	/* Intel Skylake-E */
>  	{PCI_VENDOR_ID_INTEL,	0x2030, 0},
>  	{PCI_VENDOR_ID_INTEL,	0x2031, 0},
> -- 
> 2.43.0
> 
