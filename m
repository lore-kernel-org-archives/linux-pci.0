Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8E6442360;
	Mon, 17 Aug 2026 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982710; cv=none; b=bj3G5LQrYxIQMz4lNPTIwQTpYiLHSbspgvqKCLVbKWcNQzsiVzHkuiuoAtfJd6iV/wVUaC4SOJXUVJDor6dl5InOlA4/9FPdmm7aKFz9QFz75lG+pKuoNLYPgWL7vaVzh71w5LOxpx9GzWL22n5X7hU7dLjLDJ25YNUMoC2yQ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982710; c=relaxed/simple;
	bh=lqRMUR2+h4hnmaDRmAUQ6fQb9dua3yLyrfa1jXV0Jg4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=gsz6pqb8YfUTIaS2Gx96AhewV7JX7y5HSzeuuXZpLNxNiRbmHlZvNKZyDMzaoV9OnGbA1YGHrEGEjZ8VUdEpIQ6Gw+zaW90/y4MVCgw+J7eSqf7ATW1D9UWF+4QfcRIMhkBg15Id7zSapbWdA92q8OkcXVjTDlvQyqvopqgdSO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=cqy5Kz7T; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="cqy5Kz7T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=TKogs5DPegzHwfcOZ/AF2h0DiqhzL1S+/2g5eL61I1s=; b=cqy5Kz7Tl+T2LaGIlu4epysQYr
	zdcm41sU9S37L0Xfa062koMg06TfM2kxFFUICVfhLEInJ8MLsDd3urM6r6rRY+9Js+vaTm1VnSBZ0
	FdSiDUN5cKznTOMjp7R6ZiyYjk+dWvJR4h/u4o7dTa70Cnvr5VrT4/4FgRgk/SQ+t5eo5nOHZyY4V
	PodQjNRc+bOIOX8+XwJiRxRQVjD+R3eCWEjVPyBosAGL0DS+jxOX5jdTcGxW615VwjfJM5vwLmv5t
	gGU+Pd47Q8R6mSeSla01gfKwfiRjnMMRWjeoUB0uyQ/ypv3AsQ4y72+PNpTTb2fiNUwyvtLQ+g6X3
	FMBC2JHw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wvzpd-0000000025y-1BR9;
	Mon, 17 Aug 2026 10:05:01 -0600
Message-ID: <b6c85fd2-095a-4da8-a68f-c4f0faf6312e@deltatee.com>
Date: Mon, 17 Aug 2026 10:04:55 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Frank Li <Frank.li@oss.nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.li@nxp.com>, Kelvin Cao <kelvin.cao@microchip.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Dave Jiang <dave.jiang@intel.com>, George Ge <george.ge@microchip.com>,
 Jaeyoung Chung <jjy600901@snu.ac.kr>, Sashiko <sashiko-bot@kernel.org>
References: <20260728171523.112244-1-logang@deltatee.com>
 <20260728171523.112244-4-logang@deltatee.com>
 <an9wZJiOXGa4q_Bz@lizhi-Precision-Tower-5810>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <an9wZJiOXGa4q_Bz@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: Frank.li@oss.nxp.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.li@nxp.com, kelvin.cao@microchip.com, linux@weissschuh.net, dave.jiang@intel.com, george.ge@microchip.com, jjy600901@snu.ac.kr, sashiko-bot@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v4 03/12] dmaengine: switchtec-dma: always clear DMA base
 registers on chan_stop()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-14 13:45, Frank Li wrote:
> On Tue, Jul 28, 2026 at 11:15:14AM -0600, Logan Gunthorpe wrote:
>> switchtec_dma_chan_stop() returned early if halt_channel() timed out,
>> skipping the writes that clear sq_base/cq_base on the channel, and
>> gave its caller no way to tell the halt hadn't been confirmed.
>> switchtec_dma_free_chan_resources() unconditionally frees the
>> descriptor rings right after calling this function, so if the
>> hardware failed to halt, it could keep writing into memory that had
>> already been freed.
>>
>> Attempt the register clear regardless of whether the halt was successful
>> and have switchtec_dma_chan_stop() return the halt result so callers can
>> tell when it wasn't confirmed. switchtec_dma_free_chan_resources() now
>> skips freeing the descriptor rings (leaking them instead) in case the
>> hardware continues to write into that memory.
>>
>> But all this is hardening that is pretty unlikely to be hit in the real
>> world.
>>
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Link: https://lore.kernel.org/dmaengine/20260721162531.BA01A1F01560@smtp.kernel.org
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
> 
> This common problem when timeout happen. Before we have good method to
> handle it, I suggest leave it as it for now.
> 
> I don't want to introduce new problem by fix an unlikely happen problem.

I have to push back at this. I *really* think this patch, and the next
one, are worth applying.

While I definitely agree that this is an unlikely problem to hit in the
real world, I think it is the correct and best approach to fix the
problem. I don't think there is some good common method that the
dmaengine layer can implement to improve the situation, and if there is
it can always be applied on top of this change.

The problem it is trying to fix is a hypothetical hardware failure where
the hardware was given a job to do and never returned a completion. In
this scenario the hardware could theoretically wake up and write to that
memory at any time after the driver is completely removed. And the only
conceivable solution (absent an IOMMU) to preventing that memory from
being reused and then scribbled on by the buggy hardware, is to leak it.

But we don't know if the firmware in our hardware has bugs that could
ever trigger the problem so it is a bit of a moot point. However, for me
personally, I'd rather apply the fix in order to silence Sashiko. I'm
fairly confident it is correct and isn't going to cause another issue.
I'd much rather have this fix, as it is, than to have Sashiko
complaining about it every time I send a patch set.

Thanks,

Logan
