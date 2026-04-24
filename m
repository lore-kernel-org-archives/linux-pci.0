Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB861862
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 11:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777031316; cv=none; b=GEzX2oUPlDbM0gz6m2JwWogB1SdLV2SyJMmUtn4+ijz32fjgGYjOC6SEogQsJk/v0LKWqa/0sAZmymQ/hSnZc5OUjmJMKxOC3kdQBvUHZ6imcn/c5AIsqbr8YpDXmTwzl67rU8yx3kFaNpmi3IoKpGnVRHXkHzweqzblYGRZTEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777031316; c=relaxed/simple;
	bh=G0OTqPwFHZrR2eXz3Qd/K/P3zXcGupz+/PbGhfnUtOw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IupsIW+0VvnzD2THjQiEmQJAWdF2abdSsj5ta/5aiupS6HcZlxDXHg00MYeBN4IsT+4TQU8rXKNiVRNZZwqGEKGsp5WdmZ59LsCHUJ1PiIzvxnzjBnVB/DqhPN4AyyuqYxIlnHYMKqIg5IYJ4ZlhY+SKsw9efDiGP7YUP5fRHQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=TPmoOkHu; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TPmoOkHu"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g2B6v5Cdnz9vLN;
	Fri, 24 Apr 2026 13:48:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777031303; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0OTqPwFHZrR2eXz3Qd/K/P3zXcGupz+/PbGhfnUtOw=;
	b=TPmoOkHuLo8BjS4tXnspkwlN6s2QMoiznhg0yYFxPXOq81Xou5l605iDB1s/rHbAt3D5kM
	EfKsgEAm8Zq/MZROYb/QLrYBPw1vm2+SmxGtWiaiI4fH2mUXYLWIh2T/1ce4Bh9ZbE0wdN
	fBAm9ahqba1zupF5AjE5InfeMLByZcG7b8UT8xOHypOYqOpPBefDK1Df+ysEA2JhPIdvIc
	ueWyEAhe+RyIyqiodyuBAVbdQ0aWGo2D6i2hd1H5iQq3GKFnqab2qKX1AlkFkchMwMEBlI
	IQVHyfSAwQ2O4vYaeGG7mLTr4d1MIhF9FFKXUaaJw+Vf7hnLYWaQsWgx/YPqWQ==
Message-ID: <da29f96e7b3c0fe245634694020b7ca4190eda8a.camel@mailbox.org>
Subject: Re: [PATCH v4 0/7] Add Devres managed IRQ vectors allocation
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, Kurt Schwemmer
 <kurt.schwemmer@microsemi.com>,  Logan Gunthorpe <logang@deltatee.com>,
 Philipp Stanner <phasta@kernel.org>, linux-pci@vger.kernel.org
Date: Fri, 24 Apr 2026 13:48:20 +0200
In-Reply-To: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
References: <1777017460-243543-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: ef197ca0ef727f5c6bd
X-MBO-RS-META: we5axgudwz584nokq79qj7oqm7ttg9ow

Hi Shawn,

On Fri, 2026-04-24 at 15:57 +0800, Shawn Lin wrote:
>=20
> There is a long-standing design ambiguity in the PCI/MSI subsystem regard=
ing
> the management of IRQ vectors. Currently, the management operates in a "h=
ybrid"
> mode. Sometimes it's handled by devres but sometimes not, creating potent=
ial
> for resource management bugs.
>=20
> Historically, pcim_enable_device() implicitly triggers automatic IRQ vect=
or
> management when calling pci_alloc_irq_vectors[_affinity], as pcim_enable_=
device()
> sets the is_managed flag, thus pcim_msi_release() will register a cleanup=
 action.
