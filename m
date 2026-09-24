Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73380253B58
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 06:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790231352; cv=none; b=qRQ2V1nqpehdT5cQW/gf3yjO66KLPk+WWc8oFzsK128U5N0vMfIc7mEC985QdHkEpX+IK/HhksgOwYonmcsygnv0ozxdDtJlH5npMR6HSJrdt4reQ/ObX15d8/yLI7Nxz7ZvyPh/exsZVWjvIx1eUNHOKtfFkhV70eoFfz07KVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790231352; c=relaxed/simple;
	bh=/TcNUpZ/kuPBAehjsefGYtpqlUGGb1+1+cFMTzz7vMg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PbCKJKBSkbE0PANyKLnVUcgL/8ntEZDSFPaR4BkCjyhoQa7lAY2RaPjjR2qeJBdW8JsQYw7ADHJIt8xCXXy8JVWx5MgFzBH+Q6T8ve5NYXg+mX2azMOJuUCEsXRKzMt87k3xF2NpR+dWKNRcHboVugysP281h0jri9UwyEw4jOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4czQOBA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4czQOBA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C4D1F000FF;
	Thu, 24 Sep 2026 06:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790231351;
	bh=7XycTU9ll7jJENAPT9HnQl4X9jwyjZTdFA1Mez2W6sk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e4czQOBA1OijOm8eCj9TfB+Y77c8tY/EXYRM56St4QT++yHkeVMfR+gBkHYddR3x3
	 f1dQaByg6OhDtwVSqWs3GhmLS+oUFF1vIGmI3qpXAcRo8XSYp+9pdeoWajhQb6mNvf
	 T1J7t4E1n2iZi7lekgnsik9nRPuZFwbQSes+UBHPa9Nj5KZ2i2d+Ve0/4mpiqVVXJi
	 g0oww++/B5EUZnQUjKbWjKOLueA+JoJKfs536lgHpgUzRT3UGArlMj0RZ3heLKkqCe
	 FXBv6s+wkJgH7qxcEPcHbp4xnBcEINFSov/LkOP27diI1nP/W23l6PAjJyGuNd9IqU
	 GE2q54a9wUrEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] nvme: Expose link rate switching tunables via sysfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liao Xuan" <liaoxuan@open-hieco.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <be224cd8385a5c28a20db65d635000a7be4da91a.1790222172.git.liaoxuan@hygon.cn>
References: <cover.1790222172.git.liaoxuan@hygon.cn>
 <be224cd8385a5c28a20db65d635000a7be4da91a.1790222172.git.liaoxuan@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:29:10 +0000
Message-Id: <20260924062911.03C4D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] nvme: Use-After-Free in timer teardown due to missing timer_shutdo=
wn_sync()
- [High] nvme: Use-After-Free on per-CPU stats due to lack of synchronizati=
on during teardown
- [Medium] nvme: sysfs teardown race allows resurrecting feature state and =
causing UAF
- [Medium] nvme: torn read-modify-write data race on per-CPU I/O statistics
--

commit 923c7df43c12b9f8956632abc24a17d7d85b2d2f
Author: Liao Xuan <liaoxuan@open-hieco.net>

nvme: Expose link rate switching tunables via sysfs

This commit adds a speed attribute group under /sys/class/nvme/nvmeX/ to
expose adaptive link rate switching parameters for runtime tuning. The
attributes are read/write and are removed when the controller is torn down.

> diff --git a/drivers/nvme/host/speed_switch.c b/drivers/nvme/host/speed_s=
witch.c
> index 22f180c8119b2..fce4268459a0c 100644
> --- a/drivers/nvme/host/speed_switch.c
> +++ b/drivers/nvme/host/speed_switch.c
[ ... ]
> @@ -405,6 +417,7 @@ void nvme_speed_switch_exit(struct nvme_ctrl *ctrl)
>  	WRITE_ONCE(sw->enabled, false);
>  	timer_delete_sync(&sw->timer);

[Severity: High]
Is it safe to use timer_delete_sync() for the teardown path?

If a concurrent I/O thread in nvme_update_io_stats() is preempted, could it
wait for timer_delete_sync() to complete and then re-arm the timer after
the cancellation completes?

nvme_update_io_stats()
    mod_timer(&sw->timer, jiffies + msecs_to_jiffies(READ_ONCE(sw->monitor_=
interval)));

When the parent nvme_ctrl is later freed, the timer will execute and access
freed memory. Should this use timer_shutdown_sync() instead?

>  	cancel_work_sync(&sw->work);
> +	sysfs_remove_group(&ctrl->device->kobj, &nvme_speed_attr_group);

[Severity: Medium]
Is this sysfs group removed too late, leaving a race window during teardown?

Since WRITE_ONCE(sw->enabled, false) and timer_delete_sync() are called
before sysfs_remove_group(), could a concurrent sysfs write to the enable
attribute execute WRITE_ONCE(sw->enabled, val) and set it back to true?

Because sysfs_remove_group() blocks until active writes finish, it will
proceed to free sw->stats while sw->enabled remains true, guaranteeing that
subsequent I/Os will bypass the guard and access freed memory.

> =20
>  	free_percpu(sw->stats);

[Severity: High]
Can this cause a use-after-free when dereferencing sw->stats?

Since there is no synchronization (such as an RCU grace period or queue
freeze) before freeing the memory, could a concurrent I/O thread executing
nvme_update_io_stats() that has already passed the lockless sw->enabled
check resume and call get_cpu_ptr(sw->stats)?

nvme_update_io_stats()
    stat =3D get_cpu_ptr(sw->stats);

This would dereference the per-CPU pointer which may have just been freed by
this concurrent teardown.

[Severity: Medium]
Can this also cause a torn read-modify-write data race on the per-CPU I/O
statistics?

If nvme_check_io_and_decide_speed() iterates over all CPUs and clears their
counters with a remote, non-atomic write:

    stat->read_bytes =3D 0;
    stat->write_bytes =3D 0;

And concurrently, the I/O submission path nvme_update_io_stats() executes a
non-atomic read-modify-write on its local CPU:

    stat->read_bytes +=3D bytes;

Could the remote write of 0 occur between the local load and store, causing
the 0 to be overwritten by the local CPU's accumulated total, thereby double
counting the transferred bytes and artificially inflating throughput?

>  	sw->stats =3D NULL;
>  }
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index abf8edaae371b..3918d9c3d3306 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
[ ... ]
> @@ -1310,3 +1310,146 @@ const struct attribute_group *nvme_subsys_attrs_g=
roups[] =3D {
[ ... ]
> +static ssize_t nvme_speed_attr_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
[ ... ]
> +	switch (sa->id) {
> +	case NVME_SPEED_ATTR_ENABLE:
> +		if (val > 1)
> +			return -EINVAL;
> +		if (!val && READ_ONCE(sw->enabled)) {
> +			WRITE_ONCE(sw->enabled, false);
> +			timer_delete_sync(&sw->timer);
> +			cancel_work_sync(&sw->work);
> +			atomic_set(&sw->timer_active, NVME_SPEED_TIMER_INACTIVE);
> +		} else
> +			WRITE_ONCE(sw->enabled, val);

[Severity: Medium]
Can this overwrite the teardown flag without a lock?

If this executes concurrently with nvme_speed_switch_exit() due to late
sysfs_remove_group() calling, it could silently reactivate lockless access
to memory that is about to be freed.

> +		break;
> +	case NVME_SPEED_ATTR_MONITOR_INTERVAL:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790222172.gi=
t.liaoxuan@hygon.cn?part=3D3
