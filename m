Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564D440D59C
	for <linux-pci@vger.kernel.org>; Sun, 21 Jun 2026 06:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782021769; cv=none; b=W5vuKio8NnkQyW3FGPGRSEWx3AQwc55mHllKOU36ldl/jQJpZyE2rMXxz6Bnq7nzxtzCQ9yRUvfhRGepkTLZB1XJ4qZk0KzKmlyKFPmbFkqxdBUBEtIvNcOmxMfLiHn4sAnSNe8XaFlf9/lVEJCCDYINscc1jNTfH/T//hiz0ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782021769; c=relaxed/simple;
	bh=6kRKGt1jXAlkU0dRyflTyB5nuqznBw1mejWRuJToiZ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J1c+3u+xnnhK/0ssiGhtIm2iN/3hhvUnceTdkPKKPSEUrvFpzTRiYuAM+Ltc3u05v6j06bALzuNoYIfH6SCvysccHWWWXG3CT/r01ldsY+64QJxOHH/KPnv1rhZpq+0kl7N/btB9c2Lmn1Y35rdzeXwhrh+z465G9u6ciq7Z0yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9f2+/nU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9f2+/nU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B723A1F000E9;
	Sun, 21 Jun 2026 06:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782021767;
	bh=ZnHOGpEfDauCxMiB8m8VH/NALjXi+c9jUDnIxgdgpkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y9f2+/nUW3r7YdF6H6WE1skmWDE1ulNVgn5yE8VL8pol7AEiCe1HjNFfL56CQ+zde
	 80duhQHH8ZeqfCI/rw+TPKn3xM6aBBYwYEhelJUcgM8oZB3NsDN4r8tYqXvr+7DjIu
	 H/BqV7wTFnfs5gSNzqc7gvGWqXP6ADZPbRZZhIvCNCgzYi5rAk6iLc80/GjLp9lJql
	 5uAvHBY2truZMLZRsZMDNck6n2GOOG/MPLu2Reo8TPA4YlH3yIZWqTzheOR7JuP6GP
	 WHsqZtEvFiU0/TtU1fLQBrrB0ksOzfFzpi6IGdVUtKKfQWBKuEUJWgTbasWVIbCQ/B
	 75uhxJfrDd6ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: fix use-after-free after
 device unbind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuangpeng Bai" <shuangpeng.kernel@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260621054609.186877-1-shuangpeng.kernel@gmail.com>
References: <178144969601.60470.7358419009914000395@gmail.com>
 <20260621054609.186877-1-shuangpeng.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 06:02:47 +0000
Message-Id: <20260621060247.B723A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Deadlock in pci_endpoint_test_remove() on device unbind due to ser=
ialization with ioctls that sleep indefinitely.
--

commit 8935a4226276767a2564aa469158f4ffb5341492
Author: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

misc: pci_endpoint_test: fix use-after-free after device unbind

This commit explicitly manages the lifetime of the test object with a kref
to prevent a use-after-free when an open file descriptor outlives the PCI
device binding. The remove path now serializes with ioctl using the
existing mutex and clears device state before dropping the initial
reference.

Closes: https://lore.kernel.org/all/178144969601.60470.7358419009914000395@=
gmail.com/

> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
> index dbd017cabbb92..981a834ce41bd 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
[ ... ]
> @@ -1364,10 +1405,13 @@ static void pci_endpoint_test_remove(struct pci_d=
ev *pdev)
>  	if (id < 0)
>  		return;
> =20
> +	misc_deregister(&test->miscdev);
> +
> +	mutex_lock(&test->mutex);
> +

[Severity: High]
Can this lock acquisition cause a deadlock during device unbind?

The ioctl handlers, such as pci_endpoint_test_copy(), hold this same mutex
while waiting indefinitely for hardware interrupts:

    mutex_lock(&test->mutex);
    ...
    wait_for_completion(&test->irq_raised);

If the hardware fails to raise the expected interrupt, perhaps due to a
hardware hang or abrupt hot-unplug, the ioctl thread will block forever
while holding the mutex.

Since pci_endpoint_test_remove() now waits on this mutex, wouldn't a hanging
ioctl permanently block the removal path and deadlock the PCI subsystem for
this device?

>  	pci_endpoint_test_release_irq(test);
>  	pci_endpoint_test_free_irq_vectors(test);
> =20
> -	misc_deregister(&test->miscdev);
>  	kfree(misc_device->name);
>  	kfree(test->name);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621054609.1868=
77-1-shuangpeng.kernel@gmail.com?part=3D1
