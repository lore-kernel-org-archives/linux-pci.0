Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F57D3A544C
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 11:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805873; cv=none; b=cHS9KYyO8o6CoZ5ZQbrP91WWSrVEDigUfMMYkZZuppZQHnPeBwrgBXwsh4ILexQUIHpR93H0nmqQcBMhSWf9gW2N0992ufQW9swq3GeWM9kNMRvPp1tuX/p8i9BLOJkjS3uaYkX1yT4PDDCK9WIMTIS36x8R+OOmASTy24/gezo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805873; c=relaxed/simple;
	bh=QcIHzaXp2uzNr9ApQo6Zm4iwowhE/oJ5oO3RhN3cJBc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WGoR1WHtNESxsXWte0N1M9zEPoB/ln+HSCJhR5w4NmXjLUFvNAKimQ7CkIYz8R/vVDVqXjSIRnQRr9XYvSpb5ri+1mnSE2QEXvJziRjNLvf3HrQcONdowj5uz3bssbDnyzaCkuMW7hR9OTMuBsXANQXpR/gTi2r3aY0D/lrEF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joEDxKdu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joEDxKdu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C551F0089C;
	Mon, 12 Oct 2026 11:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791805871;
	bh=OpsiNYvKctFHfHgnoRWHYD3Ibq7FUkWTYjZbJlhITMI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=joEDxKduAc6q6bii4ucrT0uA8QiEUgUXOpfk3q04MCaEsbsR/fgbSB9trdgX2rd76
	 UF/xanI4ejENSOw8f9smnAqYzJ7/xLnVhguuDKhWlCE4Csqc3UPRrwj8k0WX/OsOtD
	 TbCbzZWkf+papiNyMV6AecxPZXew0/EYmchYbm15f4gVxSC3qYHc0AkbD3kBdaWoaA
	 JhSqfm3CU9zZpFlfXd1lMTTbkCYeiliXnjYn4jE8rYH/IiVHbwj4l5qJIpZv+Us10i
	 sy1F6Km4LFHD5EzZVuFmDFveOf4XIoyFer6EgCgDb8u4sNDJyUn0SReC5s3NpGwND6
	 nMISFKkMYz4pg==
Message-ID: <sashiko-outbox-168028@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] PCI/DOE: Poll briefly for a response before
 sleeping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Clapinski" <mclapinski@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261012114213.1757207-1-mclapinski@google.com>
References: <20261012114213.1757207-1-mclapinski@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 11:51:11 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci/doe: CPU busy loop when HZ=3D100 due to PCI_DOE_POLL_INTERVA=
L=3D0
--

commit 16e5277536bbca37386848082d18257e2ffa71dd
Author: Michal Clapinski <mclapinski@google.com>

PCI/DOE: Poll briefly for a response before sleeping

doe_statemachine_work() waits for a response by sleeping
PCI_DOE_POLL_INTERVAL (PCI_DOE_TIMEOUT / 128) between status reads,
which is 7 ms at HZ=3D1000 and 4 ms at HZ=3D250. Exchanges are served from
the device's local mailbox logic and typically complete within tens of
microseconds, so nearly all of that sleep is wasted. Every DOE-capable
endpoint pays it once per supported feature during enumeration.

> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 6b5d9ba8e9697..5e93d78a1a97e 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -27,6 +27,9 @@
>  /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
>  #define PCI_DOE_TIMEOUT HZ
>  #define PCI_DOE_POLL_INTERVAL	(PCI_DOE_TIMEOUT / 128)

[Severity: Medium]
When HZ=3D100, does this integer division truncate to 0?

If PCI_DOE_POLL_INTERVAL evaluates to 0, it permanently breaks the fallback
sleep mechanism.

> +#define PCI_DOE_POLL_FAST_MIN_US	20
> +#define PCI_DOE_POLL_FAST_MAX_US	50
> +#define PCI_DOE_POLL_FAST_TRIES		40

[ ... ]

> @@ -525,10 +528,25 @@ static void doe_statemachine_work(struct work_struc=
t *work)
>  			signal_task_abort(task, -EIO);
>  			return;
>  		}
> -		rc =3D pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
> -		if (rc) {
> -			signal_task_abort(task, rc);
> -			return;
> +		/*
> +		 * Exchanges are served from the device's local mailbox
> +		 * logic and usually complete in tens of microseconds, far
> +		 * below the jiffies granularity of PCI_DOE_POLL_INTERVAL.
> +		 * Poll for up to ~2 ms before falling back to it.
> +		 */
> +		if (tries++ < PCI_DOE_POLL_FAST_TRIES) {
> +			if (test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags)) {
> +				signal_task_abort(task, -EIO);
> +				return;
> +			}
> +			usleep_range(PCI_DOE_POLL_FAST_MIN_US,
> +				     PCI_DOE_POLL_FAST_MAX_US);
> +		} else {
> +			rc =3D pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);

[Severity: Medium]
Does passing 0 to this wait function when HZ=3D100 trigger a tight spin bug
instead of yielding the CPU?

Since wait_event_timeout() immediately returns without sleeping when the
timeout is 0, this regression results in a tight CPU busy loop spinning over
pci_read_config_dword() continuously for up to 1 second during enumeration
for affected hardware.

> +			if (rc) {
> +				signal_task_abort(task, rc);
> +				return;
> +			}
>  		}
>  		goto retry_resp;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012114213.1757=
207-1-mclapinski@google.com?part=3D1
