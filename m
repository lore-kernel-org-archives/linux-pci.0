Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE783115AF
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016676; cv=none; b=AZ0fQim9qZfHEUYtkMFDtV8wbM/2uterhtXDCxjDyRcdXJdcmdw1O4fljBFYldL2ZoN1L2KNDFkpAEFvLjOmpUHVKqlRWOPIbB6rCySoCiEL6mostjw1UA6yhvIpDHjQPQTsk/VyqwK+W+Ek44YPXcuQK83IlkF/DpMTi/4ZM3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016676; c=relaxed/simple;
	bh=r+/um84sBoyqcsPR8PCyYbPNnRQpYb+FTl9L08KwGvs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qBsw9VPr7heGPM6eZItThc5GBVaafaFedFtQmfu4GlecWdoWhAwkWj6rysepQXQkktBEmhEzbXhdvWqKpf+MqqLiTZKYG2uQlN0k5mIUfAyKgFrxEADu9nUQSaSGOZEE42koGB/pJhmF2OHCA54K5b/nBpJdar+3X3x9nKceNR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3e0VKiD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3e0VKiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FA81F000E9;
	Thu,  6 Aug 2026 11:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016674;
	bh=g4co4fKSgzryTn6T0lbz9pygALIvD+jFWEHG2xbjgqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c3e0VKiDff2iRM6ZWP32f0gOF5sHKw2saNJStCXRkV2YjKzY8mNz6DzXzBBZcsCbj
	 Y2Kbv347BMZ+Jpns76s3wXgU2d9+RlzRmaVngnGg+ncn4AZPN0lUXA5gKxji+P3VsB
	 wG7/HSfkT6Yv+nKWlvrcRUal8iy+6bauhjCnUEX01qu3GwfSDO/VqVmGa5EQqxVJIZ
	 r/QZfGLos5r8dhkCrMxjMzJredW30oxAS1psr+jlY8pI+bCD9vx4Cm4XA8CUTvlmqO
	 ef89QREPj5C6msDM0QZw1WEbxtX90Rs0cvzX8VUwohHPmYwsf7TZhknxZsEam4UNSK
	 YqoyAC8kdmmGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/13] PCI/P2PDMA: Add KUnit coverage for the ACS P2P
 routing walk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806-fix-p2p-acs-v2-12-0cec14812965@nvidia.com>
References: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
 <20260806-fix-p2p-acs-v2-12-0cec14812965@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 11:44:32 +0000
Message-Id: <20260806114433.D9FA81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] pci_p2pdma_release() skips synchronize_rcu() when p2pdma->pool is =
NULL, leading to a Use-After-Free of the pci_p2pdma struct and its XArray i=
nside RCU read-side critical sections.
--

--- Patch [12]: [PATCH v2 12/13] PCI/P2PDMA: Add KUnit coverage for the ACS=
 P2P routing walk ---
commit c4a68b62f4ec894cc35240eda46bf42dc5f562d9
Author: Leon Romanovsky <leon@kernel.org>

PCI/P2PDMA: Add KUnit coverage for the ACS P2P routing walk

Extend the ACS KUnit suite with end-to-end coverage of
calc_map_type_and_dist(), the provider-to-client hierarchy walk.

> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index c7680964d8a64..18e5339bc49e9 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
[ ... ]
> @@ -859,6 +859,7 @@ calc_map_type_and_dist(struct pci_dev *provider, stru=
ct pci_dev *client,
>  	rcu_read_unlock();
>  	return map_type;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(calc_map_type_and_dist);

[Severity: High]
This is a pre-existing issue, but does this code have a race condition
leading to a use-after-free when interacting with pci_p2pdma_release()?

If a device acts as a P2PDMA provider without setting up an allocator pool
(for example, via vfio-pci or mlx5), pci_p2pdma_release() skips
synchronize_rcu() because p2pdma->pool is NULL:

drivers/pci/p2pdma.c:pci_p2pdma_release() {
        ...
        if (p2pdma->pool)
                synchronize_rcu();
        ...
}

When the provider driver is unbound, devres frees the pci_p2pdma structure
and destroys the XArray. Concurrently, calc_map_type_and_dist() executing
here inside its RCU read-side critical section can dereference the freed
p2pdma pointer and call xa_store() on the destroyed XArray.

Should synchronize_rcu() be called during release regardless of whether
the allocator pool is set up?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-fix-p2p-ac=
s-v2-0-0cec14812965@nvidia.com?part=3D12
