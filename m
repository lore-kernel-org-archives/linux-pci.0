Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDC23AC0DE
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 19:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778699786; cv=none; b=PjVxaEK0yG6J4ndD8kdLTPqA1G/DyfTeZgeBdAQ4l0wg33O5i/4F405wgfH0nbO3OXJLDBD7Rt80g0XNEw+TOwjokUIQd0DWSEcFfAwyjgh4mIlGaWIb7lkJ1uDIqOhfTvsXTbW5UMvnG/oLW56+v033lpBIvD08H85fyMv6bIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778699786; c=relaxed/simple;
	bh=GxINWssdYtgsv17qlu3qU+affijQB4fKCvNc5xtFrTs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dTlj0IRIE8lnjkoupESv5xTW7kUEAdNno66oJZEgPVrDKhy1JyF7OnsJae3tVIn9lSl+hmXw69dY6yM+HSK2b2xbMbivCGb7aHHTKd4YjuSNlLqhrLNx0TJogJsiocHBluzNFWrf4MrmumAOMpFHvg8+N/PdDGMMEKcF5DHKeFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pdoj2hd8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pdoj2hd8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8D5C19425;
	Wed, 13 May 2026 19:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778699786;
	bh=GxINWssdYtgsv17qlu3qU+affijQB4fKCvNc5xtFrTs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Pdoj2hd8Wbfnww7tskxZA4xeW+1tnCKYyZFZhwi0vCHzu9vFiGE7tdVkHMXycJdDN
	 XaALTSWLnM+Ajo+/7Moo6RRqH+KRBt46QUctGurN9R9+RzrX8dwpqcFKtWuJ0R7yOo
	 pcp1V+oB3fgoQAd2JH1qlAhhVSvtPrdnH7+i4aLjQAec9x75v0JVgqAsE9OYqiSm1O
	 WB9ZvY0YfKpkLhsKRi+1zMhKJf1yAn2h+xQ/WftBIBQ5Oo5WQ8PLMAKY15/t8JUAfD
	 BTnO6S2PQDfRTBI6EAKo7wk42EUWlU7AdoBvTPvbaaulTbhLjKXnHBPhK+crownHgY
	 1qEQy9ZBGLXTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/16] vfio: Enforce preserved devices are retrieved
 via LIVEUPDATE_SESSION_RETRIEVE_FD
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vipin Sharma" <vipinsh@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260511234802.2280368-6-vipinsh@google.com>
References: <20260511234802.2280368-6-vipinsh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 19:16:25 +0000
Message-Id: <20260513191626.2E8D5C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Bus-specific (PCI) knowledge is hardcoded into the generic VFIO cor=
e.
--

commit 15f88d928c47afcb61541ee71ab7eb8d8e0b7766
Author: David Matlack <dmatlack@google.com>

vfio: Enforce preserved devices are retrieved via LIVEUPDATE_SESSION_RETRIE=
VE_FD

This commit enforces that incoming VFIO devices preserved across a kexec
must be retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD. Opening them via their
character device or VFIO_GROUP_GET_DEVICE_FD will fail with -EBUSY to
prevent initializing the device without the preserved state.

> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 0854f3fa1a220..5269fe021ee3a 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -11,6 +11,7 @@
>  #include <linux/cdev.h>
>  #include <linux/module.h>
>  #include <linux/vfio.h>
> +#include <linux/pci.h>

[ ... ]

> @@ -461,4 +462,21 @@ static inline void vfio_device_debugfs_init(struct v=
fio_device *vdev) { }
>  static inline void vfio_device_debugfs_exit(struct vfio_device *vdev) { }
>  #endif /* CONFIG_VFIO_DEBUGFS */
> =20
> +#ifdef CONFIG_PCI_LIVEUPDATE
> +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_dev=
ice *device)
> +{
> +	struct device *d =3D device->dev;
> +
> +	if (dev_is_pci(d))
> +		return to_pci_dev(d)->liveupdate_incoming;

Is it acceptable to hardcode bus-specific PCI knowledge into the generic
VFIO core?

The VFIO subsystem is designed to be bus-agnostic and relies on
struct vfio_device to abstract bus-specific details. By including
linux/pci.h in the generic drivers/vfio/vfio.h header and explicitly
calling dev_is_pci() and to_pci_dev(), this introduces bus-specific
logic into the core framework.

Could a generic state flag be set on the struct vfio_device object by the
bus driver (like vfio-pci) during registration or initialization instead?

> +
> +	return false;
> +}
> +#else
> +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_dev=
ice *device)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_PCI_LIVEUPDATE */
> +
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511234802.2280=
368-1-vipinsh@google.com?part=3D5
