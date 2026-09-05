Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385E249C4D4
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788634230; cv=none; b=N7FO2djHB/48zZyYpru4Zlhm3KxdlLm+38/T5y80oV55HKziqvAnQHfTURC75DZk2EaSs+N9pNEpXm30KiASc6o3dsiOvVg7+S3wQGqGczkgWAcGa1Q6V+AiQt4QGzPbte8PzWScbqMxmFwGt+IaheoGp5mC9onnKjHeasDpdfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788634230; c=relaxed/simple;
	bh=25AOzTGgr8DGD+QTjH0QN22KYsg1M+Nu7iU9km6rAtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f5YM7dH2ax92sWAItxA2rqdA8G9vMBT0tKsRvRftZcyMUiokJzyJCNDZvEohlYAnVBTY4v6SGymYGJCNF8sYvOOjPhCAnvUtRb5x0IwMgM0vUqZ5QKJyySJTBxxGPKX23G0qKR15cqxU7zPpkp2asBv712FZvSrJptW0Cs6J5jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+H0E1VF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+H0E1VF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291191F00A3A;
	Sat,  5 Sep 2026 18:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788634227;
	bh=v6dtAzlSNw5KvZ0RWrAP6J1pZegXBH8JY/dfkjEXO6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B+H0E1VFuxuYR8KuWQpWwwRlF5zbvMr3gsSRmjpTHzuEAoWJlpRHYOH9Ykn6iaRiP
	 /RcY3WTNNt6gljdrg5tvKXmkrSRRagqtMMzCcU1In7Ij0tPLlCQ0+NW5CeB6fWC62I
	 yIIjcDSx/bZ7VCXxJyK5NJvkYQpRRxAUQJU1kmrfNbMW7r5TOosLQSCFzPKHBu1uPl
	 VwqdqHxJkzgQCMxGjo6EQWtG4W+f98xtfzj2tUx8sqti0JRi34ZWqMgb41qQ2QUhi4
	 Bct1EHOOerLy1P/TRuSsdJryuwtLZ96h/a/DfIt4/UnHYrev9tTswPEBo2JSaIKTN1
	 qxU08d+j5WnYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 3/3] misc: Add edu_srpoc surprise removal POC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260905183905.997833-4-abhinjoses@gmail.com>
References: <20260905183905.997833-1-abhinjoses@gmail.com>
 <20260905183905.997833-4-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:50:26 +0000
Message-Id: <20260905185027.291191F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unconditional compilation of test driver causes kernel bloat and h=
angs on normal unbind
- [High] Missing surprise removal check (0xFFFFFFFF) in shared IRQ handler =
causes interrupt storms
- [Medium] Missing pci_clear_master() in cleanup and error paths violates P=
CI resource management rules
--

commit bf44d9ecb886ad9012988c5c1b317cd2fd7cfe83
Author: Abhin Parekadan Jose <abhinjoses@gmail.com>

misc: Add edu_srpoc surprise removal POC driver
   =20
This commit introduces a test driver for the QEMU edu device that reproduces
a surprise removal hang. It writes to a hacked register in remove() to trig=
ger
a delayed IRQ and blocks waiting for it to simulate del_gendisk() behavior.

> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index e8d8d5d88c0df..1479bf19c6467 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
[ ... ]
> @@ -9,6 +9,7 @@ obj-$(CONFIG_AD525X_DPOT_I2C)	+=3D ad525x_dpot-i2c.o
>  obj-$(CONFIG_AD525X_DPOT_SPI)	+=3D ad525x_dpot-spi.o
>  obj-$(CONFIG_ATMEL_SSC)		+=3D atmel-ssc.o
>  obj-$(CONFIG_DUMMY_IRQ)		+=3D dummy-irq.o
> +obj-y				+=3D edu_srpoc.o

[Severity: High]
Is it intentional to unconditionally compile this test driver into the kern=
el
image? Using obj-y forces the module to be built-in for any configuration w=
ith
misc devices enabled, which causes unnecessary kernel bloat.

