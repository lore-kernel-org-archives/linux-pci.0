Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367C3353EE0;
	Thu, 13 Aug 2026 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786604040; cv=none; b=oV4zjfCNzH6ISf6jYnlkvKPoZtrckLQ8CIx4vLkIrri8K9WEr5AQ6Jrr3LpJdnWgzGdJPgGnj91capMgJaud1SJALcpw4dU8akC9T+nF5cW5u0M40Td1oiYE7wSBMjkjLaqM+wwPznSRQkNZBwH1wnNff9hzWdE6hYs6o7Ok9zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786604040; c=relaxed/simple;
	bh=60H1iuFt36Dc6AaiHYMartzuZT8WNb50fSWd/18NKLM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gSzRzNbMEpwpOFrFMKr2dCJVkJVwKOLzlYp6aRaLhxJZ99aOPn2EydtOd4BHSSac48H+kOnqUlWcggSKZElXVYZWu+1uSjtjQ/6eQns1WRhCNghPCVThG/ig9A6Xbc1rOsm7aCC3PxvqYC/I9asqUDbL4Zwozd0KPItimz+Ksk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rp0GuVNC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rp0GuVNC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927011F000E9;
	Thu, 13 Aug 2026 06:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786604038;
	bh=z+FZeTTVh7j0bVNkJ4nuxoQXwDdIkcLZWZfzTJvL/cg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rp0GuVNCgKffXYuw6DcEBeVX3dvYQ2DLSJy53s+DrixmKD5q6taaz5+RwoAAAgZw3
	 Z7SNrDVQSa+/F1BZ0W9RgcvLa+taOk0+1aZFmKKOS1SfhDlOh4aHl+V9uf85qPVgfh
	 xTox+5N+9yjtUTnh49fBkQUYgpTIZ/YfoKhCf+wBnfpTtq6sml2LXpsEjOzhXWjSfa
	 +//6rHlCzBh7Mt5Z2j2BXrCIJg1/8ub/3nA1oyzF3xM87WWGVDUzJgYPU7g0Fx0Ihv
	 yTp5QEHNI+P4GY7dXJo7a/sr1HdKOGlwDNwR0PMskQej5cK3OYTqpEkBnSNVth6uE/
	 RF2oGoz6wEymA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/10] PCI: endpoint: Add DMA endpoint function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260813063757.3131865-10-den@valinux.co.jp>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <20260813063757.3131865-10-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 06:53:58 +0000
Message-Id: <20260813065358.927011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Missing `.remove` callback in the EPF driver allows Use-After-=
Free upon manual driver unbind.
- [High] TOCTOU race in ConfigFS attributes allows bypassing bound state ch=
ecks, leading to heap buffer overflows.
- [Medium] Mixing goto-based error handling with scope-based `__free()` cle=
anup in the same function.
--

--- Patch [9]: [PATCH v7 09/10] PCI: endpoint: Add DMA endpoint function ---
commit 59168807cdf2645897d81a698bfcd8a7744d66f2
Author: Koichiro Den <den@valinux.co.jp>
Subject: PCI: endpoint: Add DMA endpoint function

