Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12C5C282C2
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 15:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47AC2073F
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 15:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfBGP3s (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:29:48 -0500
Received: from mxpout01.htp-tel.de ([212.59.41.8]:55880 "EHLO
        mxpout01.htp-tel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfBGP3r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2019 10:29:47 -0500
X-Greylist: delayed 769 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Feb 2019 10:29:42 EST
Received: from mxpin01.htp-tel.de (a212594129.net-htp.de [212.59.41.29])
        by mxpout01.htp-tel.de with ESMTPS id x17FGmZp015677
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Feb 2019 16:16:48 +0100 (CET)
Received: from esd-s3.esd.local (a81-14-233-218.net-htp.de [81.14.233.218])
        by mxpin01.htp-tel.de with ESMTPS id x17FGlkp002250
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 7 Feb 2019 16:16:48 +0100 (CET)
Received: from [10.0.15.20] (10.0.15.20) by esd-s3.esd.local (10.0.0.66) with
 Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 7 Feb 2019 16:15:56 +0100
Subject: Re: [PATCH 1/1] PCI/ASPM: Add a fix for an erratum of the
 PI7C9X111SLB PCI-to-PCIe bridge
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20181101192229.48352-1-stefan.maetje@esd.eu>
 <20190130232605.GN229773@google.com>
From:   =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=Stefan.Maetje@esd.eu; prefer-encrypt=mutual; keydata=
 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
 lTBX0HDtN8Ei0Wx1KzpNu00=
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <ad23dead-415a-5b6d-5226-431891e61459@esd.eu>
Date:   Thu, 7 Feb 2019 16:16:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130232605.GN229773@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (mxpin01.htp-tel.de [172.19.12.4]); Thu, 07 Feb 2019 16:16:48 +0100 (CET)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Björn,

I'm happy that you come back to my problem report.

Am 31.01.19 um 00:26 schrieb Bjorn Helgaas:
> Hi Stefan,
> 
> On Thu, Nov 01, 2018 at 08:22:29PM +0100, Stefan Mätje wrote:
>> Due to an erratum in the Pericom PI7C9X111SLB bridge in reverse mode the
>> retrain link bit needs to be cleared again manually to allow the link
>> training to succeed.
>>
>> If it is not cleared manually the link training is continuously restarted
>> and all devices below the PCI-to-PCIe bridge can't be accessed any more.
>> That means drivers for devices below the bridge will be loaded but won't
>> work or even crash because the driver is only reading 0xffff.
>>
>> See also the Pericom Errata Sheet PI7C9X111SLB_errata_rev1.2_102711.pdf.
> 
> Is there a public URL for this?

There is no public URL to download that errata sheet. Because Pericom has been
acquired by Diodes Inc. all information has to be downloaded from their web site.
Following the link below you can find a datasheet and there is a button to 
request additional documents like the errata sheet for instance.

https://www.diodes.com/products/connectivity-and-timing/pcie-packet-switchbridges/pcie-pci-bridges/part/PI7C9X111SL#tab-details

> Are there any bug reports for which you could include URLs?

I'm sorry. Last November when I found the bug my Internet searches turned up at least one
other victim of that bug, but I don't find it again now.

>> Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
>> ---
>>  drivers/pci/pcie/aspm.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 5326916715d2..89a245023aa9 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -268,6 +268,15 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
>>  	/* Retrain link */
>>  	reg16 |= PCI_EXP_LNKCTL_RL;
>>  	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
>> +	if (0x12d8 == parent->vendor && 0xe111 == parent->device) {
>> +		/*
>> +		 * Due to an erratum in the Pericom PI7C9X111SLB bridge in
>> +		 * reverse mode the retrain link bit needs to be cleared
>> +		 * again manually to allow the link training to succeed.
>> +		 */
>> +		reg16 &= ~PCI_EXP_LNKCTL_RL;
>> +		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> 
> There's no timing constraint, e.g., PCI_EXP_LNKCTL_RL doesn't have to be
> maintained for some minimum time before being cleared?

There is no timing constraint. I will quote here the errata sheet. It says:

E6: 	In Reverse Mode, retrain Link bit is not cleared automatically; this bit
	needs to be cleared manually by configuration write after it is set.

Problem:
	In Reverse mode, after setting Retrain Link (bit 5 of register C0h), this bit will stay on
	and PI7C9x111SL will continuously retrain until this bit is cleared by another
	Configuration Write to register C0h.
Workaround:
	Issue another configuration write to clear Retrain Link bit after setting this bit. No delay
	is required between these two configuration write.

>> +	}
> 
> Sinan suggested a quirk, which I think is a good idea.  Possible
> implementation:
> 
>   - add a pcie_retrain_link() interface (internal to PCI core, maybe even
>     internal to aspm.c)
>   - call pcie_retrain_link() from pcie_aspm_configure_common_clock()
>   - add a pci_dev.clear_retrain_link:1 bit
>   - set the bit in a quirk
>   - test the bit in pcie_retrain_link()

Thank you for depicting possible way on how to implement that in more detail. This makes it much
more clear to me.

But it will take some time for me to come up with a patch implemented in that style because I'm
very busy with a complete different project.

>>  	/* Wait for link training end. Break out after waiting for timeout */
>>  	start_jiffies = jiffies;
>> -- 
>> 2.15.0

Best regards,
	Stefan

