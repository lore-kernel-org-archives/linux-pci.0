Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070EE2FFFB8
	for <linux-pci@vger.kernel.org>; Sun,  3 May 2026 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777840212; cv=none; b=cAjWHyrJcN96JLXbP3Q+OLfpw5f6SRyPQTy2Eb/dRLIDSPyokK0C1UYB5p+1u7E/8iku2pNmZt2o4oSUVGNGcMD5E1+s3w29dysa6KXcSaA0iZqevbHUFyTndHgFRVd0A8+6tXN53JK9eUKXRscMgN3BEhHbGpzhnBYa+B+mxHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777840212; c=relaxed/simple;
	bh=bcezSkZUVFmq8awrbtFKLKUmQEyY8sZzF9XzM732STE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Benb3iUqZjOrGDK7YoowuX+9h+0vAwjx4TmnP/336K2XKy9OOtvBLu3hJty1G8Fsum8dhX/ZmDB2z48vRtLUbn9bM/CPFaRI1HRj9RqDAA7iszWhw6kr6ObB3tMQP3bwBPp08MN9dckXWt5cDC4qozRq8whi/VCcgZxOfwOlOAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUHmQrQ8; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUHmQrQ8"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7b41fdf9de2so25153857b3.0
        for <linux-pci@vger.kernel.org>; Sun, 03 May 2026 13:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777840210; x=1778445010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utFZGAmkY5HSapsYpTO/OWvfTIFdh3s3Nz41thxW7Qs=;
        b=GUHmQrQ8hKWDTJOwRtc08rGvp+UVgi9NH61NCQCxliZna/4NcN2ejglHqVXhHK/9Ue
         jc4HuXxuBU+qWr5YEHdT2rv3RLh882BuKFXp51MIakVF/BCMB9fLMaW8n9QRmK+GFrRk
         RnR9uKyIr5vtMsqlfSjAgZa53AHrGvgznnYGBlGb4j3kiY8+qg32h/ejVc14Nj+QS/bJ
         QVqTN7RtFvUs3KrVhspsrM7Vgk8tT9Y0Jtnac26gHjs0WJdTGfDr50cw8Go1jHi54iaC
         1SNVGNt0eMe8VKNtC1Mz3nCjQumjmedxjX7S+2qYdIqCsmohQgZPiAGAETxYdy4iVcLn
         SF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777840210; x=1778445010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=utFZGAmkY5HSapsYpTO/OWvfTIFdh3s3Nz41thxW7Qs=;
        b=oPHLcff9TB7lcfqWudj7afdp/eMXG2FZaYDlCJeZJmEnnTMwwdahdvi2mWmcociFCA
         ssQv6a9V2tUu/KYp8HaAvkJJ2wwp8IPYHzYjuwLx054jXhD75+Cq8GG+IFuS5P4JzvHF
         nlsnN1DYn7wDJbpHjyRa1SQ3W0IfulTKMr+gOitugwW/vIafVaXzDemhqAVIrv2GL6HP
         G7WYO9UPplLGXnvQ3t8q8d6MLjRaAajODLu/KMQqX+YhR3ltnATQZQ0WWyw7qp8jTvzC
         wecj424Hh+9kVlRCbv+Jy63YzsrzXXxDAT898HJA/zh8yh9NWYYTFUGIW82D+oXShrmd
         ZWlA==
X-Forwarded-Encrypted: i=1; AFNElJ/11neJhDU+/pCyS1Aq+HJKRy6HjGxw2TTsKqrQ1D12iSg0fhnhnp/krOhbDwB53tfqtH9PnxdQ6ec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1walcbBPlnnc3jv5HN8soV5K1dMamFbPcVZjyi7WdgWvopzV8
	nTCv53ZYOQWFsptmnISGa2Ti+d32j/+7q18mJCFGj9YmxtTVGuxsKr9m
