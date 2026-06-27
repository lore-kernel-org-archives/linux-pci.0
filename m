Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B70E1A9FBD
	for <linux-pci@vger.kernel.org>; Sat, 27 Jun 2026 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782547981; cv=none; b=Rr/juWwmJlI83oy5bAC5Atqys+cACxHCIRTRcdAHcXzX50diIDonk0Gekn2A2iR2/TY9uBek2V5CYvzGAu17Zs02dR37cuarx4Qg7hyzrZ6zMlaDlMeN8zga5qqpZyM415LK8XMCdFSGd3jIi9DpLulCiIM1cbki9Y4ggQj5EBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782547981; c=relaxed/simple;
	bh=GWbDbC4Pg1imyqFa0s4+rrZ90Fj7gpLI4h1R3Qy0s3A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TkKsYXGoG+CETMkSQiNl8xo/kwTGMmH8PpsaHbrKFmIh0u3zTD+Qd2WQ62dRRyG4YT6s4iog8U8UkegCFZ2v2/UGCelUZl16cGrQW/haB9DmsZU0MbJYgulwhEDpaX/RGTNYQ+/S1wGYXB+5uMKmPrwo1/EvguI1jH1ROlHWEnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxN8AyZ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxN8AyZ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025B71F000E9;
	Sat, 27 Jun 2026 08:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782547980;
	bh=mDEZ8a3RhZLbY/mr8lV1ztk8mywxZq8cSeMEg3+C5ns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZxN8AyZ+ui2zzU4MNNRcsVXOaIyZxK6Ke5B0mFBWIaDMH+BSa2Wp5PqEpgJeUTc5B
	 yWXYNc/vxlvMqqjsZJvV0B6jQg1wb2kROhkPbLYZUekhz7L5EgnWZhOSL6lU6LJLHr
	 qUazXe2j3vJFnEiL4vD92u2o3FV/CrM5GH+6RfCNKIhInXmioY3TfHHR87pWjxbNaM
	 A5KOZtW+zM+P0Ffa0EfqAZylNs43cv2HPBc6dOFAywNmN/g8Sye6IK7TMrbLx0Aj4x
	 oHFHjLynOmO/b9//cyUa3XhjjHFgLVicqI4W9PO+/l0oE4Ie+HK9LchglDuA1VF05D
	 8rGh3/23ZOkIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] Revert "PCI: qcom: Advertise Hotplug Slot
 Capability with no Command Completion support"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260627080913.14002-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260627080913.14002-1-manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 08:12:59 +0000
Message-Id: <20260627081300.025B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> This reverts commit 480c94d3affbc11b9e98ca223a9fa19d90b84fbb.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627080913.1400=
2-1-manivannan.sadhasivam@oss.qualcomm.com?part=3D1

