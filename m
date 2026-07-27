Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE48D429CE8;
	Mon, 27 Jul 2026 21:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187715; cv=none; b=fGdQ+WmBNrB846oowRqEw02nOZ6VBQ/YVkJsHaG3eAq4Gip+eTi3QVFLQeyFrItndStTU5ah06KjB7CJeCv+rZRVWQk9HYDFQdymYASLCShKxtmMk2zuBnIUMwqyOKQjNhCQwC1kvbHvOlnledEoz1IqNK9WgJe4Bo9WpyzMMk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187715; c=relaxed/simple;
	bh=ALS7vBn18SgtIKVfwkA4e5c3d8MN8XZhRBQ1VttH5b4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=TPKFFaBjRZBK3uPRClc1+QEpf65w8tgzlkqI6J9XqEtgx8wIUhik6YjDvl8FVxcCYk53eXGE/XYNrDmqYX0Ut+VilcRMvUx3KxwivCn8vYHEDRjxMdlZN2Q2utgFCFL5L3d9G57XxRpv2GpC4bqJihtKstX2EmMzZ3NFFfAU6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=scf1WQ75; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="scf1WQ75"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=+opPWdgRV1BTzzbL0B1+NApg/PpxSyqVyqLAI3aZ+rQ=; b=scf1WQ75XwqpiqH1lcRPvXcErI
	AluBNJdQDWUJ67/DabYparV9DhszI2RNlym3XNsSUdGd671mj+RH8TCztrPsl4LZHzqygsjsAJ+x8
	Mwk4P49pa1gaxAsRHPNzG+08t6WXx9VZB1Lwf0lVFkcwpV5fArEoPIherb1ti5Lx/M3gcRuW45lRT
	50I69q/apldN1U+UxzEXLA5wTA2986ivAyiYMlFGLW6UrWMnTFsjKM9SGGSbQ7toloj/fVyLuGJcJ
	QKYKFDRL0odTAQZx1bY/zE6vKagd8o8P6xB0wUzodxh7j42v+TOCqBTG54p+T+NrSQhyB2sQvpCkz
	rFMni09Q==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1woSsC-000000007Dq-2UMN;
	Mon, 27 Jul 2026 15:28:33 -0600
Message-ID: <03ebef77-d53d-491d-ad32-b9a766fa9fc2@deltatee.com>
Date: Mon, 27 Jul 2026 15:28:31 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Frank Li <Frank.li@oss.nxp.com>, sashiko-reviews@lists.linux.dev
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org,
 dmaengine@vger.kernel.org
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-4-logang@deltatee.com>
 <20260727185101.D221C1F000E9@smtp.kernel.org>
 <amfD6-xlqll-Md2Z@lizhi-Precision-Tower-5810>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <amfD6-xlqll-Md2Z@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: Frank.li@oss.nxp.com, sashiko-reviews@lists.linux.dev, vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v3 03/11] dmaengine: switchtec-dma: halt channel on
 alloc_chan_resources error
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-07-27 14:47, Frank Li wrote:
> On Mon, Jul 27, 2026 at 06:51:00PM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
>>
>> New issues:
>> - [High] Incomplete fix / DMA Use-After-Free due to early return in switchtec_dma_chan_stop() on halt timeout.
>>
> 
> Is it true?

Yes, unfortunately. I'm working on v4 now that fixes this and maybe the
issue Sashiko pointed out in patch 4 as well, but I haven't dug into
that one yet.

Logan
