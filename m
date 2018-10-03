Return-Path: <SRS0=Y6U6=MP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3C0C00449
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 08:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB21B2098A
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 08:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MqeaouCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB21B2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeJCPoG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:44:06 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43184 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeJCPoF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Oct 2018 11:44:05 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w938uYHQ065009;
        Wed, 3 Oct 2018 03:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538556994;
        bh=4qIR5l4rFUEx/ITrj+nU/Dp4Upw78PHcV2INrcf3RfM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MqeaouCe9y5gjt5EP4Apx30LayQdhQZcAFSAJLgwF3n9LsfsQ/+4MMe5bK2cD6b8Y
         rYcEL5Wj7oE1VG3VQPaxUt5vUA/Z4xIG58UMk0ING8NVzyxf1Jn1ZuL07qSVm2fdkT
         CDWpT4gYwAFGY9pTEJ34XfH4KudTMBtKlSXKClag=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w938uYi8025869;
        Wed, 3 Oct 2018 03:56:34 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 3 Oct
 2018 03:56:34 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 3 Oct 2018 03:56:34 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w938uV7s010164;
        Wed, 3 Oct 2018 03:56:32 -0500
Subject: Re: [PATCH] tools/pci: Fix compilation warnings
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <b2433aaac6ace7b1b9843b520242d9e9185d3685.1535024080.git.gustavo.pimentel@synopsys.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <05c2974e-6788-2664-2fc3-b5153bc9f834@ti.com>
Date:   Wed, 3 Oct 2018 14:26:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b2433aaac6ace7b1b9843b520242d9e9185d3685.1535024080.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On Thursday 23 August 2018 05:04 PM, Gustavo Pimentel wrote:
> Fix compilation warnings:
>  - remove unused variables
>  - change function return from int to void, since it's not used
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  tools/pci/pcitest.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> index 9074b47..8ca1c62 100644
> --- a/tools/pci/pcitest.c
> +++ b/tools/pci/pcitest.c
> @@ -23,7 +23,6 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <sys/ioctl.h>
> -#include <time.h>
>  #include <unistd.h>
>  
>  #include <linux/pcitest.h>
> @@ -43,17 +42,15 @@ struct pci_test {
>  	unsigned long	size;
>  };
>  
> -static int run_test(struct pci_test *test)
> +static void run_test(struct pci_test *test)
>  {
>  	long ret;
>  	int fd;
> -	struct timespec start, end;
> -	double time;
>  
>  	fd = open(test->device, O_RDWR);
>  	if (fd < 0) {
>  		perror("can't open PCI Endpoint Test device");
> -		return fd;
> +		return;
>  	}
>  
>  	if (test->barnum >= 0 && test->barnum <= 5) {
> 
