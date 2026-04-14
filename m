Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B485389472
	for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2026 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776207837; cv=none; b=XA2xv5xxgxxzNlNDHuxSI7fRT5RlPd7ziSkHAyjO96GF4Ovwf00OPvFCt3DT+Q/Thyxqu9rPF6dDZUIOHflt+3JVgFkbpIKo3BijXWbxb42ASvLjdNbl+6CMnOPsBFMFKKiBRjDqtTJtlGGhX1AtzXmzfhUyLaLR/e6VDr0ptOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776207837; c=relaxed/simple;
	bh=EkBHiVCFVAdtMcYoyVUw520Je70YymN/TMMD4BxSlMg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCgbze27AdP7RWAMqBYZqpsHEiTmzR7IsbK8VOE3Q+aE9cOV4OZMV765KknQcw6bsBqp2NoQbXVks46m1sk6hHQ2EvtYAH0TwaPyr9WVD2npXP3zBUFGOz4a1Ojp4m+Me2/Yl75oaczwQXjm3dnz++i4eDN2DXkqBYtXsJK/DdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=r26.me; spf=pass smtp.mailfrom=r26.me; dkim=pass (2048-bit key) header.d=r26.me header.i=@r26.me header.b=Vf49MAmq; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=r26.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r26.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r26.me header.i=@r26.me header.b="Vf49MAmq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r26.me;
	s=protonmail; t=1776207831; x=1776467031;
	bh=EkBHiVCFVAdtMcYoyVUw520Je70YymN/TMMD4BxSlMg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Vf49MAmqsUKDbrdAeW3u51/etLEzFfqIze9PWcnHZOEEN9PMuF0JDaEQXQVdq2t5O
	 wBComDJolKiaMRpL+7jOEG0pO03HqWQbxn91d3nXyaNyTgGuFnv6zY03DO8aiQFTmL
	 uQgqm98yVzzgqpU3afMlnGIRn/yYIiIp48Qi1rg4YGsxYqlGTb8LtuXFSXg77z4SN8
	 nxPp8DmuQVocWyMXJL+xgGWOpWqLBxFrAuFTAkIMK4ItmcAC6bzqRiMGf1AzEeAecY
	 V/ZFV7gEk/BRs/oSUnuTn059oD2P44eMaBKtreZBW4LrWUb7be/HR5OsdpSegz1cZb
	 JtyypY7NSl7Xw==
Date: Tue, 14 Apr 2026 23:03:49 +0000
To: =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
From: Rio Liu <rio@r26.me>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [REGRESSION] amdgpu fails to load eGPU after 6.19
Message-ID: <j-oL8G7jik8a-PYnIVU4kE-w4HJaq9pNshpbPC5zphvGa0SIno_vpSq1zEcBUVDx6hSMvbV1eAIcIO7C8jtMv0GTG7UfvWVZaEzabnQ-6YY=@r26.me>
In-Reply-To: <4dfc25f2-f660-c234-4e4d-c5c76216523d@linux.intel.com>
References: <a1FodrO_nl6UemO3VLBk5Gsu6PjvxLU-OYhvJEMeKFem-Bpi7ZXDHrIxtwsTCmpn-WndBxnzZNtdKJy_V6PjafnFjSKz7sr1eEfGobRzpgs=@r26.me> <4dfc25f2-f660-c234-4e4d-c5c76216523d@linux.intel.com>
Feedback-ID: 77429777:user:proton
X-Pm-Message-ID: d890b8beb51b38e0c8a44847b3d98c8eaa700496
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

> This snippet only contains collateral damage and does not show where the
> problem originates from. Please provide a full dmesg instead with
> dyndbg=3D"file drivers/pci/*.c +p" on the kernel command line.
>
> Preferrably test with the latest code + fixes that are in pci/resources
> branch (you can just take all changes from there) and get the logs from
> there. I wouldn't be surprised if your problem is already addressed by
> those fixes but we'll see.

Thanks a lot for the help! I tested on pci/resources
8cb081667377709f4924ab6b3a88a0d7a761fe91 "PCI: Fix alignment calculation fo=
r
resource size larger than align", and the eGPU is now loading! There are so=
me
messages in dmesg showing "can't assign; no space" and "failed to assign", =
but I
don't see any functional impact from it. Including the dmesg anyways in cas=
e
there's anything important: https://pastebin.com/n5hhtkz0.

Thanks,
Rio

