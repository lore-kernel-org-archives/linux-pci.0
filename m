Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583541;
	b=ASb2P2XvA01yP+VoREfWNlEpW+sqw7ZHZxaUgO/eZ5PqIbM4q+4aPnTx6hgPbNBynVmX
	 lwgTRQu58e4qexKBhshjPxzF7GdTkt/I8h/FCGC4c58XSUHhErX9+wv3p363lMsEmrumW
	 vqGxOrFqXOSoCsbIu8FIYwaj/f8WSHZ/rvnn0rmROVZXrKM2PBwYQOGDQZg0e95KAF9Ej
	 f6briabg4Qzl5ChP1OFHKel7DXqclbdwd9/sieh+jhEUKtMp30ETCtDVzYV5VeGWEpxZK
	 kW25o3VKMNu6bH1WkGNmpZ2FnUJ9Yd0ElsldwE0x/A7/vvIym1iCh2a9EGYxUQDwnMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583541;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=59bACXFSdErnR4t1sdIB9FWGUdGUsbzpc8omJ0+y/4E=;
	b=Puqnrk9XBmomPWdyVpqK1eZbBS85mfO37eC4BNwqdolgew0u5fIF/4JdFpQ5jBq5bsdk
	 aGOkHvuivGX9ckzq7Rq+pn9wSHGZyyNiz9AttcVDyjgnch+x2f7QzYBgPKcZoWLxmrLYP
	 P1dl06mUE7tqlJl6zmgGMN1ftQvkuzmBqBZAo6zvFTnYtwhY5TPUx64BQGuWssfE5ueqp
	 BRTCv+ek66os6rQ0RDzKbkxYbDiBhQf5USDKlgFoqXU1tiARtxR1ouTp5E1mzOyj8qdsV
	 /JOiPs1SEbXJff32DMSjE3bDoq5QcFqI/dyXcg4ehtsLMRDTAtq3cvXxCYtJNd6BTIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gEyQfF5Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F6A606A32D
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gEyQfF5Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BD81F000C4;
	Fri, 13 Nov 2026 15:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794583540;
	bh=59bACXFSdErnR4t1sdIB9FWGUdGUsbzpc8omJ0+y/4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gEyQfF5QanqBBjspY+WRYRtGIZrYHT9A0rHjDYG3jy4vRpv+qn1v3ck7gAfN2SZH2
	 PE9jW/Fb0EAXR1xzCbT/0uC9a8Hd4oy1YADC5wXooNTcwEqNIBhE7VGx+uaVvy5Ewy
	 O7mAQZDGYAGRPfunYMSAKnkWcrGQh7GnTkuvkia7ndn2EQPcPp4UioABdlJ+EqQWHQ
	 Riw+0XHiL4X4bJQAcgsJ/iwfq3kqz3BMg/VOebTRRlNGfSWcbZvvzFCfvBy9dEfDCa
	 XNUQPqCHVnNp1GmPIL9C7To6Z35SAukbkBjrOoBXvZc3Ggu4E3EGHJl3eMB1vefclo
	 +ieJVZUdB/Qrw==
Message-ID: <sashiko-outbox-213087@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/portdrv: remove redundant
 pm_runtime_dont_use_autosuspend() calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joshua Crofts" <crofts@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261113-pci-remove-dont-use-autosuspend-v1-1-413cb01fa0f6@kernel.org>
References: <20261113-pci-remove-dont-use-autosuspend-v1-1-413cb01fa0f6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:25:40 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] PCI/portdrv: autosuspend state leak in pcie_portdrv_remove()
  and shutdown()
--

commit 62458954dcb1cf459473df3e377ccf5bc59b1591
Author: Joshua Crofts <crofts@kernel.org>

PCI/portdrv: remove redundant pm_runtime_dont_use_autosuspend() calls

This commit removes the pm_runtime_dont_use_autosuspend() calls from
pcie_portdrv_remove() and pcie_portdrv_shutdown(), relying on the driver
core to undo pm_runtime_use_autosuspend().

> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 32fc623dd4108..3ce960b4ea25e 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -728,7 +728,6 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>  	if (pci_bridge_d3_possible(dev)) {
>  		pm_runtime_forbid(&dev->dev);
>  		pm_runtime_get_noresume(&dev->dev);
> -		pm_runtime_dont_use_autosuspend(&dev->dev);
>  	}
> =20
>  	pcie_port_device_remove(dev);
> @@ -741,7 +740,6 @@ static void pcie_portdrv_shutdown(struct pci_dev *dev)
>  	if (pci_bridge_d3_possible(dev)) {
>  		pm_runtime_forbid(&dev->dev);
>  		pm_runtime_get_noresume(&dev->dev);
> -		pm_runtime_dont_use_autosuspend(&dev->dev);
>  	}

[Severity: Medium]
Does removing pm_runtime_dont_use_autosuspend() here leave
dev->dev.power.use_autosuspend enabled after driver unbind and system
shutdown?

pci_bus_add_device() enables runtime PM for the PCI device, and it remains
enabled across driver unbind.  Because pm_runtime_reinit() returns early
when runtime PM is enabled, device_unbind_cleanup() never calls
pm_runtime_dont_use_autosuspend():

drivers/base/power/runtime.c:pm_runtime_reinit() {
	if (pm_runtime_enabled(dev))
		return;

	if (dev->power.runtime_status =3D=3D RPM_ACTIVE)
		pm_runtime_set_suspended(dev);

	if (dev->power.use_autosuspend)
		pm_runtime_dont_use_autosuspend(dev);
}

As a result, unbinding the driver leaves use_autosuspend set and leaks the
dev->dev.power.usage_count reference acquired by update_autosuspend() if a
negative autosuspend_delay_ms was written via sysfs.  In addition,
device_shutdown() invokes pcie_portdrv_shutdown() directly without calling
pm_runtime_reinit().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-pci-remove=
-dont-use-autosuspend-v1-1-413cb01fa0f6@kernel.org?part=3D1
