Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC9234CFC4
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 23:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777938373; cv=none; b=KahwbRNrhlWr6egwse5qHyqyVs/5F1Y1aL8ie5OYexFqHMrkdFCjy7fZ5Cfzp/KZaMjNER2+hQQgCHPmt7H9Jlb+QmQC3A//4hoKdGFfFGy31BW2gxjGPwETrfjJtATyMN2ZGCJaFmeW8Fp4ni8shadBFtTOdWXiSn8ExB8JQV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777938373; c=relaxed/simple;
	bh=dtd96popeIqRCLlEoHEljSVU4eBfwabpBTPPeSA4SOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fl1KQR9BQ0xTISDYjpRsgp6CXt1SOGucVEyFZ7qoKyd3mrYZ10AYZOgtpssM05UwWxcIZdbdDbFCedXpVjoeDfSMHyIbGayOf34aAy07/Mu4jTW0t+sk0Dgg8HpHvs7tfO0m+mwaRDe3cDlAoyzkdIEIg1EFyuEu87eGSL7NJeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BBMgmrM7; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BBMgmrM7"
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-50e5bea4045so38933231cf.3
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2026 16:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777938371; x=1778543171;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tq2bh31wVJEqzkyFJlgDPXd4ErLVOZNLSFfdQyUd90s=;
        b=XEEU4G11SAUzCrM8gy5E9TM4XCPQ0AWMFfMQK2r0THqSXxN4XTC0nAttyi9ijSn+DF
         8tCqnvFA+zK2IDE0itzy7k8OuJWrOXJDeDbM/1oRe37kaOXLd/R+ZQka4BPWeyPJcTOF
         d5/nvVEBm+K7WMhNY1flsccO4rilSwYwiJl6Urs3S1mS6iWB+xoM7/jC5pWrxvC1OO0o
         B3XQx7F1z8zQoSegHYjwUmSNECI4rocEJsYIdzc9TQh+65Sp0fKSaHNto8bif0HbNrEB
         fwWud21ltilnKSxZLzIHEvOL6OLjCJge2gogcn4UkTVuxYrmbV5/zoGs092dYhBp3z97
         vhZA==
X-Gm-Message-State: AOJu0YzWC87o+UpA2wn9L4ekT2a9dKr7wvH89IgaLHcgu2ERT+F0lzFt
	UDdQuRtB5OIAjKYl4jLEgkA6L+T4Sdg98I+rULBibrNXBxJCsST/xGOuke21WxyhIX4zJVLUrE/
	WFCwyyxqgPREJ90dUuKGdwvFIEWhuiAce5+UIPLu5qzbKV0zjUoND95qMvHtEZVmAgoQc02WL97
	tXm18aib5wuh60bU4oIgXsCoiXnM+7IK4McK+OUdfm+7xOQwblskvRj9qFkGGHOiwM2LYUSe5/O
	PU+iESlvA5jUKKsGHFH
X-Gm-Gg: AeBDieu1yLtGeVrjGHtWOgCUgkW2wX0CLp3e5WtPpzRBSUCq9OwgEMEiO/x8Dek0VII
	r3WPsfAMuaun8Yw2Orx0yG2uQB/wwqF9YiOgpWqZAz8ZOnUU0ZsIY+GLUMwjzjQWuOiNafT0pgu
	F2EE6snePnpekiVejVnri+Lj1e5UmAqA9TEPYNF9EBTCmCeYdWKIXHX/gXa+ETrILYZwjXxWvDW
	83cWykF6A7MlEbfpV+UhjfjxTDNrzxz6RnFDRTXWJzkniXKUJHpFA5oiZ686p6AoRyxtHpRN4rk
	8vJK0Vc0/5sNuMgtMsHFr5mG18tfD6LSbJhGf4QHvvOtx9G5vTUC9F+C0b0nYJ62L/aDdABKcb9
	Yz/4BW7ELYR/ozgCG8X1lNgDzjYfdvMfUn7dMq9WgvB9yRMPVrXIQkphSljmfjGmssHi8ddRnkD
	vd0JcqLd4BssOP3I2ajGhbJbXVEn0X1Ili2uvKdFoKRLz5RJLNbf7/mMy9Zj7Fp4Patqpkax+y
