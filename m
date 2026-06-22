Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EBB3FBA7
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148536; cv=none; b=Q5y/tQvU8XUPenRpif3ic2VsGF+6qTtCX5h+tjKmXSuQimtV0XmL6Mj8litXpra6EnXUVdNK0ysEXNF40xliult/dPGqyw/wdaJhXVv1tN9YQykxiV8p3o4LiZQHKEBbgXfiGe3xqVDHpbhsIEGdCf6w+97QB7FWxKr8x/RLaig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148536; c=relaxed/simple;
	bh=sM8mm6FnApGqnK5rE7ZZB/ZK0S1UPgeFm6wgHLYl/Ic=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pppIJXNbDI9QGowbIvkB6tB3O2NkcMUPoJ3Yd+t94MvNORWSCgRYx8Nvne8WX0pH4l4/q23iUB+0H5vQ8dPJxc32AgAQsElHpawRM5fZYwX+w0+7TtNGJom8VCEY0p/JGO9hjFYgGNS22dcxs/HVlNcSnTXo/x6KeIAYdE9Q6pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niB8lHbg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niB8lHbg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316C31F000E9;
	Mon, 22 Jun 2026 17:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782148535;
	bh=B2kfNwB/R8epDVftfvarQWAxUW1OHJ3yCaQZTSR8Dyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=niB8lHbgSdS+d03WNdh1CT+nK4opurjJqF6a1uzzUFXO1RK2oodvbdWek9p36Mpxm
	 Jf2xG1y/KVhcaiEhunVzzyTk3DJct5AWk4r6+byvJvzQ5HS5FrpZJ7fSEdWBNrtSiB
	 l/znmdW/ihuVCI4Plq5oR3HFw7qxoYTK8jVxGpQFEhI6bUANSwgnRGdcoS8F20lP95
	 83TF639gK/Uf2LjdYDsoHhvofkV+P4fO31EPvVPC1RDlUlCcYSX9027HXthTRvYjxS
	 9se9z3OsF9ysN+aZtQAMoIfYUajGCXj6uEAlq4jgyLzPmwugq7ux5Y7XhOZNZlPjkb
	 GWGCUHOWX25GA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] misc: pci_endpoint_test: fix use-after-free after
 device unbind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuangpeng Bai" <shuangpeng.kernel@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260622165249.374155-1-shuangpeng.kernel@gmail.com>
References: <20260621054609.186877-1-shuangpeng.kernel@gmail.com>
 <20260622165249.374155-1-shuangpeng.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 17:15:34 +0000
Message-Id: <20260622171535.316C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Adding a timeout to DMA transfer ioctls without aborting the o=
ngoing hardware operation allows the PCI endpoint to perform DMA into freed=
 physical memory, causing a use-after-free and memory corruption.

Pre-existing issues:
- [Critical] Spurious delayed completions from timed-out commands desynchro=
nize the ioctl state machine, causing subsequent commands to prematurely re=
turn and free in-use DMA buffers.
--

commit 55971777f70d30f6a31f34520e097bb21bd66951
Author: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

misc: pci_endpoint_test: fix use-after-free after device unbind

This commit changes the lifetime management of the pci_endpoint_test object
by using a kref and taking a reference during .open(). It also replaces
wait_for_completion() with wait_for_completion_timeout() to prevent
unbounded waits on missing endpoint interrupts.

Link: https://lore.kernel.org/all/178144969601.60470.7358419009914000395@gm=
ail.com/

> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
> index dbd017cabbb92..65d768dab4504 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
[ ... ]
> @@ -804,10 +815,17 @@ static int pci_endpoint_test_copy(struct pci_endpoi=
nt_test *test,
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
>  				 COMMAND_COPY);
> =20
> -	wait_for_completion(&test->irq_raised);
> +	if (!wait_for_completion_timeout(&test->irq_raised,
> +					 msecs_to_jiffies(1000))) {
> +		ret =3D -ETIMEDOUT;
> +		goto err_dst_unmap;
> +	}
> =20
> +err_dst_unmap:
>  	dma_unmap_single(dev, orig_dst_phys_addr, size + alignment,
>  			 DMA_FROM_DEVICE);
> +	if (ret)
> +		goto err_dst_phys_addr;

