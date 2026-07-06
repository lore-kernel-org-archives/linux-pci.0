Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76351433BB1;
	Mon,  6 Jul 2026 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352149; cv=none; b=uvSZ9QTbGLk05r2gYzm4gTGB2HM4Yk8jcRLPaTJw+UNK+QpnZ8CmaXJMynx/JN64oefVxIvNf9wYIgtylT/kTxCU5t9tIrOuvQkCQYXQ1Ln33Z/gaytgwfjBgrQwxOH2SWJ/ZXCHwF7HseuItPLtvPOVBE6x9IFIxKB6CKdrPWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352149; c=relaxed/simple;
	bh=3gJV4JtItQt16iIJXRMMlVKAxvbct7RZWpJgvYxNdLQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=BCGeaT8WWrKczO7TQbo/36k4f4HHAXRdjzwyZtQGT+2dnYa0D2XaBSPWKqweDLfaHlKhnXIfyoOs9heyY2sS5/R/L/v8IvPmqxH4/z+MBNqihccDOm40ehehr8RTbo0PJttTlgxta71IrmbSk9pZc9qcpxcPWmgmxGGgxHBTIK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=YlSGiAiy; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="YlSGiAiy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=VSwdCWKV/nLqywQb3ggYqrp7aJvjbBGRNOaSZqaDaOQ=; b=YlSGiAiyxVlFNhHvsy6aNxf4xq
	P19oyKC8FQMNqtBJPOn/8VodrTeR0ndrufsCj4j4YZuEyLIKveQ/nOBR2Nt6YXjWq8vGvRIlqFUzP
	txD+/mjPudhWwrZ+yznaGJ7PQX0sd9xRQ3WvCIj2kFqNW9kFTskz44gVTUSZtACPoZ07FTW0LuFW9
	ZHlm6kpE1i/8ZwATwRZvUKnATRNNvZWRzQsnltx3mPT60Emj1XHDkWBqakZGcghNHra2udIuddOCx
	zhoL1ZecgI9N3nKZCeL5/uE2fDruf7GE9S40xEGx/7oNoMURfH538k0pywV0AAvsi+WDX2JpsjukH
	UA9jmhYA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wglMD-00000009yMZ-0aoO;
	Mon, 06 Jul 2026 09:35:41 -0600
Message-ID: <5ef21f59-ef01-4e7d-b6b6-a540b48d08aa@deltatee.com>
Date: Mon, 6 Jul 2026 09:35:40 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260705-p2p-vr-v1-1-3cd45cab3fb4@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260705-p2p-vr-v1-1-3cd45cab3fb4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] PCI/P2PDMA: Add Nvidia Vera Rubin device to P2P whitelist
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-07-05 03:54, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Nvidia Vera Rubin platforms support PCI peer‑to‑peer transactions.
> Add them to the P2P whitelist to enable this functionality.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Looks fine to me:

Acked-by: Logan Gunthorpe <logang@deltatee.com>

