Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF5937E2E2;
	Wed,  8 Jul 2026 23:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553640; cv=none; b=FJroeHmUtzKWZJ2nmdvlhFwOW5fvotCD2/fD36YUIaPLK35P27OiFlMOzPhY80XW/vn/6UKB8RujPQEhoKPP9fP7NDGXtOEDbU+8kmUAQ+yj2+BYTwUX/+SCzsZCPHthD+LK9hmBPfK3vVkqSBgPAiVAFaVZp/mx3o2vWHGiL3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553640; c=relaxed/simple;
	bh=NiMadouX2CuQJ199AwHj1pAOU7HqAEaJmPsQ7ln4GZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ih56xkxnBcpU0xmz59FBBLKJuqTxsuYivJ7JQuO0x/NAn62eho6vFCo9/iAXN7dSo/iU11hvcXo+RMtkkE4A65bC+4yHFCQxGuKfwAX0Ws697w0VXhPWQJdZxQKHmRg1r6Mtv3VXM5JiGN9IVecLAbnVfoW17fEs4yPTIRWvg6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Z9lfqPll; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hry4084H; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Z9lfqPll";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hry4084H"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 676F4140008C;
	Wed,  8 Jul 2026 19:33:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 08 Jul 2026 19:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783553635;
	 x=1783640035; bh=Bbb7u4jKCMgFHMPEauyc1kG+kRMO++/vRnKeUn3WMuI=; b=
	Z9lfqPll1Dn5lZ9XC5AMrgqePXqi5w47NoIF6lW0vga5CEk5lATaAqvq8oG7IOLH
	4fYPiHd7jGXF7KI/RfVk524jfYW3A7ASuQq59aZpDL95Z5eY3dgn6Cd6rf4SkNv5
	td0686ShxQWknh268a4192GVhEML6fI+fAUFsspRpdn2MNEtcIgON4XZGeBVPnaU
	A8gmLF2Y97jFPvnHEgZ5cQhPb4/1uTnlWG24DjWoikis+WwIcVRcRRQ4ggaOuxWs
	2rPRkbqyLTHDQ92o+E8BiRKoDYF0b+FL/PE0zxDXcFnrBhPg+WHFEwcsQj64DSyK
	hGCfYje0z1/XebFzdLOQXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783553635; x=
	1783640035; bh=Bbb7u4jKCMgFHMPEauyc1kG+kRMO++/vRnKeUn3WMuI=; b=H
	ry4084HG2M6O2Us3qRezXISC+KZ7lmcfFF3H9fIjGrVr1WK/KQ8/+3swovXyL98a
	+YEN4jG+S9ptNXqyhHU+ic2kv1nk2Dgh5rpRx13DhtGfR+moIbxZygpI7oy7CeVk
	RXkwbiwu0AyrCO+UK98XO8QrCxmDQTf9uBJmOA2hv2k+FOLnwhqOcPvF4vrP6NcB
	EPj/yY0sfqOUTWF4N9KqRLzqh1Nj0AOjzNh310V94nS8oo6O9gMxR/fRrd4UsDe1
	cd5TI2pcrjWYg7q+V8bwQeU1/w03g4aSFBBy2i7vC8UzikCKos23VXYNLCCXlBvr
	iU/IM1FVUXGBZxy1MK20w==
X-ME-Sender: <xms:Y95OauuSkmhZa4kNh5e3WmuankIcgtnCOT8tVrY8klIv2iM9bg8RXA>
    <xme:Y95OalDtuaP0VylmsgOHltCNk5sR8qw7-H7BVF5IAXz3oo7uXXj-AxRrCllKhDUST
    UbQ3Y-uFVskKqhSB9GB7RRrW221fdqade4__iKmN9P7D9sejxc>
