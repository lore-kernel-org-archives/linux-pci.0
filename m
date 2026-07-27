Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0523C1963;
	Mon, 27 Jul 2026 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785178582; cv=none; b=K6FTIi8Zz8WotPPECrOFH4rgrUixYmKSa2uP53UntEi4vDJzuCIHdt9adijDcGT5wcmA/M0Yr2NVLa4wFR+sa6sHcLXmS/N3tNb4rSXPoExyXYN3L/T3tDwlzETopMlLDzHUWB/0hdTzX+YvevYlOFyX2wqT9FMFNQJ8uBsYDpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785178582; c=relaxed/simple;
	bh=g5fh4aUNF8NZFG/1m/8vUQz3INTiPVGb0eImIbuuT80=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=g0l0krcDEka96oqu5nuXmvbtemWJX67N+iEs6iCVPra24OpjLnBFSxI1d0LpOc1+F9HBhkm2ctp6Rt36TP0zFZ8t4c4/sCu23UsnGQhrgRyUHqVRYTNlk6krXeD7EJkMrInKoDzzCTGe9Lhn87fF2aMKBaQzlTohbyBBL9GrOPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=q0NnfN+a; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="q0NnfN+a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=0xk3yxtgIQmJU9TYiKFwuD4xcCKLBEe81eLskSvd0ns=; b=q0NnfN+a8yKrWcGR8IoFB3lmkC
	lcqOmT/6LRMlhsArGHAlfU2uX3c0EWx4XmxsmA+5DhSnMBvwJGM8z/aqFQhDviBGFUGsc2k31dCar
	sMrNwFS7R+XJdQjwQKIsQt/m4jI8pd35J9eAaFuiL9XnarBWSNchs2V6dH3USAXp15e4do9aqF7ks
	uJmwp8aOoWmFbbLIPrmHd1Pguj07oIlgbiWSeb6nIQUkR3LC5Bpi6fzwcR/N2ypfRpOdIPGtPvt5w
	xCOIJXB9AY+irPVFTSnBrtg4Bu2ORI9WA7QQEcK6zFUu88HeNqccbrm9/bwN+dZGpCB5P9kU+eIcu
	Hu3R7ihw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1woQUs-000000005Ib-2lzX;
	Mon, 27 Jul 2026 12:56:19 -0600
Message-ID: <a2de6abc-b9b2-4daa-ba8e-525646dff5bb@deltatee.com>
Date: Mon, 27 Jul 2026 12:56:18 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org,
 Frank.Li@kernel.org
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-3-logang@deltatee.com>
 <20260727184023.B9B021F000E9@smtp.kernel.org>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260727184023.B9B021F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v3 02/11] dmaengine: switchtec-dma: fix resource leak in
 alloc_chan_resources
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-07-27 12:40, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] DMA use-after-free due to missing channel halt in the allocation error path.

Note: this issue I believe is fixed in patch 3 of this series.

Logan