X-Gm-Gg: AeBDieuyaMU7mdL+hws3zJP87jwOEGXzQGdOu5L2QoK7+azm8Pm/p0fszrKEQDaZuOf
	O667JngWtP9pPTx9AuEQ7dMF2KIxZCAcBd+eZpmtFu4RWJUTNqqlTag09SuzCgDSbAsnqsPDX5f
	ZZywUqBOvA8NQRvR+7V5kKgZVSQufaoKng0lzuT8mGhrU0Dr/9wZoHp/S30Fxwd1AMlBHmXwhas
	3t6d3bC4I64XuK12/DVCSJ3XhilZC70ulWE+9jiUTXL6cPjjhwn8jwjpUFQSwDLvVeJl0wYrj2F
	X6qGr6w/b58kqB2kFPWIE2RaSTnjK5a+3qZDzkyGAskhl2CCZWVNeClqo1J2zwDi4EL/v4+YAnD
	V9Cee+MS6rWPm+KnP+U8lp/7VgsfYlEa4UYJNG1wJkmUY70aLQt2GFZ55iO/KcrOvfPJhobbpnS
	HmHm7UcGpy7FKD8CyVe2p/DraQkyifGwkQVl6oAhJ3aqlHBXSsMaHQI43Y8BaHts6kWNsyFZGRi
	gRln4nCNg==
X-Received: by 2002:a05:690c:c4f6:b0:79a:40fb:9346 with SMTP id 00721157ae682-7bd76fabc9emr76374857b3.20.1777840209910;
        Sun, 03 May 2026 13:30:09 -0700 (PDT)
Received: from localhost (104-48-214-220.lightspeed.snantx.sbcglobal.net. [104.48.214.220])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66525651sm40140327b3.3.2026.05.03.13.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 13:30:09 -0700 (PDT)
From: Steev Klimaszewski <threeway@gmail.com>
To: krishna.chundru@oss.qualcomm.com
Cc: bhelgaas@google.com,
	bjorn.andersson@oss.qualcomm.com,
	jingoohan1@gmail.com,
	jonathanh@nvidia.com,
	kwilczynski@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	will@kernel.org
Subject: Re: PCI: qcom: Add D3cold support
Date: Sun,  3 May 2026 15:30:06 -0500
Message-ID: <20260503203008.287559-1-threeway@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429-d3cold-v5-0-89e9735b9df6@oss.qualcomm.com>
References: <20260429-d3cold-v5-0-89e9735b9df6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Krishna,

> This series adds support for putting Qualcomm PCIe host bridges into D3cold
> when downstream conditions allow it, and introduces a small common helper
> to determine D3cold eligibility based on endpoint state.

> On Qualcomm platforms, PCIe host controllers are currently kept powered
> even when there are no active endpoints (i.e. all endpoints are already in
> PCI_D3hot). This prevents the SoC from entering deeper low‑power states
> such as CXPC.

> While PCIe D3cold support exists in the PCI core, host controller drivers
> lack a common mechanism to determine whether it is safe to power off the
> host bridge without breaking active devices or wakeup functionality.
> As a result, controllers either avoid entering D3cold or depend on rough,
> driver‑specific workarounds.

> This series addresses that gap.

> 1. Introduces pci_host_common_can_enter_d3cold(), a helper that determines
>    whether a host bridge may enter D3cold based on downstream PCIe endpoint
>    state. The helper permits D3cold only when all *active* endpoints are
>    already in PCI_D3hot, and any wakeup‑enabled endpoint supports PME
>    from D3cold.

> 2. Updates the Designware PCIe host driver to use this helper in the
>    suspend_noirq() path, replacing the existing heuristic that blocked
>    D3cold whenever L1 ASPM was enabled.

> 3. Enables D3cold support for Qualcomm PCIe controllers by wiring them into
>    the DesignWare common suspend/resume flow and explicitly powering down
>    controller resources when all endpoints are in D3hot.

> The immediate outcome of this series is that Qualcomm PCIe host bridges can
> enter D3cold when all endpoints are in D3hot.

> This is a necessary but not sufficient step toward unblocking CXPC. With
> this series applied, CXPC can be achieved on systems with no attached NVMe
> devices. Support for NVMe‑attached systems requires additional changes
> in NVMe driver, which are being worked on separately.

> Tested on:
>   - Qualcomm Lemans EVK, Monaco & sc7280 platforms.

> Validation steps:
>   - Boot without NVMe attach:
>       * PCIe host enters D3cold during suspend
>       * SoC is able to reach CXPC provided other drivers also remove
> 	their votes as part of suspend.

I have been testing this patchset with Mani's patchset that is supposed to be
related to NVMe on the Thinkpad X13s found at:

https://lore.kernel.org/all/20260414-l1ss-fix-v1-0-adbb4555b5ab@oss.qualcomm.com/

v4 of this patchset *boots* along with Mani's patchset, however, v5 does not,
and unfortunately, the machine does not seem to get to a point where I can even
get logs from it.  Do you know what I might be missing?  I have *not* attempted
to remove the nvme drive and boot off USB to test it.

-- steev
