Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844805;
	b=M3lwYA7hQUJaXfu2Kbxv1+AMMQNeJHH3rT+cxLOIIcIwG1GLq77Jaicd59NHTlTY/ydb
	 Q0cu9Xfn1Pwvgpc4dZY5fMa2QchicLVC96/XQtJkr8DO1iFGDmQ1ZThgC38sEcPYRcGVF
	 W91iPwHTCSElvV7afz7YfHg4rBBmCs69Dw12JfzPpDrO9a3MlA/MwsvHBOBR+xP9UNdTd
	 tfAtWPhWL+kT0vaese12QX2rQPYhecXfZh7yzwb2pZaPmVxewIndSSVpdzirCIqe44dMv
	 Vg2NpVzxuSKqUDCaE/xV+qFQKWzFjnHCBR4ZMWVHFZaWouT/Faj/BGyRr1iCXeoNg4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844805;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xAASFgdW/J4mo/lmKN3FH+d+5mSl8efVe28CsgSKsPY=;
	b=JDv3h1Pu78Dq0CK0IqSLG7aOP79t9JqHdWDR4pa1rFa7HV9xfZMQZ8laAliFCEhEsqn3
	 OuCcFEL2+1NEY4bwoVjeFilbYwiFJAodBv6HzGvwy0mIFlMZwLanzlYc+GiwYPh68mQQ5
	 TihmWAAJP8scxFCAyvTjnDGqT1PVjBqDcSuXBI8OQP8Y1Hivfqc7iVphf5eNRE222cuGN
	 UpZTMzhAE1lMyT7tnj8HQxr+zGz/VeBwmrKAIgdxsVPsezHh44INIMPshBnH9T7Spkd3j
	 778JV6YyXfqSPBPlE9KWkpk0UkDk6BB7yUTiixBXgvZjHUal0HwuWSN0VhbmrQxk+FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+GrFt85;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FCF606A31C
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+GrFt85
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF0C1F000C4;
	Mon, 16 Nov 2026 16:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794844804;
	bh=xAASFgdW/J4mo/lmKN3FH+d+5mSl8efVe28CsgSKsPY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=d+GrFt85eU+k/xZC5+wd95i+M+96ZU1iZ3hv5kVYrncKxAlCo2HeZJP6l1pyxxqE6
	 PFdC9IbZ2bYd06P1lffwbH8r1voYhKDOykb8A/c+n5yKeICGjt57+13orWmTH2cjJz
	 TLBfJO3MInZlPbzHl7HmbjcR7+KhX6Q6eJ5qBUu18MVBQR+lZdzMqoqCEKb4PJEoMQ
	 qwxNt7FCmCRmLo/DWdVdd1lPBkD4iQJSu+1O2mfVwh15spbQ4dCXDVMY5S/jdM8e4J
	 FCBqNFmj46lr0UceDd9WC161qBOVY2AYu81JssOnYYigKjJzB6uIcoKyUXGomCIaDI
	 q/yH1Ab2Xv+wg==
Message-ID: <sashiko-outbox-217333@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/13] PCI: Serialize bridge window sizing and resource
 assignment
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261116152403.2672-6-ilpo.jarvinen@linux.intel.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 16:00:04 +0000
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
- [Medium] PCI: acpiphp: enable_slot() holds pci_res_setup_lock across
  pci_scan_bridge()
--

commit 25d4f4c5afed80a01b7847608ddc4982cc9fd58d
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

PCI: Serialize bridge window sizing and resource assignment

This commit introduces pci_res_setup_lock to serialize bridge window sizing
and resource assignment across rescan, hotplug, and BAR resize paths.

> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acp=
iphp_glue.c
> index 632344f34caed..d3987be044e33 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -502,6 +502,7 @@ static void enable_slot(struct acpiphp_slot *slot, bo=
ol bridge)
> =20
>  		acpiphp_rescan_slot(slot);
>  		max =3D acpiphp_max_busnr(bus);
> +		guard(mutex)(&pci_res_setup_lock);
>  		for (pass =3D 0; pass < 2; pass++) {
>  			for_each_pci_bridge(dev, bus) {
>  				if (PCI_SLOT(dev->devfn) !=3D slot->device)

[Severity: Medium]
Does taking pci_res_setup_lock before the pci_scan_bridge() loop invert the
lock hierarchy with device_lock()?

pci_res_setup_lock is documented as nesting inside device_lock() because
__resource_resize_store() and driver probe hold device_lock(dev) when
calling pci_do_resource_release_and_resize().  However, pci_scan_bridge()
discovers child devices and calls pci_device_add() -> device_add(), which
exposes the resourceN_resize sysfs attributes in bus_add_device() before
acquiring device_lock(dev) for dev_set_ready_to_probe() and
bus_probe_device():

CPU0                                    CPU1
----                                    ----
enable_slot()
  lock(&pci_res_setup_lock)
  pci_scan_bridge()
    ...
      device_add()
        bus_add_device()
                                        __resource_resize_store()
                                          device_lock(dev)
                                          ...
                                            lock(&pci_res_setup_lock)
        device_lock(dev)

 *** DEADLOCK ***

Could pci_res_setup_lock be taken only around the __pci_bus_size_bridges()
and __pci_bus_assign_resources() calls after pci_scan_bridge() has
completed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116152403.2672=
-1-ilpo.jarvinen@linux.intel.com?part=3D5