X-ME-Received: <xmr:Y95OapCBqi30ZZDQ75pXafBW1E3IByGqZVhaDZzpRRRWElK4TX6BnhvtzyA>
X-ME-Proxy-Cause: dmFkZTFte9WprN0NxcJROcfQFoEYm4B20MOLRP0aieXCyUdPRt+dzeE8Foerkd28PADnVQ
    Q2OHQyexbOYRg0rBSNOhchlTE+r/ewb9pSaPJb36wKXVH9KGO8zOd2ACKSAkP71biec0nW
    AiYi6lJEcJuY92jHX23f2U7Qb1Dg05BGKYh0T/ac7eHxqJqxnMLvbEkhPqn19+QJmg51Bi
    R83/qttr1Zc3Z5ixxRe9NSaWY+LnlyEwiLj4EwFEmOG4Lb+4OmLVuoXmcpjG+fAzjJwsof
    el3RyOoiWDxEYOLUI/eLpV38WJAiH7Apu9E5tR2zCkAGUlL+0Ao0YBSWPfngxFwsSk3UJF
    NdB9YjlCFcuXBAZP2XMOqyt2VUpVSRyyzmqMaq6qvYDHQNY479z8oyfDQHR8Jr2xryb0cJ
    0ITUYF7gigkwUqJ/VHdnah+cBr1OpjI0CScJSEeJzBiFsnjLbJwymM/3nh7F1OqWHmkD+X
    L/KIOcM5dmukv1Ig+D8yzDO12a9wfj3ZHNgfcONSEbH/2R5ZEHwrHHXYnbWCVRirzxf8Xc
    PBf89wgzcKLfwmgp5yrGhIwMTP/IrhGjv+OzPnqwEgc+b2XGOONgwm7bCBSyb8NUIz+tNU
    h4EZ9G+JSyo5+audFAF13kIwChXEZO/nLZSl8NWJOaFmbiRnWx1mgvLkyGRA
X-ME-Proxy: <xmx:Y95Oavpbvx0V0-R_0N848Cn2omrHMq4WOGFvKZvPgH0LHNWWlLMtWQ>
    <xmx:Y95OakHTLffGOWsi3RQKatf_wb2mMXL9Ku0xM1z6ElXK2TFPcU6gvg>
    <xmx:Y95OajvXpdrOYJZgOQ_mQQ_hxs9A0KqpzMY7qeST2TyYKeYl-yAUFg>
    <xmx:Y95OaqbHTynFnqAoSoq9EuzvlOrALlUlQAWF1GnL3lBYTwdY_w2_Sw>
    <xmx:Y95Oahzpjiy7hpDcnANQSva8TYu1oxI-6U6H2jkzS_GkMnbta7vfo5Bp>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 19:33:54 -0400 (EDT)
Date: Wed, 8 Jul 2026 17:33:25 -0600
From: Alex Williamson <alex@shazbot.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v19 04/18] PCI/TPH: Refactor pcie_enable_tph & add
 explicit requester variant
Message-ID: <20260708173325.599bc892@shazbot.org>
In-Reply-To: <20260702124224.57168-5-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
	<20260702124224.57168-5-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 20:42:10 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Refactor pcie_enable_tph implementation: extract core logic into static
> internal enable_tph() helper accepting explicit requester type.
> 
> - Preserve original pcie_enable_tph() unchanged as auto wrapper; it
>   auto-selects EXT/standard TPH requester per device capability, existing
>   bnxt/mlx5 callers require zero modification.
> - Add exported pcie_enable_tph_explicit() with bool 'extended' parameter
>   for explicit STD/EXT selection, used by upcoming VFIO TPH support.
> 
> Input validation for EXT_TPH availability is retained inside helper to
> reject invalid explicit EXT request if hardware does not support extended
> requester.

I'll leave final judgment on the APi to Bjorn, but I'd tend towards
defining tph_mode and tph_req_type as enums, store the max available
tph_req_type on the pci_dev.tph_max_type, and have the base function
take exactly those enums as args, get rid of the bool wrapper.  Then the
existing function just becomes:

int pcie_enable_tph(struct pci_dev *pdev, int mode)
{
	return pcie_enable_tph_type(pdev, (enum tph_mode)mode,
				    pdev->tph_max_type);
}

(Given the 2 existing callers, this could also be easily changed to
take enum tph_mode as the arg as well)

This might also disambiguate how this series conflates tph_cap to mean
TPH capability is not present or not available to instead retain
tph_cap as simply the offset of the capability and (tph_max_type ==
PCI_TPH_REQ_DISABLE) means it's not available.

Validation in the base function is also simplified:

	if (tph_req_type == PCI_TPH_REQ_DISABLE ||
	    tph_req_type > pdev->tph_max_type)
		return -EINVAL;

Same comment for patch 5, expose the base function as "_type" with the
enum tph_req_type (the precedent is already there for enum
tph_mem_type).  The wrapper for the existing interface is the same as
you have, the base function adds the same test as above, modulo
s/tph_max_type/tph_req_type/.  Thanks,

Alex
 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  drivers/pci/tph.c       | 68 +++++++++++++++++++++++++++++------------
