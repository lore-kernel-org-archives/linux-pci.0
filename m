Return-Path: <SRS0=vBCh=MJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47954C43382
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 16:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4ED12168B
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 16:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4ED12168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeI0W5g (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:57:36 -0400
Received: from ale.deltatee.com ([207.54.116.67]:58172 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbeI0W5g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Sep 2018 18:57:36 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1g5ZJ7-0003WJ-1O; Thu, 27 Sep 2018 10:38:29 -0600
To:     Wesley.Sheng@microchip.com, kurt.schwemmer@microsemi.com,
        bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
References: <DM2PR11MB010585C1D5584683B31CCF5495140@DM2PR11MB0105.namprd11.prod.outlook.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2164850f-0772-026e-19a0-73747d03aa93@deltatee.com>
Date:   Thu, 27 Sep 2018 10:38:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <DM2PR11MB010585C1D5584683B31CCF5495140@DM2PR11MB0105.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, corbet@lwn.net, bhelgaas@google.com, kurt.schwemmer@microsemi.com, Wesley.Sheng@microchip.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2] NTB: switchtec_ntb: Update switchtec documentation
 with pre-requisites for NTB
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018-09-27 12:36 a.m., Wesley.Sheng@microchip.com wrote:
> Update switchtec documentation
> 1.add pre-requisites for NTB driver
> 2.misc updates
>  change NTB hardware driver name to ntb_hw_switchtec
>  update the description of 2 partitions limit
>  add reference to Linux Documentation/ntb.txt
>  add use of term 'Command ID'
>  add use of term 'Command Return Value'
>  add a missing ')'

You need a better commit message. It needs to describe, in plain
English, why the maintainers should merge this, not itemize the
individual changes (that's what the patch body tells us).

>  * A write must consist of at least 4 bytes and no more than 1028 bytes.
> -  The first four bytes will be interpreted as the command to run and
> -  the remainder will be used as the input data. A write will send the
> +  The first 4 bytes will be interpreted as the Command ID and the  
> + remainder will be used as the input data. A write will send the
>    command to the firmware to begin processing.

You still have some broken white space in this patch. Notice the spacing
before "remainder" compared to the previous line.

>  * Each write must be followed by exactly one read. Any double write will
>  @@ -45,9 +45,9 @@ The char device has the following semantics:
>    produce an error.
>  
>  * A read will block until the firmware completes the command and return
> -  the four bytes of status plus up to 1024 bytes of output data. (The
> -  length will be specified by the size parameter of the read call --
> -  reading less than 4 bytes will produce an error.
> +  the 4-byte Command Return Value plus up to 1024 bytes of output  
> + data. (The length will be specified by the size parameter of the read  
> + call -- reading less than 4 bytes will produce an error.)

Here too.

>  * The poll call will also be supported for userspace applications that
>    need to do other things while waiting for the command to complete.
> @@ -83,10 +83,20 @@ The following IOCTLs are also supported by the device:
>  Non-Transparent Bridge (NTB) Driver
>  ===================================
>  
> -An NTB driver is provided for the switchtec hardware in switchtec_ntb.
> -Currently, it only supports switches configured with exactly 2 
> -partitions. It also requires the following configuration settings:
> +An NTB hardware driver is provided for the Switchtec hardware in 
> +ntb_hw_switchtec. Currently, it only supports switches configured with 
> +exactly 2 NT partitions and zero or more non-NT partitions. It also 
> +requires the following configuration settings:
>  
> -* Both partitions must be able to access each other's GAS spaces.
> +* Both NT partitions must be able to access each other's GAS spaces.
>    Thus, the bits in the GAS Access Vector under Management Settings
>    must be set to support this.
> +* Kernel configuration MUST include support for NTB (CONFIG_NTB needs
> +  to be set)
> +
> +NT EP BAR 2 will be dynamically configured as a Direct Window, and the 
> +configuration file does not need to configure it explicitly.
> +
> +Please refer to Documentation/ntb.txt in Linux source tree for an 
> +overall understanding of the Linux NTB stack. ntb_hw_switchtec works as 
> +an NTB Hardware Driver in this stack.
> 
