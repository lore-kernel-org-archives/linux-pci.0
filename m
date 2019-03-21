Return-Path: <SRS0=33lb=RY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E0BC43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 12:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B194F218FF
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 12:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfCUMpq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:45:46 -0400
Received: from ns.iliad.fr ([212.27.33.1]:35584 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbfCUMpq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Mar 2019 08:45:46 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id D4A1C202D9;
        Thu, 21 Mar 2019 13:45:43 +0100 (CET)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 93352202A3;
        Thu, 21 Mar 2019 13:45:43 +0100 (CET)
Subject: Re: WIP: PCIe on MSM8998
To:     Robin Murphy <robin.murphy@arm.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
References: <c97b6f4e-4b4c-027f-5a0b-80b3f7054177@free.fr>
 <fb5f2b94-34b7-d021-7ac9-832b08138ad4@free.fr>
 <6041e92f-4dbf-c6ce-d92a-220fc8239acb@free.fr>
 <e0a650ce-e7d4-a803-5e08-f998722bf15d@arm.com>
 <b027ad18-f7f4-cf05-b8de-ea951e0dc457@free.fr>
 <2e7d4564-01ea-d0bc-51c8-2bc2c116c4cc@arm.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <a866daca-d704-94d5-b614-6ef22b54b796@free.fr>
Date:   Thu, 21 Mar 2019 13:45:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <2e7d4564-01ea-d0bc-51c8-2bc2c116c4cc@arm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Mar 21 13:45:44 2019 +0100 (CET)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/03/2019 00:07, Robin Murphy wrote:

> Unfortunately, having looked around the code, I think I do. 4.4 long 
> predates the iommu-map binding, and in the absence of anything other 
> than the hard-coded SID==RID assumption of arm-smmu at the time, they 
> apparently went and did their own wacky thing[1]. AFAICS the Stream ID 
> appears to be pretty much derived from the PCI topology as I would hope, 
> but it looks like it might depend on some sort of lookup table being 
> programmed appropriately as well.
> 
> Bear in mind that the this is _The Qualcomm Android Kernel_ we're trying 
> to reason about here - playing true to the stereotype, the diff against 
> the mainline driver is significantly bigger than the entire mainline 
> driver itself; the line count of arm-smmu.c alone is pushing 
> 2-and-a-half times that of the file in 4.4.y ;)
> 
> Since the curiosity had set in, I finally got round to dumping the ACPI 
> tables from my Snapdragon 835 laptop, and judging by the IORT it seems 
> like the EFI firmware for Windows machines does provide some set of 
> static ID mappings which could probably transcribe to an iommu-map (if 
> indeed it's valid at all - Windows itself doesn't seem to be even 
> touching PCI here), but I guess the Android BSP might not be so 
> generous. That'll be a question for the Qualcomm folks. FWIW mine 
> interestingly claims that its SMMU instances are all sharing SPI 231 as 
> a global fault interrupt, but whether that's true and/or depends on the 
> runtime firmware, again I really have no idea.
> 
> Robin.
> 
> [1] 
> https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/drivers/pci/host/pci-msm.c?h=LE.UM.1.3.r3.25&id=f1fa301f977f06dcf990c0452d85e2f67d8cbbf1#n4687

I can't say I'm enjoying working on the qcom kernel so far. It's mostly
a guessing game, comparing upstream vs downstream MMIO traces.

If you are so inclined, below is a very verbose boot log where I try
to set the link up, and the kernel blows up:

	https://pastebin.ubuntu.com/p/PJPhsFxhN9/

The last MMIO write before hara-kiri is 0x00000000fff4e000 at SMMU + 008800
However, I print a call stack before doing the actual write, so the fact
that there is no stack is puzzling...

Regards.
