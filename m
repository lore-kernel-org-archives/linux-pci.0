Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413F23A1E95;
	Thu, 16 Apr 2026 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776346827; cv=none; b=mcCvjKh0i5QC6IoutAejGyvwFQe6niczx333hQIaZBHT36zYCLYpprS9gNgxa/3FkqYU62n0quIRHhe4aRU5FuJdfjqxBaJhnla9xInm9RkgAIN0D977tEkKBT0xFG3w1REYYIeox4aWnm+VpoNhxBxMqSKaud+r49l68ZkF/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776346827; c=relaxed/simple;
	bh=+Cm8zdxXLz7bcaZJWZhDWcXgaMPEgeSJ2u2pQZs12FE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlKE62vwk3m7o9DtcXFk0jbq84Ie0zvMeuXaJ9JUutEyBPMarTXpaNePvrU69T1FjEVORgljzi79h/4vv86UlVWRmwQBg1pEe9/AEPJBNQiqo232q7tPCEXhbHyGVJj8WlFw+eVVeNmJIGDa4tmxLrdeuIx2sgN39yKEcMCiOrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=cL02z3/J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BS60DdTJ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="cL02z3/J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BS60DdTJ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A9CBB1D002E6;
	Thu, 16 Apr 2026 09:40:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 16 Apr 2026 09:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776346823;
	 x=1776433223; bh=/wRBy3MPr3uBglPzHimTBE2v1WQkXuAVNb1SXsJzKsM=; b=
	cL02z3/JXlwXMIQ0hL1iyF5rr0TSqB5ClZHgEvF5j+Gs+IPXwYKrIrti5g3qNB6w
	K4JpGKiFJVUVS0yIkGmQINGU1W9PKii0POKonkmSQN5oRBFwbiU+iGo9cOBamNCN
	O/ZyNDVXBu+QwN1/vyjNYG4Yc9HTsMI9tmof7R/cYU6JcqRNzpTRD1RTqqoZWxvv
	mpe7vXSLXW7OVgL5ruuw/I04jwR5I/l50iWF1sfDHKRhBJCBvuphpZuLblrarjEt
	z/3v2FtE/T6nA4TCmuMgQPC4x9Z57uvmJgIR2fyZmRFijg2MCNwjcNElqH61sFE4
	rr+oxz7sKEkRaYzjYw+8Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776346823; x=
	1776433223; bh=/wRBy3MPr3uBglPzHimTBE2v1WQkXuAVNb1SXsJzKsM=; b=B
	S60DdTJFyzVflIZg8wsFxtK3sjKlEmry5YC5XeT2NNnwz/gSdBe6c5z/V+7kZmdd
	fG2BoNE1fb2STkQEspaL66lUFrDx5qxd888i5edZdO+YSwFgYWhsNMc4JtFoEFXZ
	osOhP0SpQgQxNPTe8LQaphMvsW4O6UFEhYPEBVgC3EAKLiprGbUtjHGkuOCSTqF2
	qfxtaINc4dIInHOhKF8eUHMU1FWT+uP1muOFRigkWOPKNBsqw6GVA7XOLBAxjqGB
	viGWVSltZZsUqrk65F8vvqX5z6e0rH5mhMnVN20dbesrqHZ1FQW6oK3ESh3lp0J9
	RQ1HqdfPNkqfi++1BLf9A==
X-ME-Sender: <xms:xubgaWyt2tvtXeYYRjIlO52P_s-g-HP0l_3YgeVK9pQlkyMkiwmH-g>
    <xme:xubgablOaH-Ju3NySP55YpUj2G81veBf7BXFg3cSS_V0ItmADnPpHCGHi9vaA7nW_
    d9s99fFXH7M4JFw3LMoT4eA1g-uVj8jaa2We0m-NAU9pll9odD_UQ>
X-ME-Received: <xmr:xubgafmJJV1l6d5N-pBINb7BBwUP9Gi1xJrydj-yoWNxjSuE5_GsDkcOq68>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepgeduvefhjeeufeevudeiueeuieeftedtkeevkefhgfdvteefleeuhefgtdeh
    fffhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnheshhhurgifvghirdgtoh
    hmpdhrtghpthhtohepfigrthhhshgrlhgrrdhvihhthhgrnhgrghgvsegrrhhmrdgtohhm
    pdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtohepkhhvmhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigsehshhgriigsohhtrdhorhhg
