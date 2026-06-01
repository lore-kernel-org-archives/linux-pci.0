Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38056356742
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 19:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340531; cv=none; b=a4msBFGcptvoIRPS6ANAPj1cig/iN5cV/N/GUZNuk9IxAmmLqhT3QVd51DUl7s0uRD29tg8xXs//oMLuhpx3fcNm5SHIOstwq6/MmVBH9gtkU/ubH/5b46umQSOk3ocunrr7XnwzXeO2Iv+4nzs7hvGxuR1vAjQA1xrWY0Q0D7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340531; c=relaxed/simple;
	bh=KaHGhf4byy+LVR424XvxK1ysT7KJHJgWUd7ihlz9U/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvqEvU+LoANyGkGU7HffyswryCckBY5FBw9mxmURA2fl/+Hw4PaVBKOd26fq4PnRB0tes+kxLpdI5nKQiHErP3hz9OM13JJVwyx+0wrCiA57OqjnBnHRLGYUebLp3+vjy8ov5wqXax4AbLnAKSssVPzLoDeJcpoKBi7ehKhD1Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iCi5C1AC; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iCi5C1AC"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-304cf518c9dso6705935eec.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 12:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780340529; x=1780945329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/F6zSnrZsJYVN0xGf0C0erkpZXQIz/UeKORQq5fNkL4=;
        b=iCi5C1ACxb0DpTvRXQQ2jBAWWGHgnDSBHrKR8vPgspvq6avePpvSSdw2/HuQ5XxOdW
         rjcawDze8JjHRNuoH5QWDkb/bP1kOg1sQpSiwc/uNzTb2b0PjGFgiJve286ZMBKyBrm9
         A7v+a/lIo0KUaoR2+1lzOiSVoxlYQ81znpueQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780340529; x=1780945329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/F6zSnrZsJYVN0xGf0C0erkpZXQIz/UeKORQq5fNkL4=;
        b=d6AZNomoOJpK0sMndyPJyVFgo/gr9pU4PGnFvY1d/MYsfYJJegonAEVJjwy+F3ZWtP
         dTQf4xmIjMKKD4WcapWDFUKQ9qgVimQuizX9DI3ONMtKyLRsUGRG9yq8ChMb+dNfe2Om
         glPnRXVcBds6k0+TbXcD/UwrJ/A7vB1qMZJPMjdrL0TWb3zwHCZ5Wh3jrvwseRABSuqo
         1Oke9ak7P3flUD18eVKyuOGCRiRwo2DxF7dvmaatVlGg8mqTxcho5DnrT5D4hMaC88KV
         aCB/fkSn9LnCneWYaEHFMWg5j5nKjDapkVlD7Xs8yje2+bT4HpiwlR8E3p7QUiU8SFxm
         F4Hg==
X-Forwarded-Encrypted: i=1; AFNElJ+HC0uOXcx28Ea/YI6R5iSdH6i5NWvGTtvVc0itLxswZn4TBOSwrGnKIDEIr6JWN84uzMhUr4HoxOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCUSZwCyJbNfmQfepP9jK4k+BOIRZZnjujYsjd0puqmi255X45
	J1iUVpyKBCELqSDlmUIcMX/WJyJEEMe9hp1Ir6F0CzKdlO6JLAeXkhdDSO/u4pP2Fg==
X-Gm-Gg: Acq92OHtMAW/E41VDCqhtLi7o+/yAerp0A9Oewcave8GU9aJIiZ5kZyn+9q4d+tLifO
	zZ/W+/4uqF4o86W3uHC1IxouEGF9uQpYH07hng1sNWTnaWvFlgL31q77HPv9yJC07y0/mNzIc16
	zLzvbqIbdHfJ0ujs275Hf0y8kV6zfeEM51UEvuayCgCLgyUk7uxOIkLMAnfxWnL5NJ2AzrWm69M
	PIVghETa9PurKIcMkIa++AHUvud7FsiiVT7hOoAw/pUHunvZKJYE6ykBh9Bs4E/Xj5DkccYLIsA
	xfFH6bbntzJhFj6Xy4BaXiVDpW6eqWd8dE8BPATMl7uCJc4DGB+wfKS7QWUUSbq9cUCJJzFEipZ
	Uo8iGcEpGDEjv0T/oVLyoBpCQ2aWgqZIGmWyh146Bghpubh2Zff/7Is1v+SVqAU3FQJLlun1yUX
	UCG5+XsSEJM2Ks9F97D0Pt+A6rsKwOL/QpPn308U1fDSrUiNf79HwfuTnMLe0J8ttiwoQzBAMXS
	ugNiMgm6go=
