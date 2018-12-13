Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B9FC65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 11:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E317820870
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 11:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TjtAUMqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E317820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbeLMLxr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:53:47 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:58748 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbeLMLxq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2018 06:53:46 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 545CD24E23AD;
        Thu, 13 Dec 2018 03:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544702026; bh=66br7oGUHvxE9Jy7OQLA2c/aeJLuRbAM/viNn1aoepo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=TjtAUMqd3UG/jXoG4lVy3P45x/dP5cRghfljpLK98In1Mg5IwE1BQOQZ89PraBb2I
         g0QVbZa5eJHVapD3LBi90opsop8vAGUG2hpaHIdw0FSoSM9hljz75JeMFp9jlFvV71
         a+thv4tsqqfNFMEqmMJme5hOTyh8IjYqJKPF6noCQ/ovZJCUVDKx8iL1ReVghJIzQ+
         pjqTC8hw0F8se7Z735w3PSHldUaCWyKJJh9kPpi/bjWn/QM4M9aaEHSt2XQ9UfOIcq
         DnGz59b5+ziKijWIpi5MOOZFjch3oOzBxZztJMA0KTC+NXzQZPf7J7Y3BVRDYpyYgZ
         bcULG4SMzwvVQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 20524353D;
        Thu, 13 Dec 2018 03:53:46 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 13 Dec 2018 03:53:37 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 13 Dec 2018 12:53:34 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 13 Dec 2018 12:53:34 +0100
Subject: Re: [RFC 6/6] pci: pci_ids: Add Synopsys device id 0xedda
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Kishon Vijay Abraham I" <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
 <df5417ded1e55e5f994ab0ec7f696ddba83eaa35.1544610287.git.gustavo.pimentel@synopsys.com>
 <20181212230345.GN99796@google.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <5fa633ea-3a85-6915-f003-ed6c0d8fe9ad@synopsys.com>
Date:   Thu, 13 Dec 2018 11:49:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181212230345.GN99796@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 12/12/2018 23:03, Bjorn Helgaas wrote:
> On Wed, Dec 12, 2018 at 12:13:26PM +0100, Gustavo Pimentel wrote:
>> Create and add Synopsys device id (0xedda) to pci id list, since this id
>> is now being use on two different drivers (pci_endpoint_test.ko and
>> dw-edma-pcie.ko).
> 
> Please run "git log --oneline include/linux/pci_ids.h" and make your
> subject line match, i.e.,
> 
>   PCI: Add Synopsys endpoint EDDA Device ID
> 
> Also, if you want, you can reorder this to add the ID first and use it
> in drivers/misc/pci_endpoint_test.c, and then just use it from the
> first appearance of drivers/dma/dw-edma/dw-edma-pcie.c.  Either way is
> fine.
> 
> For the include/linux/pci_ids.h change,

Ok, I'll change it.
Thanks.

> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Joao Pinto <jpinto@synopsys.com>
>> ---
>>  drivers/dma/dw-edma/dw-edma-pcie.c | 2 +-
>>  drivers/misc/pci_endpoint_test.c   | 2 +-
>>  include/linux/pci_ids.h            | 1 +
>>  3 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>> index f29a861..50e0db4 100644
>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>> @@ -280,7 +280,7 @@ static const struct dev_pm_ops dw_edma_pcie_dev_pm_ops = {
>>  };
>>  
>>  static const struct pci_device_id dw_edma_pcie_id_table[] = {
>> -	{ PCI_DEVICE_DATA(SYNOPSYS, 0xedda, &snps_edda_data) },
>> +	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
>>  	{ }
>>  };
>>  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>> index 896e2df..d27efe838 100644
>> --- a/drivers/misc/pci_endpoint_test.c
>> +++ b/drivers/misc/pci_endpoint_test.c
>> @@ -788,7 +788,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
>>  static const struct pci_device_id pci_endpoint_test_tbl[] = {
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x) },
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x) },
>> -	{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, 0xedda) },
>> +	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, NULL) },
>>  	{ }
>>  };
>>  MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 69f0abe..57f17dd 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -2358,6 +2358,7 @@
>>  #define PCI_DEVICE_ID_CENATEK_IDE	0x0001
>>  
>>  #define PCI_VENDOR_ID_SYNOPSYS		0x16c3
>> +#define PCI_DEVICE_ID_SYNOPSYS_EDDA	0xedda
>>  
>>  #define PCI_VENDOR_ID_VITESSE		0x1725
>>  #define PCI_DEVICE_ID_VITESSE_VSC7174	0x7174
>> -- 
>> 2.7.4
>>

