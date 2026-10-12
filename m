Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D8F2BFC7B;
	Mon, 12 Oct 2026 23:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791847220; cv=none; b=UNkVuPuKBLjbVA6nEDs8gtUJt2WiQN33t/YJuXF/MGa2vOnhMdDdaaLETx0800iYneXF18h35/Yl6I6rQpGDNf5mLT8PD8G4eIXo63Bi2HzeeyUF60uFUlp3/V5TPup17tl+t0VPWTfCfOA0mqrjpPbhETkcwzzXvww4nj0ZQuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791847220; c=relaxed/simple;
	bh=WdyZQ+u/1nVShA20+JGSbrpv+kYiOhfDzau+w6JgPFA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=H6ib0GExo3iZ82VJgw2iLGsLJJ18Facw96F6zhywHK9UTLdLyCYScy9XX2UJ7/qe2atlF6/3Q9/VPl3E1kX8lcWoVm+SMTj19RkDDqcitvlZFxykcigusX3tiCc0zZ7fPJptBNok0duGErCzdlpdTv7P1bm3ESx7z1B9h7COaF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbW6Vh0k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbW6Vh0k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434F51F0089B;
	Mon, 12 Oct 2026 23:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791847219;
	bh=o4oN5lKH9EEBCH19PG70lJLrhKcKXfLPurXqtoeLfGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=WbW6Vh0k6NHKZMsuSbhZYg0xatoAJneorZ8ZD3SAVs9g6WfhJTykvaxi/wRaemfFk
	 B/vmazhK6TpAwW63I5vSK8O2IialYqb/ed69cci48HKDqWQ5U+Yc9xckul6Qr5Zi+x
	 cmfsMW/1xDTBcFPsgui5okGK0hlefKKnxKiIBSixShD4D98uN2AEkDBaFkaJZwhbEL
	 Lf/S/yhPMQVCbs1FCBi1cMwdGmvAR2BqmILho6fgKYMPhJwyXWZm89Hsbmj/cCnzYu
	 +sLNchhQQ6fIVUoDNYko+PRiFgyhQDoFp1RIAY3RgnQpGivd6NQE1YjVmetKa1JxTm
	 Px0bM1XoCtVOA==
Date: Mon, 12 Oct 2026 18:20:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI/DPC: Decide DPC ownership with
 host_bridge->native_dpc
Message-ID: <20261012232018.GA1428722@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007165840.1604136-1-sathyanarayanan.kuppuswamy@linux.intel.com>

On Wed, Oct 07, 2026 at 09:58:36AM -0700, Kuppuswamy Sathyanarayanan wrote:
> This series makes host_bridge->native_dpc the single decider for whether
> Linux uses DPC, as Bjorn asked during the review of "Simplify PCIe native
> ownership".
> 
>   https://lore.kernel.org/r/20261001221408.GA2731929@bhelgaas
> 
> Today the DPC service binds on host_bridge->native_aer, AER availability
> and "pcie_ports=dpc-native".  host_bridge->native_dpc is only consulted
> by pci_dpc_recovered().  After this series, native_dpc is the end result
> of everything that decides DPC ownership, and portdrv binds the DPC
> service on it.
> 
> The series applies on top of two others:
> 
>   - pci/portdrv, which has patches 1-3 of v15 of "Simplify PCIe native
>     ownership".  They fold "pcie_ports=native" and "pcie_ports=dpc-native"
>     into the _OSC control mask, so native_dpc already reflects the
>     command line.
> 
>     https://lore.kernel.org/r/20261002211828.1293177-1-sathyanarayanan.kuppuswamy@linux.intel.com
> 
>   - Lukas's "Error reporting for AER-incapable devices".  It removes the
>     AER Capability requirement from the DPC driver.
> 
>     https://lore.kernel.org/r/cover.1790531238.git.lukas@wunner.de

My impression was that Lukas planned to tweak a couple things in that
series, e.g., https://lore.kernel.org/all/arltOHrdHdokyfC9@wunner.de

Does this actually depend on Lukas' series?  If so, can we include the
relevant patch here?

> Patch 1 removes CONFIG_PCIE_EDR, which was another knob in deciding
> whether to request DPC control in _OSC.
> 
> Patch 2 stops requiring pci_aer_available() to bind the DPC service,
> since the DPC driver does not depend on MSI or on the AER driver.
> 
> Patch 3 requests DPC control only together with AER control, as PCI
> Firmware r3.3, sec 4.5.2.4, requires.
> 
> Patch 4 binds the DPC service on host_bridge->native_dpc and logs a
> message when the OS assumes DPC control that _OSC did not grant.
> 
> Kuppuswamy Sathyanarayanan (4):
>   PCI/EDR: Remove CONFIG_PCIE_EDR
>   PCI/portdrv: Don't require AER to bind DPC service
>   PCI/ACPI: Request DPC control only together with AER control
>   PCI/portdrv: Bind DPC service based on host_bridge->native_dpc
> 
>  drivers/acpi/pci_root.c    | 26 +++++++++++++++++++++++---
>  drivers/pci/pcie/Kconfig   |  9 ---------
>  drivers/pci/pcie/Makefile  |  5 ++++-
>  drivers/pci/pcie/dpc.c     |  5 +++--
>  drivers/pci/pcie/portdrv.c |  7 +------
>  include/linux/pci-acpi.h   |  4 ++--
>  6 files changed, 33 insertions(+), 23 deletions(-)
> 
> 
> base-commit: 4fe37866b0d92cdc45b62954a76489a9d9f8bd73
> prerequisite-patch-id: e0eafcb39f15c38f3acfa601dfce07a6f0832ce1
> prerequisite-patch-id: 83e8185612e785fad80790d4a0c20fa68ab12ce7
> prerequisite-patch-id: 8e9e2b06f55249ff57c7d7f43918ee82f79d1450
> prerequisite-patch-id: 78ad13a1c423c3ee50122237c4bd0fdedf2d1e00
> prerequisite-patch-id: 0c4b9d46eea86635c431382aef2bf576a3bb5691
> prerequisite-patch-id: 2d1a35309e750427352c6fe0d9bb62c4453c6252
> prerequisite-patch-id: c1ed9c8ac6123e0a65ae0d7ba3183dd46477edf7
> -- 
> 2.43.0
> 
