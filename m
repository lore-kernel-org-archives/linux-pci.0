Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D78438330E
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779481671; cv=none; b=F7PQWrZHRbGgwLFZYNP3eyEGDx/wHn8urifPQjtGek52KZwu7QQV8dOhpFgOBE0sbmlg1kUpLGYcDlNRT5ouERiE+gRWLaCLowq8XwquZ2MUcctPWD3BueLyXUa5QCmmkf1pIcFS5sKPbLYHhYu6/lT06SVk3i79N8IdC2uLD78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779481671; c=relaxed/simple;
	bh=vD0NGKmZJH6OjEeLX1hplt52pSbhQCv+7Fu0Y92tE+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+fo/GSdXWSrw9pZX1VzYWMCQ9D3U6jsRZlPqhK5ONj6aIs3nIzqZIDWUMIWTp+V+vamhZ8V2A48FuYOdKyQAU+XZi39j/LYiWjqlmldZk4kzuk6BhH6Vq6tt2d/qhT9j+kNAJKR92AUFsRzHIR2mg3BHnZCc3mgn1IFVruIW2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S/8+awcl; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S/8+awcl"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3045c195251so585828eec.1
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 13:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779481668; x=1780086468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MmVms1Ce7TXzV6PTImEMq1eJYsKLuKG4ibEOvZoeRdo=;
        b=S/8+awclM6Yc7YJLG8OqaAmZmiHqQgLgg5V+8E5Dr+slHlxSj5xcxjxJq3g2aVp0oN
         CX2Fo5t8mUQDHtwxFMmeQxHuK8mE38AQdV1M2SfTVLLAzvGeO2Gosn52xfVwFmBQpZtq
         KT/yXLYXf6YkXmEMDXDrb9NgAnwHkotCyO+ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779481668; x=1780086468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmVms1Ce7TXzV6PTImEMq1eJYsKLuKG4ibEOvZoeRdo=;
        b=NR0b1bpS8V4P65hgVHR8tro0ti53+vn88VSJky5yqrIv2QANkAF0dIYAde30j84mU+
         TSxGLSaq1XuZA/bBi0M+jf6sX093E90ff6YoVdXMqmeiWFtl3eZPWhIcB5cHyVTl/BnW
         yMdTLh4E71NwhYuSsUynNytWYE3Mg32mQEHh4zaDcbkFgScb7gh98eke4TUSaetOfYy+
         GwHk9HYtRTGgnkDAG6xG2ozrPg9o8QJmgJrcCw/3Oa12NH8GhsljPi+qsYeBWAPvDtLH
         dCuODyRkcyjbVfX25xclIGpC6eh27L/cF7UI/ZtQZfAT2MFTos3yraUk/D4dy1jI5sOK
         GkEA==
X-Forwarded-Encrypted: i=1; AFNElJ8IcFJC26a7Cuwd/4KpviEon1WL49W9u/G2km6Tk2kkRLVRR5zYXTbhxrU7sjrpiWTRsxHR82H4Y9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNCXHb7497SEZLsAuZUSp7tWr19cICI+43u656fOGz0AZwtIjO
	0KdJjCgpl4+wTNjXHYgJKhBTCbAf6G02paWArsPomGXUY8SfQz/6Lnw1Yv28CFH5Rg==
X-Gm-Gg: Acq92OFs0fPXlVLxoIrxK8UNshpIqSmPAA1cGRfMAvuoPvGB3JQKFvYc+wWT8sRINjI
	+Absf/bW9k4rEBkaWqVo950NFU9BUeUSd0xGcSHPucp4abifnxmN9q63pqnFO6v/adUBq8YPp6o
	voWGaVH2aLRFITT9xK+zBJUsucXw+T1HYW3RN716CM86HfyCjvlS1wNmw68pm1Gj8YcQ3M5+7Xl
	Tb5YdVzVr3jFYWDPegggCQq0oD0DQeWRQJawuESjMnYDNxxdCKqw5e+JlHh/W7rlM98rrPNXy/M
	yqKzSHJTVtnppyBD/pPoX9slmt4FK1UCXTmTlYctM0MQreiaZWBBZ58ughX6IWmV+09TmWD5GBD
	xiTSo8E87/Reo1xwjUkwt1D+nWU/ZgcjCOg8u0AZZlFJqqjSk0yRwzj/xnWs0toFrpebjwHCwsp
	bEehWRack19Uh0Tkv2AUN4b5fc+uBL7OeuQda0z26S/cI3tCSyYf55h5lXVmZ8vw==
X-Received: by 2002:a05:7300:b104:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-30448ffc85fmr2757627eec.8.1779481667664;
        Fri, 22 May 2026 13:27:47 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:c51f:b7da:e920:bf64])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-304522314a4sm1757579eec.18.2026.05.22.13.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 13:27:46 -0700 (PDT)
Date: Fri, 22 May 2026 13:27:43 -0700
From: Brian Norris <briannorris@chromium.org>
To: Radu Rendec <rrendec@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Daniel Tsai <danielsftsai@google.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Brian Masney <bmasney@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Alessandro Carminati <acarmina@redhat.com>,
	Jared Kangas <jkangas@redhat.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] PCI: dwc: Enable MSI affinity support
Message-ID: <ahC8Pyuatu_AvnZp@google.com>
References: <20251128212055.1409093-1-rrendec@redhat.com>
 <20251128212055.1409093-4-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128212055.1409093-4-rrendec@redhat.com>

