Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6E38551A;
	Wed,  8 Jul 2026 23:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553635; cv=none; b=KYl7HbfFuu70WAcbtwp4a71qlMKzXmLvZ01RHSLsaUbEDmL7NqHZpe7U+yIAMoQYldweir52/lrwREadpgLae4OFvHANbd2UCZPxhrYdeAootlz0DBfQh/EiXmg3OSVIC5waWLDrnJfQJfFn+fkFAm7p7bAs3P4OdUOX1f/w3yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553635; c=relaxed/simple;
	bh=nrVGoNf0AQ1Pf1j/HXa7m19KJOTbgbVK32Iru/v1VEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSlPS+jDzv4kJ9s89vDaPKBTDTVAywKbUI8Jj33W+KDPerBo0HlVUF9NwvCSDggyqfhs6nRDGxaAzH9vUD5kfl6f7xCbZQycXW7W8bGVKG1Z14PDtY+sbNxkhkDEJR1V4ZYUvfRnmrJGqflK+jUcELgoQVBNh6jsfOyF7J0oHhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=ByOPLzxY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RyHQL+5E; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="ByOPLzxY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RyHQL+5E"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id B6116EC0092;
	Wed,  8 Jul 2026 19:33:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 08 Jul 2026 19:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783553632;
	 x=1783640032; bh=08xlNeBWtwlCE5iQ/YpRt53+LZLMhwf6NzqlJeZlhG0=; b=
	ByOPLzxYO4pQlWMxPq91aVdWFKUrSBi2WAZt72Fj4TSl0Pd5I1CbBW+gDES1qWYD
	V6j5uX5YEv9fwz9Qfiv5FzoPnprtUVyvHLWpkDLPcpMSVROW5wimev9R6E8TCcwS
	z6zhQ1qpy9XzhWH8hmb3MnXVzRlyA4lhhF8uuNskJSICNcmwAz2GLdoqxI5kYmdW
	NGzg/m5yVrERNBYmNj6z8r3adBQNueTMypCVGYyYWpENZDUlVPUdXS+F7NipATqo
	nA+qOhz55FkZ6vdLM6FGPDoCHUfWeSbTSI/emO3A5D/PUg5vXMD3TI1i1chv43G7
	kH7VQhFv0bjeoMIoj572eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783553632; x=
	1783640032; bh=08xlNeBWtwlCE5iQ/YpRt53+LZLMhwf6NzqlJeZlhG0=; b=R
	yHQL+5EJFWeoCNV2v0JHJ3bNiVzQsq0kKuczcqz1M8O4+dsp0WDaGCu5EzlQuObl
	7/io+WUGDwGBlHkd03oMgk/h2zfvu5+VneQoyk6oN5amTGS4ntZPYhuhOKfB23ni
	egr2kOeqbmQoofunzhVmFlGPiAqQ3lSgfuYw6xLfUDVoWGHiHGmK3MMB8xeCksvl
	G99dPvJYtz77L8POjgD7OBpB+OO4ALtGbkitPH+G4JQLbKHgdpYdzefo+NCaOdGD
	/0dEfdqc1NU/WymZe9ihjd/AjvKOHGf3HucmWsS9NJUrWJDyw2DS6Uy5sxaYanYX
	S+h2416UC9Y2yT9MUI4Nw==
X-ME-Sender: <xms:YN5Oav9G_tVPeKCYX8Ol46U_CBpvLergDy0fDQPiGfqTMIMy7xuIyg>
    <xme:YN5OatSRz1g1LTCDUwgoMGTlhn0BI3DDbn_oRcihVgVK-7fISG9__kJFVEd9t2xGE
    x_0hGVoAwLqC0hsQJqBnhb3HjgJiuVZWRUaE4PkK0lbsx6FYcA>
