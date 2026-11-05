Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893540;
	b=I1qbIeWsf1Y1icT+EKeQjBv1sq6L/gNtn4q7GjZrImLMtiQpTayxPCT8xMmAjBfCkwXC
	 b4UEbsFluWsgehOneLIIn0NIoLXgXxI1g1Qd4iEfLGWWaVENaxiZKdQePESWRxN/WKK7x
	 yjf90xOJ0ZYaWTC3Cfo6O2hc5Hzs4Kju478aGKut/Iyxe4Ti01JFzsuTHoG9oAidRhE4B
	 5hHd4udy5ERRqD9LvizZblzJFfjEu3DBcgBopaWkjlAmeVBnZbvzFO5mv0v1gEMtJsMPU
	 WzvFayz9ShloboHIzvYrhAp2NnA+omeUXybv1hkWIK1nF4ObxIoJGWkMXLYBul2pq9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893540;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZChCsSBjMmcf786nuHNijb1yMGPrpTjvGf31UybvgYk=;
	b=fnb3r7SqWzIt0oPqfI69MOOlNEnJ+OzP6KDvuqoJ6tn9gXn9JWWfgGPIkbdZn09dsg1z
	 4LyEfvltIWP/PlbOw5sFDADGcxFYbdxCI/DiiJROjUnB5MC9Qm1DhF7b1oJk3SFwCVhA+
	 ji5/gkhqZ0663b4S1q4E8V+uwFspVAdg0FAxcbzsF4AvNXQGNtZgCpcPAlLmr5wGROTQM
	 +vZOgx9146uatzyFv3SAwooZT7zAwCX/5hTYsr077FdLJ8Z8lG6pU5pXUjEDb9+A9Gpxv
	 bEKKauvDkMVozcdJN7o5eePu15hNPBJQOPwK1XSyCKZvG5PRpmp9qnDp9F8VPH+DzNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ix5eXq6u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F00606A31B
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ix5eXq6u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171681F000C1;
	Thu,  5 Nov 2026 15:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893540;
	bh=ZChCsSBjMmcf786nuHNijb1yMGPrpTjvGf31UybvgYk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ix5eXq6u+0HocfqMzwW1JwiBR+B2ioB9mGZyaFcMjT7rnkNJitfeZUbmkbpXCshnc
	 ySwvRv4kpQ9nNT0euc0CvOryCg+rXKsnKfQu7w6lpz70CO2FTCh6VEzkrdkCIcpQH5
	 PMgUnwE7jeGvdaL2oeOR91dXAyGSZn0oBzDppPLZxCOstHu/8iVl9xTzGzMo9y6ChI
	 PhZdSSEp6rGT5jDlj2MBdlLh3/7V6TRUS/tYlRZGTqKe+/Yvi1KC61dg29YKi9Fs03
	 swsaGpfPL21pObxixBryzQZFhPDwpVtgOGukiNwxwoyvdtITcVMbbrU0PtQw5VuNPW
	 7ij0finjBoTow==
Message-ID: <sashiko-outbox-199339@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: keystone: drop host bridge reference in
 ks_pcie_quirk()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103104239.1373754-1-vulab@iscas.ac.cn>
References: <20261103104239.1373754-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 15:45:39 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] PCI: keystone: unexported pci_put_host_bridge_device() breaks modul=
e build
--

commit 7a2a6fc28bf725e307c0f83095897f6ac6b29cc8
Author: Wentao Liang <vulab@iscas.ac.cn>

PCI: keystone: drop host bridge reference in ks_pcie_quirk()

This commit fixes a host bridge device reference leak in ks_pcie_quirk() by
calling pci_put_host_bridge_device() via a cleanup label on all exit paths
after pci_get_host_bridge_device().

> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/cont=
roller/dwc/pci-keystone.c
> index edfbc32904cda..0c46887de0d5d 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -579,26 +579,33 @@ static void ks_pcie_quirk(struct pci_dev *dev)
>  	 * when MRRS is set to more than 128 bytes. Force the MRRS to
>  	 * 128 bytes in all downstream devices.
>  	 */
> -	if (pci_match_id(am6_pci_devids, bridge)) {
> -		bridge_dev =3D pci_get_host_bridge_device(dev);
> -		if (!bridge_dev || !bridge_dev->parent)
> -			return;
> -
> -		ks_pcie =3D dev_get_drvdata(bridge_dev->parent);
> -		if (!ks_pcie)
> -			return;
> -
> -		val =3D ks_pcie_app_readl(ks_pcie, PID);
> -		val &=3D RTL;
> -		val >>=3D RTL_SHIFT;
> -		if (val !=3D AM6_PCI_PG1_RTL_VER)
> -			return;
> -
> -		if (pcie_get_readrq(dev) > 128) {
> -			dev_info(&dev->dev, "limiting MRRS to 128 bytes\n");
> -			pcie_set_readrq(dev, 128);
> -		}
> +	if (!pci_match_id(am6_pci_devids, bridge))
> +		return;
> +
> +	bridge_dev =3D pci_get_host_bridge_device(dev);
> +	if (!bridge_dev)
> +		return;
> +
> +	if (!bridge_dev->parent)
> +		goto put_bridge;
> +
> +	ks_pcie =3D dev_get_drvdata(bridge_dev->parent);
> +	if (!ks_pcie)
> +		goto put_bridge;
> +
> +	val =3D ks_pcie_app_readl(ks_pcie, PID);
> +	val &=3D RTL;
> +	val >>=3D RTL_SHIFT;
> +	if (val !=3D AM6_PCI_PG1_RTL_VER)
> +		goto put_bridge;
> +
> +	if (pcie_get_readrq(dev) > 128) {
> +		dev_info(&dev->dev, "limiting MRRS to 128 bytes\n");
> +		pcie_set_readrq(dev, 128);
>  	}
> +
> +put_bridge:
> +	pci_put_host_bridge_device(bridge_dev);
>  }

[Severity: Low]
Will calling pci_put_host_bridge_device() here break the module build when
CONFIG_PCI_KEYSTONE_HOST=3Dm or CONFIG_PCI_KEYSTONE_EP=3Dm on non-ARM32 tar=
gets
(which selects CONFIG_PCI_KEYSTONE_TRISTATE=3Dm)?

In drivers/pci/host-bridge.c, pci_get_host_bridge_device() is exported for
modules, but pci_put_host_bridge_device() is not:

drivers/pci/host-bridge.c:
    struct device *pci_get_host_bridge_device(struct pci_dev *dev)
    {
        ...
    }
    EXPORT_SYMBOL_GPL(pci_get_host_bridge_device);

    void  pci_put_host_bridge_device(struct device *dev)
    {
        kobject_put(&dev->kobj);
    }

Additionally, pci_put_host_bridge_device() is currently only declared in the
internal header drivers/pci/pci.h rather than include/linux/pci.h alongside
pci_get_host_bridge_device().

Should pci_put_host_bridge_device() be exported with EXPORT_SYMBOL_GPL() in
drivers/pci/host-bridge.c (and moved to include/linux/pci.h) so modular bui=
lds
of pci-keystone.ko do not fail at modpost?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103104239.1373=
754-1-vulab@iscas.ac.cn?part=3D1
