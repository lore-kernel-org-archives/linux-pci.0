Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284DA44F56A
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790753040; cv=none; b=sh1m8msK4ITjBqQCCqv+MJl0EOQJgV2CbS0oKhWofc9HSGw2A5E9XDGu2D0jqtueBt7tLmpvK0dnfoDn5H3kkdsL9s/gIqZMsBzEDQ1/Q2OyPfhDSXIlEGiCtT5khmKuBwTnL6G1XUplml4X8bRpIAfkQAESc6It0Uf6sybsh4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790753040; c=relaxed/simple;
	bh=1FSWjft/uXlGWNDezC0MsIeZbpIR9JP16SGbpf2VtpA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TA1XeOn3/OLIqs+tqnuAwQCyyXdh5wyBtV6azZBJd7ZCQ1Wq5aWfe5k+eY6grcfz6tS6n0mUwO3wh56cJRaMIddts2NSrjSK1qQok35QXdlzTmCEejCn7z4LXFg1ED9vRjvKRB8n61uga6GEwNEBtGT7J3ciW+cXzuxDdM62iWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zv5RbXsv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zv5RbXsv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FD81F000FF;
	Wed, 30 Sep 2026 07:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790753039;
	bh=6rIcqJ8cSOFqQ0OT+F6xzfW1F6hVQnxC5cz+72zw7CA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zv5RbXsvtPpQ8qoC3qfr4IUlLoS90ZQnMOgmq7DbSK+PRNUVi786GxtueAzmRVuu8
	 wHCO0kl2gSVucUTAsiiFTVsowMmil7po3qmPRww5KsnWusiX9I2b/lUE1hoFjCjuDX
	 dRDs+17G5zWhIDZoJBv9wBuJf9cWYnizwlsl2Os1qW6qeMF5tNCXbQdxbiKmR8a4nH
	 aT+mgx7ExS4qCnDjzMm3Hy9/oWdffYee/fBALpVfnbn6CbYNKAdfPBkdlCkzeP9Kcx
	 OSWSnhTao5PPf5Mb3xRbOQ1SvtbkM9y1mz9wWCGG21Udwx2dDO2jsUMzYozKPVVOK2
	 RLGdnM7m64i9A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] x86/PCI: Use the only online node for root buses
 with no _PXM
Reply-To: sashiko-reviews@lists.linux.dev
To: Ferran <ferran.duarri@me.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <33c0b32e-11eb-4e3e-bb59-e349289c498b@me.com>
References: <33c0b32e-11eb-4e3e-bb59-e349289c498b@me.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 07:23:58 +0000
Message-Id: <20260930072358.C5FD81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] x86/pci: num_online_nodes() check breaks NUMA locality for offli=
ne nodes
- [Low] x86/pci: faking NUMA locality to suppress out-of-tree module warnin=
gs
--

commit 8ab24ac3406319565e845067f7c37f528237c0fa
Author: Ferran <ferran.duarri@me.com>

x86/PCI: Use the only online node for root buses with no _PXM

When a host bridge has no _PXM and the Northbridge fallback finds
nothing either, pci_acpi_root_get_node() leaves every root bus at
NUMA_NO_NODE. This patch forces the node to first_online_node when
there is exactly one node online.

> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 7cd5388edc756..cf7f9b879b42f 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -463,6 +463,13 @@ static int pci_acpi_root_get_node(struct acpi_pci_ro=
ot *root)
>  	if (node !=3D NUMA_NO_NODE && !node_online(node))
>  		node =3D NUMA_NO_NODE;
> =20
> +	/*
> +	 * One online node means there's only one possible answer, so don't
> +	 * leave the bus at NUMA_NO_NODE just because firmware didn't say.
> +	 */
> +	if (node =3D=3D NUMA_NO_NODE && num_online_nodes() =3D=3D 1)
> +		node =3D first_online_node;

[Severity: Medium]
Could this num_online_nodes() check incorrectly bind a root bus on an offli=
ne
node to the first online node?

During system boot or PCI enumeration on multi-node setups where a subset of
nodes are temporarily offline, num_online_nodes() could evaluate to 1. This
overrides the NUMA_NO_NODE state with first_online_node.

When the offline node is brought online, would this permanent binding cause
cross-node memory allocations and latency?

Would checking num_possible_nodes() =3D=3D 1 or nr_node_ids =3D=3D 1 be saf=
er here
to avoid corrupting topology on hotplug systems?

[Severity: Low]
Is it appropriate to advertise node 0 instead of NUMA_NO_NODE for root buses
lacking _PXM?

The commit message states this change is to accommodate the out-of-tree
nvidia-fs driver. NUMA_NO_NODE (-1) is the architecturally correct state wh=
en
hardware/ACPI lacks proximity data, and core subsystems handle it gracefull=
y.

Should hardware topology be faked in the core kernel to work around an
out-of-tree driver?

> +
>  	return node;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/33c0b32e-11eb-4e3e-=
bb59-e349289c498b@me.com?part=3D1