[Severity: Critical]
If this times out, does the endpoint hardware continue its DMA transfer?

On timeout, this jumps to err_dst_unmap, where dma_unmap_single() and
subsequently kfree() will be called to free the memory. If the PCI endpoint
hardware is still actively processing the transfer and wasn't aborted, won't
it perform DMA into freed physical memory, causing memory corruption?

[ ... ]
> @@ -909,12 +927,17 @@ static int pci_endpoint_test_write(struct pci_endpo=
int_test *test,
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
>  				 COMMAND_READ);
> =20
> -	wait_for_completion(&test->irq_raised);
> +	if (!wait_for_completion_timeout(&test->irq_raised,
> +					 msecs_to_jiffies(1000))) {
> +		ret =3D -ETIMEDOUT;
> +		goto err_unmap_addr;
> +	}
> =20
>  	reg =3D pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
>  	if (!(reg & STATUS_READ_SUCCESS))
>  		ret =3D -EIO;
> =20
> +err_unmap_addr:
>  	dma_unmap_single(dev, orig_phys_addr, size + alignment,
>  			 DMA_TO_DEVICE);

[Severity: Critical]
Similar to pci_endpoint_test_copy() above, if this times out, won't the
source buffer be unmapped and freed while the endpoint hardware might still=
 be
reading from it?

[ ... ]
> @@ -1000,10 +1023,17 @@ static int pci_endpoint_test_read(struct pci_endp=
oint_test *test,
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
>  				 COMMAND_WRITE);
> =20
> -	wait_for_completion(&test->irq_raised);
> +	if (!wait_for_completion_timeout(&test->irq_raised,
> +					 msecs_to_jiffies(1000))) {
> +		ret =3D -ETIMEDOUT;
> +		goto err_unmap_addr;
> +	}
> =20
> +err_unmap_addr:
>  	dma_unmap_single(dev, orig_phys_addr, size + alignment,
>  			 DMA_FROM_DEVICE);
> +	if (ret)
> +		goto err_phys_addr;

[Severity: Critical]
As with the other ioctls, if this times out, won't the destination buffer
be unmapped and freed while the endpoint hardware might still be writing to=
 it?

[ ... ]
> @@ -1141,10 +1171,15 @@ static long pci_endpoint_test_ioctl(struct file *=
file, unsigned int cmd,
>  {
>  	int ret =3D -EINVAL;
>  	enum pci_barno bar;
> -	struct pci_endpoint_test *test =3D to_endpoint_test(file->private_data);
> -	struct pci_dev *pdev =3D test->pdev;
> +	struct pci_endpoint_test *test =3D file->private_data;
> +	struct pci_dev *pdev;
> =20
>  	mutex_lock(&test->mutex);
> +	pdev =3D test->pdev;
> +	if (!pdev) {
> +		ret =3D -ENODEV;
> +		goto ret;
> +	}
> =20
>  	reinit_completion(&test->irq_raised);
>  	test->last_irq =3D -ENODATA;

[Severity: Critical]
This is a pre-existing issue, but won't reinit_completion() here be racy
after a previous command timed out?

Since a timed-out command leaves the endpoint hardware running, a delayed
interrupt from that prior command could arrive later. Because
reinit_completion() is called without first ensuring the hardware is idle or
discarding pending interrupts, could a spurious completion from a timed-out
command falsely wake up a subsequent ioctl's wait_for_completion_timeout()?

If this happens for the DMA-based READ, WRITE, or COPY ioctls, it would cau=
se
them to prematurely wake up and free their in-use DMA buffers before the
hardware actually finishes the new transfer, leading to a use-after-free
and memory corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622165249.3741=
55-1-shuangpeng.kernel@gmail.com?part=3D1
