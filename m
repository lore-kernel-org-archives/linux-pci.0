Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E6336165E;
	Fri,  8 May 2026 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778240091; cv=none; b=PApVQWcVurwbsCi2rANZRZk2cdGzMeBKXpzfquS5RUW+8vqPk8mx1y+66nzPMetqJY4R8btUv0RHYMEJDfJJ5MUrATIzalWKc4E9MeGfwSOgx8xtfGMrVv9fI7E78+42g2jC1YFcNaBzoqhgKdPH/UBDqT+xId/mPZqIw32zCLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778240091; c=relaxed/simple;
	bh=rtqXrBZZtnYOVK0fdPv63a7/JoIOuCyjdnQF16wdOL8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FAQM7ruhIfaooHtAXmH/c6X66sdZjjwtk8q7DKEEzvPetGWluKophDZn0l6Vsw6J1u6KA6yT0ATuM7ihxHkDCagoAYta9gNEwMOaN8oBarUbqmUODdTjNmDX07le+6qZAmyoIo9QGSN2JlJTq810Mx5NkvkCT4F5jRvzR2YGKNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=erWuUBFF; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="erWuUBFF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:To:
	Content-Type; bh=pnO5gKXFlw5O+YF/SwBk1mxOhEzSSWofa6r1cXN1DlQ=;
	b=erWuUBFFxH5Mttc6eoAy9ZKfmRN9BD3mpi7imghkq2VyoeWrf8hAcph2EpRTUz
	TtpYE7GcH1kucWMSrM+AT+VPzW4Xux73lW6z+hSqUoZdsTzY0fUoTC8eItHF/T7i
	rMARl6lqgT1Kx4UR0OicVu5XLHaRYlypHfh+lN7tEfdXs=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAnMrAqyv1pHmLxCw--.89S2;
	Fri, 08 May 2026 19:34:04 +0800 (CST)
Message-ID: <d0fb1c9b-4331-4f28-a95e-0962a2c9dd77@163.com>
Date: Fri, 8 May 2026 19:34:01 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add Aksh Garg as PCI CADENCE reviewer
From: Hans Zhang <18255117159@163.com>
To: Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org,
 helgaas@kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-kernel@vger.kernel.org, s-vadapalli@ti.com, hans.zhang@cixtech.com,
 vigneshr@ti.com, danishanwar@ti.com
References: <20260508060951.840233-1-a-garg7@ti.com>
 <12c2c868-a734-49f9-9938-77319b35da3d@163.com>
Content-Language: en-US
In-Reply-To: <12c2c868-a734-49f9-9938-77319b35da3d@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAnMrAqyv1pHmLxCw--.89S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4DZr15uw4kGw1rWFWxWFg_yoW8ur4rpF
	WUK3W3CF1fXF43u3WkG3W5AFyrWan7AFy7KrWv9asxXr9xCr15tr1aq3Wa9anrXr48W3y2
	yr4Sv3Z7Ja1YyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUDGwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AyXO2n9yixrFAAA3B



On 5/8/26 15:08, Hans Zhang wrote:
> Hi Aksh,
> 
> Let's wait for one day, or two days, to see if Vignesh is willing to do it.
> 
> For drivers/pci/controller/cadence, currently Aksh and Siddharth hope to 
> become Reviewers. Manikandan believes that he can become a Maintainer. I 
> myself also hope to apply for the role of maintainer. Then let's review 
> the common driver related to Cadence PCIe IP, as well as the driver of 
> the product.
> 
> Siddharth:
> Depending on the frequency with which we are able to Review patches 
> consistently, we could eventually take up the role of being a Maintainer 
> as well.
> 


Hi Aksh,

Privately, Vignesh has replied as follows:

Vignesh:
Agreed, I would prefer if Manikandan can own the driver as he would have
better visibility wrt IP documentations as part of Cadence.

Sorry, I don't have the bandwidth to own the driver. Siddharth and Aksh
can help review and test on all TI platforms with Cadence PCIe IP.




Could you please add Siddharth as a Reviewer? I and Manikandan are the 
maintainers. Of course, we need to see if Bjorn and Mani agree. Then, 
send this patch in the next version.


Best regards,
Hans


> Best regards,
> Hans
> 
> On 5/8/26 14:09, Aksh Garg wrote:
>> I wish to contribute to the review process for Cadence PCIe IP drivers,
>> hence add myself as a reviewer.
>>
>> Signed-off-by: Aksh Garg <a-garg7@ti.com>
>> ---
>>   MAINTAINERS | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2fb1c75afd16..e2c188a358ed 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20315,10 +20315,11 @@ F:    Documentation/devicetree/bindings/pci/ 
>> marvell,armada8k-pcie.yaml
>>   F:    drivers/pci/controller/dwc/pcie-armada8k.c
>>   PCI DRIVER FOR CADENCE PCIE IP
>> +R:    Aksh Garg <a-garg7@ti.com>
>>   L:    linux-pci@vger.kernel.org
>>   S:    Orphan
>>   F:    Documentation/devicetree/bindings/pci/cdns,*
>> -F:    drivers/pci/controller/cadence/*cadence*
>> +F:    drivers/pci/controller/cadence/
>>   PCI DRIVER FOR CIX Sky1
>>   M:    Hans Zhang <hans.zhang@cixtech.com>
> 

