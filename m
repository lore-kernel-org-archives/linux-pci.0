Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5A91643B;
	Mon,  9 Mar 2026 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066125; cv=none; b=qb+6aOlKJaSP3KbKGEhEDbTvDu88okZXxmcV4IvJsGF1PzB7pCvWzl5k4Fr81Mn7u6V9aK9nU49ICuZ7XJKPVbftNjpNtvJL+IiKsxmvYQ1cPLTEGJn12tPpp0Ec0WoU2wfPGehyzvii3DQx+a8jMVq394Vip0WE6TsmzbvBUe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066125; c=relaxed/simple;
	bh=bdYUj3SCK0hutnPDeNE7jTJFj3Akbo+PvgM3D4lJ9x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnCMPYY1EV8EMAtQYP7HU3UpsBiyh7XS9uTzZazMucpq5ZhMX2mSW/14oJLr4+Fprd9w6PN80Q015GGZ0eI2Y/EyhkYuTJlbaYdrooUSHU82NBHbaj46atrBdV9EtOu90ssDKBNtna/fyHiaZxrGciHBRdaPfbkaO9XGbYllWKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dz4z70Ie; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dz4z70Ie"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=ZuFA4Vtu7HgToudnurMBqYGXuNDn20NxfU+yOJFGUrY=;
	b=dz4z70IeeOIJjDxjtkjjwdpkK1VsEEKPbDQM2bCs547Wx2Va9P7dVGS9XnX5OY
	x7AQQFn9zEpECvJesATwP3jf/3m7E+ANCBLqL+zjLfsoNwjudRZqWeNfV2ByrVoq
	G49H3Dnf2V4NX1H0sXeErG0j5RtEBa1ht2Csh3Ys+WhuU=
Received: from [IPV6:240e:b8f:927e:1000:792:97b4:4a20:b2d3] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3d3Vc165pubUWAA--.8534S2;
	Mon, 09 Mar 2026 22:21:17 +0800 (CST)
Message-ID: <fe101f10-a56f-49e2-bece-88461f28f460@163.com>
Date: Mon, 9 Mar 2026 22:21:17 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] PCI: of: Remove max-link-speed generation
 validation
To: Shawn Lin <shawn.lin@rock-chips.com>, lpieralisi@kernel.org,
 jingoohan1@gmail.com, mani@kernel.org, kwilczynski@kernel.org,
 bhelgaas@google.com, helgaas@kernel.org
Cc: robh@kernel.org, ilpo.jarvinen@linux.intel.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260308142629.75392-1-18255117159@163.com>
 <20260308142629.75392-2-18255117159@163.com>
 <0c558d65-edca-f3a9-9e31-01d30a206e7f@rock-chips.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <0c558d65-edca-f3a9-9e31-01d30a206e7f@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3d3Vc165pubUWAA--.8534S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw43WFWkCr1kGFyrXw1kZrb_yoW5ur1kpa
	y7Ar1Y9r1UJF45Xr47XF4rZa4jq3WrWrWUtry5CasF9wnIqrZaqFy2qF4aqF9akFykuF17
	X3WagF4UCayjyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR45l5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7B0Ttmmu112CAgAA3Z



On 2026/3/9 08:38, Shawn Lin wrote:
> 在 2026/03/08 星期日 22:26, Hans Zhang 写道:
>> The of_pci_get_max_link_speed() function currently validates the
>> "max-link-speed" DT property to be in the range 1..4 (Gen1..Gen4).
>> This imposes a maintenance burden because each new PCIe generation
>> would require updating this validation.
>>
>> Remove the range check so the function returns the raw property value
>> (or a negative error code if the property is missing or malformed).
>> Callers must now validate the returned speed against the range they
>> support.  A subsequent patch adds such validation to the DWC driver,
>> which is the primary user of this function.
>>
>> This change allows future PCIe generations to be supported without
>> modifying drivers/pci/of.c.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
>> ---
>>   drivers/pci/of.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 9f8eb5df279e..cff5fd337c2b 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -889,10 +889,11 @@ EXPORT_SYMBOL_GPL(of_pci_supply_present);
>>   int of_pci_get_max_link_speed(struct device_node *node)
>>   {
>>       u32 max_link_speed;
>> +    int ret;
> 
> Should update the comment of this function, as it states:
> "-EINVAL    - Invalid "max-link-speed" property value...
> a negative value if the * required property is not found or is invalid."
> 
> So it won't validate the speed after this patch. Perhaps it's even
> better to note the caller to take the responsiblity to validate it.
> 

Hi Shawn,

I plan to modify it as follows. If there are any mistakes, please point 
them out. Thank you very much.

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 9f8eb5df279e..fbb779a94202 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -875,8 +875,9 @@ EXPORT_SYMBOL_GPL(of_pci_supply_present);
   * of_pci_get_max_link_speed - Find the maximum link speed of the 
given device node.
   * @node: Device tree node with the maximum link speed information.
   *
- * This function will try to find the limitation of link speed by finding
- * a property called "max-link-speed" of the given device node.
+ * This function will try to read the "max-link-speed" property of the 
given
+ * device tree node. It does NOT validate the value of the property (e.g.,
+ * range checks for PCIe generations).
   *
   * Return:
   * * > 0	- On success, a maximum link speed.
@@ -889,10 +890,11 @@ EXPORT_SYMBOL_GPL(of_pci_supply_present);
  int of_pci_get_max_link_speed(struct device_node *node)
  {
  	u32 max_link_speed;
+	int ret;

-	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
-	    max_link_speed == 0 || max_link_speed > 4)
-		return -EINVAL;
+	ret = of_property_read_u32(node, "max-link-speed", &max_link_speed);
+	if (ret)
+		return ret;

  	return max_link_speed;
  }


Best regards,
Hans

>> -    if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
>> -        max_link_speed == 0 || max_link_speed > 4)
>> -        return -EINVAL;
>> +    ret = of_property_read_u32(node, "max-link-speed", &max_link_speed);
>> +    if (ret)
>> +        return ret;
>>       return max_link_speed;
>>   }
>>

