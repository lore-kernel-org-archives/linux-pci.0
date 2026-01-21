Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4492ECD34;
	Wed, 21 Jan 2026 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010456; cv=none; b=sChpCvEsFBMuMzGeUgOkSpYeNJgKkO0RiDEkRG65mQtRt959C+8lFQITZC2pJaQn2NDaWfpKvW3qXdIoj7Xq3UzUWH9kwA8PnCMRtm6DI+Xx8S3OH40ttQgcHn4FBhyMRp/rX1O4s/0MB0uBBZI7d8QM3wWXLxJQxfAqRJlPnC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010456; c=relaxed/simple;
	bh=QAA059cS60BOW+/VnYbVjCEeIruVELX9mOmmE1IivCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOD0+c18Uipz+to1oduamAqWG9Hgg5j74FXyw3/0IVTYQAb3P9A86qeEy3gOPIW8tqJ5q0YRlNzCWUAMWvPzxTRnqXGvxiQM2AzIIbX5DqpHgxdreYRvIgyNeSeZDdroYr9I1VuPvlranB4vZcVa79Z+j2p9roNvXUvCTXYAtpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqTQk0/s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqTQk0/s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77347C4CEF1;
	Wed, 21 Jan 2026 15:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769010456;
	bh=QAA059cS60BOW+/VnYbVjCEeIruVELX9mOmmE1IivCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OqTQk0/spApyZnRjEWDgyXhYEpyyrCH26PnxT/yFXElQxTMmNQ89xOAIQ0bLvlklM
	 phH1pqGfqGdvvkVsN9iQoI2VTUFanyYZ0ojfvsRNfC0VD/8YPmaMsJWZINuyeZ62WF
	 75KifUMaUnrfIaV7OwfuWxuFXiZGhfOZiwIQhdjOILsBM4kt4xDTaTlHOPi4J5nxMr
	 XQT5Sq6o6m0cbTb89GJ0QbL+HCnWdwhzD4Vy8DyE7pAS4G5UZ3DJm9TtGOwQQB+bMl
	 pa3wn1cPbLbfG9aqsYLTT/+5AfrmMxkVqKtL/yKMVJlRs6OYhf5+k8YvcMuzVVen56
	 UBmFaJvxSni5g==
Date: Wed, 21 Jan 2026 21:17:21 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, dlemoal@kernel.org, 
	manivannan.sadhasivam@oss.qualcomm.com
Subject: Re: [PATCH v3 0/4] PCI: dwc: Rework the error handling of
 dw_pcie_wait_for_link() API
Message-ID: <kxppi2denhw3eriam2ryevjdebsjryeggzxbvtftr3ygd4jdzu@ah73wocpvmwj>
References: <20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com>
 <aVezfq-8bTKczYkp@ryzen>
 <b7d7ae6b-d0e7-47f2-ac84-8b0fdb395a59@rock-chips.com>
 <aXDTCQeP3CDv5qv8@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXDTCQeP3CDv5qv8@ryzen>

On Wed, Jan 21, 2026 at 02:22:17PM +0100, Niklas Cassel wrote:
> Hello Shawn,
> 
> On Wed, Jan 21, 2026 at 08:45:39PM +0800, Shawn Lin wrote:
> > 在 2026/01/02 星期五 20:01, Niklas Cassel 写道:
> > 
> > Hi Niklas,
> > 
> > Sorry for chiming in on this so late. There is a register called
> > PCIE_CLIENT_GENERAL_DEBUG_CON you may find on RK3588 TRM, you could
> > hold LTSSM on EP side in DETECT_QUIET before enabling trainning, by
> > setting BIT(6). And when EP side is ready to go, just clear BIT(6),
> > so the link is able to be established and host side can rescan to
> > find the EP properly.
> 
> Thank you for the suggestion.
> 
> Reading the register description of this debug control register.
> For as log as sd_hold_ltssm is set, the controller stays in the
> current LTSSM.
> 
> We could probably set this on the EP side, and only when starting
> the link do we clear this bit.
> 

I did consider this option before, but the problem with sd_hold_ltssm is that we
cannot predict the LTSSM state when the hold happens i.e., it will only hold
onto the current LTSSM state at the point of set, which might not be DETECT all
the time.

> However, I think that Mani's current proposal:
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc&id=01d16b8afb7afcc17f999f8b4a9b9cfe6c6fae71
> 
> 
> Will work with more controllers running in EP mode, not just rk3588.
> 
> Also, when powering on both boards at the same time, it is possible that
> the host side driver gets probed before the EP side.
> If the EP side driver has not been probed to set bit sd_hold_ltssm,
> the host will still see a load connected, but link training will fail,
> so it will still jump to Poll.Compliance.
> 

Exactly. By the time the hold happens, LTSSM could've moved to POLL states.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
