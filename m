Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035C049B1EE
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162454; cv=none; b=jskyOdt8jKO5pKb9ny6/dJrAIbOTOvwwII8ZoEtXNWVgXxeEcVWyP6/BfqDmbBOpMhMwN/2V/B32UfgEzgh4mIal63v+OsS7aLyLmtQRqSIsouIiqlTSmLhrH8K/eHQHE4DFhvvW2t5dAO7w1Ua9/z4mJ7TaMWnlG+qSw27OTrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162454; c=relaxed/simple;
	bh=ljPZGMW3EOOyQDGbBFq6Gu4+MAFs0+T56XB1zZrbm2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sylqbQgY+Rg4ZzoUlMew+NfTyrlOWEc14rcHzBwnSmUJjgi4fLPsV7shqGRCVSn05Xaw05NcKGyvwYhvLcDUtj8/G8l3YQmL5N+8clT3b+w7HwwQpxtZBRzEV7Qe3LfskQL7ZPBhUz8gy4fi5bWzQqOf7cQevlAr9fN2cI4lb7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVWOiFIK; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVWOiFIK"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c14c9c8ccso107789eec.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 04:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790162452; x=1790767252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M3A4c/xbFZ6e0tq+hH+/3HeXVXMCnlcmFGa/+buKPU0=;
        b=BVWOiFIKs2ja0GMbAE2WuwcWnyFcW3E1bmvWj/P1Z4sHdFzevPgXnMLf6U+4SChNRK
         ThMpxkMNan5bX1AZ904J4qOgvBHI+bvo7Wa3R2jS8W0mhkhuCIOhCZ+t2YAgD9gaW5Ub
         zVD7Jwz8oDk0rE4qOBeWvnpjD9dwVG1M7YCZBKeAGmtIChPbY+ZZAXnOBTSL9ok+IQN0
         LD7s0I0nEBWlKZ7vOBMgUkeJqrIWaZ+8rqGcJkq3wQRfedt4qrowVvH3ODniEF24JtkB
         d6MwreZxeMkp3AfN9Dz+//01pDqy5eL55GmfJfRAwzJUXgoWU7jW+vOHKcHrFHPkFkoZ
         QjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790162452; x=1790767252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M3A4c/xbFZ6e0tq+hH+/3HeXVXMCnlcmFGa/+buKPU0=;
        b=IJ1aPQeLcYJMdoOcENqnZZ2EzN+kicXLccuykswxTkQwO/p1W/ehlwX8I4PH6nYZzY
         M/0p3kQa/TF4+NakW6sqhO1+trQOlobvjIFvQZibgXDiivQ/qUQM4/pvIIGo+DtHdbnO
         l1OJYp0ti4mv4Mb3H04j7D5i+9rBUPEDhoU3lGAGkUWosSlFqmKEJoiWMCLzmCtAhNek
         uv0AYMmIV5Xaf5sUJOAGc5ftNE5x6qErBJBPlMyn+p7r6LpWNn4N3robP3qO2lKiFEPa
         c7IDCKeJDy9thUrAe6KUfrh8S6FzxNL19nRX9O5tfpBzGQEBxqNiSK54x7Te8zcqHwlS
         M1fw==
X-Forwarded-Encrypted: i=1; AKwUvBx9rYNWNmQr/HoiS0KAF82JcIVbEQrI/Wer/qiFBpBNh3vqL6Udh49a5xFwcqsA1PTRIY/z5hC47p4=@vger.kernel.org
X-Gm-Message-State: AFuF++mfHXEZNgP5yP8A8Nj4RJmbWvA1Pt8pEdZrbhjr6BCHZstHdU85
	zFbU6JiHFqDjAWBDygijwf1ejDBMj6nfzCkmXt4+5IE7afrYzcaqQ+E1
X-Gm-Gg: AYBFou2G+oqmjLIFoS8K2NmG3HVjmCc+gptp+FDoVx4O8j5xqAh49CjnN2x+twTORaP
	UolzuQ6FlD8CT2oOhvwKvlxNePMaWnl9QljGr9ep6sQtnphmfGmwpbTEcpPqtg9WLzDNrWgBy1z
	222cfQLjfarfit4soZucckwiOhOgzEYmpOnlfBhFy6gj1SBfA3g5jfv6q3YC8znkdZRuYf8jkGv
	RqYWCt9muVGAailJXu57Pg3AkQDNMbE6g9EWzVIqGMa1v+zdclxXOS26M7xDWhKDjeWcYOsUCFz
	mCVC4rSfdAcFGqgaPWaC19lxNNZYrDzGsWPwQ1AcOE+SdTuM/JzULUwZ8I7gMyDVqfkrNn7yDhb
	wBaM2SUmfHnpJIJbfLLUiVAjbsly7pXgPZJ6Q/f2XPvqTgJ2EFIYNS3xTv/jx1z/+V1L0hDkLY5
	9OBvOJIBTVdlc0re4dcMDmoY8sp54BHn7pCgDNGypw7WxMWz/widkQH5uslnoMQe1hcmTmcH0Oa
	WAsKSFJ6mLt/8RT7/u1J0/vk8GsDEpBgybS+9c7D+V6kx03CiWIiPgxQFW21LH9k4HHC2Bryb4m
	sSC1FvHbzAuGqXHuuA==
X-Received: by 2002:a05:7300:c8c7:b0:33f:3750:4e22 with SMTP id 5a478bee46e88-33f3750519cmr1326580eec.0.1790162451512;
        Wed, 23 Sep 2026 04:20:51 -0700 (PDT)
Received: from cachyos-aura ([45.112.148.98])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96d46f48sm11925271eec.23.2026.09.23.04.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:20:51 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Skip the suspend_noirq config save if runtime-suspended
Date: Wed, 23 Sep 2026 16:50:44 +0530
Message-ID: <20260923112044.187266-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <arOpj4C67BnrNreM@wunner.de>
References: <20260923022511.24932-1-navonjohnlukose@gmail.com> <arOpj4C67BnrNreM@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Sep 23, 2026 at 12:27:27PM +0200, Lukas Wunner wrote:
> Hm, pci_pm_suspend_noirq() should bail out earlier because of the
> dev_pm_skip_suspend() check.  That check resolves to:
>
>   dev_pm_smart_suspend(dev) && pm_runtime_status_suspended(dev)
>
> The code comment in device_prepare_smart_suspend() explains that
> smart_suspend is true for devices without PM callbacks.  But only
> if the parent has smart suspend enabled as well.  I guess that's
> the sticking point?  That the port above the card reader doesn't
> have smart suspend enabled?

It is that check, but it fails on the card reader itself, before the
parent is looked at.  no_pm_callbacks is only set when the bus has no
PM ops either, and pci_bus_type always has pci_dev_pm_ops, so no PCI
device ever counts as having no callbacks.  With no driver to set
DPM_FLAG_SMART_SUSPEND, the reader never gets smart_suspend.

pcieport does set the flag for the port, and on this machine the port
stays in D3hot through suspend.

Thanks,
Navon
