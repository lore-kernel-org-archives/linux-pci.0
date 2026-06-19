Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97621374A13;
	Fri, 19 Jun 2026 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781883243; cv=none; b=lY2GJAnq09cMzT9N+KGSQgpMizeV56WwAIPqCBKQ3REaOYO9Jkibtqusah5g7gzm0c6LzUTfWraY8dkeKRvqr/vl2uf22GksXu+apUZbGXBFXsqZ02DFeQKQvLDJGfaPzdfbrteF6XwoXUc/xAn/xQB4MjLOTSN/YsiEtgNA54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781883243; c=relaxed/simple;
	bh=aE+WACNW1UsBW8o/cWy8z5/be2h7RUailHFgjrLjWu0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZNqQG03cmaPy+LPx8cOmoLVqOksfpiaGu6nJHzOv/IBL3X0LlI34pJPOqJ6etD+Oiv1MNeqZmxblXhPheewWrDriC1m9oVq8VMnkoDVfrdoFTmPWGbhaHoiqhI7ktUnXgX+7/yxGlCXX5W3NymfiJ96yvOjq5MNahkzqyrk86ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Lr5lpOmr; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Lr5lpOmr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:To:
	Content-Type; bh=2LsTNKW584g0M2fDNV1Q7vjzp47FmOFcVmA7Y1oZ9q0=;
	b=Lr5lpOmr448eYhDYIvyALE52cTU0XBFmCqcHRKmmNmyNjPR5ecx87xwgVMLJEe
	DkQ6vqOj5QGqVeP9tahpkOXlgbfrKomeR78vHbICdleuGE3JdOGKtl7rg36dsw3C
	Lc5Mb7s2VY4/ZX9qA//68Pgfkj9VLnh7reUKwH04KOIDA=
Received: from [IPV6:240e:b8f:91b3:d000:a264:4237:512f:7b1] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDHmyc3YTVq5+NEDA--.56748S2;
	Fri, 19 Jun 2026 23:33:12 +0800 (CST)
Message-ID: <03cb3d65-c3e5-4396-9612-4e3ca8bf02f5@163.com>
Date: Fri, 19 Jun 2026 23:33:11 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] PCI: Add public pcie_valid_speed() for shared
 validation
From: Hans Zhang <18255117159@163.com>
To: mani@kernel.org
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 kwilczynski@kernel.org, ilpo.jarvinen@linux.intel.com, jingoohan1@gmail.com,
 robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <20260611172301.GA490724@bhelgaas>
 <644f5a0b-6730-445f-a537-329ac3e69cbf@163.com>
Content-Language: en-US
In-Reply-To: <644f5a0b-6730-445f-a537-329ac3e69cbf@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDHmyc3YTVq5+NEDA--.56748S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cryktw4rCFyrCF1xAw15XFb_yoW5Jr1rpa
	yDJFyYyF18Xa45ZrsFq3W0vFyYvFZ3trW8CrW3W3srZFnIyrn3JFy3KrWYgr92vrW2yF1x
	ZF1YvF1fCF4jyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR8MaOUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BhO8Wo1YTiPqgAA3o



On 6/15/26 23:17, Hans Zhang wrote:
> 
> 
> On 6/12/26 01:23, Bjorn Helgaas wrote:
>> On Tue, Apr 07, 2026 at 09:04:48PM +0800, Hans Zhang wrote:
>>> Extract the PCIe speed validation logic from bwctrl.c's static
>>> pcie_valid_speed() into a public static inline function in pci.h.
>>>
>>> This allows consistent speed range checks (2.5GT/s to 64.0GT/s) across
>>> multiple drivers and functions, avoiding duplicate code and ensuring
>>> validation consistency as per PCIe specifications.
>>>
>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>> Any objection, Ilpo?
>>
>> It looks like 1/3 and 2/3 are pure moves, and the interesting part is
>> the use in dwc, which I'd like to be reviewed and applied by Mani.
> 
> Hi Mani,
> 
> Gentle ping on this series. Please apply it when you have time. Thank 
> you very much!

Hello Mani,

May I check if there is still window to merge it into v7.2-RC1?

Best regards,
Hans


> 
> Best regards,
> Hans
> 
>>
>>> ---
>>>   drivers/pci/pci.h         | 5 +++++
>>>   drivers/pci/pcie/bwctrl.c | 5 -----
>>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>> index 4a14f88e543a..f0a082bfd6f1 100644
>>> --- a/drivers/pci/pci.h
>>> +++ b/drivers/pci/pci.h
>>> @@ -606,6 +606,11 @@ void pci_bus_put(struct pci_bus *bus);
>>>        (speed) == PCIE_SPEED_2_5GT  ?  2500*8/10 : \
>>>        0)
>>> +static inline bool pcie_valid_speed(enum pci_bus_speed speed)
>>> +{
>>> +    return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
>>> +}
>>> +
>>>   static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
>>>   {
>>>       switch (speed) {
>>> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
>>> index c4c8d260bf96..ea82e326f164 100644
>>> --- a/drivers/pci/pcie/bwctrl.c
>>> +++ b/drivers/pci/pcie/bwctrl.c
>>> @@ -48,11 +48,6 @@ struct pcie_bwctrl_data {
>>>   /* Prevent port removal during Link Speed changes. */
>>>   static DECLARE_RWSEM(pcie_bwctrl_setspeed_rwsem);
>>> -static bool pcie_valid_speed(enum pci_bus_speed speed)
>>> -{
>>> -    return (speed >= PCIE_SPEED_2_5GT) && (speed <= PCIE_SPEED_64_0GT);
>>> -}
>>> -
>>>   static u16 pci_bus_speed2lnkctl2(enum pci_bus_speed speed)
>>>   {
>>>       static const u8 speed_conv[] = {
>>> -- 
>>> 2.34.1
>>>
> 

