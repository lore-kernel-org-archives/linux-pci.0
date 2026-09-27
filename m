Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166222E22B5
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790528829; cv=none; b=WyG+MShYHTQXPLeg0o1zj6TvLDs6cvYNWbZDEMDBrPyMgx2ezo63ogwiQbJoHXAQjtRRlRzArPk5sUdFsLch1qmOi9MJYTR5ufVcTUxXQPaQbfNRdobSg1e38M2qqM0IVm92jCkhzDcHlvrc3Bc+qt86PhYHYdrM7zJWUBSfg+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790528829; c=relaxed/simple;
	bh=t4MpzbGhDP3WTd4tOwBOMMxF71dEEHxNnmTyXe4dwzg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cPLz2UhZM0EpahCRQB6BxAuWnIA7g/or9gzbkAbCzz0UEVoVMjLICwfE8qvwDhs44avsFox2xhCq4GWY2o4KcEub3Co03rRmfX6QiHINrss7NC/m3X00s38IHV0Vt1pzyJyq1FcmpyEqA8ypDkiy5XSx8RCpVSh5n9bMjpSptZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LARzo6Hh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LARzo6Hh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9241F000FF;
	Sun, 27 Sep 2026 17:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790528827;
	bh=WlaHa6omdYQ1NynS/u3240jDNLFr3tva4Fy+DjN1fT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LARzo6HhQJJ0cIPG7Q8pCURD56wthHWNsJt61ga26ASYxcjcC9BSF9DoFjJUjiqCP
	 C11AS5lbDlsEtyXpCAf2Qmrg/Oyqn4d2NqaFs/GMz8t9p3KnualBJkj/CC50/htvgq
	 IgcIqomznn/5N7YUrNyJ/Mn8zGq7J58PrVq2H7y8Nfl+RzbqWmyPwNNrLRA7rr/AcH
	 Q68F6DN7AXnQTwmkN1Vi6hMBUwjFC5ZIA6TYOgWGCwzH7AQRmviGIOlraT28iDzFtu
	 mQQ70JGi3DEU0J0MWeLz9zvHEsYeB3aTFtmRINzGC4Q66XpuBQaD9mNt1T0K6yI+3G
	 Rpas2sU4gLppg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 1/5] PCI: Report surprise removal event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260927165459.829900-2-abhinjoses@gmail.com>
References: <20260927165459.829900-1-abhinjoses@gmail.com>
 <20260927165459.829900-2-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 17:07:07 +0000
Message-Id: <20260927170707.6F9241F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: workqueue list corruption via TOCTTOU in pci_dev_set_disconne=
cted
--

commit 95014e29e88ff3b1020861e3c7351ac0913e2410
Author: Michael S. Tsirkin <mst@redhat.com>

PCI: Report surprise removal event

This commit introduces a mechanism to notify drivers about surprise device
disconnects via a work struct. It allows drivers to perform necessary clean=
up=20
knowing the device is inactive, preventing the remove callback from hanging=
=20
forever when waiting for interrupts.

Link: https://lore.kernel.org/all/fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.=
1752094439.git.mst@redhat.com/

> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ba3c3fddddc23..23b1605e783a3 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -805,6 +805,12 @@ static inline int pci_dev_set_disconnected(struct pc=
i_dev *dev, void *unused)
>  	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
>  	pci_doe_disconnected(dev);
> =20
> +	if (READ_ONCE(dev->disconnect_work_enable)) {
> +		/* Make sure work is up to date. */
> +		smp_rmb();
> +		schedule_work(&dev->disconnect_work);
> +	}

[Severity: High]
Can this lockless check cause a race condition if the CPU is preempted right
after the READ_ONCE(), but before schedule_work() executes?

If preemption occurs here, the driver could be concurrently unbound, calling
pci_clear_disconnect_work().

If a new driver then binds and initializes the work item via=20
INIT_WORK(&dev->disconnect_work, ...) during its probe, the delayed
schedule_work() from the preempted CPU might execute concurrently with the
new initialization.

[ ... ]

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107b1ef..f4c0240b62dc8 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
[ ... ]
> @@ -2123,6 +2126,49 @@ pci_release_mem_regions(struct pci_dev *pdev)
[ ... ]
> +static inline void pci_clear_disconnect_work(struct pci_dev *pdev)
> +{
> +	WRITE_ONCE(pdev->disconnect_work_enable, 0x0);
> +
> +	/* Make sure to stop using work from now on. */
> +	smp_wmb();
> +
> +	/* Leaves the work disabled, so a racing schedule_work() is a no-op. */
> +	disable_work_sync(&pdev->disconnect_work);
> +}

[Severity: High]
Does this function provide enough protection against the delayed
schedule_work() scenario mentioned above?

While disable_work_sync() prevents immediate races by setting disable bits =
on
the work item, a subsequent driver probe calling INIT_WORK() will
non-atomically reset work->data.

This reset clears all flags, including the WORK_OFFQ_DISABLE_BITS. If
INIT_WORK() executes INIT_LIST_HEAD() concurrently with the delayed
schedule_work() insertion, couldn't this overwrite the next and prev pointe=
rs
of the queued work item and corrupt the workqueue linked list?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927165459.8299=
00-1-abhinjoses@gmail.com?part=3D1
