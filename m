Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48313C43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 01:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185232080C
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 01:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185232080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbeKSLac convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:30:32 -0500
Received: from mx01.hxt-semitech.com ([223.203.96.7]:57449 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725881AbeKSLac (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Nov 2018 06:30:32 -0500
X-ASG-Debug-ID: 1542589700-093b7e362426430001-0c9NHn
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda.hxt-semitech.com with ESMTP id YCaUFfwBa1wMAHBC (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 19 Nov 2018 09:08:21 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 19 Nov 2018 09:07:40 +0800
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1]) by
 HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1%12]) with mapi id
 15.00.1395.000; Mon, 19 Nov 2018 09:07:40 +0800
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
Date:   Mon, 19 Nov 2018 01:07:39 +0000
Message-ID: <77c4a0a9a9174e0aa5d94dada2e0be15@HXTBJIDCEMVIW01.hxtcorp.net>
References: <bcaf1d5d-23a6-d4e6-08e8-587daf6cca06@kernel.org>
 <5e88860c8426df537c5a5f2d0e6add6df8955a0f.1541574331.git.shunyong.yang@hxt-semitech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.6.155]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1542589701
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0247 1.0000 -1.8606
X-Barracuda-Spam-Score: -1.86
X-Barracuda-Spam-Status: No, SCORE=-1.86 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.62008
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,
  Would you please help to review and pull these two quirk patches to
your branch if there is no problem?

Thanks.
Shunyong.

On 2018/11/7 15:24, Yang, Shunyong wrote:
> The HXT SD4800 PCI controller does not set the Command Completed
> bit unless writes to the Slot Command register change "Control"
> bits.
> 
> This patch adds SD4800 to the quirk.
> 
> Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 7dd443aea5a5..91db67963aea 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -920,3 +920,5 @@ static void quirk_cmd_compl(struct pci_dev *pdev)
>  			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0401,
>  			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
> +DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_HXT, 0x0401,
> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
> 

