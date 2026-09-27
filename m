Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631A8427FB0
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790533787; cv=none; b=gDdMkXZVgPt5U3DygpRLWFKf5zS9ye1XU6sYk5HszcJQ8WonfzOGPHRs+vDXul0EfILtV07jFT0zbdMa9x32+WQ9L5201P1tjTJXZxW3aYkuGcqNKCBgMxKhg1wgSCKVHYFnyzQTfs69pXfdisNBgXeReI2IuDIq43Gw0b0vTEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790533787; c=relaxed/simple;
	bh=3jh01DUm3Vkcr1dpDydsiC4CXQ1G5KRtm2gNg6LsJeA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QwesLZfu3nAkU1uGYjMxyH7q88XN5b8bRxFae/eQwpB+x4jvPvIOPeMKq4Ar3w47IHYklOMXi92h/8C49hcqwxQThtPtjYMvLNU8oaPr8CZ+xMUlXTIh3WHqPZvA59sjqQRs9N/hcPur9Wz7+kIpQJbLZAEnTe3+M76TxQBSKwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1XRvPw+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1XRvPw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224981F000FF;
	Sun, 27 Sep 2026 18:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790533786;
	bh=WZoWbATcGlbaw3MaeAsesoVhsnCa1pefTQdFC9++Cm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X1XRvPw+Lt8Jp4bYk7vtoe+gy3zoQbs49MyVChUGSN65TNRMAzPkVOZTFrIyFJLgp
	 c53n1XqTus4W8TqEFv/s7zl07DUPg7Ele4Jb5G206sBdadsGhz++oPqSQsMRoHts0X
	 Lgrrh7BTfkV16Ny92Zpzwm+UZ1YnOd5J85pw2O+XB+SbM4Ovr90W9OgwwbXgU3tKHU
	 AvKCbztDHjVR4jOWwDJqzinqu3ujrpVf7aKba2PN4/hPVUdsxQNRWHDAdVv/uglB+h
	 q0VdfFGiMpyfBAPdNUbfPTb2RbEwX1/GWs4UILwe0W4aJHQevFY9MvC7MHr5+/YhVh
	 sDgldsSwRipsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] PCI/AER: Renumber severity constants
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <244713dea3786099e9ad4eb10ff9f2f430cd7ad3.1790531238.git.lukas@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
 <244713dea3786099e9ad4eb10ff9f2f430cd7ad3.1790531238.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 18:29:45 +0000
Message-Id: <20260927182946.224981F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] ras/aer: ABI breakage in aer_event tracepoint severity values
--

commit 1b45a2c88d40942123bcb76f3b3bbf8eb9ec2cac
Author: Lukas Wunner <lukas@wunner.de>

PCI/AER: Renumber severity constants

This commit modifies the AER severity constants to align with the Device St=
atus
Register bit numbers defined in the PCIe specification. It updates the seve=
rity
strings and the ras_event documentation to reflect the new constant values.

> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index df0f5c382286f..795c551320088 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -11,10 +11,10 @@
>  #include <linux/errno.h>
>  #include <linux/types.h>
> =20
> -#define AER_NONFATAL			0
> -#define AER_FATAL			1
> -#define AER_CORRECTABLE			2
> -#define DPC_FATAL			3
> +/* Must match bit number in Device Status Register (PCIe r7.1, sec 7.5.3=
.5) */
> +#define AER_CORRECTABLE			0
> +#define AER_NONFATAL			1
> +#define AER_FATAL			2

[ ... ]

> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index fdb785fa4613a..1e03ade99386b 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -302,7 +302,7 @@ TRACE_EVENT(non_standard_event,
>   *			([domain:]bus:device.function).
>   * u32 status -		Either the correctable or uncorrectable register
>   *			indicating what error or errors have been seen
> - * u8 severity -	error severity 0:NONFATAL 1:FATAL 2:CORRECTED
> + * u8 severity -	error severity 0:CORRECTED 1:NONFATAL 2:FATAL
>   */

[Severity: Critical]
Does this change unintentionally break the userspace ABI for the aer_event
tracepoint?

The tracepoint exports the severity field as a raw u8 integer in the binary
trace ring buffer. By renumbering the underlying AER constants in
include/linux/aer.h, the tracepoint now emits different integers for hardwa=
re
error events without an ABI translation layer.

Userspace tools like rasdaemon that rely on the historical raw integer valu=
es
will now misclassify hardware error severities. For example, a correctable
error (now 0) would be incorrectly interpreted as non-fatal by older tools
expecting the previous ABI layout.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790531238.gi=
t.lukas@wunner.de?part=3D6
