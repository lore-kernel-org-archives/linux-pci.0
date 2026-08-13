Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D69731C56D
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 22:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786660397; cv=none; b=NqKZnwwRsrSYMPRHqeNVMnmOPJYyYPZW01FrRnqNx8eXPdejiqBCOaN6MWH31oh6DKObPAWiSTGk8MADUJNzpu+ZM+Tmyz8nxu/sI6SYCUkBy+zW3fMkLtucqenenPzPKGnqTa1hAVmYwUHVSwmgp/HirEPnC3uce9UJjYpK8gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786660397; c=relaxed/simple;
	bh=/aaB18UkuGY07d3ZsZ6HcfIQ7056lvRcvUukFB4S6ws=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g94h5Nch7bKip6MT18EiruNvi2fRAsYSuYCaENbnBbl/zUPycpcWXvd7BOwCKBlls+pZAs/A3VO/8S8075hHnlY6DECGmd3VSQIAqcJqDLtvh7FLFXV3bBW9lLQVwQoL4OovLlQuki5NGbxEFefxEEF5VjdVMIdQuYntMDnd+YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2yS0nXj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2yS0nXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0408C1F000E9;
	Thu, 13 Aug 2026 22:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786660396;
	bh=kpIgvftfn+qpufjMb4a+wKHUv7rIIXpk2NGyEcAnVVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c2yS0nXjc+OImdSMxNe0MEPZfwIOgkAAmrLhqtwpKlFHCKKuIhjeDIhwM8OvbsNK3
	 UVHX2EkGRTHyFgHxxeT9ytisQyIEqhby0PZvfLsD7OfmkHwEc+u4t6ehgAZ9EJ0NS2
	 FYZgoAP0FZIkK7/TxjFHHxA/QwjK5X3/NzA2aquxa4z7ECR6DcJFUCOsrO7UwM0mYx
	 P3hl/ZSOH3byeGPhNbMDdiVF3mXO/0prOD9MXTdbcNPFLoq/OPwE0eqNlX00joLuWv
	 sgEiFCgIoXB+nf96gCl7Xj1m89yaZm3gpJYgM22i0/J34DWFEaoT8/dB/xPfx66wvu
	 elIJ9v1FhG1ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 08/15] idpf: refactor idpf to use libie_pci
 APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tony Nguyen" <anthony.l.nguyen@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260317230905.847744-9-anthony.l.nguyen@intel.com>
References: <20260317230905.847744-9-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 22:33:15 +0000
Message-Id: <20260813223316.0408C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unhandled NULL pointer returned by `libie_pci_get_mmio_addr()` whe=
n resolving dynamic MMIO offsets from virtchnl (Control Plane). If the CP p=
rovides invalid register offsets, the driver silently assigns NULL to criti=
cal pointers (like interrupt control and queue tail pointers). Subsequent h=
ardware interactions on the fast path (e.g., `writel(..., q->tail)` during =
packet transmit/receive) will dereference the NULL pointer, triggering a ke=
rnel oops.
--

--- Patch [8]: [PATCH net-next 08/15] idpf: refactor idpf to use libie_pci =
APIs ---
commit f697d04a8f177d8259403ad799fd72beb013621d
Author: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

idpf: refactor idpf to use libie_pci APIs

This commit refactors the idpf driver to use the libie_pci APIs for initial=
ization and MMIO where possible. It introduces the libie_ctlq_ctx structure=
 and replaces custom MMIO mapping and offset calculation with standard libi=
e equivalents.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/eth=
ernet/intel/idpf/idpf_dev.c
> --- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
[ ... ]
> @@ -110,22 +114,21 @@ static int idpf_intr_reg_init(struct idpf_vport *vp=
ort,
>  		intr->dyn_ctl_sw_itridx_ena_m =3D
>  			PF_GLINT_DYN_CTL_SW_ITR_INDX_ENA_M;
> =20
> -		spacing =3D IDPF_ITR_IDX_SPACING(reg_vals[vec_id].itrn_index_spacing,
> +		spacing =3D IDPF_ITR_IDX_SPACING(reg->itrn_index_spacing,
>  					       IDPF_PF_ITR_IDX_SPACING);
>  		rx_itr =3D PF_GLINT_ITR_ADDR(VIRTCHNL2_ITR_IDX_0,
> -					   reg_vals[vec_id].itrn_reg,
> -					   spacing);
> +					   reg->itrn_reg, spacing);
>  		tx_itr =3D PF_GLINT_ITR_ADDR(VIRTCHNL2_ITR_IDX_1,
> -					   reg_vals[vec_id].itrn_reg,
> -					   spacing);
> -		intr->rx_itr =3D idpf_get_reg_addr(adapter, rx_itr);
> -		intr->tx_itr =3D idpf_get_reg_addr(adapter, tx_itr);
> +		intr->rx_itr =3D libie_pci_get_mmio_addr(mmio, rx_itr);
> +		intr->tx_itr =3D libie_pci_get_mmio_addr(mmio, tx_itr);

[Severity: High]
This is a pre-existing issue, but what happens in idpf_intr_reg_init() if t=
he
Control Plane provides invalid offsets via virtchnl messages?

The old idpf_get_reg_addr() function contained an explicit BUG() statement =
if
the register offset couldn't be resolved. The replacement function,
libie_pci_get_mmio_addr(), returns NULL for invalid or unmapped offsets.

Since we don't validate the return value before assigning it to intr->rx_itr
and intr->tx_itr, will this result in a silent unhandled NULL pointer
dereference later when these pointers are accessed?

>  	}
> =20
[ ... ]
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/ne=
t/ethernet/intel/idpf/idpf_virtchnl.c
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
[ ... ]
> @@ -1421,7 +1425,8 @@ static int __idpf_queue_reg_init(struct idpf_vport =
*vport,
> =20
>  			for (j =3D 0; j < tx_qgrp->num_txq && k < num_regs; j++, k++)
>  				tx_qgrp->txqs[j]->tail =3D
> -					idpf_get_reg_addr(adapter, reg_vals[k]);
> +					libie_pci_get_mmio_addr(mmio,
> +								reg_vals[k]);

[Severity: High]
This is a pre-existing issue, but could this similarly result in an oops on
the hot path?

In __idpf_queue_reg_init(), if libie_pci_get_mmio_addr() returns NULL for an
invalid queue tail offset, it gets directly stored in the queue structure.
Later, when fast-path packet processing routines attempt to update the tail
pointer (e.g., via writel(..., q->tail) during transmit), they will derefer=
ence
NULL.

Should we add a validation check for the returned address before we
commit it to the tx_qgrp->txqs[j]->tail pointer?

>  		}
>  		break;
>  	case VIRTCHNL2_QUEUE_TYPE_RX:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260317230905.8477=
44-1-anthony.l.nguyen@intel.com?part=3D8
