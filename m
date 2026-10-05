Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE003233ED
	for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2026 05:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791179973; cv=none; b=Wvs0MZ/6EDZekeopLR9+a+kehJJs7cfmEUgNvr0PTWSVXCOf2V0M7nxKL5Ud/re6Fe3AnBOeZYxYk16Ou2ZgQTqSaF/kbe3F+Sf2XLOvwtjHupKHhNKdzI+N9StcNqBmzrlVh3UXziP0lTgp5rD4FhYaBQMPN+8WQD0WztdlA+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791179973; c=relaxed/simple;
	bh=3qIJDSPevmqGqOAuEasli9/toMVB3iMFhQphc4/AzLM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ol5rx1hgsGTObhYraRkbnRsQHZn/tgNSzdTw7rzudhD6gEROU4DDMtUgKyjplKIVqHqzAfaT909CyjQR9sGt4e6LN5uDBYw+Oyc7OvnBpoq0PfPHeaR7n8DOdfpocNHFSSeimC+aQCyaq5wkED06jYULJqZ2PmhQd81iOeo+4p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huuZEsv+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huuZEsv+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B85A1F00893;
	Mon,  5 Oct 2026 05:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791179971;
	bh=3qIJDSPevmqGqOAuEasli9/toMVB3iMFhQphc4/AzLM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=huuZEsv+zDtGj0n8QC/wdRB9Jgx6xbeQ89cNb423NsH5n7YNn7pMyp5WirJhX5K5t
	 CDUW253X9I3H0Fxsvj91rcORyFbIHbBahcyBrqEvpo2i8wVnhnIg152x1V+Kzzm171
	 5IcLjgr+Q+iVWemW3eAYkaXP8XrGHB2Ed2yVkNgJKlqs/4Ajz1cf7SsO/LN4R4IiK7
	 XEJcN00ja+iyFsE4Til4RdeAzQ/PWCaGOzA0Nef76bJ7mO0+jHiRI5xywxQy6BQem3
	 0gMBlVgsg1SuOytTt+5aclf+2CfgLmGYATGeELV1taGlduw4snIboOgEJr8cYPSBU3
	 +ATOmGb6WKQjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] pci: Add broken-GPE quirk for some Lenovo Legions
 with Nvidia GPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261005-broken-gpe-legion-v3-1-f49f465d48ec@gmail.com>
References: <20261005-broken-gpe-legion-v3-1-f49f465d48ec@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 05:59:30 +0000
Message-Id: <20261005055931.0B85A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Lyude Paul <lyude@redhat.com>
>=20
> On certain Lenovo Legion devices (including the 16APH8, 16AHP9, and
> 15AHP9), the firmware appears to enjoy firing a GPE on the parent PCIe
> port of the nvidia GPU very shortly after the GPU enters D3Cold. This mea=
ns
> that every time the GPU is runtime suspended, ACPI firmware immediately
> wakes up its parent PCIe port, which then wakes up the GPU. Once it falls
> asleep again, the cycle repeats.
>=20
> Note, this bug doesn't require Nvidia's driver. It happens on nouveau and
> nova as well, and it even seems possible for this to happen without any
> driver loaded.
>=20
> This seems to simply be a bug. Luckily, there is nothing that we actually
> need ACPI wakeup events for on the GPU. Events such as display connector
> hotplug events in D3Cold come through as ACPI_VIDEO events which aren't
> affected by this quirk.
>=20
> Reported-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Link: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905
> Co-developed-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-broken-gpe=
-legion-v3-1-f49f465d48ec@gmail.com?part=3D1

