Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6443D967A;
	Wed,  3 Jun 2026 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497887; cv=none; b=aRJHx06UbCFrgCr4bxS0FBIa2GF/50gjq5nUwj+13KMt0CHByxOrk45n69KQWxKswMPiTiE9C2WHZdSSp/wKP64YktetFnOMhfYtuE2eljelxlJyeNA8aGEfZwzg3jIFC7XQo5kw8w55FOT/fNkQafjs7Of8DcXIC4FojPUUuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497887; c=relaxed/simple;
	bh=H3omxgVqm8lKTgj38LJ/eVoVJgJBIEuZzN6+2zUFq6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BmXDm0JUU/C07QdNfbmIGKxf69obziSCB9nim7/rLan5GHmligmx5eq7+HUxfOWyKzhsv8VsU04hizRCVqcIZC18BCJcT4iTqAHtcOkvpYqI5w0wUinFQTWP6bH4E8zLa7a/0ubZSxFxfNIfATaKnTdT7Tl8NEEC7JGKkQxB9eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMDlDgi9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMDlDgi9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562521F00893;
	Wed,  3 Jun 2026 14:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780497885;
	bh=o/txvbo10oOWk46rmPX2byw291k/GcboYzdUh5PUvh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EMDlDgi9/71H7djf0DY8Rz4BTKPgPWHgLWEuIv0xIqfWQiF4beGePzR52enXtIkVH
	 tcwW68JQDParKqKevUXX1ccQJybAFEVWfWb9Vo4IJOZvLrqFAQOcyjpPAEL9+2MHmO
	 tVTzz4Ri0tSP0QqlTE+s82XG1G+A/Pgl+gGGcDl06Fps7g2hYUPaSL1ASxmugexZGi
	 NWjrGQDBezgFiywa7xSQuqbvfw9Ybr6o3c4+8m9gr+ECwLJikKdqpP9xzMyK/p7wyS
	 PHu/lV7J6btT/YDD8j6WuCM8uY0QpT/pc2DibSNF1Ul4Qdl8sl6Urn/rNNMe6EdUB2
	 N/a1bRmuDEGig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] dmaengine: dw-edma: Add Xilinx CPM6-DMA DeviceID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devendra.verma@amd.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260603143158.3243500-1-devendra.verma@amd.com>
References: <20260603143158.3243500-1-devendra.verma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 14:44:44 +0000
Message-Id: <20260603144445.562521F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing pci_free_irq_vectors() cleanup on error paths in dw_edma_p=
cie_probe() leading to IRQ resource leaks.
--

commit a523468dbe7999a5962895c3e0d73662a2938006
Author: Devendra K Verma <devverma@amd.com>

dmaengine: dw-edma: Add Xilinx CPM6-DMA DeviceID

Add Device ID for AMD (Xilinx) CPM6 DMA IP to enable 64 Read and 64 Write
Channels. Adds the relevant dw_edma_pcie_data to use 8 Read and 8 Write
Channels for the initial commit.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 0b30ce1385036..4ba368d18cb1d 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c

[ ... ]

> @@ -547,6 +561,8 @@ static const struct pci_device_id dw_edma_pcie_id_tab=
le[] =3D {
>  	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
>  	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
>  	  (kernel_ulong_t)&xilinx_mdb_data },
> +	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B00F),
> +	  (kernel_ulong_t)&xilinx_cpm6_dma_data },

[Severity: High]
This is a pre-existing issue, but adding this new device ID exposes the new
device to an IRQ resource leak in dw_edma_pcie_probe().

When the device is probed, dw_edma_pcie_probe() successfully allocates IRQs=
 via
pci_alloc_irq_vectors(). However, several subsequent error paths return dir=
ectly
without calling pci_free_irq_vectors().

For example, if the pcim_iomap_table() lookup fails:

drivers/dma/dw-edma/dw-edma-pcie.c:dw_edma_pcie_probe() {
    ...
	chip->reg_base =3D pcim_iomap_table(pdev)[vsec_data->rg.bar];
	if (!chip->reg_base)
		return -ENOMEM;
    ...
}

Or if the main eDMA probe fails later on:

drivers/dma/dw-edma/dw-edma-pcie.c:dw_edma_pcie_probe() {
    ...
	err =3D dw_edma_probe(chip);
	if (err) {
		pci_err(pdev, "eDMA probe failed\n");
		return err;
	}
    ...
}

Does this code leak the allocated IRQ vectors in these error paths? Because=
 IRQs
are a strictly limited resource, repeated probe failures (such as deferred =
probe
or unbind/rebind cycles) could silently exhaust the system's IRQ capacity.=
=20

Would it make sense to ensure pci_free_irq_vectors() is called on all error
paths after successful allocation before enabling new devices?

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603143158.3243=
500-1-devendra.verma@amd.com?part=3D1
