Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613514;
	b=yzMuyxdPiKBxU8qwNvuCUWnyuX/vxOOjcOcSBtrAZkcb/mCqAjySaKD8BGh5isOqp84q
	 iORTFXPE+drpe1Sas1fXHWCJiqyLcY0yAnTj6rwolOfHYs4WqfZC0DfQP8ddF1k2nHy8h
	 cJqjdV+DCK3tjWEAhB4pWZpROiak3cO1zrtJhbb7HDeLqy6eQDPHCx8WxatcoR5sIUiv4
	 RQoSriVjJNy9IoWcUY3WKZzCp+67taqpvPSm8SaDL56fHlImfp8YH5bKiKNDbOLu4/Cr2
	 JGvK0NyJ4qCpO28MUvkrNHWKD3gMjQzwwH3jFpOzHfbMLkTImdctADbamij+6aDmckw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613514;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Tykci3iR+wu+l+MHp1JiS2Gruzc52Sho6Bi5yYsZuDU=;
	b=q8SRlrmSNh1sdMjQNuMjJ26j559+kScfeUGYhHFrXgQXRdRSXUDgM5/Ae74UWD/XCgne
	 hekxtzCS2TO005kH5CIOyeM2cXbVeB9/fHGk//ZFHecsprbXNN9G5lI+maYFIZTGDYPUc
	 DGHERceZfeOtfbCvd6wDahkg7FqVMgn6Ycv579cendzXAsrpPEKviaYntv20g75Lzhwt9
	 cCtWnTSFzmow2mCfFqiQZG7Gf3jIVVorYIIrLIGRr2JLxBaGuQhLGw6gGiisn4aUTnKWc
	 /1JrR6GsIB9oPz70NZPTDvJ02Uhr1Wp9EW+9NQ0umZkMyqy0B6WgQpH5JLp5AVvFDcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fbao+545;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319D6606A326;
	Mon,  2 Nov 2026 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fbao+545
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F621F0093A;
	Mon,  2 Nov 2026 09:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793613513;
	bh=Tykci3iR+wu+l+MHp1JiS2Gruzc52Sho6Bi5yYsZuDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fbao+545FqiJZAUQqr+biGlSW3LRgXX9la2ju4MkI2ROlycGB2ocOugPIbWZS2fPq
	 A3lPeeMQDz5JmfFFlmQfJopX/PTsmy2G6bHZEEt1iG1fvYcRGZOuQmK3bgT/jbeL/w
	 M6YXWURAHC8bdQmppjrzWZiTmmZrTxc7UOTlDZRnBW/0KLVzc3895r8n2Xmc7tQOrv
	 mhGEF/Oi/YDq5RYzqHSaM5tYbJ08myeZ42dXH6v1uxtbuI4uJWlsWfISUw3o0IKmDN
	 AqYL8yqisu9ZN8dfxWqchBoFU1aglPUZ/CBpGqyBIZsRz8k65P5yIdPzK2ilTwM8eZ
	 FMkyW1sftR+dg==
Message-ID: <sashiko-outbox-193224@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: PCI: Add linux,pci-domain-reuse
 property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cui Chao" <cuichao1753@phytium.com.cn>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261102095150.2370959-2-cuichao1753@phytium.com.cn>
References: <20261102095150.2370959-1-cuichao1753@phytium.com.cn>
 <20261102095150.2370959-2-cuichao1753@phytium.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 09:58:32 +0000
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
- [Medium] dt-bindings: PCI: redundant linux,pci-domain-reuse OS-policy pro=
perty
--

commit 4d7d1f09f7c3c39f32142c31f5a0c2f23d8b30fc
Author: Cui Chao <cuichao1753@phytium.com.cn>

dt-bindings: PCI: Add linux,pci-domain-reuse property

This commit adds an optional boolean property linux,pci-domain-reuse to the
generic PCI host bridge Device Tree binding so that multiple host bridges w=
ith
disjoint resources can share the same software PCI domain number.

> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml =
b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> index 420d551e9af97..1b439e2f38af7 100644
> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> @@ -114,6 +114,16 @@ properties:
>        Requests with Address Type (AT).
>      type: boolean
> =20
> +  linux,pci-domain-reuse:
> +    description:
> +      Boolean indicating that this host bridge is allowed to reuse the s=
ame
> +      "linux,pci-domain" value as another host bridge on the platform. H=
ost
> +      bridges reusing the same domain must have disjoint ECAM, bus-range,
> +      memory, and IO windows so that (domain, bus) tuples remain globally
> +      unique. A duplicate domain on a host bridge without this property
> +      remains an error.
> +    type: boolean

[Severity: Medium]
Is a new Device Tree property needed here when the hardware topology of
multiple host bridges sharing a domain with disjoint bus ranges is already
fully described by setting the same linux,pci-domain alongside disjoint
bus-range, reg, and ranges properties?

In the PCI core, pci_register_host_bridge() in drivers/pci/probe.c already
tracks per-domain bus number resources via get_pci_domain_busn_res() and
pci_bus_insert_busn_res(), and rejects conflicting (domain, busnr) tuples:

drivers/pci/probe.c:pci_register_host_bridge() {
    ...
	b =3D pci_find_bus(pci_domain_nr(bus), bridge->busnr);
	if (b) {
		/* Ignore it if we already got here via a different bridge */
		dev_dbg(&b->dev, "bus already known\n");
		err =3D -EEXIST;
		goto free;
	}
    ...
}

The only reason duplicate linux,pci-domain values currently fail in Device
Tree is that of_pci_bus_find_domain_nr() in drivers/pci/pci.c unconditional=
ly
allocates static DT domain numbers from pci_domain_nr_static_ida:

drivers/pci/pci.c:of_pci_bus_find_domain_nr() {
    ...
		domain_nr =3D of_get_pci_domain_nr(parent->of_node);
		if (domain_nr >=3D 0)
			return ida_alloc_range(&pci_domain_nr_static_ida,
					       domain_nr, domain_nr,
					       GFP_KERNEL);
    ...
}

Could the kernel distinguish valid multi-bridge domain sharing (disjoint
bus-range) from accidental DT duplication (overlapping bus-range) directly
using existing DT properties, rather than introducing a Linux-specific poli=
cy
property in the binding ABI?

Also, if a binding property were used, shouldn't it live in
Documentation/devicetree/bindings/pci/pci-host-bridge.yaml where
linux,pci-domain is defined (and parsed by generic OF PCI code in
drivers/pci/pci.c), rather than only in host-generic-pci.yaml?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102095150.2370=
959-1-cuichao1753@phytium.com.cn?part=3D1
