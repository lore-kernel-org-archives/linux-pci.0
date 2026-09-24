Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AAF3E7BC7
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790231251; cv=none; b=bb31PFMKsm4mYGtuQ/xRddyPXEJ3uPuMFca9VO6rBOOSwsRvXRDsyh+m+odjRXahlQfn7Fyx0Z1QSPTzXJkZErVDyCRuCAOma59pjp5aOCGEhNcCH8MKSPZB0j83VKbLk2D9cXeuykx1+QdIE0hmvNdK6ygdKQxQpxLmspn4liY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790231251; c=relaxed/simple;
	bh=gWRZthGtBO3IGmOyOpBOTvqYIsL4vkRMMQKc2/g5sZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KHwrx2sw/t7H/pXde5j9CmE3p+ttUu7AFisJg2+BGAaVXP59/tAjFOEHKLiHbqA/p1pVjsngRdG9M/H0llG0mPEYVLe3g3B6jdVkMJ2+/CftWtajM/Jdq9mr5oqfAGmkdB9P5iIa0mK6Z0Ltm/Ct0gcaDb9V5JWBkcu8wrKlhBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hzoi5oMk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hzoi5oMk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860BF1F000FF;
	Thu, 24 Sep 2026 06:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790231249;
	bh=Lwl89TcFlaZaWQlVyVwI6jSFK6D2dwq1l2rdQQjFgbs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hzoi5oMk4uo9FzdQlH61QUkaXMEPfa2mnFokmKsr7r87AZSCdGEAxCfxmzsyH2qkZ
	 6/DoCfsDQN+Ceac4VphDfW5gMm3Trz/rIU+ge37riGXwwIqJYUKNn2muOMwUZaeuDL
	 ATBhzi86Yxs1Dy/d2iIJ/wylE5XFkWmaKA4sSHekJ8Bp1q/7AXa2+Udedj5xbV97yZ
	 Ne/ewkIB5gz4RFlcgiFOWsNdL0kAj231VEDWzrM0OkZg862xbah4JmpoKzPdyh/CIA
	 9my2yg1c3bYDpubtgacwHyGIA4J9mVqhKwt7CPhhIpFfOZbv85D5j+TzSITNLAd083
	 ypEyOBdASi4xQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] nvme: Add hysteresis and idle detection to link
 rate switching
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liao Xuan" <liaoxuan@open-hieco.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <de23e8b9699b5a7a77e7ee215e8e4c9f530ce5da.1790222172.git.liaoxuan@hygon.cn>
References: <cover.1790222172.git.liaoxuan@hygon.cn>
 <de23e8b9699b5a7a77e7ee215e8e4c9f530ce5da.1790222172.git.liaoxuan@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:27:29 +0000
Message-Id: <20260924062729.860BF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] nvme: data race between timer and worker causes stuck link rate
--

commit 281ed4a8d51a45615fb54b154554270a5683089c
Author: Liao Xuan <liaoxuan@open-hieco.net>

nvme: Add hysteresis and idle detection to link rate switching
   =20
This patch adds counters to avoid excessive rate switching when the
workload fluctuates, requiring consecutive windows above or below a
threshold to trigger an upgrade or downgrade. It also stops monitoring
after 10 seconds of inactivity.

> diff --git a/drivers/nvme/host/speed_switch.c b/drivers/nvme/host/speed_s=
witch.c
> index 88c046fcdde89..22f180c8119b2 100644
> --- a/drivers/nvme/host/speed_switch.c
> +++ b/drivers/nvme/host/speed_switch.c
[ ... ]
> @@ -247,31 +252,62 @@ static int nvme_check_io_and_decide_speed(struct nv=
me_speed_switch *sw)
>  		stat->write_bytes =3D 0;
>  	}
> =20
> +	if (read_bytes || write_bytes) {
> +		*io_activity =3D true;
> +		sw->idle_cnt =3D 0;
> +	} else {
> +		sw->idle_cnt++;
> +	}
> +
> +	/* Stop monitoring after 10 seconds of inactivity (100 windows of 100ms=
). */
> +	if (sw->idle_cnt >=3D 100)
> +		*io_activity =3D false;
> +
>  	read_kb =3D read_bytes / 1024;
>  	write_kb =3D write_bytes / 1024;
>  	dev_dbg(ctrl->device,
>  		"I/O in window: read=3D%lu KB, write=3D%lu KB, threshold=3D%u KB\n",
>  		read_kb, write_kb, READ_ONCE(sw->threshold));
> =20
> -	if (read_kb >=3D sw->threshold || write_kb >=3D sw->threshold)
> +	if (read_kb >=3D sw->threshold || write_kb >=3D sw->threshold) {
> +		sw->up_cnt++;
> +		sw->down_cnt =3D 0;
> +	} else {
> +		sw->down_cnt++;
> +		sw->up_cnt =3D 0;
> +	}
> +
> +	if (sw->up_cnt > READ_ONCE(sw->up_threshold)) {
> +		sw->up_cnt =3D 0;
>  		return sw->max_speed;
> +	}
> +
> +	if (sw->down_cnt > READ_ONCE(sw->down_threshold) || !*io_activity) {
> +		sw->down_cnt =3D 0;
> +		return sw->min_speed;
> +	}
> =20
> -	return sw->min_speed;
> +	return READ_ONCE(sw->cur_speed);

[Severity: High]
Does returning cur_speed here cause a data race between the timer and the
worker that leaves the hardware link rate permanently throttled?

If the timer previously returned min_speed and scheduled
nvme_speed_switch_work(), the worker will freeze the queues and begin a slow
hardware transition via pcie_set_target_speed().

While the worker is blocked on the hardware transition, I/O is 0 because the
queues are frozen. The concurrent timer will increment down_cnt, but since =
it
is below down_threshold, it will fall through and return
READ_ONCE(sw->cur_speed).

Because the worker hasn't updated sw->cur_speed yet, it's still max_speed.
The timer then updates sw->target_speed to max_speed:

drivers/nvme/host/speed_switch.c:nvme_speed_switch_timer_fn() {
    ...
	sw->target_speed =3D nvme_check_io_and_decide_speed(sw, &io_activity);
    ...
}

When the worker finishes setting the hardware to min_speed, it double-reads
sw->target_speed:

drivers/nvme/host/speed_switch.c:nvme_speed_switch_work() {
    ...
	ret =3D pcie_set_target_speed(bridge, nvme_speed_to_bus_speed(sw->target_s=
peed),
				    true);
	if (ret) {
        ...
	} else {
		WRITE_ONCE(sw->cur_speed, sw->target_speed);
	}
    ...
}

This overwrites cur_speed with the timer-corrupted value (max_speed).

The hardware is now throttled at min_speed, but software thinks it is at
max_speed.

When high I/O resumes, the timer will decide the target is max_speed, but
since cur_speed is already max_speed, it won't schedule the worker to resto=
re
the link rate, causing a severe performance regression.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790222172.gi=
t.liaoxuan@hygon.cn?part=3D2