>  obj-$(CONFIG_ICS932S401)	+=3D ics932s401.o
>  obj-$(CONFIG_LKDTM)		+=3D lkdtm/
>  obj-$(CONFIG_TI_FPC202)		+=3D ti_fpc202.o
> diff --git a/drivers/misc/edu_srpoc.c b/drivers/misc/edu_srpoc.c
> new file mode 100644
> index 0000000000000..f536bc4aa253d
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

[Severity: High]
What happens to this check during a surprise removal where MMIO reads typic=
ally
return all 1s (0xFFFFFFFF)?

Since 0xFFFFFFFF evaluates as non-zero, it appears this will bypass the
return IRQ_NONE. The handler would then incorrectly complete edu->irq_done
and return IRQ_HANDLED. Because the IRQ is registered as IRQF_SHARED, false=
ly
claiming the interrupt without clearing it on the actual hardware could def=
eat
the kernel's spurious interrupt detector, leading to an infinite interrupt
storm.

> +
> +	iowrite32(status, edu->regs + EDU_REG_IRQ_LOWER);
> +
> +	if (status & (EDU_FACT_IRQ | EDU_DELAY_IRQ)) {
> +		complete(&edu->irq_done);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
[ ... ]
> +static int edu_probe(struct pci_dev *pdev, const struct pci_device_id *i=
d)
> +{
[ ... ]
> +	pci_set_master(pdev);
> +
> +	err =3D pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI | PCI_IRQ_INTX);
> +	if (err < 0)
> +		goto err_iounmap;
> +
> +	err =3D request_irq(pci_irq_vector(pdev, 0), edu_irq_handler,
> +			  IRQF_SHARED, "edu_srpoc", edu);
> +	if (err)
> +		goto err_free_vectors;
> +
> +	pci_set_drvdata(pdev, edu);
> +
> +	INIT_WORK(&pdev->disconnect_work, edu_disconnect);
> +	pci_set_disconnect_work(pdev);
> +
> +	dev_info(&pdev->dev, "edu_srpoc probed\n");
> +	return 0;
> +
> +err_free_vectors:
> +	pci_free_irq_vectors(pdev);
> +err_iounmap:
> +	pci_iounmap(pdev, edu->regs);

[Severity: Medium]
Should pci_clear_master() be called in the error paths here to match the
earlier pci_set_master() call? Failing to clear the bus master bit before
releasing resources and disabling the device could theoretically allow rogue
DMA operations if the hardware acts unexpectedly.

> +err_release:
> +	pci_release_regions(pdev);
> +err_disable:
> +	pci_disable_device(pdev);
> +	return err;
> +}
> +
> +static void edu_remove(struct pci_dev *pdev)
> +{
> +	struct edu_dev *edu =3D pci_get_drvdata(pdev);
> +
> +	iowrite32(EDU_STATUS_IRQFACT, edu->regs + EDU_REG_STATUS);
> +	iowrite32(600000, edu->regs + EDU_REG_DELAYED_IRQ);
> +
> +	dev_info(&pdev->dev, "Waiting for IRQ in remove()\n");
> +	wait_for_completion(&edu->irq_done);

[Severity: High]
If this driver is bound to a standard QEMU edu device (which lacks the cust=
om
EDU_REG_DELAYED_IRQ functionality), will this wait forever? A normal device
unbind via sysfs or system shutdown seems like it would hang indefinitely h=
ere
since the delayed hardware interrupt will never fire and disconnect_work is
only triggered on surprise removal.

> +	dev_info(&pdev->dev, "Unblocked, cleaning up\n");
> +
> +	pci_clear_disconnect_work(pdev);
> +	free_irq(pci_irq_vector(pdev, 0), edu);
> +	pci_free_irq_vectors(pdev);
> +	pci_iounmap(pdev, edu->regs);
> +	pci_release_regions(pdev);
> +	pci_disable_device(pdev);

[Severity: Medium]
Does this cleanup path also need a call to pci_clear_master() before
pci_disable_device() to ensure bus mastering is properly disabled upon
removal?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905183905.9978=
33-1-abhinjoses@gmail.com?part=3D3
