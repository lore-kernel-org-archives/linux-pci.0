Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA68E3BBFDA;
	Mon, 31 Aug 2026 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788216200; cv=none; b=RaiK2AAw/8dbN6+zFq7G13wWiCwroTN6taoYfYWk1fa0/9RSnnXgqrMQMSTJEFFwrSMwfD/hVgIPE/xxQxjyRpl8v8uceYVPVJE2EXq2duaTPnJM5gQanM4/7cWGYwAbZv2wigUBL4n/FjnPc60Mk7VWS6iNGy4c1VUXwpFK1Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788216200; c=relaxed/simple;
	bh=C86cLwqiVQjgoUmy6okisb8H6iBfeqc014Ec4WxbZhc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=YF1Nt/XEJKB+cx20CFz/fz9EnKRCHIn3TnrZB1YF8C38CHEypvFavjza6EBMJjTX5mK9/b0nuI8/1TTPJY1pAOXJhm81vkvae2iY80QVDvLxhIzmXv36mBVlI8XkCQqKTISnyTKxzqNebGmpuOoyW05gBG13CDOBmaDot4geRCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=trc7TcJ5; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="trc7TcJ5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=JgABZjKONoUgmU+jz86iozL3tdgr8GNXvtkYvMs144k=; b=trc7TcJ5em4eCn4LpAsA+5zfUE
	XW0Rce9463xoN5+Z9eiHAur7vUwu0YvGLm3SPuBh61ysIZ3j9YI5buVuMYN001UP/J2rup/hasf1x
	/fs8pDBf7x9WVPoleRLq3Yf1xffUbmVr3xlYcBzTu9wUEcM6yntEv/OGE8PLQlurW03vd14LIfoh8
	iZF99A0eSbWFrYR68XIf4ErPwnz4wyoKeBnLzcBZdA8mRhT81xrCU5fdokLUjmJuWJ0ZYuWl4C8Sy
	qiKP/zGJHUf7UyEVS1XHtkHAClYufc7YCkXiyPEEjt9vUOHhGS80npVqWIhslEyRf9DDI2sNYgdJx
	nusVhRBA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1x1Aik-0000000095W-1bI9;
	Mon, 31 Aug 2026 16:43:19 -0600
Message-ID: <53a3a210-518b-46eb-b73f-bc9ddc51a108@deltatee.com>
Date: Mon, 31 Aug 2026 16:43:17 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: sashiko-reviews@lists.linux.dev
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org,
 dmaengine@vger.kernel.org
References: <20260831191403.207631-1-logang@deltatee.com>
 <20260831191403.207631-4-logang@deltatee.com>
 <20260831215146.4EC931F000E9@smtp.kernel.org>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260831215146.4EC931F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sashiko-reviews@lists.linux.dev, vkoul@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v5 03/12] dmaengine: switchtec-dma: always clear DMA base
 registers on chan_stop()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-31 15:51, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] Clearing DMA base registers to 0 redirects runaway DMA to physical address 0, causing critical memory corruption.
> - [High] Unconditional memory leak of DMA descriptor rings during device hot-unplug because -ENODEV is treated as a halt timeout.
> - [High] Dangling pointers allow intentionally leaked DMA memory to be accidentally freed on subsequent channel allocation failure, risking hardware memory corruption.

Ugg, ok yes. Seems patches 3 and 4 still have issues that I thought were
resolved. I'll drop them for now and resend a v6 without them tomorrow.

Sorry, for the noise. I was wrong about this one.

Logan
