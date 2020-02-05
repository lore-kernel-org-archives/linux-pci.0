Return-Path: <SRS0=seBN=3Z=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD4CC33CA1
	for <linux-pci@archiver.kernel.org>; Wed,  5 Feb 2020 09:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E6B217BA
	for <linux-pci@archiver.kernel.org>; Wed,  5 Feb 2020 09:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l61pZHWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgBEJOu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:14:50 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40662 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgBEJOu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Feb 2020 04:14:50 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0159El82089159;
        Wed, 5 Feb 2020 03:14:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580894087;
        bh=/dzRGIB8uGr8zpu8e5+MZneLAQ39NQN68abZ5LYe6Oc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=l61pZHWPSRWY6VkY0DeKKYPO9EnJuJfB15SefGEg4h+fgzxrmVZiSaP/Zmi5jNibX
         EYLpZMnWtwWEVwTKA97AKh6X2PMfX+kpCIhMjJiRPHM3TxNP6q9xM1MEfjoPYG7LO5
         Xc/KdmcwX36RrrGz1FK61dhepQo6ep7EquNPjvyE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0159Eloe125413
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Feb 2020 03:14:47 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 5 Feb
 2020 03:14:47 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 5 Feb 2020 03:14:46 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0159EjwV039695;
        Wed, 5 Feb 2020 03:14:45 -0600
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <120f7c3e-363d-deb0-a347-782ac869ee0d@ti.com>
 <20200130075833.GC30735@lst.de> <4a41bd0d-6491-3822-172a-fbca8a6abba5@ti.com>
 <20200130164235.GA6705@lst.de> <f76af743-dcb5-f59d-b315-f2332a9dc906@ti.com>
 <20200203142155.GA16388@lst.de> <a5eb4f73-418a-6780-354f-175d08395e71@ti.com>
 <20200205074719.GA22701@lst.de> <4a8bf1d3-6f8e-d13e-eae0-4db54f5cab8c@ti.com>
 <20200205084844.GA23831@lst.de>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <88d50d13-65c7-7ca3-59c6-56f7d66c3816@ti.com>
Date:   Wed, 5 Feb 2020 14:48:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200205084844.GA23831@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Christoph,

On 05/02/20 2:18 PM, Christoph Hellwig wrote:
> On Wed, Feb 05, 2020 at 02:02:51PM +0530, Kishon Vijay Abraham I wrote:
>>> you try that branch?
>>
>> I see data mismatch with that branch.
> 
> But previously it didn't work at all? If you disable LPAE and thus
> limit the available RAM, does it work without any fixes?

Previously there was a warn dump and it gets stuck.

With the branch you shared (with LPAE enabled), there was data mismatch.
With the branch you shared (with LPAE disabled), things work fine
(https://pastebin.ubuntu.com/p/kPNdsJd7ds/)

Thanks
Kishon
