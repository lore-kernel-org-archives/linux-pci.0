Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03803A1A23;
	Tue,  4 Aug 2026 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785880546; cv=none; b=AUwdvRC0Kn1pAYyvmkc3RLJkL2HKTt0iujwU+hR9/eAurzVTHCWJQvnkBOR2QmvqewV8kQhKiz7nGpc42U12pgIX/jTZZjSuyL5wgT44MtJK6nZ23uCNrRJoNxI+e3HbqWBWSM1ppMJjwW31KBFgGwWM9mPAMe0WcD5pa5Ug/D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785880546; c=relaxed/simple;
	bh=kT1azf3X8y4IT6vZQyh0JezAI+RYBQ+2ytkS3ld8T8U=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=Zl8FPbjpeD+xfsYIBcmVhit1cD7Q0SxniEX9Fqx5l999m8FICiWY4gfM1LoM8NsFM0jboZla7010g79RWIb+SXBqU8b/nPL8aMhjd2Ke9nEIclmndJyTbAk/xDvGX0XWMsF5MxS+PN8AvUz5940WDl7Axu9OcVLYZ4lLfHf6vIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=OeuGrtOW; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="OeuGrtOW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=Kz8BPKp3Ug6p/fQkR2kl6+0G/24Zo28yOS4kq6jQtPU=; b=OeuGrtOWeUNrHxsV0vV/TD0m5m
	DJsZJLLhzuWxwT1FIerbsrKRCLPEb5joo5o4Na89yxDVNIZZUrBzhIYMApPlK311mxTWlhHy450hL
	HpnNN2+uiZFBKYvrNgoi+VhzYelDzVL4fAie8mz+V4DGYTQO6ZRj6qvTA1uh3bzqb46bkAwdJY769
	JTo15xk5jJIHvHkMd+v2xAQbZJhIGxONLoEXwaq+vsyHsyc/luRjQXWMLdzmk145/s0z30wQjBod0
	VrVMBNNzZPTS7i7bvu6unEiLtmPFsywgSTLedR+7b4AHYOBtBguXn4f6koCOekegoUel8sAKxsJ4A
	Usbv2QpQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wrN6t-000000002SS-1aeE;
	Tue, 04 Aug 2026 15:55:44 -0600
Message-ID: <694d33b8-8f27-4e87-bc3e-f07e98a05091@deltatee.com>
Date: Tue, 4 Aug 2026 15:55:43 -0600
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
 <20260802-fix-p2p-acs-v1-5-a7c5eb64fff6@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260802-fix-p2p-acs-v1-5-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, corbet@lwn.net, skhan@linuxfoundation.org, alex@shazbot.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 05/13] PCI: Add ACS egress control vector accessor
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-02 09:09, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Whether ACS P2P Egress Control routes, redirects, or blocks a peer-to-peer
> request depends on the Egress Control Vector bit for the target port, not
> on the enable bit alone (PCIe r7.0, sec 6.12.3).
> 
> Provide a helper to read that bit for a peer Root or Switch Downstream
> Port. Report an unreadable or uncovered vector as an error rather than as
> a clear bit, so callers do not mistake it for permission to route
> directly.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
