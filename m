Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2788F514759
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651785; cv=none; b=OVV4tbMuJgKXuMZ5z70gdVdDQX3Gq8JYK4q4q+1U3nbhPJPiedpsPxlDeawkoZtLRA+cDmjp5jUnwgLBaj7ibOgimAoNzLVXDxetc8vR0SYNZIKiTwB8t2UnH5xployFLA3MOLoxpXVDWbQEHkcEDWusTu1iRMdTRzA/MKU4LN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651785; c=relaxed/simple;
	bh=tb2KrOY59nKuLgbD2hiI3KQevm9dpRF7hkQHb7R2eQc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MKPG2I3nC56LPS8kT3L5nMArpf2HuhaC2BVJUB4QN69z1fT9TAkfpqOSrKH8QLlkdo58pksNEffsK7kE4/1d0PIIpirbTNk7W5/SX5i/hvKaKTUtyZreUtw3a06u15M5u1gBsTIRswakMr9RAKzVdRwRdNvn21bzPdmpCpfXTSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/emFj1S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/emFj1S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF5D1F000FF;
	Thu, 17 Sep 2026 13:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789651783;
	bh=YGGamJjonYfnQm7f5a0ZkLuByW9G4PjG3lqapqY7YA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J/emFj1S4npc1drhOLJuorcgTkdm0l7Qt1Mt0sPSzZA+kZYzEfkOlUGvfgn/GTjxy
	 6+MWmL1L8z7yiWXHarQvOBEtryiRDhdZTE3o8r/8dT4HdASXlRPneOZz1da7iWLrBC
	 baCZzW8SoInE7x1jSoBlX3d9WKut3NNUf6XIC0B05vJAmnaUpk7vfDe25tCsizx48C
	 n+/VskZIpWpTGssdbB0FsbgZQwGIl0IkX5vLIMbUG2j97hFm95jJGtCLfO0fUjUAN7
	 cn4tD/XZmXiddA4SfJXPPYwHaWlsw9ovFKJRwqMdpiQI+1WHQgF+l1uHvnib2j1a6c
	 cxLYGmluEfkSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: xgene: Fix device node reference leak in
 xgene_pcie_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260917132235.2153154-1-vulab@iscas.ac.cn>
References: <20260917132235.2153154-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 13:29:42 +0000
Message-Id: <20260917132943.2EF5D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: xgene: refcount underflow and build failure due to hallucinat=
ed of_node_get()
--

commit 3a601f05188e398e03ea9af2fc4238c97e5b4cf2
Author: Wentao Liang <vulab@iscas.ac.cn>

PCI: xgene: Fix device node reference leak in xgene_pcie_probe()

This patch attempts to fix a device node reference leak in the error paths
of xgene_pcie_probe() by adding an error handling label that drops the node
reference.

Cc: stable@vger.kernel.org

> diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/=
pci-xgene.c
> index 83c9a2930eeca..6b922120db3fc 100644
> --- a/drivers/pci/controller/pci-xgene.c
> +++ b/drivers/pci/controller/pci-xgene.c
[ ... ]
> @@ -630,20 +630,28 @@ static int xgene_pcie_probe(struct platform_device =
*pdev)
[ ... ]
> -	return pci_host_probe(bridge);
> +	ret =3D pci_host_probe(bridge);
> +	if (ret)
> +		goto err_put_node;
> +
> +	return 0;
> +
> +err_put_node:
> +	of_node_put(port->node);

[Severity: High]
Does this patch introduce a refcount underflow and a build failure?

The commit message states that xgene_pcie_probe() takes a reference with
of_node_get(), but that function does not appear to be called anywhere with=
in
xgene_pcie_probe(). If there is no prior of_node_get() incrementing the cou=
nt,
calling of_node_put() on these error paths will drop an unowned reference,
potentially causing a use-after-free of the device node.

Additionally, does struct xgene_pcie contain a node member? It appears this
struct does not have a node field, which means accessing port->node will
cause a build failure.

> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917132235.2153=
154-1-vulab@iscas.ac.cn?part=3D1