X-Received: by 2002:a05:693c:3006:b0:304:d388:c33e with SMTP id 5a478bee46e88-304fa4a7fd1mr7288853eec.1.1780340528759;
        Mon, 01 Jun 2026 12:02:08 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:d53d:3040:2c80:7717])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-304ee0dd8e1sm12978919eec.21.2026.06.01.12.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 12:02:07 -0700 (PDT)
Date: Mon, 1 Jun 2026 12:02:05 -0700
From: Brian Norris <briannorris@chromium.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Radu Rendec <radu@rendec.net>, Thomas Gleixner <tglx@linutronix.de>,
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
	Jared Kangas <jkangas@redhat.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 3/3] PCI: dwc: Enable MSI affinity support
Message-ID: <ah3XLfI7E39B1UPh@google.com>
References: <20251128212055.1409093-1-rrendec@redhat.com>
 <20251128212055.1409093-4-rrendec@redhat.com>
 <ahC8Pyuatu_AvnZp@google.com>
 <ahDvvGew5UK3KSpi@google.com>
 <73f04f467e65b13fd455a3650dc2bd106af1e5a6.camel@rendec.net>
 <ahowweKTZXteLgZS@google.com>
 <ah1At6tb_V2jxIfS@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah1At6tb_V2jxIfS@ryzen>

(CC a few more)

Hi Niklas,

On Mon, Jun 01, 2026 at 10:20:07AM +0200, Niklas Cassel wrote:
> On Fri, May 29, 2026 at 05:35:13PM -0700, Brian Norris wrote:
> > 
> > This seems to tell me the irq_set_affinity()/migration process isn't
> > really what's killing things, but something else.
> 
> Hello Brian,
> 
> Perhaps a long-shot, but have you tried to apply:
> https://lore.kernel.org/linux-pci/20260519-l1ss-fix-v2-0-b2c3a4bdeb15@oss.qualcomm.com/

For the record, that's:

[PATCH v2 0/4] PCI: Introduce pci_suspend_retains_context() API

> to see if it helps your problem?

It also seemed like a long-shot, but I tried it and it does resolve my
problems. Maybe I can provide a Tested-by there.

> https://lore.kernel.org/linux-pci/r247uuc7ilkhn65vcbsaoxhgypif37lj3r3mvb7ooqqdg55vnm@vx3ip6klg6ha/
> also seems to mention a recent PSCI fix:
> https://lore.kernel.org/all/20251231162126.7728-1-manivannan.sadhasivam@oss.qualcomm.com/

That's:
[PATCH] firmware: psci: Set pm_set_resume/suspend_via_firmware() for SYSTEM_SUSPEND

> Which also sounds somewhat related.

Yes, that looks somewhat related. I tried it, and it seems to resolve my
issue as well.

It looks like Mani suggests both patch sets are valid proposals,
although solving slightly different variations depending on the Qualcomm
firmware in question? But the PSCI patch looks like it's stuck in
/dev/null. Dunno if a Tested-by would help there too?

I'm also perplexed at why:

1) those patches claim that NVMe wasn't really working on Qcom systems
   before, and yet the laptop in question was working fine before v7.0;
   and

2) this bisected to commit eaf290c404f7 ("PCI: dwc: Enable MSI affinity
   support").

Anyway, thanks for the pointers.

Brian
