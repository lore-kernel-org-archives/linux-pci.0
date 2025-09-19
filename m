Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F797139D;
	Fri, 19 Sep 2025 01:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758246119; cv=none; b=gqQjBSrgnGf3ukLaSEVqWCCqa173YfQgfgYWADRO2jEowmnbSODdRgU5ZUlsPjXU+80VY2e44FhvlkLMslJxpP772aIazQ0iSMZzO26enKmt9KxZCJaDc2e373kxuWD1mp2Sln9R8a47VIxzPT/EbSu/t6PlcgMhPxFhOZsKR6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758246119; c=relaxed/simple;
	bh=BRO0WEM0aeIlcUUykf2EgkcvC6ENyIezC0+IrWRnH/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/Yu2EnwoA4fAx5MMK+oRqDfDkUNKX3LkR3zTAkksJWkUklEf1npX1veN1m0Q2Zke/Kl211+sbw38D12t65aZehEyZGksAmcDMTFLdD8a4SRGRtFzQoCGfiQKw19THtYOMH9X55vGOUBt/239TVmJZsVV39BOuoj68xysvl9IGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AEv7G7gc; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AEv7G7gc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758246114; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5F2mu+HPJmOD+g9xW2Kjsqxc2iUpO4ZGC562yuztetI=;
	b=AEv7G7gc5GEeu0cyehtPwGkAMzAUWuQhWjWp0lYSz1H/mkIIrBVUhADsOR30TqmQPV3PCaeE9fIh6Pe1WRtElgL1AMZ6SFShwFK6SNUF9J0JxwpUW7LXHQ1H7Ik84cKmuKbIkAUuds79Di7TFPTR48n3iMQtjpsn0k1nMOzZkt4=
Received: from 30.246.178.33(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WoHzP3E_1758246112 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Sep 2025 09:41:53 +0800
Message-ID: <47b52f6f-d27d-49bc-a999-382441aa310e@linux.alibaba.com>
Date: Fri, 19 Sep 2025 09:41:52 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, mani@kernel.org,
 Jonathan.Cameron@huawei.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 oohall@gmail.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20250918203315.GA1920702@bhelgaas>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250918203315.GA1920702@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/19 04:33, Bjorn Helgaas 写道:
> On Wed, Sep 17, 2025 at 02:33:52PM +0800, Shuai Xue wrote:
>> The AER driver has historically avoided reading the configuration space of
>> an endpoint or RCiEP that reported a fatal error, considering the link to
>> that device unreliable. Consequently, when a fatal error occurs, the AER
>> and DPC drivers do not report specific error types, resulting in logs like:
>>
>> 	pcieport 0015:00:00.0: EDR: EDR event received
>> 	pcieport 0015:00:00.0: EDR: Reported EDR dev: 0015:00:00.0
>> 	pcieport 0015:00:00.0: DPC: containment event, status:0x200d, ERR_FATAL received from 0015:01:00.0
>> 	pcieport 0015:00:00.0: AER: broadcast error_detected message
>> 	pcieport 0015:00:00.0: AER: broadcast mmio_enabled message
>> 	pcieport 0015:00:00.0: AER: broadcast resume message
>> 	pcieport 0015:00:00.0: pciehp: Slot(21): Link Down/Up ignored
>> 	pcieport 0015:00:00.0: AER: device recovery successful
>> 	pcieport 0015:00:00.0: EDR: DPC port successfully recovered
>> 	pcieport 0015:00:00.0: EDR: Status for 0015:00:00.0: 0x80
> 
> When you update this series, can you indent these messages with two
> spaces instead of a tab?  That will preserve a little space and also
> preserve the formatting when "git log" adds its own indentation.


Sure, will align with space.

Thanks.
Shuai
