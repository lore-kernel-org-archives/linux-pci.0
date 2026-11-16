Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822406;
	b=4TnufwAIKA2VctIHQ4AXANYV3twctmofnUyMXRVaBKY5RKG8UWVSpaWVyLYpQsbEP0Na
	 RqWB79a+0sNgUvJIxVFvNy0+xUo042jyvHVEsxatrTxFDGmIIfGabtlBVRe9t53Cd+1T3
	 Z2k1lkqqcKDlPLH9hHvHKEUgiyf81D3idhN5NsvHRPCVu92Tfu63CzBpZ5RXVdP1pdpOT
	 ChzgRFPcJZSXIiv79Q1kYszUfgVPvbIp7nXBxS4KYaUkuPSJq+Z1U9HmpqLGKz/vfwA90
	 73QDD04onOsdAw8ZaSorALdwN+EDLTkHcaBsydSdlDoPxh4ZmEX/uIHiaty8JHNAjyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822406;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TseDfUkS6YTK/qWDUHqr0w332iE476hbl+fhvbCBL1o=;
	b=mRVDp+E+BZkSB4qHiTKmiYFOXhLqTwPGSe7gzhZd0WK/v2SI/Zo4E1xHSKkpiJjFr7+J
	 n85SRXc0urKNtnNWISzozo41e65kPbdUkp/PRh68aRdHj75cVi/XIETrF4gJbD5CUpM8m
	 yMZ6gyvOI/Whic/POFUKB27w44WdH7y7dMM/2uST/djv0i5Dtwc10CsAoZQb3jw3y9UvH
	 d/BVoBwXE+VaqVNg3ZA02am1PuFDy1pxY+jQ1rJWY8+0l0bmW1wL+I19ufs29brDM4jd4
	 KNSXabsw8ODVvpd89uTaTPlANtTn/wzc6xYMzWcI40sIX+4WCUi1JQnb341rC/jjqgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="op/CC8zf";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29B7606A329
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=op/CC8zf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618A51F000C8;
	Mon, 16 Nov 2026 09:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822405;
	bh=TseDfUkS6YTK/qWDUHqr0w332iE476hbl+fhvbCBL1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=op/CC8zfvQCaDR2iS+agctoB/zuFqtrZbWiLzeItS5OexCQitdpA9BOassUrkkDkk
	 BeasL5CVIA7Tn1qAHazpwQFM3iZz8LGTEnChMUNivHBiAT2CmSU1DxqqtAM+/vJfmF
	 UXMxgB6Z7d8LcXVu6n76bOR/efMHE3iL4fF8SU9TtWXad9bQlxrLGUft8vuzoXhYRA
	 x2vAQdx08pv9AaQXLdQ3bWLBzOKPuJX8NFRr7lee67J72RTkAU14+KXDaZ4DJuEs7r
	 yv+Jr8+nEa3SZo122s9JbH/AhgaUSwXERy6XW7y5L63lLHrK9VkCgwTg9XxDRVFgVi
	 1aEudG03eRWxQ==
Message-ID: <sashiko-outbox-216634@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 1/6] PCI: rockchip-host: Skip downstream config
 access while link is down
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Thompson" <matt@boondocker.io>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261116-rfc-b4-v3-1-0bf052b68f2a@boondocker.io>
References: <20261116-rfc-b4-v3-0-0bf052b68f2a@boondocker.io>
 <20261116-rfc-b4-v3-1-0bf052b68f2a@boondocker.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:46:44 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Matt Thompson <matt@boondocker.io>
>=20
> On a RockPro64, a PCI bus rescan with the downstream FPGA unavailable
> faulted in rockchip_pcie_rd_conf() during a vendor ID read. The rescan
> task exited with interrupts disabled and the watchdog reported a lockup.
>=20
> Check the controller's link-up and link-training status before issuing
> downstream config requests. Return PCIBIOS_DEVICE_NOT_FOUND while the
> link is unavailable. Root port config access still uses the local
> controller registers.
>=20
> This check cannot prevent the link from dropping during the transaction.
>=20
> Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller support=
")
> Signed-off-by: Matt Thompson <matt@boondocker.io>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-rfc-b4-v3-=
0-0bf052b68f2a@boondocker.io?part=3D1

