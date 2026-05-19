Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A393382E7
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779159631; cv=none; b=CmZmZhV1oixNHOUTFO1gaU2yqzaWU5aKFW8rX19YX4SaQjKSTY3X7q4tKUzUJiOcGUiiNkIpcBGUBf0eQwibxCWsdw4fKRIbjvgAxayKNnPxk2JS4ItfS+TFCWcnUeGr/0Ue0z0xlcn1nEmduam5g4+D7JWM9zKqAJSJ5BN0ICc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779159631; c=relaxed/simple;
	bh=lHB5+tx29EdpautQyLI2rD9TpYurtTNk2IRC2bSQTPM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EYKhmkeo6Jh1vC3cEulBML2sEU/Wxte/jv2Pha5ccMoZTB6bGIhqczOUe4HuHgqqQwat0tlnzk/6GF4kSg0kYUZ3oOBVdrHyAJClAVvvVfOTtAIPKoBpawULkhUZvkMJI5Cs0HHNb7+NaMnFMMlDYiw9hkAfkxWkWLqmaOYR9IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4N3l2ku; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4N3l2ku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AE1C2BCB8;
	Tue, 19 May 2026 03:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779159630;
	bh=lHB5+tx29EdpautQyLI2rD9TpYurtTNk2IRC2bSQTPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=N4N3l2kuGyVd5ZqyBr9idFxac8VE9OOkcAmgtMZt5mavNDSae7z3GTSMh8VbUEcqS
	 QXW1N/8oPdNeBUhpgTVhSr6L4L+oIA4vodJZWx047gFEtPP9XQwwRCkGQlZ3CYCOyV
	 GnhNTWIpDecdxyGaoFSgkHWSra27yU7q5Fzoh5rB9wFdoKxreIQvuXaIeejhIU3SW5
	 su6cJLFSvKQpnRlsRDuch8vR44xIoZxT6FhKP51ekCaLWRgRMyE+Cq6FDo80dZ6NmY
	 +bongcQ2Akl7fi/XINKN56kACKhOdVd2eJaPRz1NiauVXQH+tdsIP1BGT+QT1IfFUJ
	 OcKilW3/qmSVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: hotplug: compaq: drop X86 dependency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260519024216.671889-1-rosenp@gmail.com>
References: <20260519024216.671889-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 03:00:30 +0000
Message-Id: <20260519030030.C5AE1C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message incorrectly describes Kconfig dependencies an=
d build behavior, and the patch introduces a brittle implicit architecture =
dependency.
--

commit dac4b501e3f9e9ff1b735ba64997762d448245d3
Author: Rosen Penev <rosenp@gmail.com>

PCI: hotplug: compaq: drop X86 dependency

This commit removes the explicit X86 dependency for the Compaq PCI Hotplug
driver. It relies on the PCI_BIOS dependency instead to limit the driver to
32-bit x86 systems.

>     This driver needs X86_32, not X86. It does not compile on x86_64 beca=
use
>     of invalid assembly there.

Is this description accurate regarding the previous build behavior?

The previous dependency was "depends on X86 && PCI_BIOS". Since PCI_BIOS
depends on X86_32 in arch/x86/Kconfig, it evaluates to false on x86_64.
This means the driver was already prevented from compiling on x86_64 even
before this change.

>     PCI_BIOS already selects X86_32, so the explicit X86 dependency is re=
dundant.

Does PCI_BIOS actually select X86_32?

Looking at arch/x86/Kconfig, PCI_BIOS is defined with "depends on X86_32",
not "select X86_32". In Kconfig, select (reverse dependency) and depends on
have fundamentally different semantics.

> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index 3207860b52e42..57ad8b048a032 100644
> --- a/drivers/pci/hotplug/Kconfig
> +++ b/drivers/pci/hotplug/Kconfig
> @@ -20,7 +20,7 @@ if HOTPLUG_PCI
> =20
>  config HOTPLUG_PCI_COMPAQ
>  	tristate "Compaq PCI Hotplug driver"
> -	depends on X86 && PCI_BIOS
> +	depends on PCI_BIOS

Could removing the explicit architecture dependency entirely obscure the
driver's hard architectural requirements?

Since the driver contains x86_32-specific inline assembly, relying on the
transitive dependency of the PCI_BIOS feature flag might be brittle. Would =
it
be safer and more explicit to change the dependency to
"depends on X86_32 && PCI_BIOS"?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519024216.6718=
89-1-rosenp@gmail.com?part=3D1
