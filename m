Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6980F4BA1CE
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827074; cv=none; b=b1VGboIOH5yzUzMva9HzMm8ek0a3QYUA1ta1VLgGxbdAAq3VeZ/dYZzD3ScFIcrUUeX+CdAzZyVR7uTnQt3gP158WfR3DBVrW6jLVHRh+QwrYhnviDv75t3XIW1JNPggMR2NsgoQuvmtdZ9OmyJ7WlzpI1ux1QoW7lrPGyBMuBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827074; c=relaxed/simple;
	bh=4/EdfXMW5Vqg1cUnQyuv7Ao7060KoW/fL+xc3B5dUfs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=fLX/XWR/3W3SmrKSF1a+yw82AffuQYj8kWY366K4Hhj/6Bpv+2dYyh4HVb96y/uWQBPPcQMwUj/8yKmulf+4zX4tbpqVExX6Q3tfm6Frv/VsoSdAOp6C0OWmh6ca4zDeQ9CmymRfzIcAnlTe/6/ESKRTlTzI/nog5LTbM9r7tFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrm890gx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrm890gx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213FB1F0089B;
	Mon, 12 Oct 2026 17:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791827073;
	bh=GtSYe9svWmETFoSuhDJqDPh44HGW4TuzWhxAZNh8iO4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nrm890gxN1noL9GAR5NP8UF0dTLDgnKM/3YqkVK1FIOEJNZRsUfLJ4BKr6S3oWOmg
	 zjba+klfHX2/OybYiYmJDww1yAk5doQ7T9TpnflBeDGHgI91IdT90tyEkq8FGkm//a
	 baCaApY3ttXrJsy/eZoOGRpEU5QFhcZ9VSpyfKMM5bXs3LFAuq5srrQGu+I0LOlzvJ
	 l6fTn2BD+LPHWSZ2pJGmtPY81fqqWMlHbVl/W1swFnBsofbZadx+jM9cS7zf+SFw6p
	 D2N9MLyXKPm+7n/7ZF3EGEy2C6yaiC7adTAOtlJzHIU5RDYvq8ISuYpMLxRXsjR7nB
	 JEtkx8drY7HDQ==
Message-ID: <sashiko-outbox-168485@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/2] PCI/LMR: Add Lane Margining at the Receiver
 debugfs interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261012-pcie-link-endpoints-v7-1-36aba9c91f10@google.com>
References: <20261012-pcie-link-endpoints-v7-0-36aba9c91f10@google.com>
 <20261012-pcie-link-endpoints-v7-1-36aba9c91f10@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 17:44:32 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-pcie-link-=
endpoints-v7-0-36aba9c91f10@google.com?part=3D1

