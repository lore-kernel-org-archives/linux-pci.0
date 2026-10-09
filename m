Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA72363C43
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560792; cv=none; b=b+nTku4LXDLBuCuRFPl69QqxBJGGqNoT6vTGMBEcPusmDPZZV/XohPkg95pWlRVvQcjceqMz4OhONSRlcOuEXXjXHEwMU2Rgk+3h6dg863/e5ZHaFL6RxFyuJ6LJlIcKBPHT2uWpyqHebj6f/Q9xubjsgTpeMi8UcKJel8/qI/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560792; c=relaxed/simple;
	bh=fqvJILd/jZz0Mj2CWv+gF1lol8cO6RplFQztVs/Ir+4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UixDP5onrrnraTstPjF1/KK3VVIgO65+01tI8L5aIxAxy1mLLQl394MCj7h3uxlquq4z/cWeLspSJEvUrQrA+iCjX2ihnQEkquT5Ud9VsWryvVGQ35ElX/Y2NI4Xq9edHI4X+kcmTTZdGfoLf5lZ58Z26lwOzm3Kv6ICGXMZSGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esfpjf3D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esfpjf3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8463E1F00893;
	Fri,  9 Oct 2026 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791560791;
	bh=Qds+GYfyfLd1W0t+bDOq73HgtXyPCyvPDWLYnzPNp/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=esfpjf3D9KRy6TL23e5HIpPmG1en33DGWjgRQsOyh4cmjhDOFGbodZK3KmqcQ3mqA
	 QYRy7O5f5ULSYh8AGPXDl5uWURdkgsnkhQtTSiYQfzeqY0UXV1YND0XgzgyQomGPNy
	 rT120y/YK9Pmr1iVwRhwA4gePbuYI9ktpN9S6Gs3EGv8fUEmNRZmQoHgkC/mr2lO9T
	 c15vbzZ88xQmcAt6jpWZ11cirQ7r3DXQTbmfJOh28aWTm9kndUjWwktQYBMQPxg0gJ
	 XVdWZta/TAhBbhYaFplgugi74qLgFJkpoSo+ukcZpMU48mz62nGwK128O6OpcahNLX
	 LA2TOUqtNKWVQ==
Message-ID: <sashiko-outbox-165794@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI/P2PDMA: Allow P2PDMA in VMware guests on Intel
 hosts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavel Popov" <pavel.e.popov@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261009154034.82321-2-pavel.e.popov@intel.com>
References: <20261009154034.82321-1-pavel.e.popov@intel.com>
 <20261009154034.82321-2-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 15:46:31 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] x86/cpu: non-monotonic VFM comparison incorrectly matches older In=
tel architectures
--

commit 057eed2a36be8e0dd1417073d5f1e8a59caa5ea8
Author: Pavel Popov <pavel.e.popov@intel.com>

PCI/P2PDMA: Allow P2PDMA in VMware guests on Intel hosts

This commit allows Peer-to-Peer DMA (P2PDMA) to function in VMware guests on
Intel hosts starting with Skylake-SP. It bypasses the standard host bridge
whitelist checks which fail in VMware guests due to passthrough devices
appearing on virtual root buses without host bridge devices.

> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 9334eb314663e..d96f44d0738a8 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c

[ ... ]

> @@ -532,6 +538,19 @@ static bool cpu_supports_p2pdma(void)
>  	return false;
>  }
> =20
> +static bool hypervisor_supports_p2pdma(void)
> +{
> +#ifdef CONFIG_X86
> +	/* Hypervisor hides host topology, allow p2pdma on Skylake and newer */
> +	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL &&
> +	    boot_cpu_data.x86_vfm >=3D INTEL_SKYLAKE_X &&

[Severity: High]
Does this logic correctly identify Skylake and newer CPUs?

Intel's Family 6 model numbers (VFM) are not monotonically or chronological=
ly
increasing. INTEL_SKYLAKE_X is Model 0x55. Older, unsupported processors li=
ke
Broadwell-D (0x56) and Atom Goldmont (0x5C) have numerically higher VFM val=
ues
and will erroneously pass this check. Conversely, some Skylake processors l=
ike
Skylake-L (0x4E) have lower values and will be incorrectly excluded.

Passing this check on older, unsupported architectures could result in
unsupported P2PDMA transactions that trigger PCI bus master aborts or
Uncorrectable Errors (AERs).

Would it be better to use x86_match_cpu() with an explicit list of supported
VFMs rather than a numeric threshold comparison?

> +	    hypervisor_is_type(X86_HYPER_VMWARE))
> +		return true;
> +#endif
> +
> +	return false;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009154034.8232=
1-1-pavel.e.popov@intel.com?part=3D1
