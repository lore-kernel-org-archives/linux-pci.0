Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5A931E849;
	Thu,  9 Apr 2026 23:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775776549; cv=none; b=S2xIeBtO5ewOJ3eKyZ0rsv3SdfZi0jm0Ir3kqY9q7q68EUbBRhLCzDA/U5+VeO7ex5jOLaE8arq8JsqcedE5FTEZdH8rGzu5xf/hLYDz9zBNdCrXAM5LSR2xbnG8WsX0D4DkDj9bJoUeVlCUAkQfg1IN/Hn88jT8KdD+2e4JCMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775776549; c=relaxed/simple;
	bh=lP5Wlfa3AQDtvggwi4zPItLItkK4iZDM5bGg2RZqVto=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=RjI1ho+i56cHdPIXWrisKIC67pI5CuicszEJmYxIMCcMNhHIt66jQj4Jr5HjMrWXgxGsAyuyphrihkrPw4rvm/7QmPDvsoa+gV3PNBDB7zbnzgr8FwURvoC/FEyd7Nfbi6Jr5PcDhuCo4OswSNiCQJvNCgZ2n3vIs9LfF2ooXWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=naF1Hpy+; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="naF1Hpy+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=CBPuqvPrNzluhY7gEW1H7/bDOzj0BJI/0RrN78K4O8E=; b=naF1Hpy+FIsryvrGv3/hsC7GeM
	tlzbC5JSGSeCqusGpnrVZgk8QCo6OiLfHO+PG22yJDe6pIAqjY7RpzOU+nf1IS9O3ttmmTYQOTGgV
	Dxl3/Xq75OXyiPQYEtEJyMweZVumHVuPXz2PZ5AQSjrsZnDEJJL4fwTj9oIY7kxXCr2SLcByrvTQH
	4UyMxnUAk61pil1pueNU7eAYNQRjg2jYtyFx7ZPT8hI06Cz99SL6oWy4q+KRfPalTTtriEJJKbsB3
	j4GlWBVoUCw8xGPrS1Z8nhTN9nVf1RUgvwtj8Zio1SsnJ0J5/13ETsNoCLbOwzYzpf49OhvY/ewMu
	EtHzxxjA==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([96.51.150.74] helo=[10.0.33.11])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wAy9y-00000007s6C-1K0y;
	Thu, 09 Apr 2026 16:47:39 -0600
Message-ID: <966da6d1-5c49-4147-9710-3425fab28d4b@deltatee.com>
Date: Thu, 9 Apr 2026 16:47:08 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jacob Moroni <jmoroni@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 David Hu <xuehaohu@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260409150123.3538444-1-jmoroni@google.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260409150123.3538444-1-jmoroni@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 96.51.150.74
X-SA-Exim-Rcpt-To: jmoroni@google.com, bhelgaas@google.com, xuehaohu@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 1/2] PCI/P2PDMA: Allow wildcard device IDs in host bridge
 list
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-04-09 9:01 a.m., Jacob Moroni wrote:
> Currently, the pci_p2pdma_whitelist array requires an exact match
> for both vendor and device ID. Some hardware vendors support cross
> bridge p2p across their entire silicon lineup, so add support for
> wildcard device IDs to avoid the need to continuously update this
> array.
> 
> Signed-off-by: Jacob Moroni <jmoroni@google.com>

This looks good to me thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

