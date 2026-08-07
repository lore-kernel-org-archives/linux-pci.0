Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708893C3F5E;
	Fri,  7 Aug 2026 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786132569; cv=none; b=hcdIPGCNDf8EkUDWpfv6HACYur6/saEdCyM/ls/V1uC++O1YTG7L1dt8UbSni8exvXy406blkdPkBzldu+iz6N/nFMqIE1j1Oa5TedBt/U+4PN1ufY7ksJqonBTqg45YQWhAb9TZ4RtBdpYmFpZf6hXlJwK9cjFkX9M6wCVVY9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786132569; c=relaxed/simple;
	bh=CkjDnuSXVwc7EXnVEscgirCN9iNwE99I5OG9wnZye/k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=syURXSEI1TqtDSopeuj2rPm3or2JhbO/CzyTRGmYSYlGRLQQPB+w+vYQOaxu5eLmsD6ipcPZar86T6YnEnu1bREtJ8GVeb7XfljH7Tg8s73OgjlONrNF28md9QvPDfhQ8SqhEq0uC7hjaJu0pG15VmBfqC/OCuZuin0VJAGqhkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hW/0JJ+i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hW/0JJ+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277C31F000E9;
	Fri,  7 Aug 2026 19:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786132564;
	bh=KHufeByWmbGKxJ7tRQ8QahvLpGoD+5vCP0lt+wcU22Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hW/0JJ+iMdKwpX7mHkEoDYrDJMhPDs0N6T2Nohce0iTXg4cAQD70wtCD9XXbG06UB
	 vZhvsgecyrmnYUdgF98hSKFGpVj2z1ENeXnyNE5aLTyqUvh87G1PMt1h9lWLbUoLV1
	 E7MZd3YZecnuUMk3xJBHFi2MSeOvnu/YDyIR6+hMIOcnB+Gz5XNe81POpX7EqSC1ll
	 uiP1DfPVnzD6sFLV5W8vUrwXzRtVaxoMz1iiiuyYjLV1JKSSO8BZ4Kx8Vh9rDs7xYd
	 lu440YGh7CnlhIAWgpcttTCp31e/zcHqpnCG6bl8qjlSzPc0kTEaQhdz8OrZ85fRAz
	 NHtDp1EtfdFWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] PCI: of: don't zero flags in
 of_pci_get_addr_flags()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260807194100.455599-3-elder@riscstar.com>
References: <20260807194100.455599-1-elder@riscstar.com>
 <20260807194100.455599-3-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 19:56:03 +0000
Message-Id: <20260807195604.277C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The function `of_pci_is_range_resource()` incorrectly evaluates `I=
ORESOURCE_MEM_64` using the `resource_type()` macro. The `resource_type(res=
)` macro applies the `IORESOURCE_TYPE_BITS` mask (`0x1f00`). Because `IORES=
OURCE_MEM_64` is defined as `0x00100000`, it falls completely outside this =
mask. Consequently, `resource_type(res) & IORESOURCE_MEM_64` evaluates to a=
 constant 0.

As a result, the condition `!(resource_type(res) & IORESOURCE_MEM_64)` is u=
nconditionally `true`. This simplifies the entire filter condition to `!(re=
source_type(res) & IORESOURCE_MEM)`. Any resource that does not have the `I=
ORESOURCE_MEM` bit set=E2=80=94such as `IORESOURCE_IO` (`0x100`)=E2=80=94wi=
ll cause the condition to evaluate to true, making the function return `fal=
se`.

This logic flaw inadvertently filters out `IORESOURCE_IO` resources entirel=
y, which prevents PCI host bridges from exposing IO space mappings via the =
dynamically generated device tree `ranges` property. Furthermore, if a 64-b=
it memory resource were defined with `IORESOURCE_MEM_64` but without `IORES=
OURCE_MEM`, it would also be incorrectly rejected.
--

--- Patch [2]: [PATCH 2/4] PCI: of: don't zero flags in of_pci_get_addr_fla=
gs() ---
commit d6dba8ef5457a1efb23f2b68f270883ef856bbdb
Author: Alex Elder <elder@riscstar.com>

PCI: of: don't zero flags in of_pci_get_addr_flags()

The flags variable whose address is passed to of_pci_get_addr_flags()
is zeroed before assigning a value to it. Skip the zeroing and just
assign it instead.

> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index 505226b876c56..22fea1905a080 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c

[ ... ]

> static bool of_pci_is_range_resource(const struct resource *res, u32 *fla=
gs)
> {
[ ... ]
> 	if (!(resource_type(res) & IORESOURCE_MEM) &&
> 	    !(resource_type(res) & IORESOURCE_MEM_64))
> 		return false;

[Severity: High]
This is a pre-existing issue, but does this correctly evaluate
IORESOURCE_MEM_64?

The resource_type() macro applies the IORESOURCE_TYPE_BITS mask (0x1f00).
Because IORESOURCE_MEM_64 is defined as 0x00100000, it falls outside this
mask, causing resource_type(res) & IORESOURCE_MEM_64 to evaluate to a
constant 0.

This makes the condition !(resource_type(res) & IORESOURCE_MEM_64)
unconditionally true. This simplifies the logic to reject any resource
that does not have the IORESOURCE_MEM bit set, such as IORESOURCE_IO.

Could this inadvertently filter out IORESOURCE_IO resources entirely when
called from of_pci_host_bridge_prop_ranges()?

drivers/pci/of_property.c:of_pci_host_bridge_prop_ranges() {
	...
	resource_list_for_each_entry(window, &bridge->windows) {
		res =3D window->res;
		if (!of_pci_is_range_resource(res, &flags))
			continue;
	...
}

If IO windows are wrongly skipped here, will dynamically created PCI host
bridge device tree nodes lack IO mappings in their ranges property?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807194100.4555=
99-1-elder@riscstar.com?part=3D2
