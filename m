Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DE32DECCC
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 23:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780616748; cv=none; b=EEaOW+pF+qBo4bc8xpay6Td2eZYaYx/gzEZHzW1M0Aqvza8EoJlaNUuJRqtGL/dqwEJ5kCvyy/H016LfxibDChV1XUi2Yks33SrfSX37XXwrOSzlYqcT3olshMLQpR2Gxij6QODjuZwDpQRkcx2jN2is1xwqOZu0BGKWis4HwZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780616748; c=relaxed/simple;
	bh=bK530mU73DRw7JQEZDRZTj4Hgh4QEo0lbRGrSsIqAUE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=nLIqXjwEd69hbayn5w8JiHLU93cw41gmmIsub50B3RZlW/sjPljtX1X3mlS4/KuxWHGPMSbzw5fLRSmOvscncOT8hW9jjN6ruH4iAhw8UNREY4m9ME1AYylqpg4LJqv+dHKCJei2U1RxG9+CEYfUAhMV9CS/kd4eXjdcJ0tnWLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=NwNNEIDY; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="NwNNEIDY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=6hTU5y8HzIerh1pATDNFjPEtyYT3op3mfra1ZOmc/AE=; b=NwNNEIDYYIwo5R3Xt/UjSyLbUQ
	D3M+XJNnD2QsK/s3S6IXHcNZFLI7uhG6FyMn0M4IkpOJ7CQpHmLhBsmhuRb+lU6I1L9P5x8Sp08bF
	tKPv6cBHqoPcBqSCQs7vGstlnv6VU4xB84SIBxOgoCN+qLiLAoVq69BN1g0p745qhZ7+xV4hQrAUb
	EK2tIyz9+Ott9mbF4KFL+GziDOSBGWTMeusm7ad9lJB9xbEuRUd8F7q4qCSax3WAD8xq9WjemDha+
	CwuswPsPv3FoFVIDiXfVHG4YOhRWjZZ9hK6zTHGxJel+DaAteCDUCA/U8j7oA1Rawv97VS5gwguhl
	i+UB66Eg==;
Received: from [104.157.31.28] (helo=[192.168.1.251])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wVHkw-00000002SJe-0Hbe;
	Thu, 04 Jun 2026 17:45:46 -0600
Message-ID: <ea1b3578-8216-4a7e-a97b-d5534aeb1422@deltatee.com>
Date: Thu, 4 Jun 2026 17:44:41 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, linux-pci@vger.kernel.org,
 qat-linux@intel.com, Damir Chanyshev <conflict342@gmail.com>,
 Simon Richter <sjr@debian.org>, Tomasz Ossowski <tomasz.ossowski@intel.com>
References: <4ea5265495876beb5fb5e6d479b2782f882bcbb3.1780570508.git.lukas@wunner.de>
 <a830ffd4-14a1-4739-b862-25e664394a96@deltatee.com>
 <aiGc-CCSdIeEYTLb@wunner.de>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <aiGc-CCSdIeEYTLb@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: lukas@wunner.de, helgaas@kernel.org, giovanni.cabiddu@intel.com, vinicius.gomes@intel.com, linux-pci@vger.kernel.org, qat-linux@intel.com, conflict342@gmail.com, sjr@debian.org, tomasz.ossowski@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] PCI/P2PDMA: Add Intel QAT, DSA, IAA devices to whitelist
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-06-04 9:42 a.m., Lukas Wunner wrote:
>>> Whitelist them for P2PDMA as well.  Move their Device ID macros from the
>>> accelerator drivers to <linux/pci_ids.h> for reuse by P2PDMA code.
>>
>> I'm sorry, I don't fully understand this. Are QAT devices functioning as
>> root ports? Are there devices in the tree that are doing P2P
>> transactions through theme? That surprises me.
> 
> These accelerators are RCiEPs, each located on a Host Bridge by itself.
> The idea is that users should be able to set up P2PDMA between these
> accelerators and other devices.
Oh, of course. Now that you mention it, it makes perfect sense. Thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
