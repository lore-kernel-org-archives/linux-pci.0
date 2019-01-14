Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1361C43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12F420659
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 11:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XL2ds9Jc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfANLtH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:49:07 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:38884 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfANLtG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2019 06:49:06 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 63D0124E0F81;
        Mon, 14 Jan 2019 03:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547466546; bh=XFnaYnqXSQrkZWgKieqVWVV9EczZge/8FBLAvICX3CI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=XL2ds9Jc26WyFaW+emD0mkdw9ZbKkcYR7kUndYJkvUSuaGOd65+Tv1iKh9jhBqXAv
         4bng9vNaw/qctAQ6KBBLDyteCpsr5wtpZWtJhIkSLoWiNNYC3M79h8rjXAYF9pzPr7
         dFgwQJAV9HtjFrxIyKVN0iEaUjkfIa3tjU+h1g0CImgDu+C/7CIuhShncnwCORkua9
         3gB+3TIjxqQrRE19lzHAYWEqMkzGLUETSA9hwhxcxz0FFa4ngJqbl2xMtxJ7Hjfnu0
         bu3fVXz6nO7Gc0J2x2Udoezl8+XDfCs9TMWg43in1387OPOKyjXq2591M2wST2d2Oi
         eWF/nzgIYLaZw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 414FA36C1;
        Mon, 14 Jan 2019 03:49:06 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 14 Jan 2019 03:49:05 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 14 Jan 2019 12:49:03 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 14 Jan 2019 12:49:03 +0100
Subject: Re: [RFC v3 7/7] dmaengine: Add Synopsys eDMA IP test and sample
 driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        "Luis Oliveira" <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
 <cc195ac53839b318764c8f6502002cd6d933a923.1547230339.git.gustavo.pimentel@synopsys.com>
 <20190111194819.GV9170@smile.fi.intel.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <2de7f43e-0702-9ab3-b24c-a1b212e18f7c@synopsys.com>
Date:   Mon, 14 Jan 2019 11:44:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190111194819.GV9170@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/01/2019 19:48, Andy Shevchenko wrote:
> On Fri, Jan 11, 2019 at 07:33:43PM +0100, Gustavo Pimentel wrote:
>> Add Synopsys eDMA IP test and sample driver to be use for testing
>> purposes and also as a reference for any developer who needs to
>> implement and use Synopsys eDMA.
>>
>> This driver can be compile as built-in or external module in kernel.
>>
>> To enable this driver just select DW_EDMA_TEST option in kernel
>> configuration, however it requires and selects automatically DW_EDMA
>> option too.
>>
> 
> Hmm... This doesn't explain what's wrong with dmatest module.

There isn't anything wrong with dmatest module, that I know of. In beginning I
was planning to used it, however only works with MEM_TO_MEM transfers, that's
why I created a similar module but for MEM_TO_DEV and DEV_TO_MEM with
scatter-gather and cyclic transfers type for my use case. I don't know if can be
applied to other cases, if that is feasible, I'm glad to share it.

> 

