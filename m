Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579F7C4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 07:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2910B20882
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 07:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uUjYa2MP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfDDHni (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:43:38 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46724 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfDDHni (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 03:43:38 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x347hTGA064131;
        Thu, 4 Apr 2019 02:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554363809;
        bh=j1tJfLJ9K3b+a/cwVN/Xnyt70KNgMDwu+dzIRENh08w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uUjYa2MPeVCkCRBNp1O27ggyqpInZg3T3NbKO9+UCG0hArheaKYxnCOm57joKdtlV
         o6pQjKu7wSihZo/5m5YxhnIPFFpifyYwsnqUOkbQP4T7+q7vWFHmgiVV0gPD4snO+c
         El8e0H40SCITMARyxG8BbhZspXtRV7bVrjXSi6jQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x347hTWg010231
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Apr 2019 02:43:29 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 4 Apr
 2019 02:43:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 4 Apr 2019 02:43:28 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x347hOQ5113095;
        Thu, 4 Apr 2019 02:43:26 -0500
Subject: Re: [PATCH v5 8/8] PCI: dwc: Do not write to MSI control registers if
 the platform doesn't use it
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190321095927.7058-1-kishon@ti.com>
 <20190321095927.7058-9-kishon@ti.com> <20190403171902.GB3783@red-moon>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7fb6436b-133b-0345-c8de-02fa77ebcf4d@ti.com>
Date:   Thu, 4 Apr 2019 13:12:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403171902.GB3783@red-moon>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 03/04/19 10:49 PM, Lorenzo Pieralisi wrote:
> On Thu, Mar 21, 2019 at 03:29:27PM +0530, Kishon Vijay Abraham I wrote:
>> Platforms which populate msi_host_init, has it's own MSI controller
>> logic. Writing to MSI control registers on platforms which doesn't use
>> Designware's MSI controller logic might have side effects. To
>> be safe, do not write to MSI control registers if the platform uses
>> it's own MSI controller logic instead of Designware's MSI controller
>> logic.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../pci/controller/dwc/pcie-designware-host.c | 24 ++++++++++---------
>>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> This patch is needed regardless of the rest of the series, correct ?
> A.k.a. it is fixing an issue already in the mainline.

That's correct.

Thanks
Kishon
