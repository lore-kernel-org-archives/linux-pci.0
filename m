Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B63367B72;
	Tue, 14 Jul 2026 21:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784065361; cv=none; b=YgKz3esd5Y7JHf2k4vfUb65CeaEHYSVpokHOWpC/Gq+qRBivS7+oSJqoQi7X1aDXMDbxBG9zscqbTBrL7ROa4dgJY0Kj2YzBmOCMMFD6GZVaDTKPxazcbNPLBYKFf3elbkzsM8/WhKHS0IHrjO4dzG8H92mxZ9lmIWi+bje3JsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784065361; c=relaxed/simple;
	bh=8rqAuISZTrwleX9fX/itLoGnv3ehU0TZyEiMY9tJGpY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=LN1Fj+5+AFoFGI88GUA3xgtpsgMgjWEFxW8twzYKAQivHZZTfBGvtrp9FZsPkm7Ebt5WRi3y3JVpT7FoQGKBUBTWWUYaxwYQbALKhJolKaJJENCV92RACVuWkUexW4Eg87S/pDWKxo0qA6RgREvtKH+kyPo2iQT5sTqLYcWGmZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=sMOV2HB8; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="sMOV2HB8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=6g5HNAUSFJYWMSMD+h29dJhibxCRsgeQy/Qe2Ojoht8=; b=sMOV2HB8/Z2DQEJbTFUFh2HWoT
	RydWPXDh12JdBqOXtY1L4suB0GFHxYZOfVcf6T8D6gW69lz2a2rDwikiNyHgxj3ckfUOME6TPwKOC
	Fktlr28Bre50EvbyHoorlFvUTPZ6Iddj5UbIUK3WHi9RFzru7IiAfW+7urk9BmzAbajsABptQm268
	3rbdlrjFF7ILR+omoywVeaVSRniDFKHOFzcm8i2pkKgFmgwiOZvLWBH/ZOML4yE6AGU6voCdgFCYE
	IqSUY0m4afGxZLTuD7wStuT0qtVTCErGkl6BTJpbknKfcHNuZunOjpZAQFV4Y+G2uM1VsPgotI7KR
	70qiYFUA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wjkti-00000006fIQ-3oNv;
	Tue, 14 Jul 2026 15:42:39 -0600
Message-ID: <e1926634-0fcc-494b-8cde-fdd7e90af426@deltatee.com>
Date: Tue, 14 Jul 2026 15:42:38 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: sashiko-reviews@lists.linux.dev
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org,
 dmaengine@vger.kernel.org, vkoul@kernel.org
References: <20260714212010.230606-1-logang@deltatee.com>
 <20260714212010.230606-2-logang@deltatee.com>
 <20260714212817.4DE8B1F000E9@smtp.kernel.org>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260714212817.4DE8B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sashiko-reviews@lists.linux.dev, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v1 1/3] dmaengine: switchtec-dma: Add PCI1008 device ID
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-07-14 15:28, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Does this new device ID also need to be added to switchtec_pci_tbl in
> drivers/pci/switch/switchtec.c?
> 
> If the companion ID is omitted from the core management driver, the DMA
> engine will bind, but the core management function will not. Would this
> leave the character device, NTB features, and hardware telemetry
> inaccessible for the PCI1008 device?

Unless I'm totally missing something, this is taken care of by the next
two patches in this series.

Logan
