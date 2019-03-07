Return-Path: <SRS0=a/OH=RK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3758DC43381
	for <linux-pci@archiver.kernel.org>; Thu,  7 Mar 2019 15:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D7320840
	for <linux-pci@archiver.kernel.org>; Thu,  7 Mar 2019 15:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfCGPQe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:16:34 -0500
Received: from mxpout01.htp-tel.de ([212.59.41.8]:32836 "EHLO
        mxpout01.htp-tel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCGPQe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Mar 2019 10:16:34 -0500
Received: from mxpin01.htp-tel.de (a212594129.net-htp.de [212.59.41.29])
        by mxpout01.htp-tel.de with ESMTPS id x27FG4ij019124
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Mar 2019 16:16:04 +0100 (CET)
Received: from esd-s3.esd.local (a81-14-233-218.net-htp.de [81.14.233.218])
        by mxpin01.htp-tel.de with ESMTPS id x27FG3WY014082
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 7 Mar 2019 16:16:04 +0100 (CET)
Received: from [10.0.15.20] (10.0.15.20) by esd-s3.esd.local (10.0.0.66) with
 Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 7 Mar 2019 16:15:54 +0100
Subject: Re: [PATCH V2 1/1] PCI/ASPM: Work around link retrain errata of
 Pericom PCIe-to-PCI bridges
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "ptalbert@redhat.com" <ptalbert@redhat.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "fred@fredlawl.com" <fred@fredlawl.com>,
        "bhull@redhat.com" <bhull@redhat.com>
References: <20190305173122.11875-1-stefan.maetje@esd.eu>
 <20190306070341.GY9224@smile.fi.intel.com>
From:   =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=Stefan.Maetje@esd.eu; prefer-encrypt=mutual; keydata=
 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
 lTBX0HDtN8Ei0Wx1KzpNu00=
Message-ID: <adca5e40-f349-9692-84da-84d45ec828ca@esd.eu>
Date:   Thu, 7 Mar 2019 16:16:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306070341.GY9224@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (mxpin01.htp-tel.de [172.19.12.4]); Thu, 07 Mar 2019 16:16:04 +0100 (CET)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 06.03.19 um 08:03 schrieb Andy Shevchenko:
> On Tue, Mar 05, 2019 at 06:31:22PM +0100, Stefan Mätje wrote:
:
:
>> The patch introduces a new flag clear_retrain_link in the struct pci_dev. This
>> flag is set in quirk_enable_clear_retrain_link() for the affected devices in
>> the pci_fixup_header in quirks.c
>>
>> The link retraining code is moved to pcie_retrain_link(). This function now
>> applies the work around to clear the PCI_EXP_LNKCTL_RL bit again if
>> clear_retrain_link bit is set in the pci_dev structure of the link parent
>> device.
> 
> 
>> +	/* Wait for link training end. Break out after waiting for timeout */
>> +	start_jiffies = jiffies;
>> +	for (;;) {
>> +		pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &reg16);
>> +		if (!(reg16 & PCI_EXP_LNKSTA_LT))
>> +			break;
>> +		if (time_after(jiffies, start_jiffies + LINK_RETRAIN_TIMEOUT))
>> +			break;
>> +		msleep(1);
>> +	}
> 
> I see this is existing code, though two comments (perhaps for future clean up):
> 	- msleep(1) is not guaranteed to be 1 ms at all (in some cases it might be less)

	Even if msleep(1) would return after a very short time it would not do any harm
	here. It is only needed to do "some" sleeping in this status reading loop.

> 	- better to use do {} while (time_before()) loop

	I will change that.

> 
>> +static void quirk_enable_clear_retrain_link(struct pci_dev *dev)
>> +{
>> +	dev->clear_retrain_link = 1;
> 
>> +	pci_info(dev, "Enable Pericom link retrain quirk\n");
> 
> If some other device would appear with same issue, but from another vendor this
> becomes misleading.
> 
> I would recommend to refer to an issue the quirk is about, and not the vendor.

I think that would be better, too. I'll change that.

>> +}
> 

