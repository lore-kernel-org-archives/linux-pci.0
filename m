Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C4A231A41
	for <linux-pci@vger.kernel.org>; Sat, 16 May 2026 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778971532; cv=none; b=sKgyqNfNtqaw+9UmCYAQCiAsYWZBdX+HHnE3poXz1n92ygpouANcH6B7hB01y2lI1SRnOHpmb2OeGGUfawhH5hVl3pLqGa3Skp1q3oqt/0wl980o+kzGuxW5qmtF6Y3Q3/J776IBkWWUzxdEorWO0n7f5+uM2EI39imGDFln0cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778971532; c=relaxed/simple;
	bh=jxSjP/zQ+oemDHsDDNNiOuSy0cJ/3w7z2HMD6kljsJc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W6/6WqQNvnKU0N5lspiKHnCYpQBTZ8dWAHioIy2hPo/FWh7+/Tff3CMtd9s1v0psiUHF3jgqCXkoux+pGekgkYGtU46PqAeI0HJQYeXVUdcFSltBqcoTmew1R63bFX/e8fcUejBZTz8Iy2gl748P3VvPJX7eqnXRRY6HKkKkKeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ph1itGHv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ph1itGHv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45240C19425;
	Sat, 16 May 2026 22:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778971532;
	bh=jxSjP/zQ+oemDHsDDNNiOuSy0cJ/3w7z2HMD6kljsJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ph1itGHvUfJ4xqTkDJfg9PPNLQDRN6gxthENPaqrLZX3naFeGRDTdytL/balvShgy
	 khDObzG/rEwEK23YWQbTVqb/wmbX2rrb2evyD6GVMI1j+d9uCkkGyW+mitQnVx+go0
	 0AT1f8TetgYUfPqghPQYLXozuKzeORkXhSzc1WpNMVLlpkkt3bE6B4GC+rqoybJESX
	 fMyOsi2eJ9kIlb763uUMt5sZroZffl6iaCuv1ivWXRg9iWxcr2a59l5p4jIZElay1J
	 iByyB7sbKBPZNvX6U/eIDH+w9qzIBewe2seMrTaJLLtcuz2PclTljXZICHH7mvUOCW
	 TikebWl+hWjhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 07/14] idpf: refactor idpf to use libie_pci
 APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tony Nguyen" <anthony.l.nguyen@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260515224443.2772147-8-anthony.l.nguyen@intel.com>
References: <20260515224443.2772147-8-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 22:45:31 +0000
Message-Id: <20260516224532.45240C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing NULL check for `libie_pci_get_mmio_addr()` can lead to ker=
nel panic.
- [High] Teardown sequence in `idpf_remove()` causes Use-After-Free and unm=
apped MMIO page faults.
- [Medium] Uninitialized `__free(kfree)` variable declaration violates clea=
nup subsystem guidelines.
--

commit e19227dc4c557d70d94d43565d6b6daafde0cccd
Author: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: idpf: refactor idpf to use libie_pci APIs

This commit refactors the idpf driver to use libie_pci initialization
and MMIO mapping APIs. It transitions the driver from open-coding BAR
resource mapping to utilizing the shared libie_mmio_info structures.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_dev.c b/drivers/net/eth=
ernet/intel/idpf/idpf_dev.c
> index 1a0c71c95ef12..e36b0017186fd 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_dev.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_dev.c
[ ... ]
> @@ -93,14 +94,17 @@ static int idpf_intr_reg_init(struct idpf_vport *vpor=
t,
>  		goto free_reg_vals;
>  	}
> =20
> +	mmio =3D &adapter->ctlq_ctx.mmio_info;
> +
>  	for (i =3D 0; i < num_vecs; i++) {
>  		struct idpf_q_vector *q_vector =3D &rsrc->q_vectors[i];
>  		u16 vec_id =3D rsrc->q_vector_idxs[i] - IDPF_MBX_Q_VEC;
>  		struct idpf_intr_reg *intr =3D &q_vector->intr_reg;
> +		struct idpf_vec_regs *reg =3D &reg_vals[vec_id];
>  		u32 spacing;
> =20
> -		intr->dyn_ctl =3D idpf_get_reg_addr(adapter,
> -						  reg_vals[vec_id].dyn_ctl_reg);
> +		intr->dyn_ctl =3D libie_pci_get_mmio_addr(mmio,
> +							reg->dyn_ctl_reg);

libie_pci_get_mmio_addr() can return a NULL pointer if the provided offset
is invalid. If the firmware provides an unexpected or invalid offset, could
these pointer fields be set to NULL and cause a panic when accessed in
the interrupt handler or datapath? Is it possible to validate the return
value here before assigning it?

[ ... ]
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/ne=
t/ethernet/intel/idpf/idpf_virtchnl.c
> index d4546d62cca9f..3e6411a07e4d0 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
[ ... ]
> @@ -1037,7 +1072,6 @@ static int idpf_send_get_lan_memory_regions(struct =
idpf_adapter *adapter)
> +static int idpf_cfg_lan_memory_regions(struct idpf_adapter *adapter)
>  {
>  	struct virtchnl2_get_lan_memory_regions *rcvd_regions __free(kfree);
>  	struct idpf_vc_xn_params xn_params =3D {

This isn't a bug, but the cleanup subsystem guidelines recommend defining a=
nd
initializing scope-based cleanup variables in a single statement. If a futu=
re
patch introduces an early return before rcvd_regions is assigned, could this
cause the cleanup function to free an uninitialized stack variable?

[ ... ]
> @@ -3647,7 +3649,6 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
>   */
>  void idpf_vc_core_deinit(struct idpf_adapter *adapter)
>  {
> -	struct idpf_hw *hw =3D &adapter->hw;
>  	bool remove_in_prog;
> =20
>  	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
> @@ -3672,12 +3673,10 @@ void idpf_vc_core_deinit(struct idpf_adapter *ada=
pter)
> =20
>  	idpf_vport_params_buf_rel(adapter);
> =20
> -	kfree(hw->lan_regs);
> -	hw->lan_regs =3D NULL;
> -
>  	kfree(adapter->vports);
>  	adapter->vports =3D NULL;
> =20
> +	idpf_decfg_lan_memory_regions(adapter);
>  	clear_bit(IDPF_VC_CORE_INIT, adapter->flags);
>  }

idpf_vc_core_deinit() now calls idpf_decfg_lan_memory_regions(), which
unmaps the MMIO regions. When this is called during the teardown sequence
in idpf_remove(), the netdevs are still registered.=20

Could the datapath still execute ndo_start_xmit and attempt to write to
the now-unmapped q->tail, triggering a page fault? Would it be safer to
unregister the netdevs before unmapping the MMIO regions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515224443.2772=
147-1-anthony.l.nguyen@intel.com?part=3D7
