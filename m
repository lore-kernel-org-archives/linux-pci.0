Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0A314AD0D;
	Wed,  1 Jul 2026 06:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887733; cv=none; b=NdJMY6aYcFnp4olqBpwN3PbSPrnp306rGd8ywQJAgovR/2N6WD5ez4Bj+najWhL5eHwAaP4KFDxCLi6MlYKqilGjKIHyyPCbjhP6/obxAoxb5PbcCXIYm2i4g4lGV7pborZfvCerabyOr6MC3dTN7kSoK96SRfo6zplKM8RjDp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887733; c=relaxed/simple;
	bh=zI04UAsaaWVrZy+X4Boq+QPVG8kLxopZQhRjPwT4f4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/GED0I9UUK0pYWTXXu/jwN07umkj7oZpNyE1zreqCuwByyQrDweB6RJkEssAs9fS9UC2CKfQxdoSuZHmXx7MeXRi8WlRzzucnOl9Bd/HrpXqyMOeJaBDn7erYChF84X3WPdXscpt9wTNnZmqHXeeupc9yrN80DCMbTQM4LO7CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MhlVdpsd; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MhlVdpsd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=njQinEVkgusGfhyF8rTIvEV8bWJr0jZJFCVJKhLlkLA=;
	b=MhlVdpsdNTk4MMJljTKz00OOEARaQ0YV96sDk3dR/w46xcI9LaPCUIocMsRD2O
	4C4jvoJrubiUigoKIaXodmHtSWlediDAx8zFQ1/JTV8QICP7TOIwpTAfsDzjVPO0
	UfPhhRFiL7vNoUQCJjjhWVysrQvUZ5+qomhXnhtlzL1QY=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBHP88QtURquL94HA--.9803S2;
	Wed, 01 Jul 2026 14:34:56 +0800 (CST)
Message-ID: <03fce02c-7a6e-4679-bc8b-fb9ff50d977d@163.com>
Date: Wed, 1 Jul 2026 14:34:55 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] PCI: Add public pcie_valid_speed() for shared
 validation
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: mani@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
 kw@linux.com, kwilczynski@kernel.org, ilpo.jarvinen@linux.intel.com,
 jingoohan1@gmail.com, robh@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
References: <20260622171646.GA681416@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260622171646.GA681416@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHP88QtURquL94HA--.9803S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrykJF13AryDZFWfGr1fXrb_yoW5Aryxpa
	98JFyYyF18Xw15Ar4qq3W8XFyYyas3trW8ury5J347XFnIyrnxJFy5tFWj9rn2qr4UAF18
	Z3WYyF1fCr1jyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUDGrUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xAdwGpEtRAwUwAA3O



On 6/23/26 01:16, Bjorn Helgaas wrote:
> On Fri, Jun 19, 2026 at 11:33:11PM +0800, Hans Zhang wrote:
>> On 6/15/26 23:17, Hans Zhang wrote:
>>> On 6/12/26 01:23, Bjorn Helgaas wrote:
>>>> On Tue, Apr 07, 2026 at 09:04:48PM +0800, Hans Zhang wrote:
>>>>> Extract the PCIe speed validation logic from bwctrl.c's static
>>>>> pcie_valid_speed() into a public static inline function in pci.h.
>>>>>
>>>>> This allows consistent speed range checks (2.5GT/s to 64.0GT/s) across
>>>>> multiple drivers and functions, avoiding duplicate code and ensuring
>>>>> validation consistency as per PCIe specifications.
>>>>>
>>>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>>>> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>>
>>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>
>>>> Any objection, Ilpo?
>>>>
>>>> It looks like 1/3 and 2/3 are pure moves, and the interesting part is
>>>> the use in dwc, which I'd like to be reviewed and applied by Mani.
>>>
>>> Hi Mani,
>>>
>>> Gentle ping on this series. Please apply it when you have time. Thank
>>> you very much!
>>
>> Hello Mani,
>>
>> May I check if there is still window to merge it into v7.2-RC1?
> 
> There is not.  Unless there's some catastrophe the bits in pci/next
> are what will be in v7.2-rc1 (I will update some merge commit logs,
> but "git diff 40e92a5476e7 pci/next" should be empty).

Hello Mani,

Please apply this series when you have time. Thank you very much!

Best regards,
Hans

> 
>>>>> ---
>>>>>    drivers/pci/pci.h         | 5 +++++
>>>>>    drivers/pci/pcie/bwctrl.c | 5 -----
>>>>>    2 files changed, 5 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>>> index 4a14f88e543a..f0a082bfd6f1 100644
>>>>> --- a/drivers/pci/pci.h
>>>>> +++ b/drivers/pci/pci.h
>>>>> @@ -606,6 +606,11 @@ void pci_bus_put(struct pci_bus *bus);
>>>>>         (speed) == PCIE_SPEED_2_5GT  ?  2500*8/10 : \
>>>>>         0)
>>>>> +static inline bool pcie_valid_speed(enum pci_bus_speed speed)
>>>>> +{
>>>>> +    return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
>>>>> +}
>>>>> +
>>>>>    static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
>>>>>    {
>>>>>        switch (speed) {
>>>>> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
>>>>> index c4c8d260bf96..ea82e326f164 100644
>>>>> --- a/drivers/pci/pcie/bwctrl.c
>>>>> +++ b/drivers/pci/pcie/bwctrl.c
>>>>> @@ -48,11 +48,6 @@ struct pcie_bwctrl_data {
>>>>>    /* Prevent port removal during Link Speed changes. */
>>>>>    static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
>>>>> -static bool pcie_valid_speed(enum pci_bus_speed speed)
>>>>> -{
>>>>> -    return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
>>>>> -}
>>>>> -
>>>>>    static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
>>>>>    {
>>>>>        static const u8 speed_conv[] = {
>>>>> -- 
>>>>> 2.34.1
>>>>>
>>>
>>

