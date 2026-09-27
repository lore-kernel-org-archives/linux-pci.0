Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA894279F9
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790533676; cv=none; b=EFmS9Y8W/Myfu1uw1rSvEyghQRbiBeTR5ZqGf8tzetjEvLUi5OEh3kZSaTBbCDP3floNdZlGoxJ4P5U8ZF33w0LNCEOZYCnNjZnh3pAdMB/z0+X6pd+RpUdohZbAbdu1s6RCrezHexnQVObPvb9SHcsLcPcPhlsfFF9t3A+l55M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790533676; c=relaxed/simple;
	bh=8UuVEgqa6u3UWcKSZpol2AEwbNIjVBGO9NfAh+plGIA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZIkXwl/PoGgGCHR3DrmodJ+POk9LjlHz+F3T+yAKxraMQX0LXn0P8hzD/RMb8XMvKTSKZfqeKt06FcrtjtnoMvH8aoqfifoolbwoQ+m218tDPol7V/dLLk4/4h9ClJhEGTwcOEli1bP0bKpiRey+W6F1UAOQgYXxXMhhIIlJBww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RL767jKC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RL767jKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C821F000FF;
	Sun, 27 Sep 2026 18:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790533674;
	bh=6PYGDLHKkHizyAdQz0XFwkdEJqZOpo155kKRCc6Xb/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RL767jKCB4ZcgJPuwUTnzpgCeA8xVLG5Bj63DPdjvSfckAV8r/DGfTVwMoxns41by
	 Z2EOSW2/IKz0QnADDV76zOW+Ezqvlwg+jGusE+pveB7VfWYGCDNUnZDi1M9kQGvcRi
	 +QNDflhqNw1RdeHbc8i8KHR7A8UqI63WYbcJ4qpAHXoPRshIOjeN/3ZhzOQQw1ktPz
	 aBV6SRabbXtB7nwsLx+NgIirzC5ejwfUM8AWa994vIohBTHPv2L8MmbFHa3aMIgNMJ
	 bMHC7w9fFFjKJ3SsoKBbfqzo/nsEGId8LerPzjF7nyKgswBikBQJTp6OOUYNVVz81T
	 B4uj9FiWArieg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v4 5/5] misc: Add edu_srpoc surprise removal POC
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260927182017.938565-6-abhinjoses@gmail.com>
References: <20260927182017.938565-1-abhinjoses@gmail.com>
 <20260927182017.938565-6-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 18:27:54 +0000
Message-Id: <20260927182754.99C821F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] misc: edu_srpoc: lost disconnect_work completion causes remove()=
 deadlock
--

commit bc425826c0abe82189b4fc145666a7bddb680acf
Author: Abhin Parekadan Jose <abhinjoses@gmail.com>

misc: Add edu_srpoc surprise removal POC driver

A test driver for the QEMU edu device that reproduces a surprise removal ha=
ng.
It blocks in remove() until a delayed interrupt arrives or the device is
surprise removed and its disconnect work runs.

Link: https://lore.kernel.org/all/20260905183905.997833-4-abhinjoses@gmail.=
com/
Link: https://lore.kernel.org/all/20260905185027.291191F00A3A@smtp.kernel.o=
rg/
Link: https://lore.kernel.org/all/20260927175203.928270-6-abhinjoses@gmail.=
com/
Link: https://lore.kernel.org/all/20260927175937.E006F1F00893@smtp.kernel.o=
rg/

> diff --git a/drivers/misc/edu_srpoc.c b/drivers/misc/edu_srpoc.c
> new file mode 100644
> index 0000000000000..1f395b2c31ee3
> --- /dev/null
> +++ b/drivers/misc/edu_srpoc.c

[ ... ]

> +static void edu_remove(struct pci_dev *pdev)
> +{
> +	struct edu_dev *edu =3D pci_get_drvdata(pdev);
> +
> +	reinit_completion(&edu->irq_done);

[Severity: Medium]
Can this cause a deadlock if the device is surprise-removed before
edu_remove() starts executing?

If the PCI core schedules and executes edu_disconnect() first, it clears the
disconnect_work_enable flag and signals complete() on edu->irq_done:

drivers/misc/edu_srpoc.c:edu_disconnect() {
    ...
	if (!pci_test_and_clear_disconnect_enable(pdev))
		return;
    ...
	complete(&edu->irq_done);
}

When edu_remove() then runs, it unconditionally calls reinit_completion(),
which wipes out the unblock signal from edu_disconnect(). Because the
disconnect flag was already cleared, edu_disconnect() will not run again.

> +	iowrite32(EDU_STATUS_IRQFACT, edu->regs + EDU_REG_STATUS);
> +	iowrite32(600000, edu->regs + EDU_REG_DELAYED_IRQ);
> +
> +	dev_info(&pdev->dev, "Waiting for IRQ in remove()\n");
> +	wait_for_completion(&edu->irq_done);

Since the device is gone and no hardware interrupts will arrive, will
wait_for_completion() block indefinitely here, defeating the test driver's
stated purpose of unblocking on surprise removal?

> +	dev_info(&pdev->dev, "Unblocked, cleaning up\n");
> +
> +	pci_clear_disconnect_work(pdev);
> +	free_irq(pci_irq_vector(pdev, 0), edu);
> +	pci_free_irq_vectors(pdev);
> +	pci_clear_master(pdev);
> +	pci_iounmap(pdev, edu->regs);
> +	pci_release_regions(pdev);
> +	pci_disable_device(pdev);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927182017.9385=
65-1-abhinjoses@gmail.com?part=3D5
