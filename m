Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED94543AB0;
	Mon,  3 Aug 2026 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781530; cv=none; b=uA1IPk8xncdFzD9FaGVhjIIDLS8NapCpSZcM52870Dz/TB+Js/XXZL5dciDwgNoDPfbbKkDNpRY2aRrwsZEP3I3b/9Rur733q6talSVyitP19nvCiPb1U30vzlosoYrd0gc0jPS72A8YdGlRgjj/ocCVPpsS4Az+znPnyd2MAVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781530; c=relaxed/simple;
	bh=jhYNc4FTxXSfhO+ssvnBUeAO5cfhFu9r/LktIgOyGO0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TjiwrQVLs0TxkHCg8PrxZ37cgsf7SM0e9P+IDr1xcuXVYAYo7DbrDMB9k8lcqWrAvIE39bLvjXu6mbXdcaPfXemV0B9tt3e6Rt9A9DjNpFPJt8XzrwH/q7CXBPHhyyWhF8o3jaKvUcO/MuBwG0SuoiDwsDgrXYAdK8GN2JlHk80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CruAUM8C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CruAUM8C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750A91F000E9;
	Mon,  3 Aug 2026 18:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781528;
	bh=VizkbkDQ15erG4doj+fS/MQLpg7B/DMJuimactfQ/wo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CruAUM8C3CFx4EBnh9LMWICEoPm9JX9xFX1mAak5MRcX6OrQlf6p+3fuDzqVUEedz
	 VKVQEHrrBOqKtikUKE7CbulIxqVVb51U9+q8UpW9X0fUN8l/WL+1ndfSrrSV8+oBlZ
	 egkU2Tn/aGToZAiX0dSd0SfGEL3e0tddXDDU1Dqs7972lVo++bnQblQbXcIPMpchDU
	 R/vGcX82CcqRXR+5LSknKU2SZ0g4uBgfTzaTJTzuT2u+tOByERfgm+ahdnMcJcrpjn
	 xsjf77BmKNJzF5nBH7q9nyceYZ6nQxuiAhxCCmndQRtRphigDX8wrWpJugA4UXcBID
	 DcgrC7FK7X2VA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/11] PCI: endpoint: pci-epf-vntb: Implement MW group
 translation callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20260803180439.1963864-5-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
 <20260803180439.1963864-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:25:28 +0000
Message-Id: <20260803182528.750A91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] DMA Use-After-Free due to `vntb_epf_mw_clear_trans_group()` an=
d `vntb_epf_mw_clear_trans()` returning success (0) without actually disabl=
ing the inbound hardware translations.
- [High] The `vntb_epf_mw_set_trans()` function incorrectly hardcodes `func=
_no` and `vfunc_no` to 0 when invoking `pci_epc_set_bar()`, whereas other E=
PF APIs (including the newly added group API) correctly use the endpoint's =
configured function numbers.
- [High] The `vntb_pci_driver` structure is missing a `.remove` callback, c=
ausing NTB device leaks and use-after-free conditions when the endpoint fun=
ction is unbound.
--

--- Patch [4]: [PATCH 04/11] PCI: endpoint: pci-epf-vntb: Implement MW grou=
p translation callbacks ---
commit 419429d9534b2c856c11cb4a4a4107e84a87fe8e
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: pci-epf-vntb: Implement MW group translation callbacks

All RC-to-EP MWs in a packed group share one inbound BAR. Setting each
MW separately would keep replacing that BAR and could expose a partial
group. Add group callbacks that program the shared BAR once for the
complete backing range.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index f22459e5a8c69..0c72b907c2896 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1622,6 +1622,31 @@ static int vntb_epf_mw_clear_trans(struct ntb_dev =
*ntb, int pidx, int idx)
>  	return 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while looking at this contex=
t,
I noticed that the existing vntb_epf_mw_set_trans() hardcodes the function
numbers to 0:

drivers/pci/endpoint/functions/pci-epf-vntb.c:vntb_epf_mw_set_trans() {
    ...
	ret =3D pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
    ...
}

Does this incorrectly configure the BAR for function 0 when the virtual NTB
device is bound to a non-zero endpoint function or virtual function?

If the device is configured via configfs with a non-zero function, could th=
is
lead to silent failures in memory window translation or corrupt the ATU
configuration of function 0?

> +
> +static int
> +vntb_epf_mw_set_trans_group(struct ntb_dev *ndev, int pidx, int widx,
> +			    dma_addr_t addr, resource_size_t size)
> +{
[ ... ]
> +	return pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> +			       ntb->epf->vfunc_no, epf_bar);
> +}
> +
> +static int vntb_epf_mw_clear_trans_group(struct ntb_dev *ndev, int pidx,
> +					 int widx)
> +{
> +	return 0;
> +}

[Severity: Critical]
This is a pre-existing issue perpetuated here by the new group API, but does
returning 0 without actually disabling the inbound hardware translations cr=
eate a
DMA use-after-free window?

When an NTB client unmaps a memory window group and frees the backing memor=
y,
the hardware BAR mapping will remain active.

If the local host frees this memory, won't the endpoint hardware continue
translating incoming PCIe accesses to the freed physical address, allowing a
remote peer to access arbitrary new allocations on the endpoint?

[Severity: High]
This is another pre-existing issue, but I noticed the vntb_pci_driver struc=
ture
is missing a .remove callback:

drivers/pci/endpoint/functions/pci-epf-vntb.c:
static struct pci_driver vntb_pci_driver =3D {
	.name           =3D "pci-vntb",
	.id_table       =3D pci_vntb_table,
	.probe          =3D pci_vntb_probe,
};

Without a .remove callback, ntb_unregister_device() is never called when the
EPF device is unbound via configfs.

Does this cause NTB device leaks and driver state use-after-free?

If the endpoint function is unbound, won't the NTB clients remain active and
bound to a device whose backing EPF structures, DMA masks, and hardware
mappings have been destroyed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803180439.1963=
864-1-den@valinux.co.jp?part=3D4
