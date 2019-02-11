Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B65C169C4
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 11:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D439420838
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 11:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LbYKvz8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfBKLgB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:36:01 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43434 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfBKLgA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Feb 2019 06:36:00 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1BBZkTn055107;
        Mon, 11 Feb 2019 05:35:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549884946;
        bh=tCHzzOSMDaTrvQTpSBKLxiA7Z7YMPY+MtGlA/N2RQMM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LbYKvz8Nmj4HGG5Pq2pTtgQE1ndWS15FrXMhWOj3Pkpf/3ngRMps4Bl5lZ5i5UTGM
         L3sq8hGSP2/fLYxdjWBPdAdzFx7ZwSOVi1r2SQw9fhbn2HwbLo+GkoYtiJX29nASVs
         vRVYa+1V49HzHWck3NamQlesP78l6LIYkygrShOQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1BBZkEo091551
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Feb 2019 05:35:46 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 11
 Feb 2019 05:35:45 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 11 Feb 2019 05:35:45 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1BBZfjJ022066;
        Mon, 11 Feb 2019 05:35:42 -0600
Subject: Re: [PATCH] PCI: endpoint: functions: use
 memcpy_fromio()/memcpy_toio()
To:     Wen Yang <wen.yang99@zte.com.cn>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <gustavo.pimentel@synopsys.com>, <niklas.cassel@axis.com>,
        <baijiaju1990@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xue.zhihong@zte.com.cn>,
        <wang.yi59@zte.com.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
References: <1549875840-10582-1-git-send-email-wen.yang99@zte.com.cn>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <2c8762eb-ea8e-7de4-cfd8-f3db2cec5d91@ti.com>
Date:   Mon, 11 Feb 2019 17:05:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549875840-10582-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/02/19 2:34 PM, Wen Yang wrote:
> Use the IO memcpy() functions when copying from/to IO memory.
> These locations were found via sparse.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Suggested-by: Kishon Vijay Abraham I <kishon@ti.com>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> CC: Niklas Cassel <niklas.cassel@axis.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> CC: linux-pci@vger.kernel.org
> CC: linux-kernel@vger.kernel.org

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 3e86fa3..4bbd26e 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -175,7 +175,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>  		goto err_map_addr;
>  	}
>  
> -	memcpy(buf, src_addr, reg->size);
> +	memcpy_fromio(buf, src_addr, reg->size);
>  
>  	crc32 = crc32_le(~0, buf, reg->size);
>  	if (crc32 != reg->checksum)
> @@ -230,7 +230,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>  	get_random_bytes(buf, reg->size);
>  	reg->checksum = crc32_le(~0, buf, reg->size);
>  
> -	memcpy(dst_addr, buf, reg->size);
> +	memcpy_toio(dst_addr, buf, reg->size);
>  
>  	/*
>  	 * wait 1ms inorder for the write to complete. Without this delay L3
> 
