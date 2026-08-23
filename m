Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1EC29B76C
	for <linux-pci@vger.kernel.org>; Sun, 23 Aug 2026 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787510670; cv=none; b=sKogXQqz2XhbLodvdjNBxqMzPMbVefv62Yk/8jfHRAIEX34m5dUfQ4AP9g4FcFHNTQupoj6qQgITGSqFHhnbZjkbEG73Kiklv3fVziL3bVjDAcNTMRGAO1ESRRGijGwFcUjIQ1hyoKCha8eKq/O3nOLIk9A2xaFtBXKIVevzovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787510670; c=relaxed/simple;
	bh=NNrQ07oCQpNd15hUlA6WkdDbM8uTB24FX5U2UB7RXas=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qdA5vYsbUKuJuA6SIqCQjVj6OtcbZcP6C85u375CZlxpLnc3iRC35T0LTg6FbVjnvBHOPuHb91kg9PyXC1Umko1GW+q48yWaYnCshP0RmFMaDRBFbfkADTAueo+R5L14foB0l0hVwwfOCJTdxQaA8VckV/IoSqzokwh/IfejCgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCjZ51Kd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCjZ51Kd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C762D1F000E9;
	Sun, 23 Aug 2026 18:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787510668;
	bh=fg8KqwcWkCsr5vR5NAUjUSZd/NRBNDv5P70EgTtc/nA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YCjZ51KdcTCMFDlUCxhczM3o5ch1Co54j16OY/X4BJ+a6SWrlFePGu5J2LaHCpwkp
	 v+cfpRF5iIqdA7clnDR9Vq6aN/41ZwZxT6xQQze7fYGFR10ZMjeRYlR6+lxQWV8gv7
	 vQ6ptYHnQ2CnSEuli7iIYfR3wXZCzFafLZeGlcM/mWb41C3T2r0bRAn01wCDlmCUV0
	 bF0NLgWwDT48CP2UlAkXZM7gzpKh3y4vSwqRL4RRzCQOvS/R0XNhDzxHJhE8itXojQ
	 c4P3Pq+cF4bdoQTbyqFNF+gHsQ8d/EH5rnLgFtsRyKHFdab5fGOJg5MBCW+0JI5XKg
	 065CSqvxF8whg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/3] misc: add edu_srpoc surprise removal POC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260823183458.982699-2-abhinjoses@gmail.com>
References: <cover.1752094439.git.mst@redhat.com>
 <20260823183458.982699-1-abhinjoses@gmail.com>
 <20260823183458.982699-2-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 18:44:28 +0000
Message-Id: <20260823184428.C762D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The shared IRQ handler does not correctly handle the `0xffffffff` =
register read value on surprise removal, leading to spurious `IRQ_HANDLED` =
returns and false completions.
- [Medium] Missing explicit `cancel_work_sync()` for `disconnect_work` in `=
remove()` leads to a Use-After-Free of the `edu` structure due to a TOCTOU =
race.
- [Low] The driver references a non-existent `disconnect_work` member in `s=
truct pci_dev` and calls non-existent PCI functions, causing immediate buil=
d failures.
--

--- Patch [1]: [PATCH RFC 1/3] misc: add edu_srpoc surprise removal POC dri=
ver ---
commit 1e01da4d29945cd7e9e2a5dc7d46075c3af6e84b
Author: Abhin Parekadan Jose <abhin@poc.local>

misc: add edu_srpoc surprise removal POC driver

This patch adds a test driver for the QEMU edu device to reproduce a surpri=
se
removal hang. It registers a PCI driver, requests regions, and sets up
interrupts and a work queue.