X-ME-Received: <xmr:YN5OasQlYNu6KXnReH9UJktrpITpHY2Z9zMGhN85Z_llwlyvZHymZLOappg>
X-ME-Proxy-Cause: dmFkZTFk66Tr4PZ1RpoJ2yXE2BF2dN68DoODhH+NgpAxw/zva66bqnWHxfSCYuZR+JyEHm
    flF4GbtFnt8bLxJgMnCN6nvmLvaELOEEjMTryq/TRPaGVQdVxjfdjdFdCfsRXGWtaOQPLj
    vzEmEj9I22CJ/UbhUOEd0yW0tDBXwpjK6Sjvuhsts1Pkn254JZLVYCPz1f8XdQrd79LQIU
    jMi262mhG4so7FIUMKsu10QFKFjSCejJBkuIBhOwSViFF1N3o2bNmiSB1Bnpugtb4NhQFP
    ywoiS6dLdLko78Xju90QoFu5L4u4/khGmtDl8gm0o7afMlgiE6wqGIDcb9T/cN8hCOZMN+
    klUlokKrO1eXlzIGM+dZCqF7LkHUM2zQe9EhAjZdi8jkGdwtRdI45zqOlpSdntVX5tKoZJ
    aXcMsDJrtnV/ID+W8lk7LJm1cXahvE5GrbsAkJaJgFzrwcgNsS0piX7WTxCww0geC5Je08
    43hgeYffcSimKZLxGF8lGiU25q9TRAO9th2uKO+J23elkQp9H2hT5nUEyRQ4dQDTCZZlQ4
    Vm1jdkTTYmdwxupDKDmxVqdlkLUuUzj2nX2d9nx/AjYLClkrvFW98fDptrSH0Ruo2CUCn9
    gawNtb8hQKRhiFVhLGBULKQz9+lSTeeNaBM6SvXdOx/F7KmS9T6yK6hL4IWg
X-ME-Proxy: <xmx:YN5Oah7-jL2NoMkn1CTn6eYx4djiF_Aw7-cAPupSH98xkujHjCCeeg>
    <xmx:YN5OapU0mHKMVXRNwjrfp_4dkwkV8NhpwsWB7Tzf116IHfxBTwztwA>
    <xmx:YN5Oav-_0otAPFbbUlSFU4BmBwQcmnxLRHGm5B5FCcE6URYPxIRpPA>
    <xmx:YN5Oahr7Pn9iyVTaUOi7DlyQQEmu8fjUkXSkYt29SwYqhqA4E7vQAQ>
    <xmx:YN5Oavy-ixxTAUH_3MuM4pkLVYbcG5UzVzi-XbIvNkXeh-MoGvpQKPHf>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 19:33:51 -0400 (EDT)
Date: Wed, 8 Jul 2026 17:31:28 -0600
From: Alex Williamson <alex@shazbot.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v19 11/18] vfio/pci: Virtualize PCIe TPH capability
 registers
Message-ID: <20260708173128.687525c6@shazbot.org>
In-Reply-To: <20260702124224.57168-12-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
	<20260702124224.57168-12-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 20:42:17 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Implement virtualization and policy masking for PCIe TPH extended
> capability:
> - Split TPH config space permissions: keep header read-only, mark
>   TPH_CTRL and ST-table entries virtually writable.
> - Adjust virtual TPH capability bits according to hardware capability
>   and tph_policy, hiding unsupported modes.
> - Silently discard all write operations.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  drivers/vfio/pci/vfio_pci_config.c | 72 ++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 5c6ab172df6c..06d7b2fbf866 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1086,6 +1086,73 @@ static int __init init_pci_ext_cap_pwr_perm(struct perm_bits *perm)
>  	return 0;
>  }
>  
> +/* Permissions for TPH extended capability */
> +static int __init init_pci_ext_cap_tph_perm(struct perm_bits *perm)
> +{
> +	int i;
> +
> +	if (alloc_perm_bits(perm, pci_ext_cap_length[PCI_EXT_CAP_ID_TPH]))
> +		return -ENOMEM;
> +
> +	p_setd(perm, 0, ALL_VIRT, NO_WRITE);
> +	p_setd(perm, PCI_TPH_CAP, ALL_VIRT, NO_WRITE);
> +
> +	p_setd(perm, PCI_TPH_CTRL, ALL_VIRT,
> +	       PCI_TPH_CTRL_MODE_SEL_MASK | PCI_TPH_CTRL_REQ_EN_MASK);

This makes the control bits virtualized, writable with no backing
support yet.

> +
> +	/* Per PCI specification: There is an upper limit of 64 entries
> +	 * when the ST table is located in the TPH Requester Extended
> +	 * Capability structure.
> +	 * And the pci_ext_cap_length[PCI_EXT_CAP_ID_TPH] is 0xFF, so the
> +	 * following operation is fine.
> +	 */

Wrong multi-line comment style.  Also 0xFF for cap length doesn't
really explain why this is fine.  You are however highlighting that the
above perm bits alloc of size 0xFF is not fine.

> +	for (i = 0; i < 64; i++)
> +		p_setw(perm, PCI_TPH_BASE_SIZEOF + i * sizeof(u16),
> +		       (u16)ALL_VIRT, (u16)ALL_WRITE);
> +
> +	return 0;
> +}
> +
> +static void vfio_tph_capability_adjust(struct vfio_pci_core_device *vdev,
> +				       int pos)

