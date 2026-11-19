Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046609;
	b=RlhGn3fpQwMZcrmMyhsl7X1BfKVj6VLwGjNI5hoZ8I0aKSZ9UJvmQ670nv5t9Z3D6TOd
	 0STDzpIwoElPAZ7AqMH8RJYlGOIZdpKvcPPLvgi7YwZOiN0jBZksiPkodgUpwC3DnTVEa
	 TtZLEVqj2FPnskYf08XREHHnMCQH9yyR5emp9y1OPbg27kkc4qztLzJP1JRW0LpqRHoI/
	 +j1EqYzgHfyRUH1HlDH6fI5YGtGrZ4Sb7iswB6xHsoWtN1Db5sAiwK5oivvCWoGWyHd7O
	 VVxIG6qAgTGw+P0K8L09rnkd1qFKeWvwfmevSEhgfiyDvh6BTEMSpCMqqGZEMM5ciXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046609;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FOFDr8n8TB8S8y+m70XapMjZP433H0c7qz4MC5pIS8g=;
	b=gxqmYZrB9TodjtQ4llzWfyuUlCXWzS8T7hFQqe4d6D8upFtQyBChK+gb8nikYTwAVuP3
	 BG91srhFYEO0WuN858pM9wNsOXxamW5r3egIUX8iO/onliUNCwETqgoLGMm1EQh2WyZW8
	 1jBAbio6aluZx55j51bz81J4RaOjhB/VfkVyUqWkxniZkOr1UYbzHmZ4FlBWGmcxdAR1t
	 B9DKVy2XGMvIQHAMVSmfFuCXTSy8DQEuRGMCDbYUEbIaWfayawTmiQJp+tKUj92vpL8KC
	 qGW725QabpuQ6GXQSs7mNiBrfIS03prhYrW1zk9QYV29Xt6jOXkeqTz7ypbnQufux4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M/lP0Nvr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8597606A32A;
	Thu, 19 Nov 2026 00:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M/lP0Nvr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F68E1F000C4;
	Thu, 19 Nov 2026 00:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795046609;
	bh=FOFDr8n8TB8S8y+m70XapMjZP433H0c7qz4MC5pIS8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M/lP0NvrPCKtpcarKRT+2c3sNGjiqI1MRFKqap7+WQidMl/GIVty908ykdLe2tDxE
	 CIvuMllzMLJJFYCKTHgfcxtve6JfFO7f3fo3uXKt/amC0VgFWc2+Zp2k+7n3T1rbqB
	 KwaNiMFia4wXLwtS1qLzJ1HBDXeSoEcb+qAbEv+2dAIN/YI3TFssTAbjM9Wd6MT49T
	 /wTSsrCo3G5FM1mcs/9mkmfz0pESOcuwSS9Qi70E8TrMGG0RJiwkVbNJ12+85ltCsk
	 4TQfNmNaBv7to+mw+S6lFVQdJLCoZZAZ83xeHSH57jWlqOWgnAfVA4J+wszen9wvyM
	 XQKf95UOxHQkA==
Message-ID: <sashiko-outbox-222222@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Allow untainted driver_override for PCI stub
 drivers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Williamson" <alex@shazbot.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118235645.2907908-1-alex@shazbot.org>
References: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
 <20261118235645.2907908-1-alex@shazbot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 00:03:27 +0000
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
- [High] PCI: build failure due to missing support_driver_override in
  device_driver
--

commit 6d515d8bf97cee4e2be39125c16fa6391240af86
Author: Alex Williamson <alex@shazbot.org>

PCI: Allow untainted driver_override for PCI stub drivers

This commit sets .driver.support_driver_override =3D true on pf_stub_driver=
 and
stub_driver to declare them safe for driver_override bindings.

> diff --git a/drivers/pci/pci-pf-stub.c b/drivers/pci/pci-pf-stub.c
> index da4db4928907e..328fb4a57092c 100644
> --- a/drivers/pci/pci-pf-stub.c
> +++ b/drivers/pci/pci-pf-stub.c
> @@ -36,6 +36,7 @@ static struct pci_driver pf_stub_driver =3D {
>  	.id_table		=3D pci_pf_stub_whitelist,
>  	.probe			=3D pci_pf_stub_probe,
>  	.sriov_configure	=3D pci_sriov_configure_simple,
> +	.driver.support_driver_override =3D true,
>  };
>  module_pci_driver(pf_stub_driver);
> =20
> diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
> index 9bc478df4e8f0..acbd43c17adc7 100644
> --- a/drivers/pci/pci-stub.c
> +++ b/drivers/pci/pci-stub.c
> @@ -37,6 +37,7 @@ static struct pci_driver stub_driver =3D {
>  	.id_table	=3D NULL,	/* only dynamic id's */
>  	.probe		=3D pci_stub_probe,
>  	.driver_managed_dma =3D true,
> +	.driver.support_driver_override =3D true,
>  };
> =20
>  static int __init pci_stub_init(void)

[Severity: High]
Does this fail to build when CONFIG_PCI_PF_STUB or CONFIG_PCI_STUB is
enabled?  struct device_driver in include/linux/device/driver.h has no
support_driver_override member in this tree, as the prerequisite driver-core
patch introducing it is missing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118235645.2907=
908-1-alex@shazbot.org?part=3D1
