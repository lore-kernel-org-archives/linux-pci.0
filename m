Return-Path: <SRS0=33lb=RY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321A5C43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 17:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038EB2190A
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 17:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfCUReV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:34:21 -0400
Received: from ns.iliad.fr ([212.27.33.1]:55464 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfCUReV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Mar 2019 13:34:21 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 54CAC20720;
        Thu, 21 Mar 2019 18:34:19 +0100 (CET)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 3E587201BB;
        Thu, 21 Mar 2019 18:34:19 +0100 (CET)
Subject: Re: WIP: PCIe on MSM8998
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Robin Murphy <robin.murphy@arm.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Evan Green <evgreen@chromium.org>
References: <c97b6f4e-4b4c-027f-5a0b-80b3f7054177@free.fr>
 <fb5f2b94-34b7-d021-7ac9-832b08138ad4@free.fr>
 <6041e92f-4dbf-c6ce-d92a-220fc8239acb@free.fr>
 <e0a650ce-e7d4-a803-5e08-f998722bf15d@arm.com>
 <b027ad18-f7f4-cf05-b8de-ea951e0dc457@free.fr>
 <2e7d4564-01ea-d0bc-51c8-2bc2c116c4cc@arm.com>
 <b411fee4-36e6-43cb-d35e-c6fb41e00abb@free.fr>
Message-ID: <09bfdaad-2c61-f091-b4a3-6e38b2afcd93@free.fr>
Date:   Thu, 21 Mar 2019 18:34:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <b411fee4-36e6-43cb-d35e-c6fb41e00abb@free.fr>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Mar 21 18:34:19 2019 +0100 (CET)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/03/2019 17:48, Marc Gonzalez wrote:

> As far as I can tell, the specific line that crashes the system is:
> 
> 	AT_WRITE_REG(hw, REG_RXQ_CTRL, rxq);
> 
> which attempts to write 0x80800000 to [0x1b300000 + 0x15a0]
> 
> Note that I wrote "crashes the system" not "crashes the kernel" because
> there is no panic, no log from the kernel. The system just hangs for a
> few seconds, and then reboots. I suspect the system might be trapping
> into the FW, which is unhappy because $REASON.
> 
> 
> What I find confusing is that the previous write was:
> 
> 	AT_WRITE_REG(hw, REG_TXQ_CTRL, txq);
> 
> Why would REG_RXQ_CTRL be handled differently than REG_TXQ_CTRL?

As pointed out by Jeffrey and Evan, it is probably not the write /per se/
that crashes the system; it is probably that this write enables RX, which
would trigger a DMA operation which traps into TZ because the IOMMU is
incorrectly configured.

	0x80800000 = RXQ_CTRL_EN | (hw->rfd_burst << RXQ_RFD_BURST_NUM_SHIFT)

The question is: how do I figure out what is missing, considering TZ
doesn't write anything before suiciding the system...

Regards.
