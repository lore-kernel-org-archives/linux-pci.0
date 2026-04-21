Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A1C378D93;
	Tue, 21 Apr 2026 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776758785; cv=none; b=Dom5aeLpuIPqHMJqh6HapkpsgfDUFavGFoWlvxmiAQpOWA6fK5SM5o+Wt5Z1mMGIXkT1a5Uh0SJvmoo4czfXc0SxxznfStaVGHAE16KixUiFdDFQKqikq+TzhfZn3KbQNoVfdVRRVed9IBoJUm+9buDiRKCtYKaVLD+CqslFcyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776758785; c=relaxed/simple;
	bh=Kcuc5Xdw3I0X1wDe1tIZffJ2xBhEeRpjQ+Urye3ls5s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cFq1osciUq1Y2p8Cmx5QXQk31UAsK8x6Mwh7PWOIHwz2GVxycZf2KcrD8jVGQaSFRchZMc8I04KkWuUmD6alZJNKTskzN/OX/we4tMx7dfxQznP9zLyyRtc84TCFwbV3EZ7/1ms7sxyrdBLYS7yRVMGl0TYmxDinEjjyARR+b3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljZ2MCtZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljZ2MCtZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88587C2BCB0;
	Tue, 21 Apr 2026 08:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776758785;
	bh=Kcuc5Xdw3I0X1wDe1tIZffJ2xBhEeRpjQ+Urye3ls5s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ljZ2MCtZhT2Nfb4GVgTMd7pHrJ/PQKwqmJjfGzTbKds4rZL+SWAUZg4G3cWtUYdzI
	 PMDLh4rv5n/9ul5eRz1D2otA59ozHuXHOYpPmwj8C9Nlj5yIHAezgfYxsQUCd5rncG
	 OLYG9kIJH56yy5/H4IdIYOWDcldQZE1EQCaq4vHGo+OOXoOK825fgQIQ9MQIjeP9Aj
	 sNGnIEHdCykStWD9E1bYdneYypVrVU5CfYrLafdr2mzhPqIenUzQ0750DSxKXDAgy1
	 6oOIxH2pcn7P5NInDjtBhFEFPHb7txwTWDqIUSpXV1zaoK4u7cSLQ1/KpmqzkTvME0
	 aTnK4zzJC4u9w==
From: Thomas Gleixner <tglx@kernel.org>
To: neilfsun <loyou85@gmail.com>, 18255117159@163.com
Cc: bhelgaas@google.com, hans.zhang@cixtech.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 loyou85@gmail.com, neilfsun@tencent.com, shawn.lin@rock-chips.com
Subject: Re: [PATCH v2 v2] PCI/MSI: Fix memory leak in
 pci_alloc_irq_vectors_affinity INTx path
In-Reply-To: <20260421032044.55948-1-neilfsun@tencent.com>
References: <2caa071e-85ee-4e76-bb33-8f27a4579fac@163.com>
 <20260421032044.55948-1-neilfsun@tencent.com>
Date: Tue, 21 Apr 2026 10:06:21 +0200
Message-ID: <878qagd9fm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 21 2026 at 11:20, neilfsun wrote:

Please use function() notation in the subject as well.

> In the INTx fallback path of pci_alloc_irq_vectors_affinity(),
> affinity masks are created and never freed.

And then?

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog


This also lacks a Fixes: tag to identify the commit which introduced the
problem. Hint: It was not commit beddb5efb43ee.

> Signed-off-by: neilfsun <neilfsun@tencent.com>
                 ^^^^^^^^
Please provide your real name and not your nickname. See
Documentation/process/...

> Signed-off-by: Sun Feng <loyou85@gmail.com>

This Signed-off-by chain is broken. See Documentation/process/...

> Reviewed-by: Hans Zhang <18255117159@163.com>

Hans did not provide you a Reviewed-by tag. The fact that he reviewed V1
and made suggestions how to improve does not imply that.

> @@ -285,8 +285,10 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  			 * the device driver can adjust queue configuration
>  			 * for the single interrupt case.
>  			 */
> -			if (affd)
> -				irq_create_affinity_masks(1, affd);
> +			if (affd) {
> +				struct irq_affinity_desc *masks __free(kfree) =
> +					irq_create_affinity_masks(1, affd);

There is no point to use __free() here. The only reason why this is
invoked for the INTX case is to ensure that the affinity descriptor is
updated and an eventually provided calc_sets() callback is invoked. The
returned mask is not used at all, so this can be simplified to:

         kfree(affd ? irq_create_affinity_masks(1, affd) : NULL);

Along with a proper comment.

Thanks,

        tglx
