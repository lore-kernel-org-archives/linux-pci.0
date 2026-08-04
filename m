Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1574A3F328C;
	Tue,  4 Aug 2026 22:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785883106; cv=none; b=uvG6xLUPSAsOc0c4XU/i5+T8OBexTVxJIxdi4v389D849CGWAqyNj1vbv+vovgFPLqUuOFyEa90LCWOm2XYnaK8jWCZr+KueCauDAScYtXaXJbbtsNb2/LFLcBZd3rDxaztllVOaub6UK6VECYTCH9V41qLq0hDu1zqjJXhVQPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785883106; c=relaxed/simple;
	bh=49zl7e7+DFxNC9ZT6wEz1FFmwUc1fh00KGjsLZFnLEM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=S8t3/Pme9ZgJIVpzN8WWC4AOx370fZ4nheFkIv9rYSFVVk/cd97HAYzl3Ec1Ia6mkKErgvPZ2ISgjsKbKft8qLMHkIQb51R+448FLq2vbWNWe5qwdt9qym3ICEZQN8cELaB8O+zdyMZX2RUDzk/Pf/YRYeDeayLpC1U7l5Pe3zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=mP+CVWhJ; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="mP+CVWhJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=gjVXyfHZuoZNgH6GnuaCOwNp2oBsO3WIpzFm5jrw4s0=; b=mP+CVWhJWfFp7hlPBgcqbLAXkK
	74Cuu1O8vxpT+yQYkHIGdLVFU9VXuf76Yr1NiAxDeFdCCb+2aMOfDVbDuQ6i3WZ6KUXJLAV+e9Ty7
	KiaQSpFhhEf3l2+VXB2/JjRsdCqphLx8mmDwrMvMTyI22xxat4ecUng60BKM1kHs/KQlTNLrUuNI7
	to7MXXxKiOMO3uFFo66RmaXQez9Ej+KezXdjqoWoCleqLlL3dk41pSN5xktqo275Z/AOEFMLbN14O
	G6WJ5uL8Wk/vkizwLRLxw20vRIYJcv6bcExcredaj3gCbVrrm1ix5a9FivY1Frdvp7OTZDxJJWQHa
	K2xwj1XA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wrNmA-0000000038r-28O3;
	Tue, 04 Aug 2026 16:38:23 -0600
Message-ID: <9c87165a-e8ca-4d76-aa5d-ebf01f377c93@deltatee.com>
Date: Tue, 4 Aug 2026 16:38:22 -0600
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
 linux-doc@vger.kernel.org, Claude Opus 5 <noreply@anthropic.com>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-13-a7c5eb64fff6@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260802-fix-p2p-acs-v1-13-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, corbet@lwn.net, skhan@linuxfoundation.org, alex@shazbot.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, noreply@anthropic.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 13/13] PCI: Add KUnit coverage for ACS isolation checks
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-02 09:09, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Direct Translated P2P and Egress Control both let a peer request reach
> the peer without Request Redirect, and whether Request Redirect still
> isolates depends further on Translation Blocking and on the flags the
> caller requests. Firmware owns these bits, so the combinations are not
> reachable on a given machine.
> 
> Drive pci_acs_flags_enabled() with a fake pci_ops supplying the ACS
> Control register and check each combination. The function is exposed
> under CONFIG_KUNIT via VISIBLE_IF_KUNIT.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Assisted-by: Claude Opus 5 <noreply@anthropic.com>


Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