Add pci-epf-dma, an endpoint function that exposes selected
endpoint-integrated DMA channels as a separate PCI DMA controller
function.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-dma.c b/drivers/pci/e=
ndpoint/functions/pci-epf-dma.c
> new file mode 100644
> index 0000000000000..7e1c3e184a06b
> --- /dev/null
> +++ b/drivers/pci/endpoint/functions/pci-epf-dma.c
[ ... ]
> +static int pci_epf_dma_collect_resources(struct pci_epf_dma *epf_dma)
> +{
> +	const struct pci_epc_aux_resource *ep_to_rc_aux_chan[EDMA_MAX_WR_CH] =
=3D {};
> +	const struct pci_epc_aux_resource *rc_to_ep_aux_chan[EDMA_MAX_RD_CH] =
=3D {};
> +	const struct pci_epc_aux_resource *ep_to_rc_desc[EDMA_MAX_WR_CH] =3D {};
> +	const struct pci_epc_aux_resource *rc_to_ep_desc[EDMA_MAX_RD_CH] =3D {};
> +	const struct pci_epc_aux_resource *ctrl =3D NULL;
> +	struct pci_epf *epf =3D epf_dma->epf;
> +	struct pci_epc *epc =3D epf->epc;
> +	struct device *dev =3D &epf->dev;
> +	int count, i, ret;
> +
> +	count =3D pci_epc_get_aux_resources_count(epc, epf->func_no,
> +						epf->vfunc_no);
> +	if (count <=3D 0)
> +		return count ?: -ENODEV;
> +
> +	struct pci_epc_aux_resource *res __free(kfree) =3D
> +						kzalloc_objs(*res, count);

[Severity: Medium]
Does this code mix goto-based error handling and scope-based cleanup in the
same function?

The res variable uses __free(kfree) for cleanup, but later failures jump to
a goto label instead of returning directly:

	for (i =3D 0; i < epf_dma->wr_chans; i++) {
		ret =3D pci_epf_dma_claim_channel(epf_dma, ep_to_rc_aux_chan[i],
						&epf_dma->ep_to_rc_chan[i]);
		if (ret)
			goto err_release_channels;
	}

[ ... ]
> +static int pci_epf_dma_build_metadata(struct pci_epf_dma *epf_dma)
> +{
> +	const struct pci_epf_dma_bar_map *ctrl_map;
> +	u16 entry_size =3D PCI_EP_DMA_METADATA_CH_ENTRY_SIZE;
> +	u16 wr_table, rd_table, total_len;
> +	__le32 *metadata =3D epf_dma->metadata_addr;
> +	unsigned int i;
> +	int ret;
> +
> +	if (!metadata)
> +		return -EINVAL;
> +
> +	ctrl_map =3D pci_epf_dma_find_map(epf_dma, epf_dma->ctrl);
> +	if (!ctrl_map)
> +		return -EINVAL;
> +	if (epf_dma->wr_chans > FIELD_MAX(PCI_EP_DMA_METADATA_CTRL_WR_CH_COUNT)=
 ||
> +	    epf_dma->rd_chans > FIELD_MAX(PCI_EP_DMA_METADATA_CTRL_RD_CH_COUNT)=
 ||
> +	    entry_size > FIELD_MAX(PCI_EP_DMA_METADATA_CTRL_CH_ENTRY_SIZE) ||
> +	    ctrl_map->res->size > U32_MAX)
> +		return -EOVERFLOW;
> +
> +	wr_table =3D epf_dma->wr_chans ? PCI_EP_DMA_METADATA_HDR_LEN : 0;
> +	rd_table =3D epf_dma->rd_chans ?
> +		   PCI_EP_DMA_METADATA_HDR_LEN + epf_dma->wr_chans * entry_size : 0;
> +	total_len =3D PCI_EP_DMA_METADATA_HDR_LEN +
> +		    (epf_dma->wr_chans + epf_dma->rd_chans) * entry_size;
> +
> +	memset(metadata, 0, total_len);

[Severity: High]
Can a concurrent write to the configfs attributes cause an out-of-bounds
memset() here?

During the binding process (pci_epf_dma_bind), pci_epf_dma_build_layout()
allocates space based on the current wr_chans. However, the store
function for the attribute checks epf_dma->epf->epc without holding a lock:

static ssize_t pci_epf_dma_wr_chans_store(...)
{
	...
	if (epf_dma->epf->epc)
		return -EOPNOTSUPP;
	...
	epf_dma->wr_chans =3D val;
	...
}

Could this allow wr_chans to increase after the space is allocated but
before total_len is calculated for this memset?

[ ... ]
> +static struct pci_epf_driver pci_epf_dma_driver =3D {
> +	.driver.name	=3D "pci_epf_dma",
> +	.probe		=3D pci_epf_dma_probe,
> +	.id_table	=3D pci_epf_dma_ids,
> +	.ops		=3D &pci_epf_dma_ops,
> +	.owner		=3D THIS_MODULE,
> +};

[Severity: Critical]
If a user manually unbinds the driver via sysfs, does the lack of a .remove
callback lead to a use-after-free?

Because there is no .remove callback, the unbind operation appears to free
the epf_dma structure via devres cleanup, but leaves the epf->event_ops
pointer populated and the map_work delayed work still pending.

Could an in-flight map_work execution or a subsequent EPC link event try to
dereference the freed epf_dma memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813063757.3131=
865-1-den@valinux.co.jp?part=3D9
