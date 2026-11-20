Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198787;
	b=i5wFJg6RUjkHGGmvGDTUbS/gAZF6LjEYgRRfV6H7yoPlrHHpTnRa1nSOw7CP6sP6an5i
	 VSSAnFKx62LEXvrSfx9gWNPkVQNVSk+HQ5CCm7Z6pDrm5BrwHxYt5o1883ZE0t68SvV4A
	 vc327Ni+NG0JCX2AzO7TNTKvein5N1SjJ3NvFFrs2kpILTKN6j9dQDZ51GgX13hN5IHQf
	 7TNaVbL9ywpVLO+p040pS2iWholPyhcbAOsI1N5DHjDXrXTY5qvNfdlGTsE2rd/t0YWEV
	 DdJTFl3TTHNXzrKOLfpLCcm7hhB0MFAZIaOsYO7+MZRNFyIbQyc9tCwf4W2x00l7k9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198787;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5Vhbt7aW3jWHIeGfBwm+6fRLbamSR1yw/0kxYWIIdZI=;
	b=kgf0M52EcO30JuLnK48un9tHcZXVGXK2VsjU3VCBNbk7pVbzrwhOShQTP0yPzBtbCKSx
	 6yRIJOR1jVmfNOJwdxOXQAoR3syo+O5Neweq59/nczYT1YoFHFJ/ZNa0dHx67rJVfdsNj
	 CxaeOjJ9t3b+UJMDx2/RQ0I5yPsZi3P7nQPURAVJV9/QmLyS1DiryZ+iF9S3CzgIlHH7f
	 xA/wgiFcf1VLnbwqttrn6gBfetC6TTRarV/qR5C01tawwwvcHp7EDCMjusDCaDQoTYT+g
	 R8hr3aVYD6lOiZ0XzT+bveLrMyxEaVwheLZY7UH0BW/DTGkda/ILkEvT9ks/dKCI6zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="akpEE/dG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A37C606A889
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akpEE/dG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB121F000F0;
	Fri, 20 Nov 2026 18:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198786;
	bh=5Vhbt7aW3jWHIeGfBwm+6fRLbamSR1yw/0kxYWIIdZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=akpEE/dGvzTVKXG44McHDOZeqdy4kbz+M72BYyCuS8m9ySpFgszqdxQwiAI9raS/Y
	 x7UMfxeVB+x1/opIhppv5+xHQ2U9hrhCRfQSoNnCb9pSteB73hFRa7gjyzzHylqzBD
	 wz+hRpFB35xxc5Tfj9JDXSf3pKZJ+eS54Jw3PPQ9krWwg0LmNosYlLmS5I8NOGUmOe
	 LI2EcY7o7V9OBOY1q/N3FHBZnfjv3PqZr2zFqsGrZpKSJ9oJaLSU+t2Gt62TQ/HoE8
	 P5q21HdhZsjxL3Qo92xU8KtSyKuTeMMtam8UXF/Wq2BzEs1QJIIXK2Tgn/Y8sAiHJL
	 MPyKavkBMfmFg==
Date: Fri, 20 Nov 2026 12:19:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Raag Jadav <raag.jadav@intel.com>, linux-pci@vger.kernel.org,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
	Srinivasa Adatrao <srinivasa.adatrao@intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Darshit Shah <darnshah@amazon.de>, Jason Perlow <jperlow@gmail.com>,
	Riana Tauro <riana.tauro@intel.com>,
	Yury Murashka <yurypm@arista.com>,
	Matthew W Carlis <mattc@purestorage.com>
Subject: Re: [PATCH v2 0/7] Error reporting for AER-incapable devices
Message-ID: <20261120181945.GA904595@bhelgaas>
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
In-Reply-To: <cover.1794997749.git.lukas@wunner.de>

On Wed, Nov 18, 2026 at 11:40:00AM +0100, Lukas Wunner wrote:
> Bjorn suggests "the PCI core should do pci_enable_pcie_error_reporting()
> independent of whether the device has an AER Capability":
> 
> https://lore.kernel.org/r/20260826212619.GA1566339@bhelgaas/
> 
> This is done in patch [7/7].  The preceding patches contain prep work.
> 
> For context, PCIe r7.1 sec 6.2.1 defines two error reporting paradigms:
> AER and baseline capability.  The latter relies (solely) on the error
> enable/status bits in the Device Control and Device Status registers,
> which exist on every PCIe device.  The kernel has supported the AER
> paradigm for 20 years.  With the present series, it gains support for
> the baseline capability paradigm.
> 
> Patches [1/7] and [2/7] reinstate DPC on AER-incapable Downstream Ports.
> The kernel used to support this until 2018.  It is hereby fixed because
> it eases introduction of baseline capability error reporting in the
> subsequent patches.
> 
> 
> Changes v1 -> v2:
> 
> * Patch [1/7]:
>   * On AER-capable devices, infer severity from AER Extended Capability
>     instead of Device Status register because the latter also logs masked
>     errors (Sathya).
>   * Fix storytelling in commit message because 4e5fad429bd1 changed
>     behavior, not 708b20003624 (Sathya).
> 
> * Patch [3/7]:
>   * New patch to clear error status bits more selectively (sashiko).
> 
> * Patch [4/7]:
>   * Clear Fatal Errors as well on recovery failure (Sathya, sashiko).
> 
> * Patch [6/7]:
>   * Amend kernel-doc of pci_aer_unmask_internal_errors() (Sathya).
> 
> * Patch [7/7]:
>   * Convert AER severity to Device Status bit with new severity2devsta[]
>     array, instead of renumbering AER severity (sashiko).
>   * On entry of aer_get_device_error_info(), clear info->mask and
>     info->first_error (Sathya, sashiko).
>   * Emit "(no details available)" message for AER-incapable devices
>     as well as for devices whose AER registers are deliberately not
>     read on Fatal Errors (Sathya).
>   * Amend commit message to inform that System Errors may be raised
>     by AER-incapable devices if they have no AER- or DPC-capable
>     port in their ancestry (Sathya).
> 
> Link to v1:
> 
> https://lore.kernel.org/r/cover.1790531238.git.lukas@wunner.de/
> 
> 
> Lukas Wunner (6):
>   PCI/DPC: Avoid access to non-existent AER capability
>   PCI/DPC: Reinstate support for AER-incapable ports
>   PCI/ERR: Clear error status bits more selectively
>   PCI/AER: Drop AER native check from handles_cxl_errors()
>   PCI/AER: Move AER capability check out of pcie_aer_is_native()
>   PCI/AER: Enable baseline capability error reporting
> 
> Yury Murashka (1):
>   PCI/ERR: Avoid stale error status bits on recovery failure
> 
>  .../ABI/testing/sysfs-bus-pci-devices-aer     | 26 +++++--
>  Documentation/PCI/pcieaer-howto.rst           |  9 +--
>  drivers/pci/pcie/aer.c                        | 76 +++++++++++++------
>  drivers/pci/pcie/aer_cxl_rch.c                |  3 +-
>  drivers/pci/pcie/dpc.c                        | 46 +++++++----
>  drivers/pci/pcie/err.c                        | 14 +++-
>  6 files changed, 120 insertions(+), 54 deletions(-)

Applied to pci/aer for v7.5, thanks!
