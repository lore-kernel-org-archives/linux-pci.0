Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B8241DEC9
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531979; cv=none; b=kHnqhTKJZFB2h1XjSWRBWq9x1h5+Pf3rvc5/Y77AZXHXT5cwkhsgAjPz/MJZ96QS1CjWzQULbTai29esWLFtHe2N2713xYGzV0trlCXJaof6TBOa5fy8YJipjfYFnbj2BL26VHu9EpXyT8wCiBrpQ0Y7eiaRGA3A7WN+vAGtKFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531979; c=relaxed/simple;
	bh=E/aFFoYyb0zx4ieoI2M0XHXxqL8f2KkxkajSq3/lZrw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vD03+w+L1Iv7svIgThcHUMHq1zngLb3wqrjAkCoSj2SBaNTx59qqkVjdmu9o7iJiGSiVZ1k8fZPpaUM63RQRMwN1Zn1cnHIMtAt0qnCD3tpVq9KxBAlzLQ9M/TF1jJWU6M2jKWgEqJu0zNFVUklP+lutzHX332M34ETzCC9lzec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEtTP2rz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEtTP2rz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E006F1F00893;
	Sun, 27 Sep 2026 17:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790531978;
	bh=MCFoybTeJBKlQFPWMqcRsge47L4LXQxAjehARGw9x2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VEtTP2rzTkMEM56fKLGOpONAFy9ed27L5hK4IyAS9IvHtl6Bhjn0Q91ymxX2m2T+A
	 xDTYZSjNAeHG8Eq+uf8tzbiMuQHFX9W4gO6bW2ES6HDNmEabaxQ1jQUzTBrLxejQxg
	 cWbDlMHBVIoAzbZoXb2OzLOqwtaWVRhj1OsK37UckSRs5cZWv0SW+DrBiKlHG1Sns/
	 knRz54mfsHamZPk1q9kKdpfhO9WWYFd4gCudpJ2T5QBQjrzQ9D0Bic2jsEu5dz3JJc
	 Q9VbJvN0gUCDygatbQeCzs1AultET2GpdaLONtO5mJWj9uuv/HZnxtxn7PUc3Va3SS
	 VH6jlJ5wsbTfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 5/5] misc: Add edu_srpoc surprise removal POC
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260927175203.928270-6-abhinjoses@gmail.com>
References: <20260927175203.928270-1-abhinjoses@gmail.com>
 <20260927175203.928270-6-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 17:59:37 +0000
Message-Id: <20260927175937.E006F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] misc: missing reinit_completion() in edu_remove() causes unhandl=
ed IRQ storm
--

commit f9ed797f2f520a59d9e2c04ca2421e2d89d85acb
Author: Abhin Parekadan Jose <abhinjoses@gmail.com>

misc: Add edu_srpoc surprise removal POC driver

This commit adds a test driver for the QEMU edu device to reproduce
a surprise removal hang. The driver's remove callback schedules a
delayed interrupt and blocks until it fires or a disconnect work runs.

Link: https://lore.kernel.org/all/20260905183905.997833-4-abhinjoses@gmail.=
com/
Link: https://lore.kernel.org/all/20260905185027.291191F00A3A@smtp.kernel.o=
rg/

> diff --git a/drivers/misc/edu_srpoc.c b/drivers/misc/edu_srpoc.c
> new file mode 100644
> index 0000000000000..b74a95109dba9
> --- /dev/null
> +++ b/drivers/misc/edu_srpoc.c
[ ... ]
> +static void edu_remove(struct pci_dev *pdev)
> +{
> +	struct edu_dev *edu =3D pci_get_drvdata(pdev);
> +
> +	iowrite32(EDU_STATUS_IRQFACT, edu->regs + EDU_REG_STATUS);
> +	iowrite32(600000, edu->regs + EDU_REG_DELAYED_IRQ);
> +
> +	dev_info(&pdev->dev, "Waiting for IRQ in remove()\n");
> +	wait_for_completion(&edu->irq_done);

[Severity: Medium]
Could this leave an unhandled interrupt pending if the completion count was
already incremented?

If a prior interrupt (for example, from a previous test run or device state
before the driver loaded) has already called complete(&edu->irq_done),
wait_for_completion() will return immediately instead of waiting for the
600-second delayed interrupt requested just above.

This would allow edu_remove() to finish and the driver to unload while the
delayed hardware interrupt remains pending. When this interrupt fires later
with no handler registered, it could trigger an unhandled IRQ storm that
permanently disables the shared PCI INTx line, potentially affecting other
devices.

Should there be a call to reinit_completion(&edu->irq_done) before
requesting the delayed interrupt here?

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927175203.9282=
70-1-abhinjoses@gmail.com?part=3D5
