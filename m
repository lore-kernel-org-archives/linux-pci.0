Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2BC3E639E
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 22:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277134; cv=none; b=nyFu5t8swQapGoL0b0XFVE6HjZDlMqZ7iDmgQuWcFh5LMgkMlzQDY6gRxkfdt1LpOen2mFIiJ1OGOuJqqtHKR8jgp15jNPqZoKFbMcZOruX/vtMqWd4r3ePQQSIVCd43gM+2DuhcMND+SK8j1YfIN8kMH+7emnOEysBYY1zIbCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277134; c=relaxed/simple;
	bh=RyNsbfK9m1yPjDfNQPlR76wqtLdVVllX+a5ocUBKoYE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rBPQgwNU1v1dElx3ydwReIB5uCH8kVZRx95jm5VcSjkukJjlcqoz0m60vJPcBjRfg6Qa0skdR3clceket6rgyOTzNvCi6UiVJXL3Xverl6b1RQb+IQ7tCc2HWKtzLxgirCNT/Ysjfctk+tiEacstfaazrzQw9KHMAiv1VnXyggA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aP/0g4d6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aP/0g4d6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0F01F000E9;
	Tue, 28 Jul 2026 22:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785277133;
	bh=qFzClYDF4TsXjTZhSFmIAmFk3N87Wuhk8fBJo67g9ps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aP/0g4d69a9yIOLiOxHuG6xQtbKtQEe8UpwMSjluKFSKlWR4oBZbF2u3bGaGwBGUG
	 +Eb+HSOzPyWVoH+UGDk+1gbOvJIPMNTFmhFMyD2wynvn+w4LFN7GSiH3IbgAaNvgty
	 4jrhUyhHk2QUM+VseXKbrB+ALWoigv08YbNyxbKvxsvdtZ+f6DB5vWPpjw7NA+aZBe
	 d2Jp5TSLJUdgruFPvg2WR3VFndSoOXbuAmwtbAy2OvENtVYMbkIp0B7INwOu1XrUvr
	 GOlI8PooDq/f0ZqaTpfasYEtJIvRUDqaW3BbX74FXC6IQxjGYZH9neUML5dLo7l7sg
	 bTr30mJDP9GAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/12] PCI: liveupdate: Auto-preserve upstream
 bridges across Live Update
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260728221007.2098560-7-dmatlack@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-7-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 22:18:52 +0000
Message-Id: <20260728221853.4C0F01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `for_each_pci_dev_in_path` macro violates standard kernel itera=
tor conventions by not initializing its iterator variable, creating a confu=
sing API that may lead to misuse.
--

--- Patch [6]: [PATCH v8 06/12] PCI: liveupdate: Auto-preserve upstream bri=
dges across Live Update ---
commit 5f902c08492796d638f5197db23659b872ce5e10
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Auto-preserve upstream bridges across Live Update

This commit updates the PCI Live Update mechanism to automatically preserve
upstream PCI-to-PCI bridges when a downstream device is preserved. It tracks
the number of downstream devices preserved under each bridge using a
reference count in struct pci_dev_ser.

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b41dd572a2d6b..6267c83813d55 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -829,6 +829,9 @@ static inline struct pci_dev *pci_upstream_bridge(str=
uct pci_dev *dev)
>  	return dev->bus->self;
>  }
> =20
> +#define for_each_pci_dev_in_path(dev) \
> +	for (; dev; dev =3D pci_upstream_bridge(dev))

[Severity: Low]
Does this macro violate standard kernel iterator conventions by not
initializing its iterator variable?

Standard Linux kernel for_each iterators typically initialize their loop
variables. By omitting the initialization here, the macro expects the caller
to pre-initialize the variable and then mutates it in place.=20

While the current usages in this patch are functionally correct, could this
unexpected behavior lead to confusion and API misuse for future callers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728221007.2098=
560-1-dmatlack@google.com?part=3D6
