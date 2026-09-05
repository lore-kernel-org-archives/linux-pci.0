Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFDB37DAA9
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788634011; cv=none; b=rGK49hBYJmY0FMSvCxmiQzNURGBrqU9AJR2+TeLty1ADe77+r90ph2GJVCKHIieuHTGX0M4PE0C7t6VbmwEvRZ+s6i9iju/EVf//waOxZf1LMId4AU89A3V1b7a9yxdRJoSUXmjM8qYfuotiIgooFjchy8OcunyliFLORuH/HQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788634011; c=relaxed/simple;
	bh=+mujt4/L3185s9UXEzh2gSh2/tFKdez/M5fomZKfb9g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JT9wcbPikbeh9T/LSFaFot6PvTRyJlMK8+Tu1b1/+8hqyLQNYsnC/hy44zBNECCtJNSgbXD8db7uQaeOCH4ewdAjEakRPQCmRlAN4k3mho4/60nfqYVVY8Vk1Oxo5Lkm/yt1D3BkgfG5S4MBHa+HKY/J4SU9MfozVp7iFAeqFug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHy8vQBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHy8vQBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F621F00A3A;
	Sat,  5 Sep 2026 18:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788634010;
	bh=3tmCKZ7M1FitA2eMuP06mC0iqqwPNVsI49Lid4kyMWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UHy8vQBcy5ZHRAn9N/Mga57edueZk6hobtG5vUZzL5yJTAgCjncxDkcFqWJ666Kg7
	 5fUj6hSO0d1Aq4gt19xjxpqrMF0I23WGe74/kkFrLiZNC2HHnTEjV8REIjZDwGkTJW
	 j1m8v+Fk/T/OwPxt1nQgWF+mEJ9WfoYAdrkghtGkV8vwsS8sYY2Afoybju1My+Njv8
	 PXHOkhr8gG9w1F8lUeJyuBKlWMZhUJw8FCQlU/kvo18TsiyH3jTS+6beOBCan3LAuk
	 3SlAtIgYFd6MUgqMAJm3qMHTEONdrPDA2Ht+YTEpJt6oiN0svskcDlbuEsbhx/hUeJ
	 U6TTRjGBv814Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/3] PCI: Report surprise removal event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260905183905.997833-2-abhinjoses@gmail.com>
References: <20260905183905.997833-1-abhinjoses@gmail.com>
 <20260905183905.997833-2-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:46:49 +0000
Message-Id: <20260905184649.E8F621F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] A Time-of-Check to Time-of-Use (TOCTOU) race condition between `pc=
i_dev_set_disconnected()` and `pci_clear_disconnect_work()` allows a `work_=
struct` to be queued after the driver teardown completes, leading to use-af=
ter-free or execution of unloaded module code.
--

commit 889ac5c66b7f1749706d4c7c756b37926ccf5245
Author: Michael S. Tsirkin <mst@redhat.com>

PCI: Report surprise removal event

This commit introduces a mechanism to report surprise removal events to
drivers via a work_struct. It allows drivers to initiate disconnect cleanup
without waiting on device interrupts that will never arrive.

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

[Severity: High]
Does this lockless check introduce a Time-of-Check to Time-of-Use (TOCTOU)
race window?

If a thread executing pci_dev_set_disconnected() is preempted right after
checking READ_ONCE(dev->disconnect_work_enable) but before calling
schedule_work(), the work might get queued after driver teardown completes.

If a concurrent driver unbind operation calls pci_clear_disconnect_work(),
it will set the flag to 0 and call cancel_work_sync(). Since the work is
not yet queued, cancel_work_sync() would return immediately. The device is
unbound and can be freed, or the module unloaded. When the preempted thread
resumes, it enqueues the work_struct which now resides in freed memory,
potentially causing a Use-After-Free or a crash from executing unmapped
memory.

Note: This issue is not resolved by follow-up patches in this series; the
vulnerable logic is merely moved to schedule_notification_work().

> +	}
> +
>  	return 0;
>  }

[ ... ]

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107b1ef..06d43f57f5094 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h

[ ... ]

> +static inline void pci_clear_disconnect_work(struct pci_dev *pdev)
> +{
> +	WRITE_ONCE(pdev->disconnect_work_enable, 0x0);
> +
> +	/* Make sure to stop using work from now on. */
> +	smp_wmb();
> +
> +	cancel_work_sync(&pdev->disconnect_work);

[Severity: High]
This teardown function assumes cancel_work_sync() will catch all pending
work, but can it synchronize with threads that were preempted just before
calling schedule_work() in pci_dev_set_disconnected()?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905183905.9978=
33-1-abhinjoses@gmail.com?part=3D1