Hi Radu,

On Fri, Nov 28, 2025 at 04:20:55PM -0500, Radu Rendec wrote:
> Leverage the interrupt redirection infrastructure to enable CPU affinity
> support for MSI interrupts. Since the parent interrupt affinity cannot
> be changed, affinity control for the child interrupt (MSI) is achieved
> by redirecting the handler to run in IRQ work context on the target CPU.
> 
> This patch was originally prepared by Thomas Gleixner (see Link tag
> below) in a patch series that was never submitted as is, and only
> parts of that series have made it upstream so far.
> 
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/linux-pci/878qpg4o4t.ffs@tglx/
> Signed-off-by: Radu Rendec <rrendec@redhat.com>

I've been trying to bisect a suspend/resume regression on a Qualcomm
SC7280 laptop (using arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts),
and unfortunately, it bisects to this:

eaf290c404f7c39f23292e9ce83b8b5b51ab598a is the first bad commit
commit eaf290c404f7c39f23292e9ce83b8b5b51ab598a
Author: Radu Rendec <rrendec@redhat.com>
Date:   Fri Nov 28 16:20:55 2025 -0500

    PCI: dwc: Enable MSI affinity support

See the failure below [1]. Unfortunately, the logs don't give me an
immediate lead.

It fails similarly on v7.1-r1 and v7.1-rc4, so even though I know there
were a few bugfixes to the IRQ-redirect stuff already, I don't think
they help my case.

I'll see if I can learn anything more here on my own, but I figured I'd
report it in case you have any thoughts or leads I should investigate.

Regards,
Brian

[1]

[   58.229764] Enabling non-boot CPUs ...
[   58.234065] Detected VIPT I-cache on CPU1
[   58.234121] GICv3: CPU1: found redistributor 100 region 0:0x0000000017a80000
[   58.234171] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
[   58.235038] CPU1 is up
[   58.255764] Detected VIPT I-cache on CPU2
[   58.255801] GICv3: CPU2: found redistributor 200 region 0:0x0000000017aa0000
[   58.255837] CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
[   58.256394] CPU2 is up
[   58.277119] Detected VIPT I-cache on CPU3
[   58.277155] GICv3: CPU3: found redistributor 300 region 0:0x0000000017ac0000
[   58.277191] CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
[   58.277824] CPU3 is up
[   58.299086] Detected PIPT I-cache on CPU4
[   58.299104] GICv3: CPU4: found redistributor 400 region 0:0x0000000017ae0000
[   58.299124] CPU4: Booted secondary processor 0x0000000400 [0x411fd411]
[   58.299437] CPU4 is up
[   58.320186] Detected PIPT I-cache on CPU5
[   58.320205] GICv3: CPU5: found redistributor 500 region 0:0x0000000017b00000
[   58.320224] CPU5: Booted secondary processor 0x0000000500 [0x411fd411]
[   58.320513] CPU5 is up
[   58.341154] Detected PIPT I-cache on CPU6
[   58.341173] GICv3: CPU6: found redistributor 600 region 0:0x0000000017b20000
[   58.341193] CPU6: Booted secondary processor 0x0000000600 [0x411fd411]
[   58.341481] CPU6 is up
[   58.362167] Detected PIPT I-cache on CPU7
[   58.362186] GICv3: CPU7: found redistributor 700 region 0:0x0000000017b40000
[   58.362206] CPU7: Booted secondary processor 0x0000000700 [0x411fd411]
[   58.362532] CPU7 is up
[   58.384442] nvme 0001:01:00.0: Unable to change power state from unknown to D0, device inaccessible
[   59.243847] onboard-usb-dev 4-1: reset high-speed USB device number 2 using xhci-hcd
[   59.492243] onboard-usb-dev 5-1: reset SuperSpeed USB device number 2 using xhci-hcd
[   68.875606] nvme 0001:01:00.0: PM: **** DPM device timeout ****
[   68.881728] Call trace:
[   68.884266]  __switch_to+0x16c/0x188 (T)
[   68.888331]  __schedule+0x7c4/0x98c
[   68.891939]  schedule+0x38/0x60
[   68.895196]  schedule_timeout+0xf8/0x120
[   68.899254]  io_schedule_timeout+0x2c/0x4c
[   68.903481]  __wait_for_common+0xd4/0x168
[   68.907621]  wait_for_completion_io_timeout+0x28/0x34
[   68.912832]  blk_execute_rq+0x138/0x164
[   68.916792]  nvme_execute_rq+0x20/0x54
[   68.920665]  __nvme_submit_sync_cmd+0xe0/0x128
[   68.925258]  nvme_features.isra.0+0x88/0xd4
[   68.929580]  nvme_set_features+0x34/0x40
[   68.933638]  nvme_resume+0x68/0x88
[   68.937158]  pci_pm_resume+0x88/0xfc
[   68.940849]  dpm_run_callback+0x6c/0xec
[   68.944811]  device_resume+0x194/0x270
[   68.948683]  async_resume+0x28/0x3c
[   68.952289]  async_run_entry_fn+0x40/0x104
[   68.956515]  process_scheduled_works+0x210/0x320
[   68.961277]  worker_thread+0x14c/0x1ec
[   68.965147]  kthread+0x154/0x1b8
[   68.968486]  ret_from_fork+0x10/0x20
[   68.972192] Kernel panic - not syncing: nvme 0001:01:00.0: unrecoverable failure
