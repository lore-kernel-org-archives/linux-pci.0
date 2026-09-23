Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F5057D224;
	Wed, 23 Sep 2026 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194760; cv=none; b=PPTNt/brxGB0mzorV2KXdMYHXjJLiKj2M1lEm6p1JnAsiS5FqXn4QleSsFZosJ6IltY7NqMlZhL1C7afRpeyeGpMJxy9Fd1ByKK+dWJw3ZKKpKY8E1BrtGTDchE9IgHd7dx8PU7+hZ+Kyki3gCamqbtUdeG/xmb227DV6Y4rAgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194760; c=relaxed/simple;
	bh=3FRSj6iiIfWaAi5wKJIcdZYbdXeVrZJVFxIK4mh+M7M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pehQmAdRLkrqAtnBHezQa5Ub/ZRFXlq/qknWGOayswoCUGn1gRKvBtVJGRH7h68JCDcHv6FM8hPdw+PtAnYdrDKYc/8ldCGzHBVSNr/vczvZLN0ssoTD/YqbRtOBgPT5qbbA0r3eYNgR+r6fAeTuhUWFRofQ3pgDeLiwZF9+l8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rs9e0zjp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rs9e0zjp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B031F000FF;
	Wed, 23 Sep 2026 20:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790194755;
	bh=3FRSj6iiIfWaAi5wKJIcdZYbdXeVrZJVFxIK4mh+M7M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rs9e0zjpMPW7NwzeCMLr7VN6F3wAbJGggHlC15tBnEGB7gs2QW8Rm4iY8NBkqOWs2
	 ICCJagCoHKqUK1OfN1Cvqmelc5YCIn8GNR+1YzEoeMWuS6AUE/2AqYKa028qMnQHSK
	 unbyTPSRxOAIGJo2gS2tameHYyf4q3qLowF2do5nHIahM3Pkz98jw2KLvghqQlceF9
	 ef/y+m2VVFomE64YoPMhKNscLaboa43LD8GAxT3Aw0aMvNUlnOUog8kpZU6o1jTEpt
	 AJHcEzZ8BmgrahKp0i7+2ftaTlO51L9xIJusc8X7EHEsKW60s1FKdKeCvpezM12tkd
	 saZd2TtjsVQ6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/17] PCI/CXL: Probe the underlying bus reset in
 cxl_reset_bus_function()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <a05695c1dcb0682425bad7b8387cd24ad71e2d9d.1790188510.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
 <a05695c1dcb0682425bad7b8387cd24ad71e2d9d.1790188510.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:19:14 +0000
Message-Id: <20260923201915.53B031F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> cxl_reset_bus_function() reports "supported" to a probe after checking on=
ly
> that the upstream bridge carries a CXL port DVSEC. The underlying bus res=
et
> can still be unavailable, e.g. on a bus shared with other devices, so both
> the reset_methods[] array and the reset_method sysfs node end up listing a
> "cxl_bus" that is guaranteed to fail with -ENOTTY when it is attempted.
>=20
> Probe the underlying pci_dev_reset_slot_function() and then, if it is not
> applicable, pci_parent_bus_reset(). These are the same two checks that the
> actual reset runs, so a shared-bus CXL device no longer advertises a meth=
od
> that can never succeed.
>=20
> Probing via pci_reset_bus_function() would not work: its cxl_sbr_masked()
> check rejects every CXL port with a masked SBR, while the do-reset path in
> this function unmasks the SBR before resetting. Such a port would wrongly
> probe as unsupported.
>=20
> Move the port control register read above the probe branch as well, so th=
at
> probe runs the same checks. That read asserts no reset, and a failure mea=
ns
> the device cannot be reset this way, which is a probe-time answer.
>=20
> Also pass an explicit PCI_RESET_DO_RESET at the do-reset call site, since
> probe is always false at that point.
>=20
> Fixes: 53c49b6e6dd2e ("PCI/CXL: Add 'cxl_bus' reset method for devices be=
low CXL Ports")
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790188510.gi=
t.nicolinc@nvidia.com?part=3D2

