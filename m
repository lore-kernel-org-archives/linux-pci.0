Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464CFC0044C
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 01:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88942083D
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 01:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88942083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbeKFK5f convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 05:57:35 -0500
Received: from mx01.hxt-semitech.com ([223.203.96.7]:34042 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729015AbeKFK5e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Nov 2018 05:57:34 -0500
X-ASG-Debug-ID: 1541468080-093b7e4bb101d80001-0c9NHn
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda.hxt-semitech.com with ESMTP id VkSwohwyxwXYdl5b (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 06 Nov 2018 09:34:40 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) by
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 6 Nov 2018 09:34:07 +0800
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1]) by
 HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1%12]) with mapi id
 15.00.1395.000; Tue, 6 Nov 2018 09:34:07 +0800
From:   "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To:     Sinan Kaya <okaya@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH] PCI: Add HXT vendor ID and ACS quirk
Thread-Topic: [PATCH] PCI: Add HXT vendor ID and ACS quirk
X-ASG-Orig-Subj: Re: [PATCH] PCI: Add HXT vendor ID and ACS quirk
Thread-Index: AQHUdLXdxwZYUqZPBkaNFsBxAdjg4g==
Date:   Tue, 6 Nov 2018 01:34:07 +0000
Message-ID: <946ea4b463a44113b6eb84f6b8e5e3f2@HXTBJIDCEMVIW01.hxtcorp.net>
References: <1541387759-2336-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <bcaf1d5d-23a6-d4e6-08e8-587daf6cca06@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.6.144]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1541468080
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.2319 1.0000 -0.6641
X-Barracuda-Spam-Score: -0.66
X-Barracuda-Spam-Status: No, SCORE=-0.66 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.61276
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Sinan,

On 2018/11/6 7:12, Sinan Kaya wrote:
> On 11/4/2018 7:15 PM, Shunyong Yang wrote:
>> Add the HXT vendor ID to pci_ids.h and use it in quirks. As the
>> design of HXT SD4800 ACS feature is the same as QCOM QDF2xxx,
>> pci_quirk_qcom_rp_acs() is reused for SD4800 quirk.
>>
>> Cc: Joey Zheng<yu.zheng@hxt-semitech.com>
>> Signed-off-by: Shunyong Yang<shunyong.yang@hxt-semitech.com>
> 
> There is also a couple of hotplug quirks for QDF2400. You should
> probably take care of those as well.
> 
> Assuming your PCI IDs are correct:
> 
> Reviewed-by: Sinan Kaya <okaya@kernel.org>
> 

Thanks for your review and information. I will check the changes.

Shunyong.