> diff --git a/drivers/misc/edu_srpoc.c b/drivers/misc/edu_srpoc.c
> new file mode 100644
> index 0000000000000..ce2c254e3362f
> --- /dev/null
> +++ b/drivers/misc/edu_srpoc.c
[ ... ]
> +static irqreturn_t edu_irq_handler(int irq, void *data)
> +{
> +	struct edu_dev *edu =3D data;
> +	u32 status;
> +
> +	status =3D ioread32(edu->regs + EDU_REG_IRQ_STATUS);
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	iowrite32(status, edu->regs + EDU_REG_IRQ_LOWER);
> +
> +	if (status & (EDU_FACT_IRQ | EDU_DELAY_IRQ))
> +	{

[Severity: High]
When the PCI device is surprise-removed, MMIO reads (like ioread32())
typically return all-ones (0xffffffff).=20

Since this is a shared interrupt handler, 0xffffffff will pass the !status
check and the status & (EDU_FACT_IRQ | EDU_DELAY_IRQ) check.=20

Will this cause the handler to spuriously complete the wait and return
IRQ_HANDLED, stealing interrupts from other devices sharing the line?

> +		pr_info("complete(&edu->irq_done)\n");
> +		complete(&edu->irq_done);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void edu_disconnect(struct work_struct *work)
> +{
> +	struct pci_dev *pdev =3D container_of(work, struct pci_dev,
> +					    disconnect_work);

[Severity: Low]
Is disconnect_work a valid member of struct pci_dev?=20

It appears this member does not exist in the PCI subsystem, which would cau=
se
the module to fail to compile.

> +	struct edu_dev *edu =3D pci_get_drvdata(pdev);
> +
> +	dev_info(&pdev->dev, "edu_disconnect()\n");
> +	if (!pci_test_and_clear_disconnect_enable(pdev))
> +		return;
> +
> +	if (!edu)
> +		return;
> +
> +	dev_info(&pdev->dev, "disconnect_work fired =E2=80=94 unblocking remove=
()\n");
> +	complete(&edu->irq_done);

[Severity: Medium]
If the work function executes concurrently with edu_remove(), could it read
the edu pointer, pass the if (!edu) check, and get preempted before calling
complete()?=20

Since edu_remove() does not synchronously cancel the work (e.g. using=20
cancel_work_sync()), and edu is allocated with devm_kzalloc(), edu could be=
=20
freed by devres when remove() returns.

Could this lead to a use-after-free on edu->irq_done here?

> +}
> +
> +static int edu_probe(struct pci_dev *pdev, const struct pci_device_id *i=
d)
> +{
[ ... ]
> +	INIT_WORK(&pdev->disconnect_work, edu_disconnect);
> +	pci_set_disconnect_work(pdev);

[Severity: Low]
Does pci_set_disconnect_work() exist in the kernel?=20

Calling this undefined function will cause build errors.

> +
> +	dev_info(&pdev->dev, "edu_srpoc probed\n");
> +	return 0;
[ ... ]
> +static void edu_remove(struct pci_dev *pdev)
> +{
> +	struct edu_dev *edu =3D pci_get_drvdata(pdev);
> +
> +	dev_info(&pdev->dev, "remove(): starting factorial =E2=80=94 blocking f=
or IRQ\n");
> +
> +	iowrite32(EDU_STATUS_IRQFACT, edu->regs + EDU_REG_STATUS);
> +
> +	iowrite32(600000, edu->regs + EDU_REG_DELAYED_IRQ);
> +
> +	wait_for_completion(&edu->irq_done);
> +
> +	dev_info(&pdev->dev, "remove(): unblocked, cleaning up\n");
> +
> +	pci_clear_disconnect_work(pdev);

[Severity: Low]
Does pci_clear_disconnect_work() exist in the kernel?=20

Calling this undefined function will cause build errors.

> +	free_irq(pci_irq_vector(pdev, 0), edu);
> +	pci_free_irq_vectors(pdev);
> +	pci_iounmap(pdev, edu->regs);
> +	pci_release_regions(pdev);
> +	pci_disable_device(pdev);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823183458.9826=
99-1-abhinjoses@gmail.com?part=3D1
