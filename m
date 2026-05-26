Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DDB3A7186
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 04:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779770471; cv=none; b=GCNDk0ORCQjyG7GN8cLk5KyNM2Rlj0LfZGyzOEJu3+7VmLg2E3CVfm6+L45AvMLlHgw0rNM3q5aDLnqWuWlcMZ4fvmqaQo2pBO9ZM1VXYwBOaP35DOUFDDF16dQHLNQL8aE0vQatlgpAGo3+6tacz9rY5pydBGhcRfyQznotkR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779770471; c=relaxed/simple;
	bh=xJ86fXBjfFNJh7GBPYbuQAwpdHl01DwqPRIM+MkY6ZU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qb+G4UMRazsm8Ha93ZY2bZSxZnG04R0kOfLnM9PWUbMmStm/YmrcCTsLASgIMqrDtiqo3+cE3aluCT1FY/mO28QfyADGXgM9ina1Rm23jE9TMjUTR/ca4a5BlevW++U0Foy59ebgNTR+82zRxOMhM/szkgPI5GwUKMbBKmXoT2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrVdje0z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrVdje0z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B821F000E9;
	Tue, 26 May 2026 04:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779770470;
	bh=I1dp4Ndkzd/I8EAiPo8rqJRjxv/q7pnS9GQgbHvZG2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jrVdje0zxwFXxP627z1mITpb6we7MAVoT4+77PbV6ZrLNwS6vtWxKMGte2RudDtL8
	 dKH/dx3pxTQE10+7C4IakMeLPoeBVo2alkcnFH6hiwQNtXhzl0JSdYAtMk7AuN/9Fs
	 eoZWPJeBwIiMoNoIJUO6nqEab3l/zNLTyzbVSvb9Xdxmzp6pZ+Rgsk33mYLU4oR4yO
	 dtUOsiTTc0l12oNJaygUirzUJJfwtDPXDGk/UsVJmgkCTw5d8YwUje4JDr8rH996jl
	 gcb/PidLutiasm3KaQMnWl3PVU+GL+dga+WADccHv4/EY9sim8u/CT3Y05AX/4hpFm
	 46U+0EeWcvK2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] PCI: hotplug: compaq: fix X86 dependency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260526042614.1013867-1-rosenp@gmail.com>
References: <20260526042614.1013867-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 04:41:09 +0000
Message-Id: <20260526044110.29B821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit introduces a redundant X86_32 dependency and the comm=
it message falsely claims it fixes an x86_64 compilation failure.
--

commit 2f32c0aa3739414d8be655780c2734e155b45ea8
Author: Rosen Penev <rosenp@gmail.com>
PCI: hotplug: compaq: fix X86 dependency

This commit restricts the HOTPLUG_PCI_COMPAQ Kconfig dependency from X86
to X86_32. The commit message indicates this is to prevent x86_64 build
failures caused by invalid assembly.

> This driver needs X86_32, not X86. It does not compile on x86_64 because
> of invalid assembly there.

[Severity: Medium]
Is this description accurate?

HOTPLUG_PCI_COMPAQ already depends on PCI_BIOS. In arch/x86/Kconfig,
config PCI_BIOS is defined with depends on X86_32.

Because of this dependency, the driver could not be selected or compiled
on x86_64 even before this patch. Could the commit message be updated to
reflect this?

> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index 3207860b52e42..5074c0ac4ce18 100644
> --- a/drivers/pci/hotplug/Kconfig
> +++ b/drivers/pci/hotplug/Kconfig
> @@ -20,7 +20,7 @@ if HOTPLUG_PCI
> =20
>  config HOTPLUG_PCI_COMPAQ
>  	tristate "Compaq PCI Hotplug driver"
> -	depends on X86 && PCI_BIOS
> +	depends on X86_32 && PCI_BIOS

[Severity: Medium]
Does this introduce a redundant check?

Since PCI_BIOS already restricts the build to X86_32, changing X86 to
X86_32 appears to provide no functional difference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526042614.1013=
867-1-rosenp@gmail.com?part=3D1
