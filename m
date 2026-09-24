Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3383E7BCC
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 06:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790231383; cv=none; b=RQRitYjcVfbTJBpqnL3VMolk4FTPrvLYlsLyS2RbOdJ8XilV0I8RCUU2d+TI/+kQ3plk1cuaY9FVTeHJYvUHZFP7KLuVQ5bKQqgrLdHIv8AOl7dAU48uDrsOkyBXa754bdqDKJZ2ZPmw41FQqIiOsIWIvT2AsDsnAYk6RW0jXfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790231383; c=relaxed/simple;
	bh=8Ibxij+/x3hbm8xwQ38ygu3yVPlClXzhWveuN1d695U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FbgUhNmfEeJEIEkE7Wy0Ri+2gXSnpAhtq9V75dTeLwKdfsWOlHqro4+K2BpWKOKyoFPLO9hPyMrCfT04LQN6N2oH0ukyav2PVlWPuWzP49oJDSUo9Eab4c87aPyMrHq1tzw7HsaGxqDTogToIoQ8bbgnYsDA5pnPbhRgDxuroBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9bxgsIC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9bxgsIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFE91F000FF;
	Thu, 24 Sep 2026 06:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790231381;
	bh=M4zYFMFAokCj4qHG7nq67EOFpwlCHJX8xH3VyW6Scbo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n9bxgsICHkZpL/in/xpsA9a+IQOx/ZPVmfl8a6HsYEdcBfdpKquEy9es/dPw54Jip
	 UkWQAyGSHsTBUlkW61lFXhUtN5J7jn/ShyYEyMLMnI2poNTROWgugUGusHz6KUBH5I
	 m69jpXiR7dgDLaSrSrdxI7MEqhl1X5zD58r+u8/JJjeVV7Osk2Y8gjH2xye0HAV/+8
	 anVpaIWfiJo6/0ew1rl15EGT/fTvTrFRwbnqHZETGTeM/GT0t/c0IujLTTXrTXuNvR
	 4fIjdGCkYe6tqEfJkjSjJOqt+LQNf2ZN+IijL7Gz05RhnnMhXZdJgKtFyr3oQssNOn
	 Kcq9E0VwceNSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] nvme: Add adaptive PCIe link rate switching
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liao Xuan" <liaoxuan@open-hieco.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <9e99e007bf05a608b1b82da740c2b33935a27175.1790222172.git.liaoxuan@hygon.cn>
References: <cover.1790222172.git.liaoxuan@hygon.cn>
 <9e99e007bf05a608b1b82da740c2b33935a27175.1790222172.git.liaoxuan@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:29:41 +0000
Message-Id: <20260924062941.ADFE91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] nvme: UAF on per-CPU stats and timer re-arming race during teardown
- [High] nvme: infinite link retrain loop on rollback success
- [High] nvme: TOCTOU data race on sw->target_speed causes link mismatch
- [High] nvme: speed switch timer runs during suspend causing deadlocks
- [High] nvme: missing memalloc_noio_save() around queue freeze
- [High] nvme: nvme_unfreeze clears NVME_CTRL_FROZEN prematurely
- [Medium] nvme: synchronous PCIe config space read on block I/O fast path
- [Medium] nvme: data race when zeroing remote per-CPU statistics
- [Medium] nvme: speed switch permanently disabled after controller reset
--

commit 3ad252ce0a89b0f36c40c41b569dd1f1382434b5
Author: Liao Xuan <liaoxuan@open-hieco.net>

nvme: Add adaptive PCIe link rate switching function

