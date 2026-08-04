Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B66413D62;
	Tue,  4 Aug 2026 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873012; cv=none; b=Tf7jrq/Dl1riPFlePB6hHBrhV4PGVkUaGgNcW2Jszm2+vcMxyT21VN6gMq6ws+WteMADJerEdKQoTsLa5CZPkZG7aNuFBce+hUugKIX58SIJYyoZyF6kQUDNzgaY6UQfsAcJU0usHVp6PcXE1QsWZZWfIbLoj7uhkbhcbS7oEf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873012; c=relaxed/simple;
	bh=OdmraEgayirjuQK9DWPhhWq8j1tl0vCxi/Q1BBjcw64=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=p1uPxzBhkR3gsVXIeRUFS+dOuRUhMsMg0pCv4MAaICRm7xE1sW2OX21yz+7Br50PDxfCUmoc+jpkoTCuEnR340lME/eo9THF5/xuX2TZGwN8XcRecHVWSP/IztaP3yTEY9neBNkgNTFn56n0kRlbODqbmwHUE0E9F10I8Am4Dhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=VqAy9ctR; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="VqAy9ctR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=Z1wJRVHiSjrvdNZOMPAr/ED/XQobuU+iisI6uTija7A=; b=VqAy9ctRCeGkRe1uub/4LrjHU7
	rhOdackadSHgPKpXspl2NsdYJyTX+O7PH9M/iJeYLYf2g0FuMgXeOiNUYf2/RaokG74DTfvXJtgbQ
	RFckOVfZO6JOL9IS54YcZQ1DnehZ5oWAH/Z11ROExN+4ALIsaV7Hp+pkqCyr6dW/7fLpUk7fgGh7o
	zuNLJKk/3ju5ltU6ZhmNpAD8IDDfDfwm39olb4p/1A+aWp3bIBtqsKxl7ovKLd/q+vbUKXB85VC8D
	+CrFw8HmBcpMirMJz6oQcpvNpo/hEK8pPrHfv6YDjaOE/tL7vNBlQsfko+jPNiQtCKYw0QfCCxPdW
	ioyE95zw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wrL9M-000000000e6-3b0E;
	Tue, 04 Aug 2026 13:50:09 -0600
Message-ID: <239835d4-0854-43a2-aa57-6c70dfedb121@deltatee.com>
Date: Tue, 4 Aug 2026 13:49:59 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-1-a7c5eb64fff6@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260802-fix-p2p-acs-v1-1-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, corbet@lwn.net, skhan@linuxfoundation.org, alex@shazbot.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 01/13] PCI/P2PDMA: Safely terminate ACS redirect lists
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-02 09:09, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> seq_buf marks an overflow by setting len to size + 1. The ACS diagnostic
> path unconditionally writes a terminator to buffer[len - 1], so a path
> with enough ACS ports to fill the 128-byte buffer writes one byte beyond
> the buffer when verbose diagnostics are requested.
> 
> Use seq_buf_str() to terminate truncated output safely and remove the final
> semicolon only when the buffer did not overflow.
> 
> Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Looks good to me, thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

