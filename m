Return-Path: <SRS0=Hm5h=NQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F62C0044C
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 20:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214F32085A
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 20:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214F32085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeKFFyH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:54:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41114 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbeKFFyH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Nov 2018 00:54:07 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NAOoIOV1njtj; Mon,  5 Nov 2018 21:32:39 +0100 (CET)
Received: from zn.tnic (p200300EC2BCD5300329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:5300:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ABDE01EC01F6;
        Mon,  5 Nov 2018 21:32:39 +0100 (CET)
Date:   Mon, 5 Nov 2018 21:32:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Woods, Brian" <Brian.Woods@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>, Pu Wen <puwen@hygon.cn>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 4/4] hwmon: k10temp: add support for AMD F17h M30h CPUs
Message-ID: <20181105203226.GD26868@zn.tnic>
References: <20181102181055.130531-1-brian.woods@amd.com>
 <20181102181055.130531-5-brian.woods@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181102181055.130531-5-brian.woods@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 02, 2018 at 06:11:12PM +0000, Woods, Brian wrote:
> Add support for AMD family 17h model 30h processors for k10temp.  Model
> 30h is functionally the same as model 01h processors (as far as k10temp
> is concerned), just the PCI device IDs need to be updated.
> 
> Signed-off-by: Brian Woods <brian.woods@amd.com>
> ---
>  arch/x86/kernel/amd_nb.c | 1 -
>  drivers/hwmon/k10temp.c  | 1 +
>  include/linux/pci_ids.h  | 1 +
>  3 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index fd69067f6eb1..e491aa4a1970 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -17,7 +17,6 @@
>  #define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
>  #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
>  #define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
> -#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
>  #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494

Patch 3 added it here and now patch 4 moves it to pci_ids.h

Just put it straight there to avoid the unnecessary churn.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