This commit introduces dynamic adjustment of the PCIe link rate for NVMe
devices based on I/O activity. The link speed is downgraded during periods
of low activity to save power and upgraded to maximum when I/O load crosses
a calculated threshold.

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1322c678f4eb8..254053ea15fcb 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
[ ... ]
> @@ -5089,6 +5090,7 @@ EXPORT_SYMBOL_GPL(nvme_remove_io_tag_set);
> =20
>  void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>  {
> +	nvme_speed_switch_exit(ctrl);
>  	nvme_mpath_stop(ctrl);
>  	nvme_auth_stop(ctrl);

[Severity: Medium]
Since nvme_add_ctrl() only initializes the speed switch once during device
probe, will calling nvme_speed_switch_exit() during nvme_stop_ctrl()
permanently disable the feature after the first controller reset? The reset
recovery path does not appear to call nvme_speed_switch_init() again.

[ ... ]
> diff --git a/drivers/nvme/host/speed_switch.c b/drivers/nvme/host/speed_s=
witch.c
> new file mode 100644
> index 0000000000000..88c046fcdde89
> --- /dev/null
> +++ b/drivers/nvme/host/speed_switch.c
[ ... ]
> +static void nvme_speed_switch_work(struct work_struct *work)
> +{
> +	struct nvme_speed_switch *sw =3D container_of(work, struct nvme_speed_s=
witch, work);
> +	struct nvme_ctrl *ctrl =3D container_of(sw, struct nvme_ctrl, speed_swi=
tch);
> +	struct pci_dev *pdev =3D to_pci_dev(ctrl->dev);
> +	struct pci_dev *bridge =3D pdev->bus->self;
> +	u8 cur_speed =3D READ_ONCE(sw->cur_speed);
> +	int ret;
> +
> +	if (nvme_ctrl_state(ctrl) !=3D NVME_CTRL_LIVE)
> +		return;

[Severity: High]
Is this guard sufficient to prevent operations during host-managed suspend?
The controller state remains NVME_CTRL_LIVE during host-managed suspend,
which might allow the timer to fire, schedule this work, and attempt to
access the PCIe configuration space of a suspended device.

> +
> +	/* Freeze I/O to avoid timeouts during link retraining. */
> +	nvme_start_freeze(ctrl);
> +	nvme_wait_freeze(ctrl);
> +
> +	ret =3D pcie_set_target_speed(bridge, nvme_speed_to_bus_speed(sw->targe=
t_speed),
> +				    true);

[Severity: High]
Should this section be protected by memalloc_noio_save() and
memalloc_noio_restore()? Code executing while a block queue is frozen
typically needs NOIO protection. Otherwise, memory reclaim interrupting this
section could attempt to flush dirty pages to the frozen NVMe device,
leading to a system deadlock under memory pressure.

[Severity: High]
Could reading sw->target_speed here introduce a TOCTOU data race? This value
is read to program the hardware, but read again below to update sw->cur_spe=
ed.

> +	if (ret) {
> +		dev_warn(ctrl->device,
> +			 "failed to set target rate Gen%u (%d), trying rollback to Gen%u\n",
> +			 sw->target_speed, ret, cur_speed);
> +		ret =3D pcie_set_target_speed(bridge, nvme_speed_to_bus_speed(cur_spee=
d),
> +					    true);
> +		if (ret) {
> +			dev_err(ctrl->device,
> +				"rollback to Gen%u failed (%d), disabling speed switch\n",
> +				cur_speed, ret);
> +			WRITE_ONCE(sw->enabled, false);
> +			nvme_unfreeze(ctrl);
> +			return;
> +		}

[Severity: High]
If the pcie_set_target_speed() rollback succeeds, the code omits disabling =
the
speed switch. Since the function returns while sw->enabled remains true, wo=
n't
the timer fire again 100ms later, see a target speed mismatch, and repeated=
ly
fail, freezing the queues continuously?

> +	} else {
> +		WRITE_ONCE(sw->cur_speed, sw->target_speed);
> +	}

[Severity: High]
If the timer concurrently updates sw->target_speed between the hardware
programming step and this write, sw->cur_speed will receive the new value
while the hardware was programmed to the old value. Will this cause the
hardware link speed to become permanently out-of-sync with the software sta=
te?

> +
> +	nvme_unfreeze(ctrl);

[Severity: High]
Is it safe to unconditionally call nvme_unfreeze() here? nvme_unfreeze()
explicitly clears the NVME_CTRL_FROZEN bit. If this work finishes while a
concurrent controller reset is ongoing, it clears the flag prematurely, whi=
ch
could break the reset state machine and allow namespaces to be added
concurrently with the reset.

> +	dev_dbg(ctrl->device, "link rate changed to Gen%u\n",
> +		READ_ONCE(sw->cur_speed));
> +}
[ ... ]
> +/* Called on the I/O submission path to accumulate the transferred bytes=
. */
> +void nvme_update_io_stats(struct nvme_ctrl *ctrl, struct request *req)
> +{
> +	struct nvme_speed_switch *sw =3D &ctrl->speed_switch;
> +	struct nvme_speed_switch_stats *stat;
> +	enum req_op op =3D req_op(req);
> +	unsigned int bytes =3D blk_rq_bytes(req);
> +
> +	if (!READ_ONCE(sw->enabled))
> +		return;
> +
> +	if (op !=3D REQ_OP_READ && op !=3D REQ_OP_WRITE)
> +		return;
> +
> +	if (!sw->stats) {
> +		dev_dbg(ctrl->device, "I/O statistics not allocated, skip accounting\n=
");
> +		return;
> +	}
> +
> +	stat =3D get_cpu_ptr(sw->stats);

[Severity: High]
Could the I/O thread locklessly dereference sw->stats after it has been
freed? If the I/O thread is preempted right after checking sw->enabled, and=
 a
concurrent controller reset calls nvme_speed_switch_exit() (which frees
sw->stats), the I/O thread would resume and access the freed memory here.

> +	if (op =3D=3D REQ_OP_READ)
> +		stat->read_bytes +=3D bytes;
> +	else
> +		stat->write_bytes +=3D bytes;
> +	put_cpu_ptr(sw->stats);
> +
> +	if (atomic_cmpxchg(&sw->timer_active, NVME_SPEED_TIMER_INACTIVE,
> +			   NVME_SPEED_TIMER_ACTIVE) !=3D NVME_SPEED_TIMER_INACTIVE)
> +		return;
> +
> +	/* First I/O of the activity period: compute the threshold and arm the =
timer. */
> +	WRITE_ONCE(sw->threshold, nvme_calc_speed_threshold(sw,
> +					pcie_get_width_cap(to_pci_dev(ctrl->dev))));

[Severity: Medium]
Does pcie_get_width_cap() perform a synchronous read of the PCIe configurat=
ion
space? Evaluating this on the first I/O of an activity period within the bl=
ock
I/O submission fast path might introduce severe latency spikes for affected
requests.

> +	if (!READ_ONCE(sw->threshold)) {
> +		dev_warn(ctrl->device,
> +			 "failed to compute speed switch threshold, keeping current rate\n");
> +		atomic_set(&sw->timer_active, NVME_SPEED_TIMER_INACTIVE);
> +		return;
> +	}
> +	mod_timer(&sw->timer, jiffies + msecs_to_jiffies(READ_ONCE(sw->monitor_=
interval)));
> +}

[Severity: High]
Following up on the preemption scenario, if nvme_speed_switch_exit() comple=
tes
its teardown (including timer_delete_sync()), will this mod_timer() call
re-arm the timer after teardown has finished, leading to a delayed
use-after-free when the timer fires?

[ ... ]
> +static int nvme_check_io_and_decide_speed(struct nvme_speed_switch *sw)
> +{
> +	struct nvme_ctrl *ctrl =3D container_of(sw, struct nvme_ctrl, speed_swi=
tch);
> +	u64 read_bytes =3D 0, write_bytes =3D 0;
> +	unsigned long read_kb, write_kb;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct nvme_speed_switch_stats *stat =3D per_cpu_ptr(sw->stats, cpu);
> +
> +		read_bytes +=3D stat->read_bytes;
> +		write_bytes +=3D stat->write_bytes;
> +		stat->read_bytes =3D 0;
> +		stat->write_bytes =3D 0;
> +	}

[Severity: Medium]
Could zeroing these remote per-CPU statistics lead to a data race? The timer
callback iterates over all CPUs and assigns 0 to stat->read_bytes and
stat->write_bytes of remote CPUs concurrently while the I/O submission path
might be updating these variables. Without atomic operations or
synchronization, this could cause incorrect statistics and dropped incremen=
ts.

[ ... ]
> +void nvme_speed_switch_exit(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_speed_switch *sw =3D &ctrl->speed_switch;
> +
> +	if (!sw->initialized)
> +		return;
> +
> +	sw->initialized =3D false;
> +	WRITE_ONCE(sw->enabled, false);
> +	timer_delete_sync(&sw->timer);
> +	cancel_work_sync(&sw->work);
> +
> +	free_percpu(sw->stats);
> +	sw->stats =3D NULL;
> +}

[Severity: High]
This teardown routine frees sw->stats and uses timer_delete_sync(), but does
this adequately prevent the timer from being asynchronously re-armed by an =
I/O
thread that had already passed the sw->enabled check?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790222172.gi=
t.liaoxuan@hygon.cn?part=3D1
