Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FFB2210D2;
	Fri, 20 Dec 2024 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734717852; cv=none; b=kaiLN7FlNCLi2+TFpWEfRT3POqJgRPAL9uKUaVv+Lg/vgTAvzA5Ibe7iamp/6sNZkA0uQ46Ej14uM51Geujg0LWpA7/5JqDwSbIUWY5PBX780aUm7Ip6Us09RAhB6gHuqeF//gl/BYk9gkOnmf8/RzNnQ8xfrjSYrCGah7pFj2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734717852; c=relaxed/simple;
	bh=lFyEd4/EqQQu71zqqQ7WRsC3L8xmSdwLOES7edPYqFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=deW6Y2mPJBgiO9uAEdPrJP7SPyOqLsNS8Pv1M/bEVThg7v83Sukscv8BkhvBLOV2ZSPb2aibZAQsp3vF9vCbqu/cMNBRkqrc9xo36uZtN9H4ezreSffR3E+hEU1I+03ysiJmUgS/e5L6qCWBlvk/0IhQo9CPwegP1RStRbCrEhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gqzWTIQG; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gqzWTIQG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=CFGM9XWzzXcDTYpI4G9g0SqAYK9SQEzW/JQ/jfqGEC4=;
	b=gqzWTIQGcL1hQplqo9UagaZrPG1MkDBHdhry3ktbJWyg/XRxOD3c4sFEJbi01A
	t4sVoM+dYuOoiGFZsWUnVf0XHMf2BgmlixaLolS2OTi1w6UWAHYJeYaHs/gZyjBi
	T3ScNgIkfJtHiQikuk+sQZ5j8h684klEfLkVCcoxyvoTI=
Received: from [192.168.71.44] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3H9VQsWVnFYsZAg--.14832S2;
	Sat, 21 Dec 2024 02:02:57 +0800 (CST)
Message-ID: <319b18b1-9694-44eb-8e1a-b68e6f78ac93@163.com>
Date: Sat, 21 Dec 2024 02:02:56 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] misc: pci_endpoint_test: Fix return resource_size_t from
 pci_resource_len
To: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, rockswang7@gmail.com,
 linux-pci@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20241220075253.16791-1-18255117159@163.com>
 <2284f3f6-5ff1-4b1a-8eed-d0e9c63d43e2@web.de>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <2284f3f6-5ff1-4b1a-8eed-d0e9c63d43e2@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H9VQsWVnFYsZAg--.14832S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxqjgUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDx67o2dlp5bPiwAAs+



On 2024/12/20 17:22, Markus Elfring wrote:
> …
>> Changing the integer to resource_size_t bar_size resolves this issue.
> 
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.13-rc3#n94
> 

For newcomers submitting patch in the linux kernel community for the 
first time, thanks Markus for pointing out the unreasonable expression. 
Gave me a deeper insight into the whole submission process. I will 
rephrase this sentence.

Regards
Hans

