Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28891C6FA82
	for <linux-pci@archiver.kernel.org>; Fri, 23 Sep 2022 09:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiIWJUg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Sep 2022 05:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIWJUf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 05:20:35 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED68A11E942
        for <linux-pci@vger.kernel.org>; Fri, 23 Sep 2022 02:20:30 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28N9KM4c105290;
        Fri, 23 Sep 2022 04:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1663924822;
        bh=sCNsbD90Xi+xcbVK616iKJRHozDCfQcUp+/kp7N1/TI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=y3xeILJip62pfC3wBe+zICuU51ZpcQHjr5NRjpoI96kSpVxAZ7rP7LP6jkcmF8zbD
         VfEyZaAB7Q0IMIbd1ylI225TG2baJ81KBDsog7vB0qLzRoXgtbW0FaN8wXFxLzjd4y
         cQGak0kj6UMmlxfCk7tIAXQdOud3q40/aVQ1+mpk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28N9KMaf071221
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Sep 2022 04:20:22 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 23
 Sep 2022 04:20:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 23 Sep 2022 04:20:21 -0500
Received: from [172.24.147.145] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28N9KJZ7017226;
        Fri, 23 Sep 2022 04:20:20 -0500
Subject: Re: [PATCH 1/3] PCI: j721e: Add PCIe 4x lane selection support
To:     Matt Ranostay <mranostay@ti.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <tjoseph@cadence.com>, <vigneshr@ti.com>
References: <20220909201607.3835-1-mranostay@ti.com>
 <20220909201607.3835-2-mranostay@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ce9bf8e3-bfb7-5f38-39ac-3a80da2c3839@ti.com>
Date:   Fri, 23 Sep 2022 14:50:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20220909201607.3835-2-mranostay@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Matt,

On 10/09/22 1:46 am, Matt Ranostay wrote:
> Increase LANE_COUNT_MASK to two-bit field that allows selection of
> 4x lane PCIe which was previously limited to 2x lane support.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>   drivers/pci/controller/cadence/pci-j721e.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index a82f845cc4b5..62c2c70256b8 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -43,7 +43,7 @@ enum link_status {
>   };
>   
>   #define J721E_MODE_RC			BIT(7)
> -#define LANE_COUNT_MASK			BIT(8)
> +#define LANE_COUNT_MASK			GENMASK(9, 8)

The MASK value as well has to be specific to platforms. For J721E, it is 
1 bit only.

Thanks,
Kishon

>   #define LANE_COUNT(n)			((n) << 8)
>   
>   #define GENERATION_SEL_MASK		GENMASK(1, 0)
> 
