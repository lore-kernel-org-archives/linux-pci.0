Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59E84A2069
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932123; cv=none; b=L9Paztyu8ALae5Hxmeiqva7b6vHARIBap3EvhkWd/yAVzwYC+TgBW3/eloV5RmdlUfIM97CRm7PaZbc2lqv6BKD9gb5n/9HKpyu4/y8SdCMXfPQcHMRMlFrxL5NNMHK2hoPoEZrPjLwNp0oh6kEx2Cxe7t3x6ft3N5grWrALdFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932123; c=relaxed/simple;
	bh=tyYAIjorRZSRSy2rPgyQz+f/pklzb/w7XsPAJcb1nT0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dK+Ism/1IJg+dbgxlMb7LL5rWjPxpbDQvVtPPkvvLzyzLZXuyW2t1k4jVt3B1lLIgUuZ24b6R3pqddItepjUK1JwL5SubPra+Cb35kmDiUwCyYb8RLXbUnO/vo63GmqVffg5YerGjzbVjb1+Q3NxgvWxZ8W75UvjT7eBeXK436o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8lT0ZsE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8lT0ZsE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5986A1F000FF;
	Tue, 13 Oct 2026 22:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791932121;
	bh=GvifAGKT5zhwUxPdegcj8KN1jZiCQVLGoYsnaHHIWVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f8lT0ZsEA1QHGOPJpZMxLtCx0gV2SBDI/MD7GmEllAnQSYCkIMN1vGZzdMwNSq8hp
	 z9lNeeOjqsVAlZd670p1bK3PmSdn5hKHaClKQTqhp4JFBuxDx1rRRDYJSxNWxQ/I2l
	 OfrilsjkBhvg2WlH89qQLMwV9jREEnZS4EOeuDIbYFdzlKEQCf5e1IEd/ABZhDUDpn
	 rX0WVR34wKwNn9Dhi1cEc4aUM2GjsdAwLD8clt+t9P7DRxyGzClUH6i/bK7zlsSkiV
	 ZBM3g1mPajxxDCS2PIJVk3qaQIEsQ6/8kuOTGmY5ibSmwlDwsg1+Ied0XMb4qTuj+k
	 ZBKhNKoHgjBBA==
Message-ID: <sashiko-outbox-170608@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/3] nvme-pci: hybrid irq+polling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Keith Busch" <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261013223543.395054-4-kbusch@meta.com>
References: <20261013223543.395054-1-kbusch@meta.com>
 <20261013223543.395054-4-kbusch@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:55:20 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kconfig: BLK_DEV_NVME selects DIMLIB without NET dependency
--

commit a8cd25c467c1c40e704c2bd340830c637e44f89b
Author: Keith Busch <kbusch@kernel.org>

    nvme-pci: hybrid irq+polling

This commit introduces hybrid irq+polling for nvme-pci using the DIM framew=
ork
to adjust completion methods dynamically based on the workload.

> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 31974c7dd20c9..184e9ccfde8b2 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -6,6 +6,8 @@ config BLK_DEV_NVME
>  	tristate "NVM Express block device"
>  	depends on PCI && BLOCK
>  	select NVME_CORE
> +	select DIMLIB

[Severity: Medium]
Since DIMLIB is defined in lib/Kconfig with a dependency on NET, does
unconditionally selecting it here risk Kconfig unmet direct dependency
warnings and potential build failures on configurations where CONFIG_NET is
disabled?

> +	select IRQ_POLL
>  	help
>  	  The NVM Express driver is for solid state drives directly
>  	  connected to the PCI or PCI Express bus.  If you know you

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013223543.3950=
54-1-kbusch@meta.com?part=3D3
