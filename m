Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF546513560
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909617; cv=none; b=Mq25mUEEttwxNbGe4zo9cprFl/F7OpO76+yUt/Bfw49ZYIZjKQ/AgWYV41cpjwbwuRxLEanuFW/y9HYnX1FuVl/ymUonKGYUEHQDqyAC5X8/Kn99KvDjdn+yu3+uB2csyipevqBWn3OkPAE/DRTHnvqLhNGATUhVpkOdKkcVZdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909617; c=relaxed/simple;
	bh=oRSd3nBArOzl2Jb2s865qqwyoWek83didYijiJxEp4Y=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EF7nuzCkTGM0K10z3MRDNyzyp6yQBuQb/CVF7cLSSWQN6XfhKu4ujilcCEJtArE933yzx0j67P7b3kBFD8K7yJigNqM46NokY//ahDyxWxXXCOd6lUpTWeNgQt53pD6w3AoihfgPfLRRC7gchJ/2gXAwtwoyfncbIC/943JvgwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNlQgiKx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNlQgiKx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5311F000FF;
	Tue, 13 Oct 2026 16:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909616;
	bh=onpO8lBHEN85iwssSLMsBRvZRHpOY6vwoIhiGQt1cxQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YNlQgiKxykUdaNxPXZtWG0oxa6IsM144UcaLaPe226qqU1kDRq0XFsgCT7J8vBOUO
	 Fh9hndQ8L8LhCb5R4U5MjZBiCC8bWfArpNHUSyzQkB5GUs8CoQzrQKj3NQ5uIfHWAO
	 WYj3uwzbAsIOSJoIuUmGKFNMYlIR9auXBOowlqXqEHcGhXcFl0jUJqOihiPZIB41VJ
	 rgyY4zHr2lzfxX0J5sv501jtnKKTGD4/jBA051lwE2lX1H+pqpZqTS2dPX3f40pLUy
	 t++aA/jkfQzHSNhf1bpXr108kA4y2YzNMCYBq0ebTy1wxSuIXVZXeqDejsN6r2w0eR
	 e3EXbsT51vPwQ==
Message-ID: <sashiko-outbox-170133@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 03/13] PCI: liveupdate: Track incoming preserved PCI
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-pci@vger.kernel.org
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Chris
 Li" <chrisl@kernel.org>, "David Rientjes" <rientjes@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20261013162529.1928093-4-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-4-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:40:14 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: liveupdate: silent DMA corruption risk on incoming device cle=
anup
--

commit 30099916ad0bce596acb2541018cac55703694d3
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Track incoming preserved PCI devices

This commit adds tracking for incoming preserved PCI devices during Live
Update. It introduces pci_liveupdate_setup_device() to fetch the serialized
state from the previous kernel and marks devices as incoming-preserved until
drivers call pci_liveupdate_finish().

> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 22d5d177e104d..a1d9b2b1f9e38 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
[ ... ]
> @@ -382,7 +599,80 @@ void pci_liveupdate_cleanup_device(struct pci_dev *d=
ev)
>  	 */
>  	if (READ_ONCE(dev->liveupdate.outgoing))
>  		pci_WARN(dev, 1, "Destroying outgoing-preserved device!\n");
> +
> +	if (READ_ONCE(dev->liveupdate.incoming))
> +		pci_WARN(dev, 1, "Destroying incoming-preserved device!\n");

[Severity: High]
Does this code risk silent memory corruption by only warning instead of
panicking?

When an incoming preserved device is destroyed, it is dropped from the
kernel's resource tracking. However, the device may still be live and
performing DMA if it was handed over by the previous kernel.

If this only warns, it allows the PCI core to proceed and potentially
reassign the device's bus numbers and MMIO resources to other devices while
the original device is still active. Although pci_check_all_devices_finishe=
d()
panics at the end of the Live Update session for unfinished devices, there =
is
a dangerous window where resource conflicts and DMA corruption can occur.

> +}
[ ... ]
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2a37e5d3e8e36..ad7fdf0d56b68 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
[ ... ]
> @@ -2188,6 +2190,7 @@ int pci_setup_device(struct pci_dev *dev)
>  	default:				    /* unknown header */
>  		pci_err(dev, "unknown header type %02x, ignoring device\n",
>  			dev->hdr_type);
> +		pci_liveupdate_cleanup_device(dev);

[Severity: High]
Can an incoming preserved device that fails enumeration here cause a resour=
ce
conflict?

If pci_setup_device() encounters an unknown header type for an incoming
device, it calls pci_liveupdate_cleanup_device() and ignores the device.
Since the cleanup routine only issues a warning, the live device is dropped
from tracking but might still be performing DMA.

>  		pci_release_of_node(dev);
>  		return -EIO;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D3
