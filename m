Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD10FC65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 11:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9872620989
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 11:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZXWQ3LPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9872620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeLMLHo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:07:44 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:55278 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeLMLHo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Dec 2018 06:07:44 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 411C810C177F;
        Thu, 13 Dec 2018 03:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544699264; bh=s+QehwjkgExw2ba74249xOWbVHcHTN8vCjA8fjKOIq0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=ZXWQ3LPCaTsa/0wjUncxzvVmR2qzwop/sTwmkeSGCiEM/gDZrCsfCGG04wpuDwiQ3
         +PMvNq7WMWRExE4PATF0w90xSSPM9u+QXsaCd22oOFKeVrN/iJ2bs0hrbNtwk79a6X
         kgL2reLpQM2daOJQXbcIGluIZG1REPx4zez/V+hAnR/l6lPEmrUbf4l3k5yM50AV05
         kHYvMhWrp3bCW25pu68ADQazOFkRd1w5jhuQyQGJylv0rVBtJZYr3K8ICdltNNmeZP
         o9yZMv+tcfu6ENOhpJovC+9VR9lixY7wXWqwwbByExzJud4s0hVOUX7ZBAmi9VSo36
         sO9J2tu1drYjA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 076273987;
        Thu, 13 Dec 2018 03:07:44 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 13 Dec 2018 03:07:43 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 13 Dec 2018 12:07:41 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 13 Dec 2018 12:07:41 +0100
Subject: Re: [RFC 1/6] dma: Add Synopsys eDMA IP core driver
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Joao Pinto <joao.pinto@synopsys.com>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
 <bf4eb88265bf8bd95f7b2effdbfbeda8c52a2e0b.1544610287.git.gustavo.pimentel@synopsys.com>
 <20181212230041.GM99796@google.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <f9181841-e429-f578-4fda-ce7ad6ff2483@synopsys.com>
Date:   Thu, 13 Dec 2018 11:03:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181212230041.GM99796@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 12/12/2018 23:00, Bjorn Helgaas wrote:
> On Wed, Dec 12, 2018 at 12:13:21PM +0100, Gustavo Pimentel wrote:
>> Add Synopsys eDMA IP core driver to kernel.
>>
>> This core driver, initializes and configures the eDMA IP using vma-helpers
>> functions and dma-engine subsystem.
>>
>> Also creates an abstration layer through callbacks allowing different
>> registers mappings in the future, organized in to versions.
>>
>> This driver can be compile as built-in or external module in kernel.
>>
>> To enable this driver just select DW_EDMA option in kernel configuration,
>> however it requires and selects automatically DMA_ENGINE and
>> DMA_VIRTUAL_CHANNELS option too.
>>
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> Cc: Vinod Koul <vkoul@kernel.org>
>> Cc: Eugeniy Paltsev <paltsev@synopsys.com>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Joao Pinto <jpinto@synopsys.com>
> 
>> --- /dev/null
>> +++ b/drivers/dma/dw-edma/dw-edma-core.c
>> @@ -0,0 +1,925 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
>> +// Synopsys DesignWare eDMA core driver
> 
> The SPDX line in .c files needs the // comment for some obscure reason

Yes, I think it's correlated to some build breakage on linking stage.

> I can't remember, but based on the other drivers/dma/*.c files, it
> looks like the convention is the usual /* .. */ comments for the rest.

Ok, I'll change it.

> 
> I think the SPDX line is /* */ in .h files though.  The rules are
> under Documentation/ somewhere.
> 

I found the info about this on [1], however I paste here a small extract to
future reference.

C source: // SPDX-License-Identifier: <SPDX License Expression>
C header: /* SPDX-License-Identifier: <SPDX License Expression> */
ASM:      /* SPDX-License-Identifier: <SPDX License Expression> */
scripts:  # SPDX-License-Identifier: <SPDX License Expression>
.rst:     .. SPDX-License-Identifier: <SPDX License Expression>
.dts{i}:  // SPDX-License-Identifier: <SPDX License Expression>

[1] https://www.kernel.org/doc/html/v4.18/process/license-rules.html

Thanks Bjorn.
