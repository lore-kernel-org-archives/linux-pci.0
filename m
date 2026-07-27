Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998BD3D47D9;
	Mon, 27 Jul 2026 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785189080; cv=none; b=MgOW9LwZZzAsiOxv59G1Ndl2H8ngxysE6s0lk0b36kHskVBxdFAWzPm/7Bxf2lCYKlmSl/bAcV0DuvbCBoDegtWP9nLT74x/3gN+gVJGyZAWllWs7g6ycV57AHKbwQ2lSlFQtXFNXDsOTqBw6Ic/BT4v+RBtAvQb66cH07MeW/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785189080; c=relaxed/simple;
	bh=Sn/1GrL+E3sMGZEcN8MyUo6xgKjvGS4FElmUNSEgpcc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=bHhUVw/QQ00J+BIsI3iqxmYQCeJNp/MOlMZPfvVRb/xZ+hSJc16h3HN61QX+NsUTdfSPnFHfk0yqEgKHtiTrF0MPmD5XN3YdIedZedS3+Xo8uTj0IS3K/vYEoacOrBCu4XRcZehVHp17iKqy9rR50LRu/WuY4EaCRlN/VNaEgag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=cjjxl4kW; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="cjjxl4kW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=b0mO2A2To0CCd5NIZxufdN8DmSu65OeTKkWB8Zm2mNU=; b=cjjxl4kWfyxpF6s2Y6x7ozptA+
	HPfppZHkAuvjavgHELiCZZvUwuIRsJx2UxHr9uC7bOyuyFTMuuZ6zbouJ+tNhjriY/P6XFDco6WsF
	z3+UDSly8ydpruKkv8UtcBWqaBG6DAZxCEwyZj8qu7fUM7J99SPlg0UdOeb169sKP/1lKFsWHyBOI
	AcrVClHRNjrDQzjOer9Csn2vqTHvzAnWyruHJ6m6gvISxpLrkKaaryu3eNMI45qtqzt1kzC0al121
	ULkqO4INcN0O3tynrm1XZXTJHVUFWlivlTyMPfVbH88oDeyCG2rR0ZQ0iyMF+Me9/EekNAmuiGS+K
	j+umFMBw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1woTEE-000000007Ox-1T5a;
	Mon, 27 Jul 2026 15:51:18 -0600
Message-ID: <f1671c82-4cbd-45d1-8875-1466b2df6bd8@deltatee.com>
Date: Mon, 27 Jul 2026 15:51:16 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Frank Li <Frank.li@oss.nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.li@nxp.com>, Kelvin Cao <kelvin.cao@microchip.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Dave Jiang <dave.jiang@intel.com>, George Ge <george.ge@microchip.com>,
 Jaeyoung Chung <jjy600901@snu.ac.kr>, Sashiko <sashiko-bot@kernel.org>
References: <20260727181526.9672-1-logang@deltatee.com>
 <20260727181526.9672-8-logang@deltatee.com>
 <amfL4H-ddHGONlUl@lizhi-Precision-Tower-5810>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <amfL4H-ddHGONlUl@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: Frank.li@oss.nxp.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.li@nxp.com, kelvin.cao@microchip.com, linux@weissschuh.net, dave.jiang@intel.com, george.ge@microchip.com, jjy600901@snu.ac.kr, sashiko-bot@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v3 07/11] dmaengine: switchtec-dma: disable channels
 before freeing on registration failure
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-07-27 15:21, Frank Li wrote:
> On Mon, Jul 27, 2026 at 12:15:22PM -0600, Logan Gunthorpe wrote:
>> +static void switchtec_dma_chans_disable(struct pci_dev *pdev,
>> +					struct switchtec_dma_dev *swdma_dev)
>> +{
>> +	int i;
>> +
>> +	if (swdma_dev->chan_status_irq >= 0) {
>> +		pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);
>> +		swdma_dev->chan_status_irq = -1;
>> +	}
>> +
>> +	for (i = 0; i < swdma_dev->chan_cnt; i++)
>> +		list_del(&swdma_dev->swdma_chans[i]->dma_chan.device_node);
>> +}
>> +
> 
> Maybe historic reason, it is not good to touch dma_chan::device_node.
> Suppose some hepler function to manage channels.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Ok, thanks. When I have some free time I'll see if I can clean that up,
but not for this series.

Logan
