Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29E72E091B
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778099958; cv=none; b=KIgpauv/p+bQfjQ1+vHKupEfbCNOm5T3/DZGAzRKrASY3E6APrb5cS4rPzxHbrPan0DWFOzRq2EGquO7YTQVV8b9YJDofyFkDMvfizrZpVkpXwpwmv1K/IpN5w0/b66SikZPT7Nzpe0td1O0EXeySVMPKlGwi63YfRgnhZcjqNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778099958; c=relaxed/simple;
	bh=i5B0aGvhK9WAWBKdfB7LGsiLJh0U0Uoi5jcTQf6H9fk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XQQ3ZjHj6bKij79OOid4UmtJQ9D2vJ1LiEWC/NGtHPC81T1wP8TnLZd8WaAqwrJkH9r3LK34rGHuPcXBBSKXWoZ3jxrsWfoGqghR3OEe1oL88ps8uaMgWxFD5y/TvYU1ePp8L4waDlXKQUcMb05nS7trY5vNGQR1jXedtxMiyhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf3GFoIG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf3GFoIG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1B4C2BCB0;
	Wed,  6 May 2026 20:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778099958;
	bh=i5B0aGvhK9WAWBKdfB7LGsiLJh0U0Uoi5jcTQf6H9fk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nf3GFoIGQ41WE07fPFa7E7p73XTWR7Ob6JS7Wq1KoGkduWtDhgs2TAMJfLPC19WKi
	 tcsB31p2O6x4CltFX7I/U+hwsVlt+7kUWCHbx7OQT+R9VREutyZl5GfVekDCelh7eH
	 ZC+Fne8b3pcBVy4bagemPoiQzyDZsA+0WliJ34Rl9M2N4QoJBo7NyK9pvZ/Z2mM30p
	 960RsbMbFd1XULJn5/D2pKB9DsT/hfe05hqd/shzRjJydQ0EY1r4/jgw6ghLlwYwYt
	 bDeWO0Tk7bJZruml3j+xYAYaBmMHUt+rAKSQ80A6SkNcdichZ7dW/35UOTX20oCZ0A
	 7D2TFoV/oUBhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/8] PCI: cadence: LGA: Add max_link_speed field and
 100 ms delay after link training
Reply-To: sashiko@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260506152346.166056-3-18255117159@163.com>
References: <20260506152346.166056-3-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 20:39:17 +0000
Message-Id: <20260506203918.7F1B4C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The generic PCIe compliance fix is silently bypassed for several C=
adence host controllers due to uninitialized `max_link_speed`.
--

commit c86b1055b143ccb331408ed591540753d03613ac
Author: Hans Zhang <18255117159@163.com>

PCI: cadence: LGA: Add max_link_speed field and 100 ms delay after link tra=
ining

This commit adds a mandatory 100 ms delay after link training completes for
speeds > 5.0 GT/s in the Cadence PCIe host controller to comply with PCIe
r6.0. It adds a max_link_speed field to track the speed and triggers the
delay if this speed is greater than 2.

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c b/=
drivers/pci/controller/cadence/pcie-cadence-host-common.c
> index 2b0211870f02a..51376f69d0076 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
[ ... ]
> @@ -115,6 +116,9 @@ int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc,
>  	if (!ret && rc->quirk_retrain_flag)
>  		ret =3D cdns_pcie_retrain(pcie, pcie_link_up);
> =20
> +	if (!ret)
> +		pcie_wait_after_link_train(pcie->max_link_speed);

Since struct cdns_pcie is zero-initialized by glue drivers, max_link_speed
will default to 0 for drivers that are not updated by this series (such as
pcie-sg2042.c, pci-sky1.c, and pcie-cadence-plat.c).

If max_link_speed is 0, the condition max_link_speed > 2 in
pcie_wait_after_link_train() will evaluate to false, meaning the mandatory
100ms compliance delay will be bypassed for those platforms.

Could the core driver dynamically read the hardware capability (for example,
from cdns_pcie_readl(pcie, ... + PCI_EXP_LNKCAP) & PCI_EXP_LNKCAP_SLS) when
max_link_speed is 0 to ensure compliance across all Cadence host platforms?

> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(cdns_pcie_host_start_link);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506152346.1660=
56-1-18255117159@163.com?part=3D2
