Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843421;
	b=f8FhH4bsv3KQ3J8KvmkN+F8+XxISm9RdIjYLGK6fgB+NS+xGmVb8w4GbfLStrmeyrNDj
	 ZWZGlj/WbEv619UuAdkEvG7OWSh7JZt/8TqgR9aijB9GVm5s7VGzvezgnVuOEKiBSvAQ9
	 z7Hn2UWzCtdAujGv+TilWcnxVRtdx9GzISor8KmtMb2Izv3BnVK/RCgS6KtExuTNEIEyB
	 tl0MltvAixXluktF4IXWzC1gscQRHj3bAusQMoxRAqNRVc7plyFvvgMaSNWEGM8ukvPL8
	 g15LfEULcFk1ATD37z53WwkG15A5jksaTK2suT+XAMwFh33UTNdkq6XuBBqOtoAzpzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843421;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3hAm8uVZ4kzHwr8cOZ+g+HxAoONY3lrSQFrBh3TISjw=;
	b=asYH4UxcVeob3cr/5TcS9D812BcjkIabqWTG4HgWEwlKoWHPdRgQ++u8n/ZQP8V/NDkZ
	 3P0MaFZnEJNuK1q7vMQ5qnZmSqf9/VYqZYawwrZT1hof6cOlOMrEd9F4HEbDMaoHEV21o
	 PCLlwpNsy6+n2eMLRDtHIbqbJQ8/OcQ+X+c5iUcHoEvToXCkhSjKNw9tdix45QzvarODn
	 6je4KNIlf3RZolkleW0S55kXDfZrRshl33GvxKEJQTMl592WeiE+6dclO8n2AVmlBd675
	 lCIC7DC1MvRJc6lzZVhnqHrljrddPK8LZyIGJq+m8UAK6IS9OeEU/LufIsVTlQkVO9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gs++yokr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4061606A322
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gs++yokr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237DD1F000C4;
	Mon, 16 Nov 2026 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794843421;
	bh=3hAm8uVZ4kzHwr8cOZ+g+HxAoONY3lrSQFrBh3TISjw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Gs++yokrgP0O8jU3sG201X+a9EpdiC2mSoIHfnNL5nn6rQsEbkMsf5WDEkgAfWe2u
	 /kjd4k6MUrB5H2pS4lZqasWeQtk3xuCRsKkAnWuZP5AiRZUGQTWi2/nnGXwT9aOhPU
	 UaCkdENd+bowoUTUt6U4M59JagBgyygtDeZR5QHtltG/IkH2rw9nIM2E1WmxCeWSZW
	 gdXoJ+SDOhvFgWf2bOfnDyYq0oNdN/+uYf89/5q2Oi9VYDumS94pB2dQuS9+jssNi8
	 Q0MBqGeMaR+ouXePousuy9Vlvk1gAxVUbZB/5kQKSPHNqi+sW6DT8ZOCXbTg/2u+G3
	 qLOfum7z8QkAQ==
Message-ID: <sashiko-outbox-217307@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/13] alpha/PCI: Convert to
 pci_bus_size_and_assign_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261116152403.2672-3-ilpo.jarvinen@linux.intel.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:37:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> To serialize bridge window sizing and resource assignment, PCI core
> needs to hold locks across both phases. Alpha nautilus PCI code calls
> pci_bus_size_bridges() and pci_bus_assign_resources() separately
> because it needs to do special resource alignment and setup after the
> window sizes have been calculated. At least the former would seem to
> belong to some existing __weak pcibios_*() hook but the latter might
> need yet another pcibios_*() hook just for this single use.
>=20
> The nautilus code runs during init, so nothing is likely to race with
> it. Converting it is mainly about consolidating the sizing and
> assignment entry points of PCI core, which eventually allows removing
> pci_bus_assign_resources().
>=20
> Instead of trying to do a complex rework of the code, which is risky
> without the ability to test on the hardware, simply convert
> pci_bus_assign_resources() to pci_bus_size_and_assign_resources(). This
> adds a small bit of extra work by performing the sizing step again, but
> the calculations should yield the same sizes, so it seems safe.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116152403.2672=
-1-ilpo.jarvinen@linux.intel.com?part=3D2

