Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19942C4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 17:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE27820820
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 17:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MgC1EOQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfDDRsO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:48:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46910 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfDDRsO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 13:48:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id q1so1575382pgv.13
        for <linux-pci@vger.kernel.org>; Thu, 04 Apr 2019 10:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/DrOO6VMtimwYJgOIaZ7RPc/x3rzcvwOnQqt3pjgZ10=;
        b=MgC1EOQacoXR5I1XVjzH52m/uFh8KGbc13K5EkvDqjygQgIXgUGse91sPryqeO1rcU
         GgGUl3hZb+1ySxa3rWvZjXHfH0+L5L5yp+VNefxNaW8Paub9CKF8waafiOhrBXzP89jS
         Bf9jHSbNntf9arC+onDZFmCai16wQp8gwcuzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/DrOO6VMtimwYJgOIaZ7RPc/x3rzcvwOnQqt3pjgZ10=;
        b=uavhEN0TLPG9k2meJ8uc5QrBiKg7GmkQq2i10871cyWg0QIAm9JO2nUYJgPCwrL3P7
         nJN7htdveu84+U5MiLpt1qbjymDEQQM4RP7y+o/SxnhEwG+FyB1u917ugJAFYXmdU88x
         iT+vHAzrUI9+rAiuALFyP2DkeNMwheKVW+QgBrP5umb8rTCfdkh/9W2EOvft8ppDBPRB
         dgygC/xuWfJyixgN5bDuftYCob9N1htx6+wcvgGQRZPKEeYN6HScW2bIFfEh/SjrU1nA
         u6lKE0s7wLyuiH+a+CySjiH5OkqZAvX3pF9lTQgAwWxasVpjOo+B3uRZ+pCp/PedO2k4
         QkMA==
X-Gm-Message-State: APjAAAU7nq5VWd2Y495RGy3j/RylZk7BTeyDUo/Bpu/KhgAEVgUDITDy
        vYPsx2w67CaJ/5GyzzlnWj9IwX4xFb4adg==
X-Google-Smtp-Source: APXvYqxzVez1E6B1KPD1pzOEfvRKjAuzleoRti3YjslZlK8/m4igYeU9q7drlObBTLHAuBcqeCJN4Q==
X-Received: by 2002:a63:e402:: with SMTP id a2mr7351122pgi.268.1554400092708;
        Thu, 04 Apr 2019 10:48:12 -0700 (PDT)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v82sm46229448pfa.170.2019.04.04.10.48.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 10:48:11 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] PCI: iproc: Add outbound configuration for 32-bit
 I/O region
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abhishek Shah <abhishek.shah@broadcom.com>
References: <1551415936-30174-3-git-send-email-srinath.mannam@broadcom.com>
 <20190329173515.GA10367@e107981-ln.cambridge.arm.com>
 <CABe79T7LwFLST0dwwswv8sdqHcn0T4ked5WtcNpM78XUDUN3Jw@mail.gmail.com>
 <20190401164416.GA8616@e107981-ln.cambridge.arm.com>
 <e7d3e5a1-db5c-8438-f10f-81b87aba0e03@broadcom.com>
 <CABe79T7uLo+68P0Yr7jpgn1+4H01qhoPRjX05gszin3FXkBZ5w@mail.gmail.com>
 <20190402102639.GB22708@e107981-ln.cambridge.arm.com>
 <CABe79T5O-1EWVrR1vZ27LWuxTBqN4_x37bkpfKxfm1ZB+oDUvA@mail.gmail.com>
 <20190402133851.GA26122@e107981-ln.cambridge.arm.com>
 <CABe79T7JdOh0Lpr2vhWX5QPE5nuP9hZeviSB9E3tVteeAX89fw@mail.gmail.com>
 <20190403113124.GA16233@e107981-ln.cambridge.arm.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <2c3d80ce-6fa8-a20b-135b-ea754ff4eda5@broadcom.com>