Precedent is vfio_update_tph_vconfig_bytes(...)

> +{
> +	__le32 *vptr = (__le32 *)&vdev->vconfig[pos + PCI_TPH_CAP];
> +	struct pci_dev *pdev = vdev->pdev;
> +	u32 val = le32_to_cpu(*vptr);
> +	bool need_adjust = false;

Just write it back unconditionally, not worth tracking.

However, any modification to the capability needs to be gated by the
device feature opt-in, so this might be better handled in a readfn
rather than managed through permission bits.

> +
> +	if (!pcie_tph_supported(pdev, true)) {
> +		/* Remove extend TPH if root-port don't support */
> +		val &= ~PCI_TPH_CAP_EXT_TPH;
> +		need_adjust = true;
> +	}
> +
> +	if (vdev->tph_policy == VFIO_PCI_TPH_POLICY_NO_ST) {
> +		/* Report only No-ST mode supported */
> +		val &= ~(PCI_TPH_CAP_ST_IV | PCI_TPH_CAP_ST_DS |
> +			 PCI_TPH_CAP_LOC_MASK | PCI_TPH_CAP_ST_MASK);
> +		need_adjust = true;
> +	} else if (vdev->tph_policy == VFIO_PCI_TPH_POLICY_IV_ST) {
> +		/* Report only No-ST and IV modes supported */
> +		val &= ~PCI_TPH_CAP_ST_DS;
> +		/* Remove ST location and size if dev don't support IV mode */

s/don't/doesn't/

> +		if (!(val & PCI_TPH_CAP_ST_IV))
> +			val &= ~(PCI_TPH_CAP_LOC_MASK | PCI_TPH_CAP_ST_MASK);
> +		need_adjust = true;
> +	}
> +
> +	if (need_adjust)
> +		*vptr = cpu_to_le32(val);
> +}
> +
> +static int vfio_find_cap_start(struct vfio_pci_core_device *vdev, int pos);

??

> +static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int pos,
> +				 int count, struct perm_bits *perm,
> +				 int offset, __le32 val)
> +{
> +	return count;
> +}
> +
>  /*
>   * Initialize the shared permission tables
>   */
> @@ -1101,6 +1168,7 @@ void vfio_pci_uninit_perm_bits(void)
>  
>  	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
>  	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
> +	free_perm_bits(&ecap_perms[PCI_EXT_CAP_ID_TPH]);
>  }
>  
>  int __init vfio_pci_init_perm_bits(void)
> @@ -1121,6 +1189,8 @@ int __init vfio_pci_init_perm_bits(void)
>  	/* Extended capabilities */
>  	ret |= init_pci_ext_cap_err_perm(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
>  	ret |= init_pci_ext_cap_pwr_perm(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
> +	ret |= init_pci_ext_cap_tph_perm(&ecap_perms[PCI_EXT_CAP_ID_TPH]);
> +	ecap_perms[PCI_EXT_CAP_ID_TPH].writefn = vfio_tph_config_write;
>  	ecap_perms[PCI_EXT_CAP_ID_VNDR].writefn = vfio_raw_config_write;
>  	ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn = vfio_raw_config_write;
>  
> @@ -1704,6 +1774,8 @@ static int vfio_ecap_init(struct vfio_pci_core_device *vdev)
>  		ret = vfio_fill_vconfig_bytes(vdev, epos, len);
>  		if (ret)
>  			return ret;
> +		if (ecap == PCI_EXT_CAP_ID_TPH && !hidden)

Never hidden.  Thanks,

Alex

> +			vfio_tph_capability_adjust(vdev, epos);
>  
>  		/*
>  		 * If we're just using this capability to anchor the list,

