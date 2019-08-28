Return-Path: <SRS0=6piv=WY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4789DC3A5A1
	for <linux-pci@archiver.kernel.org>; Wed, 28 Aug 2019 18:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BB6206BB
	for <linux-pci@archiver.kernel.org>; Wed, 28 Aug 2019 18:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfH1SDA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Aug 2019 14:03:00 -0400
Received: from smtprelay0002.hostedemail.com ([216.40.44.2]:36882 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726549AbfH1SDA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 14:03:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id E2A85181D33FC;
        Wed, 28 Aug 2019 18:02:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: loaf11_36e5c8fe5ba4d
X-Filterd-Recvd-Size: 2363
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed, 28 Aug 2019 18:02:57 +0000 (UTC)
Message-ID: <a13a086c2dd6dd6259d28e5d1d360e2b4d04ca83.camel@perches.com>
Subject: Re: [PATCH v2] x86/PCI: Add missing log facility and move to use
 pr_ macros in pcbios.c
From:   Joe Perches <joe@perches.com>
To:     Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 28 Aug 2019 11:02:55 -0700
In-Reply-To: <20190828175120.22164-1-kw@linux.com>
References: <20190825182557.23260-1-kw@linux.com>
         <20190828175120.22164-1-kw@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-08-28 at 19:51 +0200, Krzysztof Wilczynski wrote:
> Add missing log facility where two instances of printk() that did not
> use any (so it would be using MESSAGE_LOGLEVEL_DEFAULT set in Kconfig)
> to make all the warnings in the arch/x86/pci/pcbios.c to be printed
> consistently at the same log facility.  Also resolve the following
> checkpatch.pl script warning:
> 
> WARNING: printk() should include KERN_<LEVEL> facility level
> 
> While adding the missing log facility move over to using pr_ macros
> over using printk(KERN_<level> ...) and DBG().
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
> ---
> Changes in v2:
>   Change wording and include checkpatch.pl script warning.
>   Leverage pr_fmt and remove "PCI: " prefix used throught.
>   Move to pr_debug() over using DBG() from arch/x86/include/asm/pci_x86.h.

You might also consider the checkpatch output for this patch.

arch/x86/pci/pcbios.c:116: WARNING: line over 80 characters
arch/x86/pci/pcbios.c:116: WARNING: Prefer using '"%s...", __func__' to using 'bios32_service', this function's name, in a string
arch/x86/pci/pcbios.c:119: WARNING: Prefer using '"%s...", __func__' to using 'bios32_service', this function's name, in a string
arch/x86/pci/pcbios.c:391: WARNING: line over 80 characters


