Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7F24A0EF7
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303877; cv=none; b=FyQv1mcfTNUu6DdX0guQY3BftKv24iLeIYl/ZH4ojU32yYAFyvcbssFWUUDXuWC6i9FhDfvk9G95AVe6+iGTD3r4Hr2A3167QTlZvR5kr6TiIPVGp7vRtkQJhkzatGxdqzGNTOpFAI5fKB7Vjkr4oYNL3PCBxdE0TWcytOU5S2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303877; c=relaxed/simple;
	bh=zWrZH8Mk9ZNTVgL04kDn0HKKpXTxoYtRqR3zwOaEQug=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SZBEnaflmR8i5S0r0Ma3Llg3BYbCk5oTjVGgSZw+Pp1xCPMMgrVsZjpXSZFSbDLlR7rbdcN65CJOc7Do0DRyadzBgYBwHU2eF2811r7VOKgySDkHrYNn+YV6J9PchIFmiozcDUPQ7dHg+sbOcCU7aYt+mG9kEPikDLP91VG3dd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwCCSsh8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwCCSsh8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C531F0089D;
	Tue,  6 Oct 2026 16:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303869;
	bh=2fbebFvR0OdlleOmY2MtR/KbWX0YqItpwFe/EpYMRHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JwCCSsh8Fh6wvatpBOkS2/PDL/Yq5b58C0BhULK35bWxAwxt6M1aJG8Tumz+zd8M3
	 dKdHcxYkTynXROs08CRddpfURUYgXcZIgtHEgPp7ijlDM7Hn68NIC1z30sVbZ9nfDo
	 HsaQ7ZB7BqJSLqqbHey8VnGp4Isrf+S2yrDiZr5E8na0Vlwxnb4WL3+CxV8C4VqVKw
	 rMYIuA1DOOkcCCEs/t9awzbOteFQuHBgdl4FVko/el9XrmpRMmQ6ej26wMiVoPgESO
	 cBtS3Lg74pqbJRRQQGUGRkNVPjNBILRAwyj6iwik+FUTEQkiH/f3J2N8klZhHfR5Q8
	 3h6Lp34b3Y4Jg==
Message-ID: <sashiko-outbox-162253@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] PCI/LMR: Add Lane Margining at the Receiver
 debugfs interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261006-pcie-link-endpoints-v4-1-ad5398c4260c@google.com>
References: <20261006-pcie-link-endpoints-v4-0-ad5398c4260c@google.com>
 <20261006-pcie-link-endpoints-v4-1-ad5398c4260c@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 16:24:28 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Lane Margining at the Receiver moves the sampling point of a receiver
> away from its normal setting, in time or in voltage, while the link
> stays up, and reports the errors the receiver sees.  It is available
> on links running at 16.0 GT/s or faster, through the Lane Margining at
> the Receiver Extended Capability.
>=20
> Add a debugfs directory, pcie_lmr_<device>, for each Downstream Port
> and each Function 0 below a Downstream Port that has the capability.
>=20
> Writing 1 to 'enable' starts a margining session on the link.  ASPM is
> turned off with pci_disable_link_state(), Hardware Autonomous Width
> Disable and Hardware Autonomous Speed Disable are set on both ends,
> both ends are kept runtime resumed, and the port's Margining Ready bit
> is awaited.  Writing 0, or removing either end of the link, ends the
> session and undoes these steps.  Only one session can be active on a
> link.
>=20
> During a session, 'receiver' selects the receiver, laneN/margin_timing
> and laneN/margin_voltage issue Step Margin commands, laneN/caps shows
> the parameters the receiver reports, and laneN/status shows the
> response to the last step command, including the error count.  Before
> each command, the link is checked against the state the session
> started in: speed, width, Margining Ready, ASPM still off, and no
> system suspend since.
>=20
> The kernel does not run margining sweeps or interpret the results;
> that is left to user space.
>=20
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-pcie-link-=
endpoints-v4-0-ad5398c4260c@google.com?part=3D1

