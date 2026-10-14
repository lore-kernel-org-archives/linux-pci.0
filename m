Received: from va-2-114.ptr.blmpb.com (va-2-114.ptr.blmpb.com [209.127.231.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB7C3002AB
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791964768; cv=none; b=LX95eOfYBCVGpTvUAbxh+uW+9SaBkgTBHE3aHcDsVHPUcwNsbutHVUMZi0GhADyDv+oSZ5vQmRUY//G8yGTxwhBv+/E5mS/hq2t7s/5NyBxjNNdR11I1/oVsfg97MIdExvxhdf7/wcnCQa37vFbqPcmSs4ZbDnFL5nimjWfJ1ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791964768; c=relaxed/simple;
	bh=+4OazdAmgJvSgNZn+vsDa4YoHpBnkBVOiu4vPLVNKKc=;
	h=To:Date:Message-Id:Cc:From:Subject:Mime-Version:Content-Type:
	 In-Reply-To:References; b=dUo9/lT5xOJuc/XcH4YVCbwHiLeF+GUsSJIQG2iwC2yF+q+qWe26llWul6ukdX7kSVzfIYkUEfA8A8ZVlDbmJNblJCvjsD3S4UVt2lsuB6TZZvHWTwgHwP6x+Q6crnLStUWxl4HqpfnIOmX7Nz6RgPNBOKvsagwFn1RKNqaRGfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=j1JWBXs4; arc=none smtp.client-ip=209.127.231.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="j1JWBXs4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1791964754; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=TY/xSqncSuEedRGyadYwHJ/EqM8rGORcOlBn4Wx3l6U=;
 b=j1JWBXs4ix3DWSJBtPB1kvoZVhv+xgllKPKGq8caK3GTDgvuvvTvAYNXXyIdOR7xJ9iO/Q
 r2geFt1keIoOEXKDU334NVl2K0LZyVgFmr4mvpvvDmxKQD02FR7GsGofXuE0aDkP9s1jnr
 Fszd4PJwbtp6rlNSdU/O8s1G2GCPtPJf9DHEud+/yv69AwMu72QvHYRpI6sQcL7smcj+Q9
 dfm+THL9TePwdezhaTjc7oR1tJBFk+WBHKAlQpJJzEkVIPW/7g9YzKse8wgVL4se+Np7pN
 EJHaSCwILX7HdXeNcfI46KnQraAogtcDex2FggGnBXwAVzN4NX0az4oGEbAZEg==
To: "Keith Busch" <kbusch@meta.com>, <linux-nvme@lists.infradead.org>
Date: Wed, 14 Oct 2026 15:58:57 +0800
Message-Id: <5613ca2a-c8c7-4418-b792-5d7ddc903960@bytedance.com>
User-Agent: Mozilla Thunderbird
Cc: <hch@lst.de>, <linux-pci@vger.kernel.org>, <tglx@kernel.org>, 
	<namjain@linux.microsoft.com>, "Keith Busch" <kbusch@kernel.org>
From: "Fengnan" <changfengnan@bytedance.com>
Subject: Re: [RFC PATCH 0/3] nvme-pci: dynamic interrupt moderation
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26acf3650+c7f641+vger.kernel.org+changfengnan@bytedance.com>
In-Reply-To: <20261013223543.395054-1-kbusch@meta.com>
References: <20261013223543.395054-1-kbusch@meta.com>
X-Original-From: Fengnan <changfengnan@bytedance.com>

Hi Keith:

I ran some quick tests using your patch on the PS1010 and SN861.=20
For 4K random reads with QD=3D8, both drives showed a performance drop
of about 19%.=20
With QD=3D64/128, there was an improvement of roughly 10=E2=80=9320%.

I think the reason is that the current logic still relies on the QD
depth to determine whether to switch, but a high QD doesn't necessarily
mean that using the poll mode will be more efficient.

As for DIM, I tried using it based on my V2 patch, but the result was
that I either had to add several new DIM functions to perform similar
checks, or I still ended up with a performance regression.

Here is detail data=20
https://docs.google.com/spreadsheets/d/1VOR0xB5yk-z6IMwwRvp8R0yd4k_tMi_wI27=
Pl-dEQVg/edit?gid=3D789521759#gid=3D789521759

Based on the results, it doesn=E2=80=99t perform as well as my previous pat=
ch=EF=BC=9A
https://docs.google.com/spreadsheets/d/1rer4Nl5HHxSO-D3NrrHuHSfpR9s1kLhpLjz=
h7h7Mbmw/edit?gid=3D875909538#gid=3D875909538



=E5=9C=A8 2026/10/14 06:35, Keith Busch =E5=86=99=E9=81=93:
> From: Keith Busch <kbusch@kernel.org>
>=20
> Just adding another nvme hybrid interrupt and polling mechanism to the
> lists. There's some recent alternatives mentioned in the links below,
> but I'm trying one last time to leverage the DIM framework. Performance
> wise, this at least doesn't seem any worse than anything else proposed,
> though I've only been able to test on mid-level hardware so far.
>=20
> This one here as some irq prep patches that help some when transitioning
> from irq to polling for MSI-x enabled NVMe completions. These should be
> generally applicable, so isn't necessarily tied to how it gets used in
> the last patch if someone else finds it useful too.
>=20
> Links:
>=20
>   [1] https://lore.kernel.org/linux-nvme/20261009050556.2817978-1-namjain=
@linux.microsoft.com/
>=20
>   [2] https://lore.kernel.org/linux-nvme/20260818033846.53790-1-changfeng=
nan@bytedance.com/
>=20
> Keith Busch (3):
>   genirq: Add disable_irq_nowait()
>   PCI/MSI: Implement irq_mask_nowait() for MSI-X
>   nvme-pci: hybrid irq+polling
>=20
>  drivers/irqchip/irq-msi-lib.c |   1 +
>  drivers/nvme/host/Kconfig     |   2 +
>  drivers/nvme/host/pci.c       | 624 ++++++++++++++++++++++++++++++++--
>  drivers/nvme/host/trace.c     |   1 +
>  drivers/nvme/host/trace.h     |  26 ++
>  drivers/pci/msi/irqdomain.c   |   6 +
>  drivers/pci/msi/msi.h         |   8 +-
>  include/linux/interrupt.h     |   1 +
>  include/linux/irq.h           |   4 +
>  kernel/irq/chip.c             |  31 ++
>  kernel/irq/internals.h        |   1 +
>  kernel/irq/manage.c           |  21 ++
>  12 files changed, 698 insertions(+), 28 deletions(-)
>
