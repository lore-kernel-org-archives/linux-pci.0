Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2913F28D831
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 06:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910612; cv=none; b=Bw0kvlnUJ/djazN5EZ30L5kp5FEmCrytW7yTh0enLDOLNTe/gVjBaFIfZrpTT4DIIyedF54mwsQDdxw2xjnwq5l4NlLvhSDlvzwye2OeHyzyCbSr0W0ME1SPeJwvCP4xIntq6I0W/FvfmnpoUy7NVFO5RUd8yikaE5PZUME3r94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910612; c=relaxed/simple;
	bh=Crjwa7drvUHkdMCqvlIp++nJ4I8OYEFZBCQPQrBbOBE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=peBHIrCuM/73jNKeWqygO6eAhJYfXTgs3QDT+zED/24lJYpUkiK0eWGZlJoGQQ6Mti8P6O5JD/hmwU2SLMbxxHeSsaJzr94g3sfs9hAMQjZMHxrqSo1P7K8O9MAEAu5wP2fBF8WJc8f99Yw5tUk8q60KvncPU0m4Mlx6/JG0UG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8b4cOQT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8b4cOQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403291F000E9;
	Wed,  5 Aug 2026 06:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785910610;
	bh=IEFgIPeDjDnWrTiXYUUdw76c1CKiq1ZRjHFCfnaRQ4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S8b4cOQTjmtBN4TODySPm6kPDfmA8YHfX2x0pHhRhl7C/wFSzdJKM6cKO2IDCTyCr
	 Tw/zNTXvAHh3zZoLQqwu/GnYPPoLl94ISdQgfFNV/CZmrWf1IPl0Oy/BGovhhBDHK5
	 oq7VSPaFJKlqnaD6mrUydP10pkZBUiKo/bZeW8V201XWbNd7u+IoJvE5nh49yL9+uN
	 TyfyJUemIYoCs3i0Hw79U3FGsSRDXpb2j8sJE7xyL8A/Xo4SrgOLihUxTya/sh0V/p
	 ShQuv8wQicKc+DXdM9PpaRFNKq/6JQsfkeTyxEw5sGvFxjg02lbYiknMGhlFKfb9/m
	 0Bn2WsQKFhOqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: mediatek: Find INTx controller by property
Reply-To: sashiko-reviews@lists.linux.dev
To: aquapinn@qq.com
Cc: linux-pci@vger.kernel.org
In-Reply-To: <tencent_5E7D6E7FB25B4CD732F08547C11F5DA24808@qq.com>
References: <tencent_5E7D6E7FB25B4CD732F08547C11F5DA24808@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 06:16:49 +0000
Message-Id: <20260805061650.403291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] PCIe IRQ domains are leaked and retain dangling pointers to devm-f=
reed ports on various probe error paths, leading to Use-After-Free.
--

--- Patch [1]: [PATCH] PCI: mediatek: Find INTx controller by property ---
commit 8e34608d98c97419f127cc199be1c423e10e10a5
Author: Zhengping Zhang <aquapinn@qq.com>

PCI: mediatek: Find INTx controller by property

All existing DTS users already name the INTx child node
"interrupt-controller". Use of_get_child_by_name() to find it instead
of assuming it is the first child node.

> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/control=
ler/pcie-mediatek.c
> index 8b57c3d75b942..7b54f3dc6cf87 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -572,9 +572,9 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_p=
ort *port,
>  	int ret;
> =20
>  	/* Setup INTx */
> -	pcie_intc_node =3D of_get_next_child(node, NULL);
> +	pcie_intc_node =3D of_get_child_by_name(node, "interrupt-controller");
>  	if (!pcie_intc_node) {
> -		dev_err(dev, "no PCIe Intc node found\n");
> +		dev_err(dev, "no PCIe INTx interrupt-controller node found\n");
>  		return -ENODEV;
>  	}
> =20

[Severity: High]
This isn't a bug introduced by this patch, but does this code leak the IRQ
domains on probe error paths, leading to a Use-After-Free?

The port structure is allocated with devm_kzalloc(), but port->irq_domain is
created here via irq_domain_create_linear() which is not devres-managed. The
port structure is set as the domain's host_data.

If probe fails later in mtk_pcie_setup_irq() because platform_get_irq() fai=
ls:

drivers/pci/controller/pcie-mediatek.c:mtk_pcie_setup_irq() {
    err =3D mtk_pcie_init_irq_domain(port, node);
    ...
    if (port->irq < 0)
        return port->irq;
}

The code directly returns an error without removing the IRQ domains.=20
This also happens if parsing a subsequent port fails in mtk_pcie_setup():

drivers/pci/controller/pcie-mediatek.c:mtk_pcie_setup() {
    ...
        err =3D mtk_pcie_parse_port(pcie, child, slot);
        if (err)
            return err;
}

Or if pci_host_probe() fails in mtk_pcie_probe():

drivers/pci/controller/pcie-mediatek.c:mtk_pcie_probe() {
    ...
    err =3D pci_host_probe(host);
    if (err)
        goto put_resources;
    ...
put_resources:
    if (!list_empty(&pcie->ports))
        mtk_pcie_put_resources(pcie);
    return err;
}

In this path, mtk_pcie_put_resources() frees the ports, but
mtk_pcie_irq_teardown() is never called.

When probe fails, devres frees the port, but the globally registered IRQ
domain remains. A subsequent probe attempt or another device translating
an IRQ from the same fwnode could find the leaked domain and dereference
its freed host_data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_5E7D6E7FB25=
B4CD732F08547C11F5DA24808@qq.com?part=3D1
