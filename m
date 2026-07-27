Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8737A36AB56;
	Mon, 27 Jul 2026 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785176059; cv=none; b=eNH4IN4EOHaUiV4ohIp+51h1DmKueEu/CpY4bEE5RCl/1+gYlgM0eRBERkjbf8c1kiPQuNv98DA1QipEV5Z8AU91EDlpcZoMDC1RkjNMWRlxBXpHxChbah7gNKldvmNloQpJKv2dMfb4BEIvnP6HxsPnA2q4af/KBodUM30c/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785176059; c=relaxed/simple;
	bh=9edNS/7qUD2J+IniBo6f0ujdhSEjmFyk7NrJtxHzrNA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=lEt1AIvQe6cvBYo8ySbfr5UrsTkuZ/ihCpb4WI/1PeFIESSSBuFju8/0vcbW8brFArfPT2sJxM/sGyk5vsDih6gDGj5qv0QFBUd4dADZvzlG2gOuEc3KC4II6R/3Fv7Nyxl7CYve8eL5ux5IjgfapBO/yZBvPFNalrogxIc5usU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=mdaIDuDt; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="mdaIDuDt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=q6M9yKe/80CKt/X+fdYO4Vj4qAGQqpYvr/E/usUA430=; b=mdaIDuDtU8pp4Gx+ikpbLFET09
	SfmKeB+6gecj574XRzSsfaAZ0wtmwK3HnG5MTLJv5s8ji1LJ/+EOnBXslXQKkfJ0m9XKVXzVTkiZg
	BYwCv1rKpHmjYTQgssJiPKKCbBr+OXqY5XFKfSxLGOLmZvw9VwPp1RgY6ig7+KbaaOfoZE0u2nTkC
	+42usbdy+ZzGhlUkcwgh/6z3X2NFsqggHNLEQqZvHnoyxth9BkM+x7Uiirw3Gr0lgYKvhVImBSZoP
	suoI7tTNSgWJUjnMZCVfyEtnQ+8P2g0SAw1cc5qOX7Gb+XB+8Q2mrSRbpS0bUv2DQEnQI1Y5b8ihP
	o68hvZ2g==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1woPqD-000000004wB-0hYv;
	Mon, 27 Jul 2026 12:14:18 -0600
Message-ID: <425761bb-44cb-424a-8e16-3ebd43fd364b@deltatee.com>
Date: Mon, 27 Jul 2026 12:14:16 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Kelvin Cao <kelvin.cao@microchip.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Dave Jiang <dave.jiang@intel.com>, George Ge <george.ge@microchip.com>,
 Jaeyoung Chung <jjy600901@snu.ac.kr>
References: <20260727174837.6645-1-logang@deltatee.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260727174837.6645-1-logang@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.li@nxp.com, kelvin.cao@microchip.com, linux@weissschuh.net, dave.jiang@intel.com, george.ge@microchip.com, jjy600901@snu.ac.kr
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v1 0/6] dmaengine: miscellaneous fixes for ioat,
 switchtec_dma and plx_dma
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-07-27 11:48, Logan Gunthorpe wrote:
> When reviewing the recent switchtec patchset, the Sashiko bot noticed
> a handful of pre-existing problems in the ioat and switchtec drivers.
> Additionally, I've included:
> 
>  * A fix for a plx-dma issue that was reported on the list[1] a few
>    weeks ago.
>  * A potential issue I noticed while reviewing the code where pointers
>    need to be set to NULL.
> 
> These fixes are all valid and independent of the work I was doing so
> I've sent them as their own submission. I'm still working on the rest
> of the feedback Sashiko gave me on that submission.
> 
> Thanks,
> 
> Logan

Shoot, very sorry. I sent the wrong series. Ignore this thread and I'll
resend the correct one.

Logan
