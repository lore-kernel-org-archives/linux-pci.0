Return-Path: <SRS0=66QY=NV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A816C43441
	for <linux-pci@archiver.kernel.org>; Sat, 10 Nov 2018 00:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC4B20883
	for <linux-pci@archiver.kernel.org>; Sat, 10 Nov 2018 00:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ctrlinux.com header.i=@ctrlinux.com header.b="wRoAYvib";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ps92zNL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC4B20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ctrlinux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeKJKkV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 10 Nov 2018 05:40:21 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43471 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727210AbeKJKkV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Nov 2018 05:40:21 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6439322164;
        Fri,  9 Nov 2018 19:57:13 -0500 (EST)
Received: from web5 ([10.202.2.215])
  by compute7.internal (MEProxy); Fri, 09 Nov 2018 19:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ctrlinux.com; h=
        message-id:from:to:mime-version:content-transfer-encoding
        :content-type:references:subject:reply-to:in-reply-to:date; s=
        fm1; bh=NSMxWCO45ZTbs4sywoyYiYKZX9yeEXdLp+3sJ3zZ118=; b=wRoAYvib
        PZwyLSPow8ZVqj5cXfP4rbwYRLuyNk2AD43/CNxWuAlQ/X/0EH6mAffMWT29dOU3
        eyBstvYQcRRaxrZKeSdsE4bx8t5iiIY09gQAuwSi0bsNxkWaaZhnCGFWoR46ZLCn
        +vCxP6OZCnH5RHsd97xu8TblLdIeJLoB5jP1QteL/6kEWLbrexDT0Y5YzBBiwaLS
        LMsuBuLVLmc4PgnhXbo54kMfpiFqYHDKkB4k2WOtFOpXmSIU3gBiZg5Oxulkbfcv
        f0Q67Wpk1SD4hJ4Jdq/dglf4x89mT1IlKbhP6J5bZJDrVbmxVCTHycBn017lVKbp
        ZAU+jbut7q+b6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=NSMxWCO45ZTbs4sywoyYiYKZX9yeE
        XdLp+3sJ3zZ118=; b=ps92zNL8ygNquwyj3EXz9SiMU6xvpCcCsvhNn3fEMju7L
        z5/vRRw6+jb4qMxLE4+JxWJjIIUY9AUGJHd0PzOL/15mg8J6v2S0C35/IFXS8MZI
        fFapRHkkYerCooggSSHbvWizkPnHs0wh0HwXsbhRtGg54Sz3bI5R95fG7y/8kHU5
        ZoEPZy+JSLU8BSaZZBatMLWpGly74hafVB+L1dcj01Wn4MPH7e/H6NH+wpfq9icY
        l63hiIaZDix6rohcxhxSapd3NwyFAJ/IW7zPL4B5kz/nb96FVNLemltWU3rVBNPL
        ORIkVpcJ3S2JrwUhkXsc5rhA4ZJsTLPIAI/oNZz6w==
X-ME-Sender: <xms:6SzmW_YxQqxBXN-uqVhnwS6oYLFjr7IqaGRpZgWbuCcGh2RYYCYgJw>
X-ME-Proxy: <xmx:6SzmW4ydU2KyFihY0Em8njIgQ_2XRd7TI5xO9kDOKMOKwo8a48YxQw>
    <xmx:6SzmW1B4Xj_IkHXpjuH9G8yVhGiMXHvB-e8zZdLOJa7tWVOfLeRPug>
    <xmx:6SzmW5A5sG8fp3AygHsd6txckktjyHWUvrKoggSSRgj3p-kv4f-5kg>
    <xmx:6SzmW455mjRlCv0eyFNaau3QeeEUlDCFXdUOfamz17XbrMs-qjS44Q>
    <xmx:6SzmW90Umv01fQGC8jUhQ9AACxlVaNfIFYl93ZO19cdmErCpmtw8vw>
    <xmx:6SzmWyO6r5yJ3-wXMLKNrEKduaGfWtVIKoknZkCvJtjwQ8A5XbeDyQ>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 291669E115; Fri,  9 Nov 2018 19:57:13 -0500 (EST)
Message-Id: <1541811433.2126862.1571973360.5D0EF5E6@webmail.messagingengine.com>
From:   Andrei Danaila <adanaila@ctrlinux.com>
To:     Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-c0552f07
References: <1541809334.2290928.1571950584.2632F1FD@webmail.messagingengine.com>
 <9d6840e2-1f36-619c-33fc-7872a072e12d@kernel.org>
 <1541810592.1176760.1571963216.0765E640@webmail.messagingengine.com>
 <2209a758-fa3a-ba92-a0f0-4cf2d704c10d@kernel.org>
Subject: Re: Sharing PCIe MMIO with other Drivers
Reply-To: adanaila@ctrlinux.com
In-Reply-To: <2209a758-fa3a-ba92-a0f0-4cf2d704c10d@kernel.org>
Date:   Fri, 09 Nov 2018 16:57:13 -0800
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Unfortunately, I cannot change the IP on the FPGA to add more BARs either, the whole thing is locked down.

On Fri, Nov 9, 2018, at 4:48 PM, Sinan Kaya wrote:
> On 11/9/2018 4:43 PM, Andrei Danaila wrote:
> > Thanks Sinan,
> > 
> > I thought of that as well, unfortunately that it is not possible since the FPGA IP block is proprietary from a 3P vendor and lumps everything under one function with no option of adding additional functions.
> 
> How about adding multiple BARs and then give each BAR to a children driver?
