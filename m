Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0283DFC9C;
	Mon,  4 May 2026 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777915693; cv=none; b=bvWDzejDhWS2EfG4Ab/7VtPif5jzYyuT2jVcFus2b+jemoH4RNZLZ7b/5siy8oPSgtrQrM7nEu4jShnzYjwtuM3I1htjYc6LteNKg3wvITWY1UnWFZwgibTYHCLbalCXnLg5RX9t0cY7HAneEehst8QaGdlGQIxzfcHqCWqUbKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777915693; c=relaxed/simple;
	bh=eTvOmNE2BNm1wDppi3fIZ4uvG0J+7TKuqfBE6VXCtcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkHeKpGwRgFNy/4lijIN/jEOHZ8ccFW5hc8V7epVC1Z//YhBbkXE5gSWYbQkdgdL1+ZptbKnqykMUe6StRIXdWh5+ZPE1gWWumvDKmarpomxRLX9+RflYsUC46MVUkpc6XqRmk/7mr2Pp1gurkC2web5MMKxbNFiqZBs9msNsus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jaqEnUkN; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jaqEnUkN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=/+IJ2bHq3KHL+ncW96AkfLa+YxfD/L2ZH5eAWikm96M=;
	b=jaqEnUkNVgj2cgy8SfWW9EK6v+ENe6eXlNvzSo3I0415X+x4fxY6l8Fk7Mfqor
	xH5SPnjK/Jtgqkrg87OD9Q0RHqrj4SMQfBkY7U38KcQgwMgrEidVNSLvdZb9Pu1x
	ATrSM6cykEg/+fDDxWhLRX5lFRUi7Lp8k+ZA+wE+0OorM=
Received: from [IPV6:240e:b8f:927e:5900:8c4c:fe90:544d:6d62] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3nnnY1vhpZalxDQ--.25765S2;
	Tue, 05 May 2026 01:26:49 +0800 (CST)
Message-ID: <a491a592-5576-4987-a866-a8491f8612e8@163.com>
Date: Tue, 5 May 2026 01:26:48 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: brcmstb: Assign pcie->gen from pcie_get_link_speed()
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Dom Cobley <popcornmix@gmail.com>,
 Phil Elwell <phil@raspberrypi.com>, Jim Quinlan <jim2101024@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260502114019.GA551304@bhelgaas>
 <2f453b89-0ce8-4ef3-ae93-c282a2d08fd7@broadcom.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <2f453b89-0ce8-4ef3-ae93-c282a2d08fd7@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3nnnY1vhpZalxDQ--.25765S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1Dtw17Zw1xJFW3Cr4DArb_yoWrCryrpa
	9rJa48tF18tFW5ur1jq3Z5Zw1Yg3ZxCrWUKws3Ww17uFsIy3s5KFyFkrySyF97tFZ7uw17
	X3W3tF48GF4fAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR58nrUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xqEKGn41toR3gAA3P



On 5/5/26 00:58, Florian Fainelli wrote:
> On 5/2/26 04:40, Bjorn Helgaas wrote:
>> On Fri, May 01, 2026 at 01:24:38PM -0700, Florian Fainelli wrote:
>>> After commit 03f920936977 ("PCI: controller: Validate max-link-speed"),
>>> pcie->gen stopped being assigned and as a result the established PCIe
>>> link would stop supporting Gen3 speeds on 2712 since pcie->gen is used
>>> to populate LnkCntl2 and LnkCap in brcm_pcie_set_gen().
>>>
>>> Link: https://github.com/raspberrypi/linux/issues/7343
>>> Reported-by: Dom Cobley <popcornmix@gmail.com>
>>> Reported-by: Phil Elwell <phil@raspberrypi.com>
>>> Fixes: 03f920936977 ("PCI: controller: Validate max-link-speed")
>>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>> ---
>>>   drivers/pci/controller/pcie-brcmstb.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/ 
>>> controller/pcie-brcmstb.c
>>> index 714bcab97b60..6138fc4bc064 100644
>>> --- a/drivers/pci/controller/pcie-brcmstb.c
>>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>>> @@ -2072,8 +2072,7 @@ static int brcm_pcie_probe(struct 
>>> platform_device *pdev)
>>>           return PTR_ERR(pcie->clk);
>>>       ret = of_pci_get_max_link_speed(np);
>>> -    if (pcie_get_link_speed(ret) == PCI_SPEED_UNKNOWN)
>>> -        pcie->gen = 0;
>>> +    pcie->gen = pcie_get_link_speed(ret);
>>
>> Take a look at https://sashiko.dev/#/patchset/20260501202438.376033-1- 
>> florian.fainelli%40broadcom.com
>>
>> The notes at https://github.com/raspberrypi/linux/issues/7343 assumed
>> PCI_SPEED_UNKNOWN was 0, but in fact it is 0xff, which means you might
>> want the more defensive patch instead.
>>
>> I'll be happy to replace what's on pci/for-linus if so.
> 
> I am starting to think a revert is the simplest path forward, it's not 
> clear what pcie_get_link_speed() brings to the table honestly.

Hi Florian,

The pcie_get_link_speed function is designed to prevent other Root Port 
drivers from accessing the array pcie_link_speed out of bounds.



commit 03f920936977 ("PCI: controller: Validate max-link-speed")

diff --git a/drivers/pci/controller/pcie-brcmstb.c 
b/drivers/pci/controller/pcie-brcmstb.c
index 062f55690012..714bcab97b60 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1442,7 +1442,7 @@ static int brcm_pcie_start_link(struct brcm_pcie 
*pcie)
         cls = FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta);
         nlw = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
         dev_info(dev, "link up, %s x%u %s\n",
-                pci_speed_string(pcie_link_speed[cls]), nlw,
+                pci_speed_string(pcie_get_link_speed(cls)), nlw,
                  ssc_good ? "(SSC)" : "(!SSC)");

         return 0;
@@ -2072,7 +2072,8 @@ static int brcm_pcie_probe(struct platform_device 
*pdev)
                 return PTR_ERR(pcie->clk);

         ret = of_pci_get_max_link_speed(np);
-       pcie->gen = (ret < 0) ? 0 : ret;
+       if (pcie_get_link_speed(ret) == PCI_SPEED_UNKNOWN)
+               pcie->gen = 0;




Sorry, it's my fault. Should it be changed to the following?
Florian, what do you think?



diff --git a/drivers/pci/controller/pcie-brcmstb.c 
b/drivers/pci/controller/pcie-brcmstb.c
index 714bcab97b60..9a09a48acfb5 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -2074,6 +2074,8 @@ static int brcm_pcie_probe(struct platform_device 
*pdev)
         ret = of_pci_get_max_link_speed(np);
         if (pcie_get_link_speed(ret) == PCI_SPEED_UNKNOWN)
                 pcie->gen = 0;
+       else
+               pcie->gen = ret;

         pcie->ssc = of_property_read_bool(np, "brcm,enable-ssc");



or



diff --git a/drivers/pci/controller/pcie-brcmstb.c 
b/drivers/pci/controller/pcie-brcmstb.c
index 714bcab97b60..1187e19fbe89 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -2072,8 +2072,7 @@ static int brcm_pcie_probe(struct platform_device 
*pdev)
                 return PTR_ERR(pcie->clk);

         ret = of_pci_get_max_link_speed(np);
-       if (pcie_get_link_speed(ret) == PCI_SPEED_UNKNOWN)
-               pcie->gen = 0;
+       pcie->gen = (ret < 0) ? 0 : ret;


Best regards,
Hans