> However, using pci_enable_device() will not make pci_alloc_irq_vectors[_a=
ffinity]
> register a cleanup action.
>=20
> This creates an ambiguous ownership model. Many drivers follow a pattern =
of:
> 1. Calling pci_alloc_irq_vectors() to allocate interrupts.
> 2. Also calling pci_free_irq_vectors() in their error paths or remove rou=
tines.
>=20
> When such a driver also uses pcim_enable_device(), the devres framework m=
ay
> attempt to free the IRQ vectors a second time upon device release, leadin=
g to
> a double-free. Analysis of the tree shows this hazardous pattern exists w=
idely,
> while 37 other drivers correctly rely solely on the implicit cleanup.
>=20
> To identify the scope of this issue, I used the following shell commands =
to
> search for drivers using pcim_enable_device and allocation functions but =
missing
> the explicit free call:
>=20
> grep -rl "pcim_enable_device" drivers/ \
> =C2=A0 | xargs grep -l -E "pci_alloc_irq_vectors|pci_alloc_irq_vectors_af=
finity" 2>/dev/null \
> =C2=A0 | xargs grep -L "pci_free_irq_vectors" 2>/dev/null
>=20
> drivers/dma/hsu/pci.c
> drivers/dma/hisi_dma.c
> drivers/hid/intel-thc-hidintel-quicki2c/pci-quicki2c.
> drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> drivers/hid/intel-ish-hid/ipc/pci-ish.c
> drivers/accel/ivpu/ivpu_drv.c
> drivers/accel/qaic/qaic_drv.c
> drivers/accel/amdxdna/aie2_pci.c
> drivers/platform/x86/intel/ehl_pse_io.c
> drivers/media/pci/intel/ipu6/ipu6.c
> drivers/mfd/intel-lpss-pci.c
> drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
> drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
> drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
> drivers/crypto/inside-secure/safexcel.c
> drivers/thunderbolt/nhi.c
> drivers/i2c/busses/i2c-mchp-pci1xxxx.c
> drivers/i2c/busses/i2c-amd-mp2-pci.c
> drivers/i2c/busses/i2c-thunderx-pcidrv.c
> drivers/i2c/busses/i2c-designware-pcidrv.c
> drivers/tty/serial/8250/8250_exar.c
> drivers/tty/serial/8250/8250_pci.c
> drivers/tty/serial/8250/8250_mid.c
> drivers/gpio/gpio-merrifield.c
> drivers/iommu/riscv/iommu-pci.c
> drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> drivers/pci/switch/switchtec.c
> drivers/pci/controller/vmd.c
> drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
> drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> drivers/net/ethernet/realtek/r8169_main.c
> drivers/mmc/host/cavium-thunderx.c
> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
> drivers/cxl/pci.c
> drivers/spi/spi-pxa2xx-pci.c
> drivers/spi/spi-pci1xxxx.c
>=20
> To count how many drivers, including using lagacy APIs, have the double-f=
ree bugs, the
> following shell commands find out 60 drivers.
> grep -rl "pcim_enable_device" drivers/ --include=3D"*.c" \
> =C2=A0 | xargs grep -l -E "pci_alloc_irq_vectors|pci_alloc_irq_vectors_af=
finity" 2>/dev/null \
> =C2=A0 | xargs grep -l "pci_free_irq_vectors" 2>/dev/null \
> =C2=A0 | tee /dev/tty \
> =C2=A0 | wc -l
>=20
> drivers/dma/dw-edma/dw-edma-pcie.c
> drivers/dma/plx_dma.c
> drivers/dma/amd/ae4dma/ae4dma-pci.c
> drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> drivers/perf/hisilicon/hisi_pcie_pmu.c
> drivers/perf/hisilicon/hns3_pmu.c
> drivers/platform/x86/intel_ips.c
> ....
> drivers/hwtracing/intel_th/pci.c
> drivers/bus/mhi/host/pci_generic.c
> drivers/fpga/dfl-pci.c
> 51
>=20
> grep -rl "pcim_enable_device" drivers/ --include=3D"*.c" \
> =C2=A0 | xargs grep -l -E "pci_enable_msi|pci_enable_msix" 2>/dev/null \
> =C2=A0 | xargs grep -l "pci_disable_msi" 2>/dev/null \
> =C2=A0 | tee /dev/tty \
> =C2=A0 | wc -l
>=20
> drivers/dma/ioat/init.c
> drivers/dma/amd/ptdma/ptdma-pci.c
> drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy=
.c
> drivers/crypto/ccp/sp-pci.c
> drivers/i2c/busses/i2c-ismt.c
> drivers/pci/msi/api.c
> drivers/misc/mei/pci-me.c
> drivers/misc/mei/pci-txe.c
> drivers/block/mtip32xx/mtip32xx.c
> 9
>=20
> This series introduces new managed APIs: pcim_alloc_irq_vectors() and
> pcim_alloc_irq_vectors_affinity(). Drivers that wish to have devres-manag=
ed IRQ
> vectors should use these functions to ensure proper automatic cleanup wit=
hout
> ambiguity.
>=20
> Regarding the removal strategy discussed in v3 [1], two approaches were c=
onsidered:
> a) Introducing another hybrid function temporarily.
> b) Duplicating code temporarily.
>=20
> Following the discussion with Philipp, I agree that adding another hybrid=
 function
