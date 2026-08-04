Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E144033937F;
	Tue,  4 Aug 2026 19:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873317; cv=none; b=MwpOfD2JwpOcVzdDu5pDEtGvrM0AQpcnRwdnth4ba8+9pHCjsZFcIPRB374gIuh9VLKOtsT4ifER9/reEVOtlBPz6y4UkpnKSnGDJN8aSRQXUnewpWxxBueWXu7GnAPDA8q0jwcVI1FDuTzABJCL3mwhTDhVRCyTNh9n9Ys3cUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873317; c=relaxed/simple;
	bh=vvX0SUrqtLD2pui/FRqfojoBMRp5wiNUILlNKOl4gTo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=F76QhzLx6gAhuYRK17kqLPQZqaEq+xl8Up1KegGNIejjrWkeJixWAMggM/tvhToma3kCQgo6gybE/Ki3c8BJb14JkB2nHiybo/IEbHbdlsVSjeWze/1iLusbq7gSh0fRujki0xLfjF5i0npAZpvGHm75jhzlgiCCSD6N2sb9/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=aI8HQUHT; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="aI8HQUHT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=bsnCJMRW1Wojan2LSrAzGGxy38kiy/p2s1JUs40QzZQ=; b=aI8HQUHTXi5qWuc7EJvAsYdr94
	lqSFrmp8J/9XetxN+cPUxt+Uub3KaSeA1Junv4OalKW1O29smsm6xTaTGoveUP4q/npRPOe8F2xjD
	3y617RUcHo/sALDW/UffWAtNJAz94cQ5qL1KGcSZqcArc1xb8pl1IuX7o7U8iU5cEpps7NLUxVQtm
	N9/v/3Uw1+CJQjDtWnXv49+2ZcwQVOQdISdaqm1geY4HYfhyMMsFKq+jWrNmTK66bP1F1wdnb7AL4
	yegS3U1GcYUxPQ2AmUb8trXfjXPGTZzZmAEpbC5eIHiwG7ZR8HsVF79Hju9QjkUWbgY2toBB6XdXQ
	+KY4Gonw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wrLEH-000000000hg-37jK;
	Tue, 04 Aug 2026 13:55:14 -0600
Message-ID: <e7c63c88-e6c9-4788-b772-8903511f07e6@deltatee.com>
Date: Tue, 4 Aug 2026 13:55:13 -0600
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
 <20260802-fix-p2p-acs-v1-3-a7c5eb64fff6@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260802-fix-p2p-acs-v1-3-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, corbet@lwn.net, skhan@linuxfoundation.org, alex@shazbot.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 03/13] PCI/P2PDMA: Document the Address Type assumption
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-02 09:09, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> P2PDMA selects a mapping from the ACS controls that govern Requests
> carrying an Untranslated address. PCIe r7.0, sec 6.12.3 routes a Request
> carrying a Translated address directly to the peer whenever ACS Direct
> Translated P2P is enabled, regardless of P2P Request Redirect and P2P
> Egress Control.
> 
> An ATS capable client can therefore reach the peer on the direct path
> whichever mapping is selected. Record that assumption.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

LGTM

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
