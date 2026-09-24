Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716F239F166
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 05:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229371; cv=none; b=e1Lmd2K+CY8jPcBJ97+7etvREdoMK/xo7xI1rQAqosuoW7GBIe2z+N9PVOGnMln2UcIFpATVtWwAejUNzWV18mnz4k3Ia4+LMChM35aYGt5lPXV4lECz1rpaoG4KcFOQqlddmFfpj5dOmuf1rzLJnIiIIordHqNSx4zMBgoal7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229371; c=relaxed/simple;
	bh=eGqGUlcP20T1TIsP0zazyNbincAzNrCZTZi5UN54M4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d5LPa5vx2QQ7zNdgm8mqVPJfe2hZZz/P6XrHGCVk9LLXGQHhRq3thkO4+gr/rFLxGNxRtsFIKpQXa6fGnbuA8jEWY9ooj1od2D0LKmTBlHImEPQyG0q6cUzrK8zpfVHHr+9wjcrjWkfG1n91TKQ5YzyDsDYf/IDy9mQNUH3RHXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lihtkqBJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lihtkqBJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C277D1F000FF;
	Thu, 24 Sep 2026 05:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790229370;
	bh=Qa1GmC1nX/yqE23LzELxrot2pYN7lYQjtOtuREjHRwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lihtkqBJxBND295371Apbj3kVS6C4t287TWEBDAqZslmM/TlyYsZGY02ZSj8/qeYX
	 ui++kR1OieQrnDHtYsuKahsqd3pMMFmtu3x6goa4lfMWIRcd4RgHfFUdRpC38TY90U
	 KhJ7DEs/cDFcZgB0MT+rW/te/dzfondbxTkuJr6vazqlXlkXmJOMx0aYZL7kHu7rDz
	 k+7LdaMuLzQtEKfhypGCmNgH/U189YL6/lY8k43c/4RHYojAwusCXTlh9p9/ojLPco
	 4R69jerP9o2mcNHvf20SI5D//7p8p85O0RQXHJA7ZTCG+4YyXEpB2/FdtqjUfHUICY
	 4r8jieA8uLihg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Keep an already-configured bridge's bus number
 across a rescan
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jianjun Wang" <jianjun.wang@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260924054115.75574-1-jianjun.wang@linux.alibaba.com>
References: <20260924054115.75574-1-jianjun.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:56:09 +0000
Message-Id: <20260924055609.C277D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pci: bus number overlap and integer underflow in used_buses on res=
can
- [High] pci: bus number leak and integer overflow truncating bus to 0
--

commit 327bbd815883ab87700e0adf3427c36a03e138ab
Author: Jianjun Wang <jianjun.wang@linux.alibaba.com>

PCI: Keep an already-configured bridge's bus number across a rescan

This commit changes pci_scan_bridge_extend() to reuse an existing child bus
number across rescans instead of assigning max + 1. This prevents bridges
from taking over a sibling's child bus and swapping subtrees when they are
re-discovered out of bus-number order.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..6b418d20cde34 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1513,6 +1513,18 @@ static int pci_scan_bridge_extend(struct pci_bus *=
bus, struct pci_dev *dev,
>  		fixed_buses =3D pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
>  		if (fixed_buses)
>  			next_busnr =3D fixed_sec;
> +		else if (dev->subordinate)

[Severity: High]
Does preserving the existing bus number here cause a regression where bus
numbers permanently leak during repeated hot-removes and rescans?

If preserved bridges are never renumbered down to close gaps, and new
bridges are always assigned max + 1, max will only go up and eventually
exceed 255. When next_busnr hits 256, does pci_find_bus() implicitly
truncate it to 0 (due to pci_do_find_bus()'s unsigned char argument), findi=
ng
the root bus instead?

If child evaluates to the root bus, it could misconfigure the new bridge
with root bus parameters later in pci_scan_bridge_extend():

	buses =3D (buses & PCI_SEC_LATENCY_TIMER_MASK) |
		FIELD_PREP(PCI_PRIMARY_BUS_MASK, child->primary) |
		FIELD_PREP(PCI_SECONDARY_BUS_MASK, child->busn_res.start) |
		FIELD_PREP(PCI_SUBORDINATE_BUS_MASK, child->busn_res.end);

> +			/*
> +			 * This bridge already has a child bus, so we are
> +			 * rescanning an already-configured bridge (e.g. after a
> +			 * sibling bridge was removed and the bus was rescanned).
> +			 * Keep its existing bus number instead of renumbering
> +			 * it: a re-added sibling is appended to the tail of the
> +			 * device list, so handing out max + 1 here would let that
> +			 * later sibling steal this bridge's number and swap the
> +			 * two subtrees.
> +			 */
> +			next_busnr =3D dev->subordinate->busn_res.start;

[Severity: High]
If a hotplug event expands a preceding bridge's subordinate range during
rescan, the global max bus number increases. Does this unconditionally reuse
the old subordinate->busn_res.start as next_busnr, which may now be less
than max?

This regression would cause the local max returned by
pci_scan_bridge_extend() to shrink. In the caller
pci_scan_child_bus_extend(), can max - cmax then severely underflow?

	if (max - cmax > 1)
		used_buses +=3D max - cmax - 1;

This underflow could break hotplug bus distribution and corrupt the PCI
topology.

>  		else
>  			next_busnr =3D max + 1;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924054115.7557=
4-1-jianjun.wang@linux.alibaba.com?part=3D1
