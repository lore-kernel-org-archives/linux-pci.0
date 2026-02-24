Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303DA366DD6
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927434; cv=none; b=HfzDALeWPMptK3A543ps6f9FNrT1Ts5pIJt9ce5T2lkP91p5wEYM46wxnSYIgPNnuCQfKZHt/Xbbn4mEbIISFQMGEw8WuxSOTwWq9ALeKHk5Wpcj97IfOlVhpss3q4o7Le6bt0jEPbfhUFdqCDlMtNEKCAyQ1mZstWvpeU5/nkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927434; c=relaxed/simple;
	bh=UpQ2+CjRYbdqAYCsjnR0hzz+Gs0xsp1F8m+cr8HP7qY=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hc4hH0SUuexmflKcuAmvBV7VkjXlX2fg/3KvenSZy3hotrHmSxWCQPvsO8KnuiTYUz6upzjMUjfoD+W3BJzOcDQdqSCeN4shqbhvZxhk3nz538Jm9t2CbV5k6CHzC4/8az5PT3kV05dtueDwOL1FlfWcejz1Tj8v5TJxPieRhTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZ6JHx/e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZ6JHx/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4ED1C19424
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 10:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771927433;
	bh=UpQ2+CjRYbdqAYCsjnR0hzz+Gs0xsp1F8m+cr8HP7qY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=pZ6JHx/etCgr3g6nKx1e/xCNnxZXnfjzBxxjqXUOBuZGIaCdaS+qBDd8Yihx9BePg
	 N3iQzbkkDcT6iUMVpR5DMUacJnPq2wAsVnnuyYtU1gkDcGm+upcXLhvkC5/sXbJq1q
	 K44GFlH01pHd1kZI1TK0jBvaNZMwcqE0nTl4zWcxT6DuYA/gnPr7o8s+8LIud8yef5
	 7Bw5KIradsZM8nXmwXpN2nWC8AKRvMBjHUk00afmHwuvbvMvInlUZ/NzYWq2Om0i4b
	 iDa6Fai4ZlSIj9dBcCBRlUpC6PY9vq3LWPyBuDouySvEc9GeL8B2dJX/j53Vldtqd3
	 ATPiiZ0G+W/mQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3871126dcceso41938841fa.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 02:03:53 -0800 (PST)
X-Gm-Message-State: AOJu0Yw5g1HsC2qgaasrjyvVXt0SrTizS/zdDrSKh3TT4Rg1H1R/IDgv
	qoxagxTDM277uOqhtoYmeaemPtwO3ypnhFXG3gHBoWITaUFq9RtawHNuU/DIbo1xlQ7IKIKoqs/
	zx9Y6T50yqeiaLhuOg6kt87x0bbILlC2U5QmXh3KZvQ==
X-Received: by 2002:a05:651c:2105:b0:388:62de:d8b2 with SMTP id
 38308e7fff4ca-389a5aa0c1bmr39142241fa.8.1771927432629; Tue, 24 Feb 2026
 02:03:52 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 02:03:51 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Feb 2026 02:03:51 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260224071258.2654521-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224071258.2654521-1-wenst@chromium.org>
Date: Tue, 24 Feb 2026 02:03:51 -0800
X-Gmail-Original-Message-ID: <CAMRc=MeXhB-=vT8d+u+-od7t9WqziHRtN2aCum0Tg_7vSrkv3Q@mail.gmail.com>
X-Gm-Features: AaiRm52Hi0Zoo6U7PoLWPBCoo07CV456ICsm8hKjm-acKhNUwq16XM4ftmJm_fs
Message-ID: <CAMRc=MeXhB-=vT8d+u+-od7t9WqziHRtN2aCum0Tg_7vSrkv3Q@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctrl: Do not power off on pwrctrl device removal
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Feb 2026 08:12:56 +0100, Chen-Yu Tsai <wenst@chromium.org> said:
> With the move to explicit pwrctrl power on/off APIs, the caller, i.e.
> the PCI driver should manage the power state. The pwrctrl drivers should
> not try to clean up or power off when they are removed, as this might
> end up disabling an already disabled regulator, causing a big warning.
> This can be triggered if a PCI controller driver's .remove() callback
> calls pci_pwrctrl_destroy_devices() after pci_pwrctrl_power_off_devices().
>
> Drop the devm cleanup parts that turn off regulators from the pwrctrl
> drivers.
>
> Fixes: b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power on/off, destroy APIs")
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Hi,
>
> I ran into this while integrating the new pci_pwrctrl_*() API into the
> MediaTek driver. I am sending this separately since this change is
> unrelated and does not conflict with or depend on the other changes for
> the driver itself.
>
> I think this should be merged for fixes.
>

Makes sense.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
