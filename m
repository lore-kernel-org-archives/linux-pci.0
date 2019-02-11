Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B503BC282C2
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 00:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8362F2146F
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 00:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfBKAxA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 10 Feb 2019 19:53:00 -0500
Received: from [223.203.96.18] ([223.203.96.18]:33241 "EHLO
        barracuda02.hxt-semitech.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726029AbfBKAxA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Feb 2019 19:53:00 -0500
X-ASG-Debug-ID: 1549846375-107606139f22d880001-0c9NHn
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda02.hxt-semitech.com with ESMTP id WkIMzeO3k6z2ICeR (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 11 Feb 2019 08:52:55 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) by
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Feb 2019 08:52:29 +0800
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1]) by
 HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1%12]) with mapi id
 15.00.1395.000; Mon, 11 Feb 2019 08:52:29 +0800
From:   "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "okaya@kernel.org" <okaya@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH v2 1/2] PCI: Add HXT vendor ID and ACS quirk
Thread-Topic: [PATCH v2 1/2] PCI: Add HXT vendor ID and ACS quirk
X-ASG-Orig-Subj: Re: [PATCH v2 1/2] PCI: Add HXT vendor ID and ACS quirk
Thread-Index: AQHUdmrlIch2nulfZ0GbPXTu9T/GHw==
Date:   Mon, 11 Feb 2019 00:52:29 +0000
Message-ID: <6b4a41788f0d4b1c8388ebfb4d5abea4@HXTBJIDCEMVIW01.hxtcorp.net>
References: <bcaf1d5d-23a6-d4e6-08e8-587daf6cca06@kernel.org>
 <ccf67e5f70f2d09d07268a5735ac6cee801eb9ca.1541574331.git.shunyong.yang@hxt-semitech.com>
 <20190201231947.GV229773@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.6.235]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1549846375
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 2344
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4327 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.67228
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

Thank you for reminding me. I will check with our IC team for these
design issues.
Sorry for the delay as I was taking Chinese New Year holiday.

Shunyong.

On 2019/2/2 7:19, Bjorn Helgaas wrote:
> On Wed, Nov 07, 2018 at 03:24:12PM +0800, Shunyong Yang wrote:
>> Add the HXT vendor ID to pci_ids.h and use it in quirks. As the
>> design of HXT SD4800 ACS feature is the same as QCOM QDF2xxx,
>> pci_quirk_qcom_rp_acs() is reused for SD4800 quirk.
>>
>> cc: Joey Zheng <yu.zheng@hxt-semitech.com>
>> Reviewed-by: Sinan Kaya <okaya@kernel.org>
>> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> 
> I applied both of these to pci/misc for v5.1, thanks!
> 
> As I'm sure you know, both the ACS and the pciehp issues are cases where
> the part does not conform to the PCIe spec.  Hopefully future parts will
> change the design so they *do* conform to the spec so we don't have to add
> quirks for every new part.  Adding quirks works around the problem, but
> it's a hassle for customers (and developers and distributors) because they
> need kernel updates when they wouldn't otherwise.
> 
> Bjorn
> 
>> ---
>> v2:
>>   Add Reviewed-by: Sinan Kaya.
>>
>> v1:
>>   Initial version.
>> ---
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 4700d24e5d55..1e00ef6a88f4 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -4495,6 +4495,8 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
>>  	/* QCOM QDF2xxx root ports */
>>  	{ PCI_VENDOR_ID_QCOM, 0x0400, pci_quirk_qcom_rp_acs },
>>  	{ PCI_VENDOR_ID_QCOM, 0x0401, pci_quirk_qcom_rp_acs },
>> +	/* HXT SD4800 root ports. The ACS design is same as QCOM QDF2xxx */
>> +	{ PCI_VENDOR_ID_HXT, 0x0401, pci_quirk_qcom_rp_acs },
>>  	/* Intel PCH root ports */
>>  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_pch_acs },
>>  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_spt_pch_acs },
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 69f0abe1ba1a..e60a6bc38298 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -2565,6 +2565,8 @@
>>  
>>  #define PCI_VENDOR_ID_HYGON		0x1d94
>>  
>> +#define PCI_VENDOR_ID_HXT		0x1dbf
>> +
>>  #define PCI_VENDOR_ID_TEKRAM		0x1de1
>>  #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
>>  
>> -- 
>> 1.8.3.1
>>
> 

