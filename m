Return-Path: <SRS0=Ivhv=RX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EE7C43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 05:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345EA2175B
	for <linux-pci@archiver.kernel.org>; Wed, 20 Mar 2019 05:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dHLfdoH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfCTFNZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:13:25 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50520 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfCTFNY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Mar 2019 01:13:24 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2K5DLh3086590;
        Wed, 20 Mar 2019 00:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553058801;
        bh=2hqGN48azZJhcaQjzffHINkwfBKOGB9X714mQRt7KMk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dHLfdoH/9t6+CkauCvu3IpM2DjiqmjF2vkeQmWmIGIpHuz0y09YoIoSx2fVSJcilp
         1MpVz7LGzOAdz1CNJ81pZOjyITGCLlye+W6kCaYYcYdY7LLnxerHrW9Y+LjwbtDHbC
         +exfNpXXPztjGYxx2gXOGkgwtKLn5C4ZknJh6Nts=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2K5DLjZ025689
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Mar 2019 00:13:21 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 20
 Mar 2019 00:13:20 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Wed, 20 Mar 2019 00:13:20 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2K5DIke012247;
        Wed, 20 Mar 2019 00:13:19 -0500
Subject: Re: [PATCH] tools: PCI: exit with error code when test fails
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1537455773-13470-1-git-send-email-jjhiblot@ti.com>
 <20181004111144.GC5233@e107981-ln.cambridge.arm.com>
 <20181116120113.GB3228@e107981-ln.cambridge.arm.com>
 <20190319154322.GA12647@e107981-ln.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <285c3f6f-edfb-db9f-4816-82a8c4b5c97d@ti.com>
Date:   Wed, 20 Mar 2019 10:42:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319154322.GA12647@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 19/03/19 9:13 PM, Lorenzo Pieralisi wrote:
> On Fri, Nov 16, 2018 at 12:01:13PM +0000, Lorenzo Pieralisi wrote:
>> On Thu, Oct 04, 2018 at 12:11:44PM +0100, Lorenzo Pieralisi wrote:
>>> On Thu, Sep 20, 2018 at 05:02:53PM +0200, Jean-Jacques Hiblot wrote:
>>>> This makes it easier to use pcitest in automated setups.
>>>>
>>>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
>>>> ---
>>>>  tools/pci/pcitest.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
>>>> index af146bb..5adc8cd 100644
>>>> --- a/tools/pci/pcitest.c
>>>> +++ b/tools/pci/pcitest.c
>>>> @@ -143,6 +143,7 @@ static int run_test(struct pci_test *test)
>>>>  	}
>>>>  
>>>>  	fflush(stdout);
>>>> +	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
>>>>  }
>>>>  
>>>>  int main(int argc, char **argv)
>>>> @@ -231,6 +232,5 @@ int main(int argc, char **argv)
>>>>  		return -EINVAL;
>>>>  	}
>>>>  
>>>> -	run_test(test);
>>>> -	return 0;
>>>> +	return run_test(test);
>>>>  }
>>>> -- 
>>>> 2.7.4
>>>>
>>>
>>> Hi Kishon,
>>>
>>> are you OK with this patch ? Please let me know.
>>
>> Please let me know, I need your ACK on this to queue it.
> 
> Hi Kishon,
> 
> I will merge this patch unless you have something against it,
> please let me know.

Sorry for missing this earlier.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Thanks,
> Lorenzo
> 
