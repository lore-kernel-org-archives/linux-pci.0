Return-Path: <SRS0=66QY=NV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9129BC0044C
	for <linux-pci@archiver.kernel.org>; Sat, 10 Nov 2018 00:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F5720855
	for <linux-pci@archiver.kernel.org>; Sat, 10 Nov 2018 00:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ctrlinux.com header.i=@ctrlinux.com header.b="hesCWiKi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OYA2yVPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F5720855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ctrlinux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeKJK0R (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 10 Nov 2018 05:26:17 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37357 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728082AbeKJK0R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Nov 2018 05:26:17 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A736021A90;
        Fri,  9 Nov 2018 19:43:12 -0500 (EST)
Received: from web5 ([10.202.2.215])
  by compute7.internal (MEProxy); Fri, 09 Nov 2018 19:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ctrlinux.com; h=
        message-id:from:to:mime-version:content-transfer-encoding
        :content-type:references:in-reply-to:date:reply-to:subject; s=
        fm1; bh=o9QfQd5D3+RlBv3zsWn8+jGPLb44B/C0oKOLTlqpgD8=; b=hesCWiKi
        1aP8u+ji5tHIRBUoMJAIhxweSIu0dmYQ/IftZdP5iBVR8B28I2fNT8vo3rP0r6TT
        7grl3UTH8CaHJMUqk1bkPZC8opw6J11df5rDVa+g68ktILwj5K9cbcJTW4Srz4rR
        0ChQXomxK1TsLOMaegh5/ZgHr3RlkxzeiSG3tVTnZIJUGN87pZjqTMe4khYYT70d
        UDc/T4r83kUOBD8j83KBgf48L7228S/l0uUa53hteG2r9CricYjSswLsA0J9kM0w
        JzByEZGhqQboruC/bgqAsffGdyzZvMHw/IeKtUd+xvA9F4RcsujAfHTIJNHrU/fP
        N2i/S2srIujO0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=o9QfQd5D3+RlBv3zsWn8+jGPLb44B
        /C0oKOLTlqpgD8=; b=OYA2yVPcwfGoTtcGphhic6LAllZ/d1K1lxj4Km8tSe6+u
        ZsXrzAdd9682B+JvsnJcBCWFz83I0uo9qb1eMyQC2uwnFu1XMdiT9Kh2ACjiVKDG
        CFiScDdi3gSRgEIJR+HoAL2MZoOPaC5AHHM6Xf/2mN3fXL6uJIWCeaZPduvmc8D/
        CglX9b8QsWge6y1JmdBSExffRMNZp1zoTo4DyziMAAJ/KpWlI8Z1d4u6z/tN5Vep
        FSAdQEmppwyuwR9o3n6J+ZCLVVv12Cv/Q8JCZjWn/6XqMH6Ql3bbaaZfbIJyLfPe
        lMGArimsDEuVOnnH5m+74clHBrVPwZlQiSpR7iRng==
X-ME-Sender: <xms:oCnmW0jUZqtuFmuEDZrO0zH2QqSjlbraOAkuEIrKBVdajkPYtJETwA>
X-ME-Proxy: <xmx:oCnmW_k8v5Jj2CmAyiaYLE-k1KiXcCAJHTKPG6d7ex4MaU71guWffA>
    <xmx:oCnmW5snItr3HWKUYU7xpIcHTrMNQ35TMeZaUapYBmkFKiawsaWMkg>
    <xmx:oCnmWymglYf68Bgd_LACXZKxR-F5cvAAXpcXVYDTPK6suorgKnyFrQ>
    <xmx:oCnmW0sROcoIz-xJ1QMZBlg86vjAnUfCZMUKWLQtV9iLbFMWV17cww>
    <xmx:oCnmW4d_KL7KnJU03mtfbZ4tPtoYOoIr1jMc7kOIcHFEm3EqXTYs3Q>
    <xmx:oCnmW13xttqRLVCiSX9lPlvJKDXmvrqdESCgUx3ZLiHB1-20L8kgyg>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 585EA9E115; Fri,  9 Nov 2018 19:43:12 -0500 (EST)
Message-Id: <1541810592.1176760.1571963216.0765E640@webmail.messagingengine.com>
From:   Andrei Danaila <adanaila@ctrlinux.com>
To:     Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-c0552f07
References: <1541809334.2290928.1571950584.2632F1FD@webmail.messagingengine.com>
 <9d6840e2-1f36-619c-33fc-7872a072e12d@kernel.org>
In-Reply-To: <9d6840e2-1f36-619c-33fc-7872a072e12d@kernel.org>
Date:   Fri, 09 Nov 2018 16:43:12 -0800
Reply-To: adanaila@ctrlinux.com
Subject: Re: Sharing PCIe MMIO with other Drivers
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Sinan,

I thought of that as well, unfortunately that it is not possible since the FPGA IP block is proprietary from a 3P vendor and lumps everything under one function with no option of adding additional functions.



On Fri, Nov 9, 2018, at 4:32 PM, Sinan Kaya wrote:
> On 11/9/2018 4:22 PM, Andrei Danaila wrote:
> > A couple of questions:
> > 
> > 1. Is this the correct software flow for managing multiple devices exposed by a PCIe BAR0 address space?
> >      If not, what is the correct flow?
> >      If yes, any ideas on what may be going wrong?
> 
> General practice is to create a PCI Physical Function for each sub-functionality
> (I2C/UART/DMA etc.) so that individual drivers can claim their own PCI device
> and its own BAR space without sharing resources.
