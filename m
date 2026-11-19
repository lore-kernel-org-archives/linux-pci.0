Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795047044;
	b=Zc0lWTWORebAsSZpHWKnK2iN2UgbxU5da+gDWjlDuOYhPmZD2JpuywZyHN5QJhQoXgZJ
	 Y/Bxe/KeOe5bJ7JJ0rA+194jc8L/3+bN+lDxVW3Eq5amdQGaE9uG64k17axMpRm/SMldt
	 gS25uipGCDzPfqWspNTtUncuhYq/ct1M3wbP3gHXk/8eA7ism9z8VeXAm9SpGHl0AHByC
	 2rE5rKCG0SHOzWawDUPEsTRgCUJVOeDyJtW4VbvsSOu/NAsCPJM/9DXZy/JgbdRybMtZT
	 vlibN1+EKMxgSh8paC/+PBal8qseuWbMeyoKgc08dSpTDyno4dZleVCa6Ggw2UWgNeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795047044;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RWnLnc+F0qTFDx5l6YFG1jdIeTtq63px4MNbLuTdYgc=;
	b=hWtBCWHCSPgOI32t21P0CDHPrIk5MK2HnEpEGgSFx8aK3cZxE/p08YasvACNJQhky4l1
	 CGc1x2V+BVOufdh7nAD8jYoX2Orxb3Qgt7UYPOzYRgZo/2C5tDlfQTGQbN2fFV6Fpqv78
	 gNzL022DTU8lEyKx3gCzoL1UWEYO8SL90ZslvrnZvQIPqmVF59TlB03X/fz11/9ekKcoq
	 5Sv4J/7sxZjN3FPb0Z1f/xmDOXgj9+IV5VB9A/dj0oBw/j8WVXpCCvb2YUrzpVypvOl4u
	 xAczryMKKKcp0dfS8ji9dS8nPVpOj756AnDuHUW+xJpsV0gXHWFYW9fufgtALDSOO9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0ch+DRf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73632606A32C;
	Thu, 19 Nov 2026 00:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0ch+DRf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089B21F000C4;
	Thu, 19 Nov 2026 00:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795047044;
	bh=RWnLnc+F0qTFDx5l6YFG1jdIeTtq63px4MNbLuTdYgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=D0ch+DRf/ZWw8JMTcLgJEGLGl7dAZRP/Av4mOMglrPSW8wYJl4fOeYavRZ5gSMO0u
	 HGrBt4KfUnsdr7ZwgqRonZhOLZledFtYrw3aX6WARz7yOgx9dKRUJFKtWFPrzq6fDa
	 4uzaVgVTzysinp+jhaU9LdkwCldduEayHNNumw7S7mtsclHbOfVYrOv+XHuZPF+2kA
	 /3n1Df+VADv4QXvfc1cwQdSWKpk4lQkx+g8xBGgA1OQextJzBozmbq/qdS44Mec82T
	 SgRgv72ZQJJMLLvBNvpJlzk5fToULfEIvAzb02Zcg4B1m7xl3JRfgN30VUqSXJi3pf
	 p02AJ6NeumQXQ==
Date: Wed, 18 Nov 2026 18:10:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] PCI/DPC: Decide DPC ownership with
 host_bridge->native_dpc
Message-ID: <20261119001042.GA759430@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118181718.3907441-1-sathyanarayanan.kuppuswamy@linux.intel.com>

On Wed, Nov 18, 2026 at 10:17:12AM -0800, Kuppuswamy Sathyanarayanan wrote:
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
> Patches 1-2 are the two DPC patches from v2 of Lukas's "Error reporting
> for AER-incapable devices", which are included here directly.
> 
>   https://lore.kernel.org/r/34c9ee153876bac953135b4518035194b7c07c6c.1794997749.git.lukas@wunner.de
>   https://lore.kernel.org/r/58d8a99cc6c2ecba6dadc450ecb4501d47816732.1794997749.git.lukas@wunner.de
> 
> Patch 1 keeps the DPC driver from accessing a non-existent AER
> capability.
> 
> Patch 2 drops the AER ownership check from dpc_probe(), so DPC also
> works on ports without an AER capability.
> 
> Patch 3 builds EDR whenever DPC is enabled on ACPI, so CONFIG_PCIE_EDR
> is no longer a separate knob in deciding whether to request DPC control.
> 
> Patch 4 stops requiring pci_aer_available() to bind the DPC service,
> since the DPC driver does not depend on MSI or on the AER driver.
> 
> Patch 5 requests DPC control only together with AER control, as PCI
> Firmware r3.3, sec 4.5.2.4, requires.
> 
> Patch 6 binds the DPC service on host_bridge->native_dpc and logs a
> message when the OS assumes DPC control that _OSC did not grant.
> 
> Changes since v2:
> 
>   - Pick up v2 of Lukas's two DPC patches.  Patch 1 now uses the AER
>     capability to find the error severity when the port has one.
> 
>   - Keep CONFIG_PCIE_EDR as a hidden option instead of removing it, and
>     remove the pci_dpc_recovered() check that becomes dead (Yazen).
> 
>   - Fold the PCI Firmware spec reference into the existing comment in
>     calculate_control() (Yazen).
> 
>   - Shorten the comment in acpi_pci_root_create() (Yazen).
> 
>   - Rebase on v7.4-rc1 and add Reviewed-by and Acked-by tags.
> 
> v2: https://lore.kernel.org/r/20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com
> v1: https://lore.kernel.org/r/20261007165840.1604136-1-sathyanarayanan.kuppuswamy@linux.intel.com
> 
> Kuppuswamy Sathyanarayanan (4):
>   PCI/EDR: Build EDR whenever DPC is enabled on ACPI
>   PCI/portdrv: Don't require AER to bind DPC service
>   PCI/ACPI: Request DPC control only together with AER control
>   PCI/portdrv: Bind DPC service based on host_bridge->native_dpc
> 
> Lukas Wunner (2):
>   PCI/DPC: Avoid access to non-existent AER capability
>   PCI/DPC: Reinstate support for AER-incapable ports
> 
>  drivers/acpi/pci_root.c    | 19 +++++++++++--
>  drivers/pci/pcie/Kconfig   |  8 +-----
>  drivers/pci/pcie/dpc.c     | 58 +++++++++++++++++++++-----------------
>  drivers/pci/pcie/portdrv.c |  7 +----
>  4 files changed, 51 insertions(+), 41 deletions(-)

Applied to pci/aer for v7.5, thank you!

B4 seems to collect historical things, e.g., Yazen's reviewed-by and
another Fixes: tag on "PCI/DPC: Reinstate support for AER-incapable
ports".  I *guess* that's all great, but I didn't dig out where they
originally came from.  I don't see them in the v3 thread on lore
(https://lore.kernel.org/all/20261118181718.3907441-1-sathyanarayanan.kuppuswamy@linux.intel.com/),
so they must be from a previous posting.
