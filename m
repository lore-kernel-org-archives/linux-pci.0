Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AF347DF9A;
	Wed,  5 Aug 2026 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945932; cv=none; b=i23rTXY0kputY0CSYlK+/evVWfql0j5r5vDoWhI83HFF+u/iaLg/VR89URKezfqQyrR+oIiUVmIP3AfhIq6Hzgf4acvGuXYuDDpkLjRgIdJYldUfn68tRoG8WIfM1lQeixlcM2/zizOvC31BhlS1GWkvZbPaUR4Vd7mspAtSQPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945932; c=relaxed/simple;
	bh=3lrnARUnktHPOU4i5ZDfbc0l5WLcosy1AhKaYNTjuNA=;
	h=Message-ID:Date:MIME-Version:To:References:From:In-Reply-To:
	 Content-Type:Subject; b=BlC1GWKOrClOUfWvTYoro393H0tr3JTwVAtO3jMfL0IxMZpZn4AaMO+lGI5XB+HT9EtCZ/Y9ul1V9Cb6I1WB+r90hWlCrVgyTcZChepjd+70oXWR8exrdZnftxOJ959YsSkwBWck0JJwyePUkdJ6ph5s2ccObu0AvP0jpxRpGmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=QVVGOjSf; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="QVVGOjSf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:To:
	MIME-Version:Date:Message-ID:cc:content-disposition;
	bh=8NLF8Fcb2T4FSDq/Fi3CnAvV0uLZJax5mT7k9EdSauQ=; b=QVVGOjSfUnzTat43DP0HQZvzB1
	1IJn2u0tzAe4vwGw7LOd61nhZG+2YxvbkaDwGrDe+Mh1WXfQTOiJ4Cz7zsSfaonpiMPueOV/bv8Nx
	zqj6grLNTprVimCqWJJKzAflg1EsLqCDua4+u8x/aebthvTYAnE05/CTPkOdRaJsZVLbll63NHrew
	Gpg4bXAdwiTqWg/xpnpUR4fPFSctleSRFb1gqUAmBczsdVzlGsfKIuiEnG/3pXL4/+nV3Ai+n5Ilm
	Mip+Zmy091cJCT1Mi4Fz0NlMN7G21l1iGXRsOyAI9bhOtgMP96/C2BqIp3YUbFOUTN6fz44IjRkcF
	O0aYrryg==;
Received: from d172-219-145-25.abhsia.telus.net ([172.219.145.25] helo=[192.168.11.155])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wre7V-00000000llA-0bYv;
	Wed, 05 Aug 2026 10:05:29 -0600
Message-ID: <19968e2f-8ba3-40b5-ba7f-f1be0850f925@deltatee.com>
Date: Wed, 5 Aug 2026 10:05:25 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pei Xiao <xiaopei01@kylinos.cn>, kurt.schwemmer@microsemi.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6fdcbfa869f707cad783c7f92d1681f0a2bd9a7c.1785813784.git.xiaopei01@kylinos.cn>
 <a619d2d6-5a6e-4173-9342-8186cce0eef1@deltatee.com>
 <1b8d6927-68d5-4ab1-bd09-959a90cc3c72@kylinos.cn>
Content-Language: en-US
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <1b8d6927-68d5-4ab1-bd09-959a90cc3c72@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.219.145.25
X-SA-Exim-Rcpt-To: xiaopei01@kylinos.cn, kurt.schwemmer@microsemi.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] PCI: switchtec: Fix use-after-free in
 switchtec_pci_remove due to race condition
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-04 19:28, Pei Xiao wrote:
>> I'm wondering if these should come before the mrpc_timeout sync.
>> Otherwise, hypothetically, new work could be added and another timeout
>> could be in progress.
>>
> yes,
>   	
> +	cancel_work_sync(&stdev->mrpc_work);
> +	cancel_work_sync(&stdev->link_event_work);
> 	cancel_delayed_work_sync(&stdev->mrpc_timeout);
> 
>> Also, I'm not sure, but seems like the interrupt should be disabled
>> before this as well?
> I looked it up and it appears that pci_clear_master cannot disable
> interrupt enabling. Should I use devm_free_irq?

Yes, I believe a couple calls to devm_free_irq() is what will be needed
here.

Logan
