Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17A6497B96
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677816; cv=none; b=pqqd3cFa4WInCUtL65QmIKRN7Nh282FPO4lGUeL6xHIMAkAoujc1HuP+WlzkoDcOr9kU+rHpMavj88L0lc/zIaebE6JvIe4bVpqmk+UVd6w3EiGCooXXXvDXubody+S7eg1Ttz9fJqVwq8P3FwdbN/CPIt0V2/Yyeo7aXTMd1wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677816; c=relaxed/simple;
	bh=5C7E72SS+gB86P/nF6D4p8l3v/q5Zigdez7zZN+3DnE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qe9Mh/A7QsWmHSiV6Ub/may8jD4JLDL+IqqmPo1jXHP+IYuzzgpjrA1039tW8PmftAiWVDF1m1/QOmlF9a+VhgFbex/HYEr5QU9oVlsAq2UKUXyzXnAQf9gal/r4q9KUl2ZzO6lQQ9Ku2ptKVmeEd3LRgIlNlh1rG9LnYYz8/vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMicqW2J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMicqW2J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677DE1F000FF;
	Tue, 29 Sep 2026 10:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790677804;
	bh=3jn3LUWIAee87zKHo07AMsOMgdzyz6tB+WAD+4AJSwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LMicqW2JLk0iyZusbhMGSx57/EUEemA3wmOeE+2JU2P1qtU/Jd4Z+aftWL9ciWmGu
	 +LpQwItL8WyxCQilNkzI11ib1vhVfA4jZR+g6Wwss7OfmCn6mAqxLWdLD8oAtaSECK
	 /t+yIiSZ6HjrVvamnpHmFl9n/WSKf9/cnUgQ/XY7PZNBgdEmOiMMyRzwJ+FTVb/Kge
	 KENUJq/y3/hE0AOyO4Uosq5hPe5gr/iqAEtslfRGhEmWoGQDoCVE1XAMLrI+8SETzG
	 U//z/DB+jln0FeHDHYAO9aOUqmQYd9BJH+A6En1wYy+FMpzkQFsCwlQKo80dqSgliy
	 wW7/5p5gX7Xqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: dw-rockchip: Enable INTx affinity support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shawn Lin" <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1790664898-207928-1-git-send-email-shawn.lin@rock-chips.com>
References: <1790664898-207928-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 10:30:03 +0000
Message-Id: <20260929103004.677DE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Leverage the interrupt redirection infrastructure to enable CPU
> affinity support for the legacy INTx interrupts. The INTx virqs are
> demultiplexed by the chained handler of the "legacy" interrupt, whose
> affinity cannot be changed, so affinity control for the INTx virqs is
> achieved by redirecting the handler to run in IRQ work context on the
> target CPU.
>=20
> Mask the INTx source in .irq_pre_redirect() before the handler is
> redirected: the legacy interrupt is level triggered, so an unmasked
> line would keep re-firing the chained interrupt until the redirected
> handler runs.
>=20
> Same approach as the DesignWare core, commit eaf290c404f7c39f2 ("PCI:
> dwc: Enable MSI affinity support").
>=20
> Test was done on RK3588 EVB1 board with an NVMe with pci=3Dnomsi
> parameter. The /proc/interrupts columns are trimmed for brevity.
>=20
>   # cat /proc/interrupts | grep INTx
>   51:  137 0 0 0 0 0 0 0 INTx 0 Edge PCIe PME, nvme0q0, nvme0q1
>   # echo 10 > /proc/irq/51/smp_affinity
>   # dd if=3D/dev/nvme0n1p1 of=3D/dev/null bs=3D1M count=3D200
>   200+0 records in
>   200+0 records out
>   209715200 bytes (210 MB, 200 MiB) copied, 0.182021 s, 1.2 GB/s
>   # cat /proc/interrupts | grep INTx
>   51:  137 0 0 0 946 0 0 0 INTx 0 Edge PCIe PME, nvme0q0, nvme0q1
>=20
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1790664898-207928-1=
-git-send-email-shawn.lin@rock-chips.com?part=3D1