Date:   Thu, 4 Apr 2019 10:48:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403113124.GA16233@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 4/3/2019 4:31 AM, Lorenzo Pieralisi wrote:
> On Wed, Apr 03, 2019 at 08:41:44AM +0530, Srinath Mannam wrote:
>> Hi Lorenzo,
>>
>> Please see my reply below,
>>
>> On Tue, Apr 2, 2019 at 7:08 PM Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>>>
>>> On Tue, Apr 02, 2019 at 04:16:13PM +0530, Srinath Mannam wrote:
>>>
>>> [...]
>>>
>>>>> Ok - I start to understand. What does it mean in HW terms that your
>>>>> 32bit AXI address region size is 32MB ? Please explain to me in details.
>>>>>
>>>> In our PCIe controller HW, AXI address from 0x42000000 to 0x44000000
>>>> of 32MB size and .
>>>> AXI address from 0x400000000 to 0x480000000 of 2GB size are provided
>>>> to map ob address.
>>>> First IO region is inside 32bit address and second IO region is
>>>> outside 32bit address.
>>>> This code change is to map first IO region(0x42000000 to 0x44000000).
>>>>
>>>>> IIUC you are using an OARR0 of 128MB in size to map a 32MB address
>>>>> region, that's what I understand this patch does (and the lowest index
>>>>> corresponds to the smallest possible size - it is far from clear by
>>>>> looking at the patch).
>>>> Yes, lowest index corresponds to smallest possible size (128MB).
>>>> In our controller we have multiple windows like OARR0, OARR1, OARR2,
>>>> OARR3 all supports multiple sizes from 128MB to 1024MB.
>>>> These details are given at the top of this driver file, as shown
>>>> below. all windows supports 128MB size still we must use OARR0 window
>>>> to configure first IO region(0x42000000 to 0x44000000).
>>>>
>>>> static const struct iproc_pcie_ob_map paxb_v2_ob_map[] = {
>>>>         {
>>>>                 /* OARR0/OMAP0 */
>>>>                 .window_sizes = { 128, 256 },
>>>>                 .nr_sizes = 2,
>>>>         },
>>>>         {
>>>>                 /* OARR1/OMAP1 */
>>>>                 .window_sizes = { 128, 256 },
>>>>                 .nr_sizes = 2,
>>>>         },
>>>>         {
>>>>                 /* OARR2/OMAP2 */
>>>>                 .window_sizes = { 128, 256, 512, 1024 },
>>>>                 .nr_sizes = 4,
>>>>         },
>>>>         {
>>>>                 /* OARR3/OMAP3 */
>>>>                 .window_sizes = { 128, 256, 512, 1024 },
>>>>                 .nr_sizes = 4,
>>>>         },
>>>> };
>>>
>>> Ok so this patch allows mapping an AXI I/O window that is smaller
>>> than OARR possible sizes, why it was not done from the beginning
>>> I really do not know.
>>>
>> Same Iproc driver we use for multiple SOCs, in previous SOCs does not
>> have 32-bit AXI address region to map ob.
>> In the present SOC, 32-bit AXI address region is available so that
>> this change is added.
>>
>>> Now explain this to me please:
>>>
>>>> This patch add outbound window configuration to map below 32-bit I/O range
>>>> with corresponding PCI memory, which helps to access I/O region in ARM
>>>> 32-bit and one to one mapping of I/O region to PCI memory.
>>>>
>>>> Ex:
>>>> 1. ranges DT property given for current driver is,
>>>>     ranges = <0x83000000 0x0 0x40000000 0x4 0x00000000 0 0x40000000>;
>>>>     I/O region address is 0x400000000
>>>> 2. ranges DT property can be given after this patch,
>>>>     ranges = <0x83000000 0x0 0x42000000 0x0 0x42000000 0 0x2000000>;
>>>>     I/O region address is 0x42000000
>>>
>>> Why 1:1 AXI<->PCI address mapping is not possible in (1), how does the
>>> current code works on 32-bit systems and what's the benefit your change
>>> is bringing.
>> non-prefetchable memory range can only support 32-bit addresses, so
>> that we have taken 32-bit PCI bus address in (1).
>> current code does not work in 32-bit systems. In the present SOC with
>> this new change we can access from 32-bit CPU.
> 
> Thank you. I rewrote the log and pushed patches to pci/iproc, please
> have a look (Ray/Scott please do have a look too) and report back
> if that's fine.>

I reviewed the rephrased commit message by you in pci/iproc branch. It
looks very good to me. Thank you so much for helping with this!

Ray

> Do you agree that the initial commit was lacking _significant_
> information ? Please remember that the commit log plays a fundamental
> part in understanding a change and this one is a very important one
> so I am being pedantic on it.
> 
> Thanks,
> Lorenzo
> 
