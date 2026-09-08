Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E2652FE4D;
	Tue,  8 Sep 2026 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903963; cv=none; b=g+heL2BGUpR9wxH9yKJxeN38vG/2M5o0K0SaT1ovo7zq+5UFzKKTg9Z/CdzdbxJwsdahWx+22s6/Q0wh4EfnA80vdQdZCY1uA2U0VQLBDgXYnJOqv8mYPVOAu5HXh4kEZgmxoWgH73LLpDAplZP3rGPOVKRxkYzIyCeT98yNR7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903963; c=relaxed/simple;
	bh=UIa8mbHyUivu0F/3h54gGhDXvwSzyeaU3A5Rx/2tRWA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b5O5bRiLpkzKx6m6tqvgF5O54zWrDwSYGCW0DqGve6sojBal8X5TFfuur75e83cipNLUFdLZJ9lIo6J2+Rsu1y+R4V2L9dY+Fi8xNeGwOjMVc1+nlV7gcFsIkKbJCKZ0qNX4hkEn0Q5DTP1B9sklEBe3iKABD1kcIUBvnreI0hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqXTxJIB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqXTxJIB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7716D1F00A3A;
	Tue,  8 Sep 2026 21:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788903961;
	bh=lorCGV5jaTN1EMy6qq1N5o2tpQM08Rcf7TwI8v8NQ7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bqXTxJIB8cp/PBlkc5AHy9w4FVNhJNZ6F7mlPA8gbXhh0/kIL9oI0lXR5netUS0In
	 oXI6T4ojOyd2VHmZi0aGpzb5IhGCc/uaj7upmqaZNNU80Cl8yU3Q6gbQz43kWzhGD/
	 vjTtZipFz98y667TracDB7CC1KWnDiY9lR6vVtQjRMeuUFwMfcr0OxtW7lKyAryyaO
	 UeOkuFUXm0rPHu8EkvvE/Ry1ocEGfPPNZDN0XJEY6eHgyks/aa6E+g5PNhQa7Ww3nt
	 i8zd1qou7P59S8In2oJJzLjLC9K5nmLJUvdp9VmyrsL9Lc76D023TPAP1Va4oyJk+I
	 7Yh/Jcqs5SMyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] PCI: of: drop the reg_num argument to
 of_pci_set_address()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260908213459.2519059-3-elder@riscstar.com>
References: <20260908213459.2519059-1-elder@riscstar.com>
 <20260908213459.2519059-3-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 21:46:01 +0000
Message-Id: <20260908214601.7716D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Leaked OF node reference counts in of_pci_prop_intr_map()
--

commit b3af32f45eed6da355a4a96246bdedb364fe0855
Author: Alex Elder <elder@riscstar.com>

PCI: of: drop the reg_num argument to of_pci_set_address()

The reg_num argument passed to of_pci_set_address() is always zero,
so get rid of it.

Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Alex Elder <elder@riscstar.com>

> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index d66c702218081..1caabbd4c18b5 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but does this code leak device node reference
counts in of_pci_prop_intr_map()?

When of_irq_parse_raw() successfully parses an interrupt, it acquires a
device node reference and stores it in out_irq[i].np:

drivers/pci/of_property.c:of_pci_prop_intr_map() {
    ...
		ret =3D of_irq_parse_raw(laddr, &out_irq[i]);
		if (ret) {
			out_irq[i].np =3D NULL;
			pci_dbg(pdev, "parse irq %d failed, ret %d", pin, ret);
			continue;
		}
    ...

However, the function returns without calling of_node_put() on the
successfully parsed nodes in the out_irq array. This leak occurs on all
return paths, such as when map_sz is zero or when kcalloc() fails:

    ...
	if (!map_sz)
		return 0;

	int_map =3D kcalloc(map_sz, sizeof(u32), GFP_KERNEL);
	if (!int_map)
		return -ENOMEM;
    ...

Are we missing calls to of_node_put() for these references before
returning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908213459.2519=
059-1-elder@riscstar.com?part=3D2
