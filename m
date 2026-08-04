Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E1D424D42;
	Tue,  4 Aug 2026 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873146; cv=none; b=ZrQsEfGXQNjYjZEjFQ5HVVggsOeTllYl5WYeixLR0G2NmqsxvhUOdH6ZV5mTKY5Hx0oVvTyuUiY0TD3v25Psx2ftn8dZJHVaM8foM3V4+mOkGMKsDaaILG7O+ksCb5kC+CySpKE38J+6HW+P1Y/8Y7PeafzERRcKSpMdz4KSRv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873146; c=relaxed/simple;
	bh=7OGB1EI11qWQ3Yg0ZG+Akx+MucSEes4qwa1Lae7ta70=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=g5a92rLS+2FJv43w2quBw6R3Yq05E9wo1WWxZxkIVcOBfPADT+22ri5L6WsS6MjhbPg0sejjyI4fOQGmFc/DkLa+Y0ZrRI8magjgV6zAOl13gxKGMeYhwQSPXtc3bEYzpq+yA5RIM4FPWEbNblzykVFw22C3JNGunXf8vElX+mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=bmk1Rn4p; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="bmk1Rn4p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=N1C9RRyOtzx5HDheWD12qd4gUGvsBh4sdLPtUOddlFg=; b=bmk1Rn4pGpqpvKkjT/jrK2RdEj
	okQJzHxZrYtKrXzo1iEgEqz6GpuDEbrHnkUZds7JA0HldYswn/HcOA/6mMFVlWe1+deBdLeZP84BT
	wT8mNdN6Qw+tpGLfisqyPyzISKBeemJSuHCG7lX46iSsehCTP7zeS5JABxSogSPdO23j4755y9jMj
	SizsX0cglhHtuJYO0lCVJ8AXKI/4CaE9aPfZDKILTF+hHwqh5XigEXZ15gUlGc4nwN8B6q/HOISxL
	wK812Zx2yipsGWybyQhAb7ZG4Fel63TJExcPOniOUm6inNU53Qi6fgMGV9B8rhVqDHhM431sm2zHA
	0ZeTAvMg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wrLBW-000000000fR-2pJ8;
	Tue, 04 Aug 2026 13:52:23 -0600
Message-ID: <f1ec8777-b747-4c35-860d-cde520f9b3f5@deltatee.com>
Date: Tue, 4 Aug 2026 13:52:22 -0600
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
 <20260802-fix-p2p-acs-v1-2-a7c5eb64fff6@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260802-fix-p2p-acs-v1-2-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, corbet@lwn.net, skhan@linuxfoundation.org, alex@shazbot.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 02/13] PCI/P2PDMA: Report ACS ports when the paths share
 no upstream bridge
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-02 09:09, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> A provider and a client below different Root Ports share no upstream
> bridge, so the search ends without a match and the walk takes the
> host-bridge route directly. Neither path is examined for ACS, so no
> redirect diagnostic is emitted and the host-bridge whitelist warning
> stays suppressed.
> 
> Examine the paths before taking that route, so every redirecting port is
> named in the pci=disable_acs_redir= hint. The mapping type is unchanged.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Thanks! I vaguely remember I might have got hit by this bug a long time
ago and didn't know why. The fix looks good.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
