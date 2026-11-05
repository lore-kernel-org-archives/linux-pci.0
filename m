Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=204.191.154.188
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900284;
	b=WWuJF51vpbmCGsxPyxA8N4qfG9u2lBMVlV/iUhInioM25WGcL/dILUo+12TiqNn0bRYk
	 sChJ5p/zVqnse6LDnNlhScAYibq3DM2A3RiPlTwrtUxiZN1soGwE8RpKuITsRHTlkQ5rV
	 Hlyf3yn9Q4dIb/pfso1JXlA+EL82zPwGir9zZp3K7ytFQQvDzlMwXi+3oMSdLGH8Goy3F
	 IAdGunRUvhjPQmtpp/4TpvR6XAli58m7WpFXsV7mLs0BUEkhrJArJ6Lq9Ksa+xxucRJ2G
	 Xj9A8ZGRP6m363gPBU98uLn+RR3Tj6TgEW5sn72/dr499OdmTVpEfRgisiWK32yvR6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900284;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-SA-Exim-Connect-IP:
	 X-SA-Exim-Rcpt-To:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned;
	bh=gqyPh/ubdMbfVu/lYcA7rtFUDtu+CnoXv2CHR2SP5J8=;
	b=a1vsSXMhhhVmfK6+Pkdq5eB3my/4wX23V9w39z0xPRQwImPl2hvzfUIGuPlFOKSo/aDZ
	 OcQoVJFUAB+uxo/PV52XjnD/5RjJxUgmy001G0LEbxDXgbiqx1ZKM+uYmao34fwH7Km3c
	 ZKNOhcmd51ZVz8OTP7PmA2nsVbrZtCkwXUq53E4Ygvv62Jd7XUIgyTak9An0RCNyc4//m
	 2RLWIBDWdlqubUqk6l/7hr+er0YzR/KTvkz3VT/QeEUXsrjwaMd5w11GSzMZnWfBQpiop
	 ULvaAu/pHshvliC54hsO6uqrZ5XDf9VAaPUsvnUPZ01z9OLgow9oywKJ5z8m+q1cv1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deltatee.com;
	spf=pass smtp.mailfrom=deltatee.com;
	dkim=pass header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=i8Z8VC6X;
	arc=none smtp.remote-ip=204.191.154.188
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61BE606A31B;
	Thu,  5 Nov 2026 17:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A61BE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=i8Z8VC6X
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=gqyPh/ubdMbfVu/lYcA7rtFUDtu+CnoXv2CHR2SP5J8=; b=i8Z8VC6XASBivlhrf/JD0eZDzc
	blgByrfu5OwreeasaAQs/jbTi3g2uqvHQzcJlNe/+0imm24SB4z4B40Pt6nehjY9rRSKF5itrhm7q
	XAdmfSeuCuEf/hTrSn2JsOeWq3eWFaj1/tNK7hA/WihHC/fpIxikahtzYBHROqt7RbMXBxh66MLoB
	wrTUeaPUxLh2dqZXZQ73OqXfS4OWglI5GVQdJT2chjZIN4d+qNxvV4nnWmkXsx5BnDoNFJnh41+50
	oHzk1EgNCz5JchcQVZ7JwlwlMbBGCiJ3FgNj+loCmP5OXMK2AYfjMFVZrrjvvIVkX+XfizmK5Hd46
	VqnBbYLg==;
Received: from [104.157.31.28] (helo=[192.168.1.251])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xP1PP-00000000plY-2tLR;
	Thu, 05 Nov 2026 11:37:57 -0600
Message-ID: <f1221775-424c-486e-bbd1-a7f3504ceb17@deltatee.com>
Date: Thu, 5 Nov 2026 11:37:40 -0600
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yige Jiang <yigejiang86@gmail.com>, linux-pci@vger.kernel.org
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 Daniel Stodden <dns@arista.com>
References: <rc-review-20261105-vc-149-07fa7f0c8a18@gmail.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <rc-review-20261105-vc-149-07fa7f0c8a18@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: yigejiang86@gmail.com, linux-pci@vger.kernel.org, kurt.schwemmer@microsemi.com, bhelgaas@google.com, linux-kernel@vger.kernel.org, dns@arista.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] PCI: switchtec: Fix PCI device reference leak on probe
 failure
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-11-05 1:55 a.m., Yige Jiang wrote:
> stdev_create() takes a pci_dev reference for stdev->pdev. When a
> later step of switchtec_pci_probe() fails, err_put drops stdev->dev
> but omits the PCI device reference. stdev_release() only frees
> stdev, so the PCI device remains pinned after the failed probe.
> 
> Return the PCI device reference before putting stdev->dev, matching
> the existing cleanup in stdev_create() and switchtec_pci_remove().
> 
> Fixes: df25461119d9 ("PCI: switchtec: Fix stdev_release() crash after surprise hot remove")
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>

Thanks! This looks correct to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
