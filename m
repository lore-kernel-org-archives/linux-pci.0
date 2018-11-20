Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF55C43610
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 10:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E1120C01
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 10:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E1120C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeKTUs6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:48:58 -0500
Received: from mx01.hxt-semitech.com ([223.203.96.7]:40778 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726923AbeKTUs6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Nov 2018 15:48:58 -0500
X-ASG-Debug-ID: 1542709221-093b7e36243c520001-0c9NHn
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda.hxt-semitech.com with ESMTP id HTInTUSZGEBVowlE (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 20 Nov 2018 18:20:21 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) by
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 20 Nov 2018 18:19:40 +0800
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1]) by
 HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1%12]) with mapi id
 15.00.1395.000; Tue, 20 Nov 2018 18:19:40 +0800
From:   "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To:     Keith Busch <keith.busch@intel.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "okaya@kernel.org" <okaya@kernel.org>,
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
Date:   Tue, 20 Nov 2018 10:19:39 +0000
Message-ID: <66917a57b8ca46bcbabb40934d6b374f@HXTBJIDCEMVIW01.hxtcorp.net>
References: <bcaf1d5d-23a6-d4e6-08e8-587daf6cca06@kernel.org>
 <5e88860c8426df537c5a5f2d0e6add6df8955a0f.1541574331.git.shunyong.yang@hxt-semitech.com>
 <20181119161642.GA26595@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.6.155]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1542709221
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4410 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.62093
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Keith,

Following is the discussion adding the first quirk in this file,

https://lore.kernel.org/lkml/8770820b-85a0-172b-7230-3a44524e6c9f@molgen.mpg.de/T/#u


From the discussion, I guess putting the code here is to make it just
the quirk for pcie hotplug.

Thanks.
Shunyong.
On 2018/11/20 0:19, Keith Busch wrote:
> On Wed, Nov 07, 2018 at 03:25:05PM +0800, Shunyong Yang wrote:
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
> 
> I guess you're just appending to where this quirk is already defined,
> but why are the quirks even in the core driver instead of pci/quirks.c?
> 

