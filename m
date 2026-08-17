Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF6843CE47
	for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976923; cv=none; b=fPCvRfTL0F0c5yy7ZGtV5ne3OhV8VGahR8u+4k9f4qFmQ9NEDRLhcK6g7puzMQsDBzMN2esPNSZ7UcaF/uuJYxIL9eKcB79L3Gq99D1sVF9d2DslcEBFhTOBFuNq7mUKLxRoFWbnTjRxDr3HhWnFe9hpfRxF7KVj4h3nC96/ld8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976923; c=relaxed/simple;
	bh=HgqRXlEpm43K2omV055N1TdupZsv5Q5v1QoCwmpMy3I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a6dsZVHcmAdauessQiQjsuKYXidr4jcgdQRQiIJsCMy9rN740nlAK4PqhI1M30fc0Dwn1zuuxIhd8RwwVSKbFO0rxtxdSo5SHOaHvZmf+7G6oTZNWvQYL9+TICjU0kmUwxtCpbcpcI1ul1/RUfNwtyILGgd9z89Y+E2vdJvrj6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXgskeX9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXgskeX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407021F00A3D;
	Mon, 17 Aug 2026 14:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786976922;
	bh=RcWe2DCb+77NllFzXV9i3N//6YKpE+A2+CP620a1CE0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SXgskeX9TPhcJiC1uLZxYnL+m55jfk/lrYhgU1x5tLTYFURz/P64Zmv3J/j+q3OVL
	 pZIquR+PXCj4f/LjcU536ENxbWcKPf3GSZouqVnD697nCWW5i0o4WP0mlqSxX/JTTb
	 3QonwKjLCmf9TZ6ya8wpbDJPQCj8YXCZywGibGwVRyt4FbuBWVXhz53fa+CWeke/aC
	 f0NjeT4aGCWztzva4svu53AsM8SU0jT+561lycl5V0AY1Sz9zvRdAx4Hk7snpsRGcF
	 5pThtdCpvwczB/fmIeXsSfXCDdQhmb3eDhdb7pMgcddmyIINmpYyXdm5TgDy/niVF+
	 nYKa/h1pSa1sQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: lock upstream bridge in pci_try_reset_function()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260817141918.1339057-1-runyu.xiao@seu.edu.cn>
References: <20260817141918.1339057-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 14:28:41 +0000
Message-Id: <20260817142842.407021F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Eagerly trylocking the shared upstream bridge introduces spurious =
-EAGAIN failures for concurrent resets of sibling devices (e.g., Virtual Fu=
nctions).
--

--- Patch [1]: [PATCH] PCI: lock upstream bridge in pci_try_reset_function(=
) ---
commit 26cda84dc0be3f7ffec20ace1e3feba4ee2b0184
Author: Runyu Xiao <runyu.xiao@seu.edu.cn>

PCI: lock upstream bridge in pci_try_reset_function()

This commit updates pci_try_reset_function() to trylock the upstream bridge
before locking the target device. This ensures bridge configuration access
is serialized during a secondary-bus reset fallback.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee615..c18aed839a866 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5282,20 +5282,33 @@ EXPORT_SYMBOL_GPL(pci_reset_function_locked);
>   */
>  int pci_try_reset_function(struct pci_dev *dev)
>  {
> +	struct pci_dev *bridge;
>  	int rc;
> =20
>  	if (!pci_reset_supported(dev))
>  		return -ENOTTY;
> =20
> -	if (!pci_dev_trylock(dev))
> +	bridge =3D pci_upstream_bridge(dev);
> +	if (bridge && !pci_dev_trylock(bridge))
>  		return -EAGAIN;

[Severity: High]
Does eagerly trylocking the shared upstream bridge introduce spurious -EAGA=
IN
failures for concurrent resets of sibling devices?

When concurrent threads open sibling Virtual Functions (which share the same
physical function and thus the same upstream bridge) via
vfio_pci_core_enable(), both threads invoke pci_try_reset_function().=20

The first thread successfully acquires pci_dev_trylock(bridge). The second
thread fails the trylock and immediately returns -EAGAIN.=20

VFIO treats -EAGAIN as a fatal error during initialization, which can cause=
 VM
startups or userspace applications opening multiple passed-through VFs
concurrently to fail spuriously.

Before this patch, VF resets (typically using Function Level Reset) executed
in parallel since they only locked the target device, not the shared bridge.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817141918.1339=
057-1-runyu.xiao@seu.edu.cn?part=3D1