X-ME-Proxy: <xmx:xubgadyTrRENBgprQaqnksVneOFwQ-SaBhdXq6DyX_5AXBeWl_MjhA>
    <xmx:xubgaUoTmJ5yyaADRFnLhowZGefmOHzB3-Bo3dmxnW_PjeM9IgxAVg>
    <xmx:xubgac62Ghv3SnlTRpUdtkkQaMOAzfKqSsmq_OaUuGmD-Es8Ml_upw>
    <xmx:xubgabfFyJ-QAiZqgqkvMyK3w-GK5K3W0VuxEWh1QO51CR3qT5Q9vQ>
    <xmx:x-bgaQq2O-QxmHmr7H8VWNlFUeleYNUsVx2p_tKJGf3aFMKgc14xIVwJ>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 09:40:21 -0400 (EDT)
Date: Thu, 16 Apr 2026 07:40:20 -0600
From: Alex Williamson <alex@shazbot.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: Wathsala Vithanage <wathsala.vithanage@arm.com>, <jgg@ziepe.ca>,
 <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH 3/4] vfio/pci: Add PCIe TPH GET_ST interface
Message-ID: <20260416074020.57e4ed72@shazbot.org>
In-Reply-To: <41d5b3ea-abe2-4583-be88-2addf6b4d394@huawei.com>
References: <20260415090959.53672-1-fengchengwen@huawei.com>
	<20260415090959.53672-4-fengchengwen@huawei.com>
	<518e5e0a-d0b2-4775-a32a-e2dc87c8ba4b@arm.com>
	<41d5b3ea-abe2-4583-be88-2addf6b4d394@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Apr 2026 09:09:50 +0800
fengchengwen <fengchengwen@huawei.com> wrote:

> On 4/15/2026 9:55 PM, Wathsala Vithanage wrote:
> > Hi Feng,
> >=20
> > get_st=C2=A0 feature is unsafe. It allows a rogue userspace driver in d=
evice-specific
> > mode to obtain steering tags for arbitrary CPUs, including ones unrelat=
ed
> > to the device or its workload, enabling it to direct traffic into those=
 CPUs=E2=80=99
> > caches and potentially interfere with other workloads, opening doors to
> > further exploits depending on other vulnerabilities. =20
>=20
> Thank you for the follow-up and for referencing the prior RFC
> discussion on this topic. I appreciate you clarifying the
> historical context of the safety concerns.
>=20
> I acknowledge the risks you=E2=80=99ve highlighted, but I believe the
> risk profile in this VFIO interface is different and already
> well bounded by existing design and practice:
>=20
> 1. VFIO device access requires elevated privileges
>    A userspace process can only open a VFIO device node if it
>    has sufficient privileges (typically root). This is not an
>    interface for unprivileged users.

This argument is NOT helping your cause.  This is not the usage model
we design for.  VFIO usage requires that privileges be granted to a
user, in the form of device ACL access and locked memory, but does not
generally require elevated privileges beyond that, or otherwise grant
the user authority beyond the scope of the device.  The root use case
may be typical for you, but is not required for many other typical use
cases, such as device assignment to VMs.
=20
> 2. In the thread "[RFC v2 0/2] Retrieve tph from dmabuf for PCIe
>    P2P memory access", applications can configure the steertag
>    of exported dmabufs from userspace to the kernel. Kernel PCIe
>    drivers (e.g., mlx5 NIC) then use these steertags and set them
>    to their ST tables. Even here, userspace could set invalid
>    steertags that impact GPU performance=E2=80=94but this model is
>    basically accepted I think (refer from maillist discuss).

It's an RFC.  It's bold to claim that it's nearly accepted.

> 3. Malicious resource consumption is not unique to TPH
>    A malicious thread can be created to forcibly consume CPU
>    resources and bound to a specific CPU, affecting other CPUs.
>    This is a general system security concern, not one specific
>    to TPH GET_ST, and is addressed by existing system hardening
>    and access control mechanisms=E2=80=94not by removing useful features.

You're conflating process abuse of a CPU to a potential side-channel
DMA attach from a device.  What *existing* hardening protects against
the latter?

> 4. GET_ST is strictly necessary for Device-Specific (DS) mode
>    when no ST table is present on the device.
>    For devices that do not have a dedicated ST table (a common
>    scenario in many PCIe endpoints), DS mode requires userspace
>    to retrieve per-CPU steering tags first, then program them
>    into the device=E2=80=99s steering logic via other registers. Without
>    GET_ST, userspace cannot obtain the required steertags to
>    enable TPH DS mode at all=E2=80=94rendering TPH support useless for
>    these devices. This is not an optional feature but a
>    fundamental requirement to unlock TPH functionality for a
>    large class of hardware.

Unlocking a hardware feature does not give you authority to ignore the
security implications of that feature.  Thanks,

Alex
