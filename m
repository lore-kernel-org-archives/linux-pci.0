Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2E117745
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778029267; cv=none; b=q5PTX7ko2J/o3BAS11jhzU9scAAHwk9bQMqmtMUBB/lJK8w23pozkuZb08CZT4Ei/LmyQtjM+BSZmTxdc/X+1k8+eFWED4JL0fPQxJZSbs9zldyj0miDLrHtyt7v3pE+IPKcyS9RhQtKvOHre3gawMcaslKuw4VMPqUhLBjXyDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778029267; c=relaxed/simple;
	bh=oVwPWZ6uZeC/EJrd/PraiCTW4HOIaV/2x4PuFdZC9NQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mtEIwxVYggwfyBbCFGTr0Z5/J4xhe04jQZkZGSP7dUpxG9L7GVZI6TucLCjqIS/fhI9jcTqxHF4yjxHcN49a4BcPj/ocPxyppwfZSPGeKYiKoniLwDXEWoMpBxNhkobWz5d1NzOUmzY8/VxPIErZ8kDJbku12LnlOHwr5yvDjBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJ6sg8pb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJ6sg8pb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AF4C2BCB4;
	Wed,  6 May 2026 01:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778029267;
	bh=oVwPWZ6uZeC/EJrd/PraiCTW4HOIaV/2x4PuFdZC9NQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ZJ6sg8pbpkUQXi/+nm1t38K2aYIU7t3c3VSagQezqBAohx4aZOURbXCeYTKnSADiU
	 fT0I8Ppk18v7G8VLnHU7Zy54pHIjODcivacMQfszHgZXhwry/SlIK6N8IR7YEK/bzn
	 5+xQYb3plXLy/B6qEFi5Nr3cRtukvO7NJVBQNAv8x8yQrRcsmBrKxRDdK7HporuRlk
	 Bxk/tjVmkoeNWEDECBazmWDDv9V8eh2EA6QL/gkCJYdU9MQkhE0RO4KwfO/T1wGALg
	 TlX4WsbyYKZBEA2a7nhRBPqiVoHCbMuJa4RAObPR2LJhre4k5M/rgq1fKb/HgaGT1e
	 Cy6NhGE4SKVxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 10/11] PCI/CXL: Mask/Unmask CXL protocol errors
Reply-To: sashiko@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260505173029.2718246-11-terry.bowman@amd.com>
References: <20260505173029.2718246-11-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 01:01:06 +0000
Message-Id: <20260506010107.48AF4C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Use-After-Free (UAF) in devres teardown callback `cxl_mask_proto_i=
rqs` during device hot-removal.
--

commit f060d6be86b55217cf830c823d56a91f3c54980c
Author: Terry Bowman <terry.bowman@amd.com>

PCI/CXL: Mask/Unmask CXL protocol errors

This commit introduces helpers to mask and unmask CXL protocol errors and
wires them into the success paths of cxl_dport_map_ras() and
devm_cxl_port_ras_setup(). Teardown is handled via devm actions tied to
the CXL port devices.

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index a98ce0f412adb..b45e2b539b5fa 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
[ ... ]
>  static void cxl_dport_map_ras(struct cxl_dport *dport)
>  {
>  	struct cxl_register_map *map =3D &dport->reg_map;
>  	struct device *dev =3D dport->dport_dev;
> =20
> -	if (!map->component_map.ras.valid)
> +	if (!map->component_map.ras.valid) {
>  		dev_dbg(dev, "RAS registers not found\n");
> -	else if (cxl_map_component_regs(map, &dport->regs.component,
> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		return;
> +	}
> +
> +	if (cxl_map_component_regs(map, &dport->regs.component,
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
>  		dev_dbg(dev, "Failed to map RAS capability.\n");
> +		return;
> +	}
> +
> +	cxl_unmask_proto_interrupts(dev);
> +	if (devm_add_action_or_reset(dport_to_host(dport),
> +				     cxl_mask_proto_irqs, dev))
> +		dev_warn(dev, "failed to register CXL proto-irq mask cleanup\n");
>  }

Could this lead to a use-after-free regression during device hot-removal?

The devres action is registered to the host device (dport_to_host(dport)),
which corresponds to the switch's upstream port. However, the data passed
to the callback is dev (dport->dport_dev), which represents the downstream
PCI device.

During a hot-remove of a CXL switch, the PCI core recursively removes and
frees child devices before unbinding and removing the parent device.

Since there doesn't appear to be a reference held on dport->dport_dev when
setting up this devres action, could the downstream PCI device be freed
while the upstream port is still active?

If so, when the upstream port is finally unbound, its devres actions would
execute and call cxl_mask_proto_irqs(dev) with an already-freed downstream
device pointer, resulting in a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505173029.2718=
246-1-terry.bowman@amd.com?part=3D10
