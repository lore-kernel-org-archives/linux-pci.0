Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40034C04EB8
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 02:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AA72146D
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 02:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7AA72146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeLGCcX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:32:23 -0500
Received: from mx01.hxt-semitech.com ([223.203.96.7]:53870 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726007AbeLGCcX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Dec 2018 21:32:23 -0500
X-ASG-Debug-ID: 1544149933-093b7e6e7f18eb0001-0c9NHn
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda.hxt-semitech.com with ESMTP id ScKxDprNxAPQ9WMJ (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 07 Dec 2018 10:32:13 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 7 Dec 2018 10:31:23 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Fri, 7 Dec 2018 10:31:23 +0800
From:   "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To:     "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "okaya@kernel.org" <okaya@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Add HXT quirk for Command Completed
 errata
Thread-Topic: [PATCH v2 2/2] PCI: pciehp: Add HXT quirk for Command Completed
 errata
X-ASG-Orig-Subj: Re: [PATCH v2 2/2] PCI: pciehp: Add HXT quirk for Command Completed
 errata
Thread-Index: AQHUdmrzK+cv2Db6mkeg7e7p7Mrs0A==
Date:   Fri, 7 Dec 2018 02:31:23 +0000
Message-ID: <b29b88482324443e91b45e8557faee9c@HXTBJIDCEMVIW02.hxtcorp.net>
References: <bcaf1d5d-23a6-d4e6-08e8-587daf6cca06@kernel.org>
 <5e88860c8426df537c5a5f2d0e6add6df8955a0f.1541574331.git.shunyong.yang@hxt-semitech.com>
 <77c4a0a9a9174e0aa5d94dada2e0be15@HXTBJIDCEMVIW01.hxtcorp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.6.172]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1544149933
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.1309 1.0000 -1.2107
X-Barracuda-Spam-Score: -1.21
X-Barracuda-Spam-Status: No, SCORE=-1.21 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.63220
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,
  Gentle ping for these two ID and quirk patches. Would you please help
to review and pull?
  Our PCI id is already registered at PCI SIG, following is the link,
    https://pcisig.com/membership/member-companies?combine=1dbf

Thanks.
Shunyong.
On 2018/11/19 9:07, Yang, Shunyong wrote:
> Hi, Bjorn,
>   Would you please help to review and pull these two quirk patches to
> your branch if there is no problem?
> 
> Thanks.
> Shunyong.
> 
> On 2018/11/7 15:24, Yang, Shunyong wrote:
>> The HXT SD4800 PCI controller does not set the Command Completed
>> bit unless writes to the Slot Command register change "Control"
>> bits.
>>
>> This patch adds SD4800 to the quirk.
>>
>> Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
>> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
>>
>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>> index 7dd443aea5a5..91db67963aea 100644
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -920,3 +920,5 @@ static void quirk_cmd_compl(struct pci_dev *pdev)
>>  			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
>>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0401,
>>  			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
>> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_HXT, 0x0401,
>> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
>>
> 
> 

