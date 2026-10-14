Received: from mail-m1973184.qiye.163.com (mail-m1973184.qiye.163.com [220.197.31.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CAF306746
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 02:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791944797; cv=none; b=FnVyGdRJn1tUqPRi90gn0Yb/a8oPn46xZEpxN7myV9/NJ6kV3v31vXJvFfeLF2g2mbknFScvsHNeFXiEO0nvgvoOJDqE/KduHyGHk5vhX3NWNLs6W5Brz3EIq6RJap4+USJyZVBRfKoojjkf4H/JCsiQ9YYO9abya/LB5VbvIj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791944797; c=relaxed/simple;
	bh=ZQ1uG+WQuQuLSdxk43cUMWe9MlBCod04WSmX2sPQEM4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UmYXPLm5FZwDI8PHiha0eiCFb0snvPuhU2WSiXMqqdd80Zy6Bvrv5yl2nMbzOs4akMYzURf4qzBpycNmbUJ+nqhwODUX+YqDs1GicOFRZZ6lmOijOsNch3X6FVQbHR2usUbOBLOpkwqESpGat5m+DsET56PHQ4GAEJk+OBduvg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=dGP4IHIz; arc=none smtp.client-ip=220.197.31.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="dGP4IHIz"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 50f352405;
	Wed, 14 Oct 2026 10:21:07 +0800 (GMT+08:00)
Message-ID: <ae57d0ad-cca8-401f-bbbd-8e5b6f8df674@rock-chips.com>
Date: Wed, 14 Oct 2026 10:21:07 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Update saved Max Read Request Size in
 pcie_set_readrq()
To: Niklas Cassel <cassel@kernel.org>
References: <20261013195307.181647-2-cassel@kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261013195307.181647-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa13836a3e703a4kunm54bb05602f0046
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGE5KVk9CTxpLTk4dThpPSFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=dGP4IHIz11rxWHG5vJzT8jCG1V5cRM+tvvlepdBbQKuMKRiJonXCYlNy6ogHqnPTNAiR+QVNAHZ3D4o4/ts9yQ7TUH7OZTAf07Ab1De/pVQo4Ov/N+zcP91kl5HJ0nV502LZxAbn/8qh8zfjYjl6LAxYS9hsSHnWk0YZpAaKLRs=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=RI3ZA49rS1X8pm9lIV+EIUSQmp37DBPkgZaVlLxQ+0k=;
	h=date:mime-version:subject:message-id:from;

Hi Niklas

在 2026/10/14 星期三 3:53, Niklas Cassel 写道:
> pcie_set_readrq() changes the Max Read Request Size (MRRS) in the Device
> Control register but leaves the copy saved by pci_save_state() alone, so
> a pci_restore_state() that is not preceded by pci_save_state() puts back
> the old value.
> 
> Since commit a2f1e22390ac ("PCI/ERR: Ensure error recoverability at all
> times"), the PCI core saves the state of a device when the device is
> added, before a driver is bound.  The MRRS is usually set after that, by
> the driver or by an enable fixup, some of which limit the MRRS to what
> the hardware can handle, e.g. quirk_brcm_5719_limit_mrrs() and the
> keystone and Loongson fixups.  Unless the state is saved again, a
> pci_restore_state() after a reset, e.g. in the driver's ->slot_reset()
> during error recovery, puts back the MRRS that the device had when it
> was added.
> 
> Update the saved copy of Device Control when pcie_set_readrq() changes
> the MRRS, like pcie_set_mps() does for the Max Payload Size.
> 

Looks good to me,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks.

> Suggested-by: Shawn Lin <shawn.lin@rock-chips.com>
> Assisted-by: LLM
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/pci/pci.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 5b126cd342ca..30a583aeea65 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5944,8 +5944,12 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>   
>   	ret = pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
>   						  PCI_EXP_DEVCTL_READRQ, v);
> +	if (ret)
> +		return pcibios_err_to_errno(ret);
>   
> -	return pcibios_err_to_errno(ret);
> +	pcie_update_saved_devctl(dev, PCI_EXP_DEVCTL_READRQ, v);
> +
> +	return 0;
>   }
>   EXPORT_SYMBOL(pcie_set_readrq);
>   
> 
> base-commit: 581cf67cb6f66eabc6bcd7f61dd64b2559270507

