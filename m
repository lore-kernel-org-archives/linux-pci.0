Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372452E54B6;
	Thu,  2 Jul 2026 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027916; cv=none; b=R6TAeiq/MOlvhBv0MZJDSu2i74v1f9i/Xh1cNg8QxbXXfIFAbPTc50mwg2GtHPrOZcfTR1vzQVkBROxA6aRQ7DlWBUMjY+uRku2dTJDlMqk3ULHyNkowUxLvBV0ngFd8kDRE/8r7KweiLpuBPR2FgM2kXvOPY/hQbd7oO/sJ3Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027916; c=relaxed/simple;
	bh=HZhUV4EM8bWQkAKf3IuhmmwkAq/B5kh4zS9DhKoA/vA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dS2MPa+Exyjod2aWrkxzAozlSHv2cTIMyWPUObEOdnH+A9R3hFIsWNpBm404SrUF5WNe72QllZXCreEgnDd7EYILQfWLwA7uNN0GAkgbFpHTydZGG9jNwY/h6t8U3gQY/8nLxT+tOWCW7YGUsQORJsfpgE3WDKrtRkv9L3TA4sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpmzKru2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpmzKru2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC411F00A3A;
	Thu,  2 Jul 2026 21:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783027915;
	bh=FFbMX19yCdv1YwUWUuil3P0baYF2HqJEZ0RZlmyXBZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BpmzKru2rP/kYuiRTzDkcie09BeRaQQUI69mlVEgu0ArOhxx59bE5myemSSxqbvpJ
	 wKhA4tqcaMFbh3ZZWDovJd/tgtJClE/mP1Z8RA76yeqoYsno3VdfdYGvfMWgKLFpnZ
	 i5w8ZDP/aJ3BUKZSGILZBRqks6XZ/Vzrv2KYAz3ANCieLiGtTLpCiwdrOTSkZLHlmD
	 iYY2phlTT86bogziZ4en3S5+j7UDHVheiUdrgTCD9TDOBaL2hYnPrRn4+vvuRobVH5
	 0fiFSGVDk/2pumFLJcTo2thN0cmqb+9/eCydM9GoQcx6y0dzSXdxv0oyeRFhsUzo5V
	 u3Dw0YSlEleaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/10] dmaengine: dw-edma: Move ll_region from struct
 dw_edma_chunk to struct dw_edma_chan
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, vkoul@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260702-edma_ll-v3-3-877aa463740c@nxp.com>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
 <20260702-edma_ll-v3-3-877aa463740c@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 21:31:54 +0000
Message-Id: <20260702213154.BDC411F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing lock acquisition in dw_edma_device_resume() when accessing=
 vchan descriptors.
--

commit 80df5f151f3cb77451f6a2e4ec10cbaad5b50565
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Move ll_region from struct dw_edma_chunk to struct dw_e=
dma_chan

This commit moves the ll_region field from struct dw_edma_chunk to struct
dw_edma_chan to avoid redundant copies. Since the ll_region is identical
for all chunks belonging to the same DMA channel, it can be shared.

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index 53469c8c8b82e..2652ad8e7a8f6 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c

[ ... ]

> static int dw_edma_device_resume(struct dma_chan *dchan)
> {
>         ...
>         dw_edma_start_transfer(chan);
>         ...
> }

[Severity: High]
This is a pre-existing issue, but can this sequence cause a data race on
the descriptor lists?

Looking at dw_edma_device_resume(), dw_edma_start_transfer() is called
without holding the chan->vc.lock. This invokes vchan_next_desc(), which
reads from the desc_issued list.

If another CPU concurrently calls dw_edma_device_issue_pending(), it uses
vchan_issue_pending() which runs list_splice_tail_init() on desc_issued
while holding the lock.

Could this concurrent access corrupt the list pointers when a client driver
dynamically pauses and resumes channels?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-edma_ll-v3=
-0-877aa463740c@nxp.com?part=3D3
