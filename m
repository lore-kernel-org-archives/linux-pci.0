Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619358;
	b=3RwwhUvUD0D9VPrSTFPPwmSDO4Q31AJDDYC4RiWQwQvuxeWFe0SEQVHyEU3yM6ebwdsT
	 UVpSp3loEPyw7e5UMpwOzNTbQKipgPaVwOc5VBm5y2U3Ag7IBZYITnTy0MmIlvt1qq+qc
	 vb39U4dS1Y+F4XNP0lFWD/ux7wUEFI86UL7w/P2PsEM1JszfcvqAtOW2G6n1/anD32olp
	 RYasM4iL1yyi0p8wtV4Av37lpRxz1qoCqvyxu0C924MTWIVtfmG88q0R4aP1FCuXKw9UU
	 ogirwYKbY3DUFKRXfO2OvUEqDh3PCfg4NVDSDm4Dp5y90xcvEgaTtHXBiVwwISTBMJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619358;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=M242AZXCt7J9UDmH7WST4l4dI9ZDNU8ZJUk9PpuMEFQ=;
	b=LX504041x3BLzTgm7a9elm/c/1y057Ziq80ZwL146uijT64MBQ7YxTh2tbLOzo9epJgW
	 QIedztOv1d3BdLg5jkT2vV+brAi/Eq5E+yfnhbE7JHykMLw+++mSPlTMAZj6NvX5xMVqk
	 r1NGPsTmsVXDDfzY0pbQTor1p1j1EQek3FZkZYoT0wXEwePQ/NOHe2m5tyN/zFJ9oz8bM
	 KprYRdildDT/6FiBUr6jpXalmyKne4jYHkXS1abolj0vZhwxte5wVL6vj2sy2wcV9OSXu
	 UbOQlKW4Oc1DVfZtWUJjn2iraM3nGpyluA6FYyCGvPHar7VJnQ9f+CsUWabr5JEtF6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzcVnmdZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD99606A324
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzcVnmdZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570431F00A16;
	Mon,  2 Nov 2026 11:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793619357;
	bh=M242AZXCt7J9UDmH7WST4l4dI9ZDNU8ZJUk9PpuMEFQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LzcVnmdZ5F9NNfIGZIElFo6YTmNReq9EvNuYde9sFe7UNs+dp6M8Mkus9eERXURuj
	 G2js47oIxYTJ5QA9rPd5HFtFMEN0YwTrkcUGxjjBpLIeG5H0e7Yd5ars2tQKDGgx+l
	 JVuLMx2xVUN6oin8KoDrsPdCh/GcPQa6CO2GKe0D8/wbz8gs3JihMfcf5Bhgz2wQGp
	 IlEoY8RbFHSKCzcpnYEI3zD3vumHbcMApG1dUfvR+20CWAuBtFf6EF29Pw+hdV6a2R
	 I+HzAQ53ye+g/kPsQr4ty0rhDt0TfScZrV/zFoN0tJn7EEGgqo5n/VuMD81lsOVQAX
	 T3/Woz5M3morg==
Message-ID: <sashiko-outbox-193338@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] PCI: dwc: Reuse Endpoint resources after
 fundamental reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261102111450.4010818-2-mmaddireddy@nvidia.com>
References: <20261102111450.4010818-1-mmaddireddy@nvidia.com>
 <20261102111450.4010818-2-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 11:35:56 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> A fundamental reset clears DWC Endpoint registers but does not end the
> lifetime of the bound driver. Each full cleanup/init cycle removes and
> recreates debugfs entries and, when eDMA is present, unregisters and
> reprobes the DMA controller. eDMA detection also allocates managed DMA
> linked-list memory that is retained until device detach. The
> inbound/outbound allocation bitmaps, outbound-address array and
> per-function descriptors already have allocation guards and can be
> reused.
>=20
> Track successful resource initialization in dw_pcie_ep_init_registers().
> On later calls, restore the platform-specific registers, BAR defaults,
> PTM and non-sticky registers without repeating resource setup. Keep the
> register restoration helper private and use the existing public API for
> both initial setup and reset recovery. Clear the initialization flag on
> full cleanup so a later call performs resource setup again.
>=20
> Invalidate the outbound window bitmap, address array and MSI iATU cache
> after hardware has reset the iATU. This resets software bookkeeping; it
> does not disable or unmap live hardware windows. Document that reset
> recovery requires the hardware reset and quiesced EPF activity.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102111450.4010=
818-1-mmaddireddy@nvidia.com?part=3D1

