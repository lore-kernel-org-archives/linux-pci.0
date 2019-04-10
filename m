Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4205CC10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 08:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171F320818
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 08:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfDJIDZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:03:25 -0400
Received: from air.basealt.ru ([194.107.17.39]:44438 "EHLO air.basealt.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfDJIDY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 04:03:24 -0400
Received: by air.basealt.ru (Postfix, from userid 490)
        id 18097589B02; Wed, 10 Apr 2019 08:03:23 +0000 (UTC)
Received: from nickel-ws.localdomain (obninsk.basealt.ru [217.15.195.17])
        by air.basealt.ru (Postfix) with ESMTPSA id DC6C1589AE2;
        Wed, 10 Apr 2019 08:03:20 +0000 (UTC)
Reply-To: Nikolai Kostrigin <nickel@basealt.ru>
From:   Nikolai Kostrigin <nickel@basealt.ru>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Nikolai Kostrigin <nickel@altlinux.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        jroedel@suse.de, Alex Deucher <alexander.deucher@amd.com>
References: <20190408103725.30426-1-nickel@altlinux.org>
 <20190408103725.30426-2-nickel@altlinux.org>
 <20190409215927.GC256045@google.com>
 <8b4659c8-3f49-de62-a616-a35a1d0c68b9@basealt.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=nickel@basealt.ru; prefer-encrypt=mutual; keydata=
 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 +Q==
Organization: BaseALT
Subject: Re: [PATCH RESEND 1/1] PCI: Add ATS-disable quirk for AMD Radeon R7
 GPUs
Message-ID: <ea366789-8c9f-ecb6-15a3-9204d6826167@basealt.ru>
Date:   Wed, 10 Apr 2019 11:03:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8b4659c8-3f49-de62-a616-a35a1d0c68b9@basealt.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc] linux-kernel@, linux-pci@

10.04.2019 10:26, Nikolai Kostrigin пишет:
> Hello!
>
> 10.04.2019 00:59, Bjorn Helgaas пишет:
>> [+cc Alex]
>>
>> This claims to be a resend, but I don't see a previous posting.
> For some reason, unknown to me, my previous letter didn't appear
> neither in linux-kernel@, nor in linux-pci@ mailing lists.
I'm sorry. Now it's obvious I didn't manage to turn HTML formatting off
before.
>
>> There *was* discussion when the quirk was added two years ago for a
>> different device.  As part of that, Alex thought only that device
>> would be affected and ATS was validated on other GPUs:
>>
>>   https://lore.kernel.org/lkml/BN6PR12MB165278346BE8A76B1E4412AFF7EA0@BN6PR12MB1652.namprd12.prod.outlook.com/
> I'm aware of that and it was Joerg who pointed me to the above thread
> when I asked him for help.
> In my case both devices mentioned in quirks are present in a laptop.
> Unfortunately I have no hardware with standalone AMD R7 GPU
> (0102:6900) to check whether unpatched kernel would fail
> the same way with both ATS and IOMMU enabled.
>
>> On Mon, Apr 08, 2019 at 01:37:25PM +0300, Nikolai Kostrigin wrote:
>>> ATS is broken on this hardware (at least for Stoney Ridge
>>> based laptop) and causes IOMMU stalls and
>>> system failure. Disable ATS on these devices to make them
>>> usable again with IOMMU enabled
>>> Thanks to Joerg Roedel <jroedel@suse.de> for help.
>>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=194521
>>>
>>> Signed-off-by: Nikolai Kostrigin <nickel@altlinux.org>
>> Joerg, I'm happy to merge this if you would review or ack it.  I don't
>> know enough to conclude that this is the root cause  It'd be nice to
>> have an actual AMD erratum.  Maybe it would even have a list of
>> affected devices so we could get them all at once so people wouldn't
>> have to trip over them one by one.
>>
>>> ---
>>>  drivers/pci/quirks.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index 4700d24e5d55..abb2532e16bf 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -4876,6 +4876,7 @@ static void quirk_no_ats(struct pci_dev *pdev)
>>>  
>>>  /* AMD Stoney platform GPU */
>>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_no_ats);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_no_ats);
>>>  #endif /* CONFIG_PCI_ATS */
>>>  
>>>  /* Freescale PCIe doesn't support MSI in RC mode */
>>> -- 
>>> 2.21.0
>>>
>
> -- 
> Best regards,
> Nikolai Kostrigin

-- 
Best regards,
Nikolai Kostrigin


