Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA583FA5D2
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 03:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785815048; cv=none; b=RwVmPPb3qAYO1/yJPoJs891q88ehEPXbG4qwa2B+ONsquKjLYgUhqFL6PD3gPbVceg+CW7iy6lxkHxA4TOsP1ll7FBa+zdLIRJdoFX5h0Q+3kuu6CkhmCWTqTyhImciL/dyDY/luDDDDG6hR+8+ROm6fWECAfrP4j8U5Q8RUgzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785815048; c=relaxed/simple;
	bh=RWh0Wg4Y8qFiihDB9BlCPa3VNeFp7AJ3amPLzzfbAhE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NquDz/gRI5MOn66JCeET4AVojAd/C/ZFZVb/7+zIJmyAbkLGVilpbU4/x4VU4ZRKl6JoOj+wuRVfZVZes81SnQKLMVf9Lpx2IvW6sTeuqcLqvVd29Q9t/6fxPzymCGjkllieb+S0kFByVdnw/cpiJKlSPaQvZ2bI2SP2Z3WCgKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUeHarV1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUeHarV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D631F000E9;
	Tue,  4 Aug 2026 03:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785815047;
	bh=/ZWzQiYBh8A9pvhmCAm0FV25JmGcFjyy26Ltz4ieHgI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JUeHarV1Do+mux+yLkVGfE13a5p9mw2BvJkRdnUd9HwdHIjFtxKyyBWmlV1vT+iR3
	 tKVe9eWP05z44XevKUzwpBBiWGb8A8hsh9+k+EgLG3/Il7ZQ+fK9mvsh30ChRbT5ls
	 vaMKoc48DHkt8tjS5a0OILNHMr2TTGtUyoXaBqnoiBgFhCHARdCUsaYhCmL/CTRLJj
	 DMXktX3FHzfasyCVNbs6oR9u2VMAts+ptp9qJG9JJVGJvVckG51t5GnGj40p0KXCXd
	 HgNF+DUNxMMCTbLk7vm4ql1SvAKVnfsPqYqR6X5LVKkl9uiNXIv6d7k5/iLYso3DEd
	 djz6M7Ke40mlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: switchtec: Fix use-after-free in
 switchtec_pci_remove due to race condition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pei Xiao" <xiaopei01@kylinos.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <6fdcbfa869f707cad783c7f92d1681f0a2bd9a7c.1785813784.git.xiaopei01@kylinos.cn>
References: <6fdcbfa869f707cad783c7f92d1681f0a2bd9a7c.1785813784.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 03:44:06 +0000
Message-Id: <20260804034406.C5D631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for Use-After-Free: `cancel_work_sync()` is called =
without synchronizing or freeing active IRQ handlers, allowing ISRs to exec=
ute after `stdev` is freed and re-schedule works.
- [High] Incorrect cancellation ordering allows `mrpc_timeout` delayed work=
 to be re-armed by concurrent userspace IO after `cancel_delayed_work_sync(=
)`, leading to Use-After-Free.
--

--- Patch [1]: [PATCH] PCI: switchtec: Fix use-after-free in switchtec_pci_=
remove due to race condition ---
commit e4d2baee32009f95ba28f6ef409e3f3b5a2a15e3
Author: Pei Xiao <xiaopei01@kylinos.cn>
PCI: switchtec: Fix use-after-free in switchtec_pci_remove due to race cond=
ition

This commit attempts to fix a use-after-free bug by canceling the mrpc_work
and link_event_work works during stdev_kill(). It ensures works are canceled
after pci_clear_master() stops the endpoint from issuing further interrupts.

> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchte=
c.c
> index 41fc4b5127081..8426d5a9c1c7d 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1319,6 +1319,8 @@ static void stdev_kill(struct switchtec_dev *stdev)
>  	pci_clear_master(stdev->pdev);
> =20
>  	cancel_delayed_work_sync(&stdev->mrpc_timeout);

[Severity: High]
This is a pre-existing issue, but does canceling this delayed work here lea=
ve
a race window where concurrent userspace operations can re-arm it?

Since cancel_delayed_work_sync() is called before the mrpc_mutex is acquired
and stdev->alive is set to false, can a concurrent switchtec_dev_write()
verify stdev->alive =3D=3D true and call mrpc_cmd_submit()?

mrpc_cmd_submit()
  schedule_delayed_work(&stdev->mrpc_timeout, msecs_to_jiffies(500));

If userspace then closes the file descriptor, dropping the final kobject
reference and freeing stdev, won't the delayed work timer expire and execute
mrpc_timeout_work() on the freed stdev?

> +	cancel_work_sync(&stdev->mrpc_work);
> +	cancel_work_sync(&stdev->link_event_work);

[Severity: High]
This isn't a bug introduced by this patch, but does pci_clear_master() wait
for currently executing interrupt handlers to finish?

During device unbind, switchtec_pci_remove() calls stdev_kill(). While
pci_clear_master() prevents new interrupts from being initiated, it doesn't
flush pending interrupts or wait for executing handlers like
switchtec_event_isr().

Could a handler continue running concurrently, and after these works are
canceled, schedule the work again?

switchtec_event_isr()
  schedule_work(&stdev->mrpc_work);

If put_device(&stdev->dev) then frees stdev before the driver's devres (whi=
ch
owns the interrupt) runs, won't this result in a use-after-free when the
handler places the freed work struct onto the workqueue?

> =20
>  	/* Mark the hardware as unavailable and complete all completions */
>  	scoped_guard (mutex, &stdev->mrpc_mutex) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6fdcbfa869f707cad78=
3c7f92d1681f0a2bd9a7c.1785813784.git.xiaopei01@kylinos.cn?part=3D1
