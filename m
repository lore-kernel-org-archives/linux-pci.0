Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F131F9A4
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 05:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785301627; cv=none; b=KLxKybl1rfWnSsasjXLSAsjOEK9/sM/ejveMQHvnn+7711t2qFNKisMyPedDs7AIUo2BFnnsrTt7a9ePGfPspNM01pYkR8Y15OqgTJj6R5fwgxJZ0NI/FOtqM7G0V30sJLbdfT4aD8JG97ra6Y2toCjRbbpV0na7YnD3mavPDsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785301627; c=relaxed/simple;
	bh=6ZlKKkhYGric8oZtnQVkPQ+AEvXJGxNwGsfbowQz4m8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Uujb+SwROpsiX/4bLhLQ5BBI0h041KVUUl/39N0htINMmr+8ffrKXLHwgwMNFPCJdXlkrusRIRDno+/3mYCNxyIOs6YX6+w16JkDW8PHX2gLq0zihfe0uAdKjAuEB77Qu9UslNsrjXPRfcers+5ISweEINiahCjtBAWIHFDMP9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=capfVrt9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="capfVrt9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5E31F00A3A;
	Wed, 29 Jul 2026 05:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785301626;
	bh=Yk2fog20+MooqsmeoA/5tbSJbhUjlc5gEHwJwTvIeH0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=capfVrt9s38YNfsJ6ebBYTpH7q8pqMD9f9QoOInVVKTL2DYrqLOn5uFdp5B1f8YPT
	 IGGrkqvsOuWEK2av0z4vHSquwGnGXqknc6HnRaanEThZ1DRy1uQm/AQPto6nluTxIA
	 lZwsKeoAWe+eV3hN8UIF6y5HhEua1oDnaJVksfKgrySFG3rlzbPwat247oQ7ovKBkn
	 GzCOYKGHlmEvKx18gg4j02L5DUCyJ3o3XzlZLPFuofURG3EaaxbfoZRZIyg6LNfgYp
	 y1AMBntgtpRgdDeqMhHqIVFcqmDjOJ8rCTA7VfbMQDnchH+CDeIynkLaiIYCmpxjPA
	 uqgs/mMIq6ouw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/5] PCI: host-common: Add link down handling for
 Root Ports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260729-pci-port-reset-v9-3-53570b92064d@oss.qualcomm.com>
References: <20260729-pci-port-reset-v9-0-53570b92064d@oss.qualcomm.com>
 <20260729-pci-port-reset-v9-3-53570b92064d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 05:07:05 +0000
Message-Id: <20260729050706.0C5E31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Silent device state corruption on link recovery when AER is disabl=
ed.
--

--- Patch [3]: [PATCH v9 3/5] PCI: host-common: Add link down handling for =
Root Ports ---
commit f0b63bf7d7d526d3c654256d686360e1e2906b25
Author: Manivannan Sadhasivam <mani@kernel.org>

PCI: host-common: Add link down handling for Root Ports

This commit introduces a new API pci_host_handle_link_down() to recover PCI
links that go down. It uses pcie_do_recovery() for AER-enabled kernels to
handle fatal errors and coordinate downstream driver recovery. For kernels
without AER, it falls back to resetting the root port directly.

> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/contr=
oller/pci-host-common.c
> index 2ce6f4b661334..363d3f970b10c 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c

[ ... ]

> +static void pci_host_recover_root_port(struct pci_dev *port)
> +{
> +#if IS_ENABLED(CONFIG_PCIEAER)
> +	pcie_do_recovery(port, pci_channel_io_frozen, pci_host_reset_root_port);
> +#else
> +	pci_host_reset_root_port(port);

[Severity: High]
Without AER enabled, this falls back to calling pci_host_reset_root_port(),
which resets the downstream bus using pci_bus_error_reset().

Because pci_bus_error_reset() utilizes PCI_RESET_NO_RESTORE, does this wipe
the configuration space (BARs, MSI, Memory/Bus Master Enable) of all
downstream devices?

Since pcie_do_recovery() is bypassed in this branch, downstream drivers are
never notified via slot_reset callbacks to restore their configuration stat=
e.
Could those drivers remain active and continue attempting MMIO accesses to
unmapped or disabled memory regions, leading to Master Aborts, timeouts,
or kernel crashes?

> +#endif
> +}
> +
> +void pci_host_handle_link_down(struct pci_dev *port)
> +{
> +	pci_info(port, "Recovering Root Port due to Link Down\n");
> +	pci_host_recover_root_port(port);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-pci-port-r=
eset-v9-0-53570b92064d@oss.qualcomm.com?part=3D3