>  include/linux/pci-tph.h |  4 +++
>  2 files changed, 52 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 4097787ea98a..c22eb7f4b0bd 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -363,23 +363,7 @@ void pcie_disable_tph(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL(pcie_disable_tph);
>  
> -/**
> - * pcie_enable_tph - Enable TPH support for device using a specific ST mode
> - * @pdev: PCI device
> - * @mode: ST mode to enable. Current supported modes include:
> - *
> - *   - PCI_TPH_ST_NS_MODE: NO ST Mode
> - *   - PCI_TPH_ST_IV_MODE: Interrupt Vector Mode
> - *   - PCI_TPH_ST_DS_MODE: Device Specific Mode
> - *
> - * Check whether the mode is actually supported by the device before enabling
> - * and return an error if not. Additionally determine what types of requests,
> - * TPH or extended TPH, can be issued by the device based on its TPH requester
> - * capability and the Root Port's completer capability.
> - *
> - * Return: 0 on success, otherwise negative value (-errno)
> - */
> -int pcie_enable_tph(struct pci_dev *pdev, int mode)
> +static int enable_tph(struct pci_dev *pdev, int mode, u8 req_type)
>  {
>  	u32 reg;
>  	u8 dev_modes;
> @@ -400,10 +384,11 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  	if (!((1 << mode) & dev_modes))
>  		return -EINVAL;
>  
> -	pdev->tph_mode = mode;
> +	if (req_type == PCI_TPH_REQ_EXT_TPH && !pdev->tph_ext_support)
> +		return -EINVAL;
>  
> -	pdev->tph_req_type = pdev->tph_ext_support ? PCI_TPH_REQ_EXT_TPH :
> -						     PCI_TPH_REQ_TPH_ONLY;
> +	pdev->tph_mode = mode;
> +	pdev->tph_req_type = req_type;
>  
>  	/* Write them into TPH control register */
>  	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);
> @@ -417,8 +402,51 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  
>  	return 0;
>  }
> +
> +/**
> + * pcie_enable_tph - Enable TPH support for device using a specific ST mode
> + * @pdev: PCI device
> + * @mode: ST mode to enable. Current supported modes include:
> + *
> + *   - PCI_TPH_ST_NS_MODE: NO ST Mode
> + *   - PCI_TPH_ST_IV_MODE: Interrupt Vector Mode
> + *   - PCI_TPH_ST_DS_MODE: Device Specific Mode
> + *
> + * Check whether the mode is actually supported by the device before enabling
> + * and return an error if not. Additionally determine what types of requests,
> + * TPH or extended TPH, can be issued by the device based on its TPH requester
> + * capability and the Root Port's completer capability.
> + *
> + * Return: 0 on success, otherwise negative value (-errno)
> + */
> +int pcie_enable_tph(struct pci_dev *pdev, int mode)
> +{
> +	u8 req_type = pdev->tph_ext_support ? PCI_TPH_REQ_EXT_TPH :
> +					      PCI_TPH_REQ_TPH_ONLY;
> +	return enable_tph(pdev, mode, req_type);
> +}
>  EXPORT_SYMBOL(pcie_enable_tph);
>  
> +/**
> + * pcie_enable_tph_explicit - Enable TPH with explicit requester selection
> + * @pdev: PCI device to operate
> + * @mode: ST table operating mode (NS/IV/DS)
> + * @extended: true = EXT_TPH, false = standard TPH only
> + *
> + * Unlike auto-detecting pcie_enable_tph(), caller selects requester type
> + * manually instead of hardware auto-selection. Rejects EXT_TPH request
> + * if device lacks extended requester capability.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int pcie_enable_tph_explicit(struct pci_dev *pdev, int mode, bool extended)
> +{
> +	u8 req_type = extended ? PCI_TPH_REQ_EXT_TPH : PCI_TPH_REQ_TPH_ONLY;
> +
> +	return enable_tph(pdev, mode, req_type);
> +}
> +EXPORT_SYMBOL(pcie_enable_tph_explicit);
> +
>  void pci_restore_tph_state(struct pci_dev *pdev)
>  {
>  	struct pci_cap_saved_state *save_state;
> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index 6f02b020d7d7..ca0faa98afac 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
> @@ -29,6 +29,7 @@ int pcie_tph_get_cpu_st(struct pci_dev *dev,
>  			unsigned int cpu, u16 *tag);
>  void pcie_disable_tph(struct pci_dev *pdev);
>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
> +int pcie_enable_tph_explicit(struct pci_dev *pdev, int mode, bool extended);
>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
>  #else
> @@ -42,6 +43,9 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  { return -EINVAL; }
> +static inline int pcie_enable_tph_explicit(struct pci_dev *pdev, int mode,
> +					   bool extended)
> +{ return -EINVAL; }
>  static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
>  { return 0; }
>  static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)

