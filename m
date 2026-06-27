Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC781A9FBD
	for <linux-pci@vger.kernel.org>; Sat, 27 Jun 2026 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782547813; cv=none; b=C8CHKrIwOc/7plZrdCzlvlXKeemymjBidEK0JAiPTJNrCxN3yPjZiyI79pGjuOq/y1Rv2s6RLZD06u+4+BGd0quBh0uVCuW+1NN0xiHmKYM/KSFdQ0F6WskU2AZpAveF+moYunOv64t13ad4M3p1wu8dK92um0vOK2sBSxWMFP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782547813; c=relaxed/simple;
	bh=nNzC+hPml0wyMDQJYEMeVjKWteXsL8ROmZA5UvtcAsw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wgg0JeSi5mKlZR7+pl9v26SK0IDlNdvEleLYwGQVSWeNMfB3FV4nksCCYfGNf/XSGS/AKOOd4uR8cae4kQL3HluTaOU1H36CzSCzluU5fp9TeNth8bOuRXgZodTKnBh+7VIpQizm5Y2LB0eEpGx7W90v3dnk486uwvzraTyC68c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C47+jSls; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C47+jSls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F981F000E9;
	Sat, 27 Jun 2026 08:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782547812;
	bh=BKyTnEJlgtZxrQl2Lzk/LZQnkIuFybVv+OPLr2T/W60=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C47+jSlsNCERLl3K8wdTkIXH0f+H2kbAKHrNUEo2oK6bltZTXJy6VI+pHuuxqsdO2
	 0SdT9ysaZRexVqqF8houYoPgH0AxTbvF0cxPDAMV8MyAgqOHF3w4RyNgwcYshBjl3m
	 MMC7gHTe8F0aS1HvyJ/ffRCsv8JxOfBQP/0+6rX45vmm+dNvtpuXiuHBGmfSwW5aAG
	 u0OctH9ZCsRqYvkupzOCs9bcfNQs7UHXYZ4/An20RmcUIf2pn/YskzuzRuMFHHavL0
	 W4PWEoDBBewPQAogeUG5LD5wK/a0sc8Ha1KriVOw6MIXND2mO/25vZfTi/8XiqH1LO
	 7IM/Ivdmy3odg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y] Revert "PCI: qcom: Advertise Hotplug Slot
 Capability with no Command Completion support"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260627080702.11517-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260627080702.11517-1-manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 08:10:12 +0000
Message-Id: <20260627081012.80F981F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> This reverts commit f176c47683bf6365e2f6d580d557fae49169a703.
>=20
> When the Qcom PCIe Root Port advertises itself as hotplug capable, the
> PCI core pre-allocates a conservative 2MB non-prefetchable bridge window
> with 1MB alignment during the initial bus scan. However, the WLAN device
> (17cb:1103) on the ThinkPad X13s requires a 2MB BAR with 2MB alignment,
> which cannot be satisfied from within the pre-allocated bridge window.
> This causes the device to fail enumeration:
>=20
>   ath11k_pci 0006:01:00.0: BAR 0 [mem size 0x00200000 64bit]: can't assig=
n; no space
>   ath11k_pci 0006:01:00.0: BAR 0 [??? 0x00000000 flags 0x20000000]: can't=
 assign; bogus alignment
>   ath11k_pci 0006:01:00.0: failed to assign pci resource: -22
>   ath11k_pci 0006:01:00.0: failed to claim device: -22
>   ath11k_pci 0006:01:00.0: probe with driver ath11k_pci failed with error=
 -22
>=20
> [ ... ]
> on the Qcom platforms.
>=20
> Reported-by: Paul Guder <paul.guder@example.com>
> Closes: https://lore.kernel.org/linux-pci/CAH-zrtu1Bci7M-tQc9Vme9z+Bw=3D1=
gthM7z6=3DXX33Jjd_Q6itcg@mail.gmail.com
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627080702.1151=
7-1-manivannan.sadhasivam@oss.qualcomm.com?part=3D1

