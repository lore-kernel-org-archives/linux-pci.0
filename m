Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185A63403F1
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191070; cv=none; b=P//3i9sYO66urqHSGiC+9XSEGLvvqxDVZN57BgajWwmSyOTjXvRVC1L1TeZL7pauOMszwtD2ZV/NnvcikvcDCRO1CDgjwRpASefanan9GW09uNP/+z4PLf1k5flyjiO+Q/kWehfGUCifjbH71ZJxKQPJk51ADqm5X+ipcj2m7y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191070; c=relaxed/simple;
	bh=3vJyb1RW5P0qKRXC1BZf19cTYrTSp0as6XQPl9z8Gt0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C8qGJpuGevp1nEuG1qoQ/WgNm4GtsIW2ZsiBPT+z3iByWU9IZfFpelshKLx8kuT4hxMXgC90gfeNwK927SXUrA61qxHuz6cv/ju5JdZeGYLKMcV3gzJNY9/ZnISmzLUM43EOHuH30KLcmh76KkmImrm+9hBDQYPK2EvgAi/G4TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrQskGZk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrQskGZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0261F000E9;
	Mon, 31 Aug 2026 15:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788191068;
	bh=oT1TAyNdK/Wnza+m01qbyZIGnMHVHN8vz9iV3sYtolE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NrQskGZkKU8oYNj3+SSn1T6dvfqNYdb2K90NpaClSZB6Wr7YCAAnwhewBNFtWnglZ
	 +u/C685Vby2Mpqgd+nNNzFssmn+cXVq2+Jz44a9DrOWYILljJVyAi1YPua6cI0hexP
	 X5DtXns5tSKeeLMgB22ZLPKqw+WIewuck1tcA/kUvA/LluQvcQrlMSdxqUhebqN4lH
	 p++mUtLcLpJtnJxuFLXFzw6+NsHhe3Ly+CmNAVWPytcHh3pDEI8UEOgbyvDRw9bYyb
	 zZV8xS/2LRln9Frb2nN74MQE04Ld7WlOmbwEY0TqZ9OhAFyycjNFHhCN9yH6/L8hRo
	 iKio2vamdHf/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] PCI: mediatek: Protect root bus
 removal with rescan lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831133314.4125787-345-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-345-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:44:27 +0000
Message-Id: <20260831154428.7E0261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing IRQ teardown in multiple error paths (probe, port enableme=
nt, resume) leading to memory leaks of IRQ domains and a critical Use-After=
-Free of `mtk_pcie_port`.
--

commit fb803b3fa12664e554b8c9a2ac4cd9f5ed0a4f0d
Author: Hans Zhang <18255117159@163.com>

PCI: mediatek: Protect root bus removal with rescan lock

This commit wraps pci_stop_root_bus() and pci_remove_root_bus() in
pci_lock_rescan_remove() to prevent race conditions during sysfs rescan or
hotplug operations.

Link: https://patch.msgid.link/20260521161822.132996-7-18255117159@163.com

> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/control=
ler/pcie-mediatek.c
> index 24cc30a2ab6c6..e8af54efec9d6 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -1128,8 +1128,10 @@ static void mtk_pcie_remove(struct platform_device=
 *pdev)
>  	struct mtk_pcie *pcie =3D platform_get_drvdata(pdev);
>  	struct pci_host_bridge *host =3D pci_host_bridge_from_priv(pcie);
> =20
> +	pci_lock_rescan_remove();
>  	pci_stop_root_bus(host->bus);
>  	pci_remove_root_bus(host->bus);
> +	pci_unlock_rescan_remove();
>  	mtk_pcie_free_resources(pcie);
> =20
>  	mtk_pcie_irq_teardown(pcie);

[Severity: High]
This is a pre-existing issue, but since this teardown path correctly cleans
up IRQs, could other error paths be leaking IRQ domains or risking a
use-after-free by missing this teardown?

For instance, if mtk_pcie_enable_port() fails link training, it frees the
port memory:

drivers/pci/controller/pcie-mediatek.c:mtk_pcie_enable_port() {
    ...
err_sys_clk:
    mtk_pcie_port_free(port);
    ...
}

Does this leave the previously registered IRQ domains and chained handlers
active, potentially pointing to the freed port memory?

Similarly, on system resume, if a port fails to come up:

drivers/pci/controller/pcie-mediatek.c:mtk_pcie_resume_noirq() {
    ...
    list_for_each_entry_safe(port, tmp, &pcie->ports, list)
        mtk_pcie_enable_port(port);
    ...
}

Could this trigger a use-after-free when the chained handler accesses the
freed mtk_pcie_port structure?

There also seem to be similar missed cleanups during probe. If
mtk_pcie_probe() fails later on:

drivers/pci/controller/pcie-mediatek.c:mtk_pcie_probe() {
    ...
put_resources:
    if (!list_empty(&pcie->ports))
        mtk_pcie_put_resources(pcie);

    return err;
}

Will this free the port structures without tearing down the active chained
IRQ handler?

Also, if mtk_pcie_setup() fails midway during probe:

drivers/pci/controller/pcie-mediatek.c:mtk_pcie_probe() {
    ...
    err =3D mtk_pcie_setup(pcie);
    if (err)
        return err;
    ...
}

Could this leak the IRQ domains for successfully parsed ports, leaving
chained handlers pointing to devres-freed ports?

Finally, could domains be orphaned if IRQ setup or MSI allocation fails?

drivers/pci/controller/pcie-mediatek.c:mtk_pcie_setup_irq() {
    ...
    if (port->irq < 0)
        return port->irq;
    ...
}

And in mtk_pcie_init_irq_domain():

drivers/pci/controller/pcie-mediatek.c:mtk_pcie_init_irq_domain() {
    ...
    if (IS_ENABLED(CONFIG_PCI_MSI)) {
        ret =3D mtk_pcie_allocate_msi_domains(port);
        if (ret)
            return ret;
    }
    ...
}

Should these error paths be freeing port->irq_domain and other resources
created earlier?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-345-sashal@kernel.org?part=3D1