> does not guarantee the completion of the final cleanup work. Therefore, s=
tarting
> from v4, I have chosen to duplicate the necessary code temporarily. Helpe=
r functions
> have been factored out to minimize code duplication.
>=20
> In the short term, the series converts two drivers within the PCI subsyst=
em to
> use the new APIs. The long-term goal is to convert all other drivers whic=
h wish to
> use these managed functions. For the legacy APIs, like pci_enable_msix_ra=
nge_*() and
> pci_enable_msi(), we won't consider to provide devres-managed version for=
 them but to
> fix the only 9 double-free drivers by using the new APIs provided by this=
 series. And
> once ready, we could remove the problematic hybrid management pattern fro=
m
> pcim_setup_msi_release() entirely.
>=20
> [1]: https://lore.kernel.org/linux-pci/9dc66010d61670dc5182062ef5f1a932f7=
374323.camel@mailbox.org/T/#t
>=20
>=20
> Changes in v4:
> - Rework to create dedicated devres-managed function (Philipp)

Thanks for the rework.

I skimmed through it and it very much looks spot-on, I don't see major
concerns.

I'm a bit loaded right now. Can do a more detailed review earliest next
week, probably later.


Regards
P.

>=20
> Changes in v3:
> - Rework the commit message and function doc (Philipp)
> - Remove setting is_msi_managed flag from new APIs (Philipp)
>=20
> Changes in v2:
> - Rebase
> - Introduce patches only for PCI subsystem to convert the API
>=20
> Shawn Lin (7):
> =C2=A0 PCI/MSI: Split __pci_enable_msi_range() for reuse
> =C2=A0 PCI/MSI: Split __pci_enable_msix_range() for reuse
> =C2=A0 PCI/MSI: Introduce __pcim_enable_msi_range()
> =C2=A0 PCI/MSI: Introduce __pcim_enable_msix_range()
> =C2=A0 PCI/MSI: Add Devres managed IRQ vectors allocation
> =C2=A0 PCI: switchtec: Replace pci_alloc_irq_vectors() with
> =C2=A0=C2=A0=C2=A0 pcim_alloc_irq_vectors()
> =C2=A0 PCI: vmd: Replace pci_alloc_irq_vectors() with
> =C2=A0=C2=A0=C2=A0 pcim_alloc_irq_vectors()
>=20
> =C2=A0drivers/pci/controller/vmd.c=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
> =C2=A0drivers/pci/msi/api.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 84 +++++++++++++++++++++++++++++++
> =C2=A0drivers/pci/msi/msi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 110 +++++++++++++++++++++++++++++++++++------
> =C2=A0drivers/pci/msi/msi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 3 ++
> =C2=A0drivers/pci/switch/switchtec.c |=C2=A0=C2=A0 6 +--
> =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 22 +++++++++
> =C2=A06 files changed, 210 insertions(+), 19 deletions(-)
>=20

