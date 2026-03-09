Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4635C3D413B;
	Mon,  9 Mar 2026 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067692; cv=none; b=rRtnCM4rjocIirv9wk+1tRB4GJjJg+fMFxQEGVBPCFWBRy4I8IuYbbFCPlMYrFpyylRyQ0qNHL4q2e0sG8fO14UIAR4/gKeF/UNLsChcC3czZ52ddWt5sygzcp2kkxL7ruCYr8fpv7q0SmWlTqgGdtjDp5ArdbrlKz94J2jUFi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067692; c=relaxed/simple;
	bh=BABLSLpDCdn9A6xWZALRPtCtLMEEBGkA9tMZSkGtedE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfilKl62WHo1VnmYjZZaeM5dtioZwsoVSer5T+N93K0m2e7RNRC22LEMfallyaq4lYYCZ8aZBjGO24zWThTV0DQ3UuMg8cEZHF2bnvVhI5iIHo1B7FY3pw09f8McF7f40Gz6Ud5a59A8lhlRbMxSDlfL7GItTbaOww42M7j0JhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ouVA5WlA; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ouVA5WlA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=DdpWWlfEkH4+L6fqoMwXc4vkecQDDvJZ3mr6vVdOkXs=;
	b=ouVA5WlA0XW3GeIBbuaqL8tMA2ZwTXQtZ2cZsEyoWl4aqANLs2I6qLCBr7URDv
	PbQJaFcfBNhbvh7OcHni3ClJWIWqt9vaYzm13SzGwUHCx1/R+5MaSKes7vBXJWbU
	cxexIk/7MuZzYQtr2Yxr+Ne8woLqji/HCICHNO/xksnvc=
Received: from [IPV6:240e:b8f:927e:1000:792:97b4:4a20:b2d3] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD354aK3a5p6GgWAA--.9596S2;
	Mon, 09 Mar 2026 22:47:39 +0800 (CST)
Message-ID: <bda5aca3-bf8c-483a-a48f-165202f3af7a@163.com>
Date: Mon, 9 Mar 2026 22:47:38 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] PCI: of: Remove max-link-speed generation
 validation
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: lpieralisi@kernel.org, jingoohan1@gmail.com, kwilczynski@kernel.org,
 bhelgaas@google.com, helgaas@kernel.org, robh@kernel.org,
 ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260308142629.75392-1-18255117159@163.com>
 <20260308142629.75392-2-18255117159@163.com>
 <movonqoagqttbph3hrcmjzeqioascuktwx6btk6rci5menjnxc@5ydgeu5h2ig7>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <movonqoagqttbph3hrcmjzeqioascuktwx6btk6rci5menjnxc@5ydgeu5h2ig7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD354aK3a5p6GgWAA--.9596S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr4ftw4UAr17XFy5uw1kGrg_yoW8WF18pF
	4UGF1F9ayDGrWrAr92gF45A3WF9rn7J3y7Jr95Gw1YvrsxXr4Iqr129F4Yvry7uF95CrW2
	qa1avF4v9FZ0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR7Cz_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AufQ2mu3YsWuAAA3E



On 2026/3/9 19:47, Manivannan Sadhasivam wrote:
> On Sun, Mar 08, 2026 at 10:26:28PM +0800, Hans Zhang wrote:
>> The of_pci_get_max_link_speed() function currently validates the
>> "max-link-speed" DT property to be in the range 1..4 (Gen1..Gen4).
>> This imposes a maintenance burden because each new PCIe generation
>> would require updating this validation.
>>
>> Remove the range check so the function returns the raw property value
>> (or a negative error code if the property is missing or malformed).
>> Callers must now validate the returned speed against the range they
>> support.  A subsequent patch adds such validation to the DWC driver,
>> which is the primary user of this function.
>>
>> This change allows future PCIe generations to be supported without
>> modifying drivers/pci/of.c.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> I take my Ack back. If we decide to go with validating DTS properties (which is
> fine though for non-resources such as clocks), then we should make sure that it
> happens in a single patch.
> 
> Right now, you remove the check in one patch and add it back in another. That
> leaves a window...
> 

Hi Mani,

For the second patch in this series, I made the changes based on Bjorn's 
comments. Maybe I misunderstood something.

Bjorn's reply:
https://lore.kernel.org/linux-pci/20260306170856.GA107733@bhelgaas/

May I ask if I should place the second patch on top of the first one? Is 
it just a matter of swapping the order of the two patches? Do you have 
any good methods?

Best regards,
Hans

> - Mani
> 

