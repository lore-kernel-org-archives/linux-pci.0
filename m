Return-Path: <SRS0=VxNY=NN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63196C32789
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 11:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1145420657
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 11:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1145420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=esd.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbeKBUPo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:15:44 -0400
Received: from mxpout02.htp-tel.de ([212.59.41.9]:41661 "EHLO
        mxpout02.htp-tel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbeKBUPo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Nov 2018 16:15:44 -0400
Received: from mxpin01.htp-tel.de (a212594129.net-htp.de [212.59.41.29])
        by mxpout02.htp-tel.de with ESMTPS id wA2B8kl5013140
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Nov 2018 12:08:46 +0100 (CET)
Received: from esd-s3.esd.local (a81-14-233-218.net-htp.de [81.14.233.218])
        by mxpin01.htp-tel.de with ESMTPS id wA2B8kwn019801
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 2 Nov 2018 12:08:46 +0100 (CET)
Received: from [10.0.15.20] (10.0.15.20) by esd-s3.esd.local (10.0.0.66) with
 Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 2 Nov 2018 12:07:47 +0100
Subject: Re: [PATCH 1/1] PCI/ASPM: Add a fix for an erratum of the
 PI7C9X111SLB PCI-to-PCIe bridge
To:     Sinan Kaya <okaya@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20181101192229.48352-1-stefan.maetje@esd.eu>
 <626f2816-5f2b-b611-6177-d393ef0cdd0e@kernel.org>
From:   =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=Stefan.Maetje@esd.eu; prefer-encrypt=mutual; keydata=
 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
 JqAgHQ==
Message-ID: <64feebd1-8d14-8c9d-1054-6b26934e0979@esd.eu>
Date:   Fri, 2 Nov 2018 12:08:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <626f2816-5f2b-b611-6177-d393ef0cdd0e@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (mxpin01.htp-tel.de [172.19.12.4]); Fri, 02 Nov 2018 12:08:46 +0100 (CET)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 01.11.18 um 21:06 schrieb Sinan Kaya:
> On 11/1/2018 3:22 PM, Stefan Mätje wrote:
>> + b/drivers/pci/pcie/aspm.c
>> @@ -268,6 +268,15 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
>>   	/* Retrain link */
>>   	reg16 |= PCI_EXP_LNKCTL_RL;
>>   	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
>> +	if (0x12d8 == parent->vendor && 0xe111 == parent->device) {
>> +		/*
>> +		 * Due to an erratum in the Pericom PI7C9X111SLB bridge in
>> +		 * reverse mode the retrain link bit needs to be cleared
>> +		 * again manually to allow the link training to succeed.
>> +		 */
>> +		reg16 &= ~PCI_EXP_LNKCTL_RL;
>> +		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
>> +	}
> 
> The typical model is to abstract quirk work into quirks.c and add some
> callbacks from the actual code.

Yes, I'm aware of the quirks.c code. But I don't believe the problem can be solved
by a quirk function that is run via pci_fixup_device() at certain points of the
PCI scan (i. e. pci_fixup_pass like pci_fixup_early / pci_fixup_header ...) after 
pcie_aspm_cap_init() has run.

Let's have a look at the function pcie_aspm_cap_init() from where pcie_aspm_configure_common_clock()
is called (where the patch was included). Be aware of the fact that the PCI express link downstream 
is broken after leaving that function without the patch. But looking in pcie_aspm_cap_init() you can 
see that it is reloading the ASPM registers from the child device after returning from 
pcie_aspm_configure_common_clock() and from this point on it is working on bogus ASPM register 
contents.

Therefore I think the rest of pcie_aspm_cap_init() is doing nothing sensible for the downstream 
PCIe tree. Also I think that pcie_aspm_configure_common_clock() must be fixed in a way that after
leaving that function the PCIe downstream link is still working. This is what my patch is good for.

Best regards,
    Stefan