X-Received: by 2002:a05:622a:8405:10b0:50f:b17d:7e53 with SMTP id d75a77b69052e-512d32c80a0mr82029211cf.47.1777938370771;
        Mon, 04 May 2026 16:46:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-51040867bc5sm6344011cf.2.2026.05.04.16.46.09
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 16:46:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50fb3c7b989so86557131cf.0
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2026 16:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777938368; x=1778543168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tq2bh31wVJEqzkyFJlgDPXd4ErLVOZNLSFfdQyUd90s=;
        b=BBMgmrM7QzOF2Eytq5s01ZIrCgWgNJayfIdPoZk7OkJejhky4MyV2XEgDXOyMI8x44
         dtX6QZaFcE/dkFyn9t59drzzvOXul00ILLo5Q8JvSG5Movc3n944Oa7Xa9bCuNJEamz+
         YOeXtxpQnj8uMbFzXxtbpIFrM4+wS/OrnIYr8=
X-Received: by 2002:a05:622a:514:b0:510:1463:4fc3 with SMTP id d75a77b69052e-5104bcb8b83mr170265101cf.0.1777938368284;
        Mon, 04 May 2026 16:46:08 -0700 (PDT)
X-Received: by 2002:a05:622a:514:b0:510:1463:4fc3 with SMTP id d75a77b69052e-5104bcb8b83mr170264661cf.0.1777938367629;
        Mon, 04 May 2026 16:46:07 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-510416dfc75sm129427311cf.3.2026.05.04.16.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 16:46:06 -0700 (PDT)
Message-ID: <631c8f3f-3d38-42e0-b89a-64281d269bfd@broadcom.com>
Date: Mon, 4 May 2026 16:46:03 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: brcmstb: Assign pcie->gen from pcie_get_link_speed()
To: Hans Zhang <18255117159@163.com>, Bjorn Helgaas <helgaas@kernel.org>
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
 <a491a592-5576-4987-a866-a8491f8612e8@163.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <a491a592-5576-4987-a866-a8491f8612e8@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 5/4/26 10:26, Hans Zhang wrote:
> 
> 
> On 5/5/26 00:58, Florian Fainelli wrote:
>> On 5/2/26 04:40, Bjorn Helgaas wrote:
>>> On Fri, May 01, 2026 at 01:24:38PM -0700, Florian Fainelli wrote:
>>>> After commit 03f920936977 ("PCI: controller: Validate max-link-speed"),
>>>> pcie->gen stopped being assigned and as a result the established PCIe
>>>> link would stop supporting Gen3 speeds on 2712 since pcie->gen is used
>>>> to populate LnkCntl2 and LnkCap in brcm_pcie_set_gen().
>>>>
>>>> Link: https://github.com/raspberrypi/linux/issues/7343
>>>> Reported-by: Dom Cobley <popcornmix@gmail.com>
>>>> Reported-by: Phil Elwell <phil@raspberrypi.com>
>>>> Fixes: 03f920936977 ("PCI: controller: Validate max-link-speed")
>>>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>>> ---
>>>>   drivers/pci/controller/pcie-brcmstb.c | 3 +--
>>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/ 
>>>> controller/pcie-brcmstb.c
>>>> index 714bcab97b60..6138fc4bc064 100644
>>>> --- a/drivers/pci/controller/pcie-brcmstb.c
>>>> +++ b/drivers/pci/controller/pcie-brcmstb.c
>>>> @@ -2072,8 +2072,7 @@ static int brcm_pcie_probe(struct 
>>>> platform_device *pdev)
>>>>           return PTR_ERR(pcie->clk);
>>>>       ret = of_pci_get_max_link_speed(np);
>>>> -    if (pcie_get_link_speed(ret) == PCI_SPEED_UNKNOWN)
>>>> -        pcie->gen = 0;
>>>> +    pcie->gen = pcie_get_link_speed(ret);
>>>
>>> Take a look at https://sashiko.dev/#/ 
>>> patchset/20260501202438.376033-1- florian.fainelli%40broadcom.com
>>>
>>> The notes at https://github.com/raspberrypi/linux/issues/7343 assumed
>>> PCI_SPEED_UNKNOWN was 0, but in fact it is 0xff, which means you might
>>> want the more defensive patch instead.
>>>
>>> I'll be happy to replace what's on pci/for-linus if so.
>>
>> I am starting to think a revert is the simplest path forward, it's not 
>> clear what pcie_get_link_speed() brings to the table honestly.
> 
> Hi Florian,
> 
> The pcie_get_link_speed function is designed to prevent other Root Port 
> drivers from accessing the array pcie_link_speed out of bounds.

Yes, so that's useful in the first hunk of your commit where we were 
printing the link speed without checking that the 'max-link-speed' would 
be bounds check, however it is not really useful for assigning to 
pcie->gen in our case, so I would prefer the second option:


           ret = of_pci_get_max_link_speed(np);
  -       if (pcie_get_link_speed(ret) == PCI_SPEED_UNKNOWN)
  -               pcie->gen = 0;
  +       pcie->gen = (ret < 0) ? 0 : ret;

Thank you for stepping in!
-- 
Florian
