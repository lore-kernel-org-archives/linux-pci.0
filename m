Return-Path: <SRS0=ToWj=PL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7371DC43387
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 20:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364F320675
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 20:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OMBHAIB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfACU6Z (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:58:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46751 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfACU6Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jan 2019 15:58:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so16476702pgp.13
        for <linux-pci@vger.kernel.org>; Thu, 03 Jan 2019 12:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xj1FOSiudFmalrR2wY+7f+uAqQy/CjMmPlp0FFA3l0M=;
        b=OMBHAIB6sKrg5Wh8YPS0s0BQxv9a0QXzMSOMibK/+V3kfALVC9ws1C9tCtjr7KaVqc
         s1OyS5LYa7dPewCZjYfJQFlUVA0end2U83Aw5w3qQ7ecLZd5qPq+X+hmMk9pn0wfOmVo
         Ej1rgeZFByXMhXylBs7C3GfXGbDb8hN0gI8UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xj1FOSiudFmalrR2wY+7f+uAqQy/CjMmPlp0FFA3l0M=;
        b=CcRR7s0EFTugRmxGncUEdFP2ZxnrE6XxP08AaY/U6M46wgv10W/z0T6H7WMzaEJhdC
         /9CzNFVH6nzLWaBtqExbgrTciqMOtjsXouXwxIsmvxtAioGekkFGJr2NKxRPFr6cEsm3
         IOOP4uSGa3lUzmhnvG1tx1iP/eK3+KD4pN5TDsPhuhe8L2faGN6UJQ1HMT5Je8jyCyDw
         5+Jvh77UOtEgXO/BJZr9r5BBerIVR3zy3CN6aFWZcZbIftEAeWygkI2/5cs616hXA/TQ
         VEoH4D8rUuOVLEpd16c0skvHIR84GlYDWUJWsCmsaQX6lbQ0R4gbudHtCzUlhkZDNIfX
         iMuQ==
X-Gm-Message-State: AJcUukc62/QankYefJrrbHZBkFaYsPkCqMLyL2pS2SMg+SprYMYHuy68
        E7yRhLV9AB1uvxtrAvIQrVwWuQ==
X-Google-Smtp-Source: ALg8bN7Bdwai9QkfHzEJ+w6G963g9rSvoBDqxQkFmCytuBbKXHObFgrK3gp6sTnjTj/euhQVjL3Jzg==
X-Received: by 2002:a63:1e56:: with SMTP id p22mr18300531pgm.126.1546549103506;
        Thu, 03 Jan 2019 12:58:23 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id g185sm77373916pfc.174.2019.01.03.12.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 12:58:22 -0800 (PST)
Subject: Re: [PATCH 1/6] PCI: iproc: Update iProc PCI binding for INTx support
To:     Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
 <1527631130-20045-2-git-send-email-ray.jui@broadcom.com>
 <CAL_Jsq+ac6dmHKS6m0h5N3bv=VseKVL8XLU5K7j1Rn=mgFNLsA@mail.gmail.com>
 <20180918134152.GA31440@e107981-ln.cambridge.arm.com>
 <CAK8P3a3cWHK=DNCFn+p_NjSyXhoLQw07EVedVf5-UFdz4V4OPA@mail.gmail.com>
 <20180925105027.GA29857@red-moon>
 <CAK8P3a2nn9+8NEz8MqD_oVS9O+pb8L9ookVVkukDJXtNNRYk7g@mail.gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <cdeb8270-0583-4ff9-4d34-94e467d05595@broadcom.com>
Date:   Thu, 3 Jan 2019 12:58:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2nn9+8NEz8MqD_oVS9O+pb8L9ookVVkukDJXtNNRYk7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/25/2018 3:55 AM, Arnd Bergmann wrote:
> On Tue, Sep 25, 2018 at 12:49 PM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>>
>> On Mon, Sep 24, 2018 at 10:53:13PM +0200, Arnd Bergmann wrote:
>>> On Tue, Sep 18, 2018 at 3:42 PM Lorenzo Pieralisi
>>> <lorenzo.pieralisi@arm.com> wrote:
>>>>
>>>> On Mon, Jun 04, 2018 at 09:17:49AM -0500, Rob Herring wrote:
>>>>> +Arnd
>>>>>
>>>>> On Tue, May 29, 2018 at 4:58 PM, Ray Jui <ray.jui@broadcom.com> wrote:
>>>>>> Update the iProc PCIe binding document for better modeling of the legacy
>>>>>> interrupt (INTx) support
>>>>>>
>>>>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>>>>> ---
>>>>>>  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    | 31 +++++++++++++++++-----
>>>>>>  1 file changed, 24 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>>>>> index b8e48b4..7ea24dc 100644
>>>>>> --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>>>>> +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>>>>> @@ -13,9 +13,6 @@ controller, used in Stingray
>>>>>>    PAXB-based root complex is used for external endpoint devices. PAXC-based
>>>>>>  root complex is connected to emulated endpoint devices internal to the ASIC
>>>>>>  - reg: base address and length of the PCIe controller I/O register space
>>>>>> -- #interrupt-cells: set to <1>
>>>>>> -- interrupt-map-mask and interrupt-map, standard PCI properties to define the
>>>>>> -  mapping of the PCIe interface to interrupt numbers
>>>>>>  - linux,pci-domain: PCI domain ID. Should be unique for each host controller
>>>>>>  - bus-range: PCI bus numbers covered
>>>>>>  - #address-cells: set to <3>
>>>>>> @@ -41,6 +38,16 @@ Required:
>>>>>>  - brcm,pcie-ob-axi-offset: The offset from the AXI address to the internal
>>>>>>  address used by the iProc PCIe core (not the PCIe address)
>>>>>>
>>>>>> +Legacy interrupt (INTx) support (optional):
>>>>>> +
>>>>>> +Note INTx is for PAXB only.
>>>>>> +
>>>>>> +- interrupt-controller: claims itself as an interrupt controller for INTx
>>>>>> +- #interrupt-cells: set to <1>
>>>>>> +- interrupt-map-mask and interrupt-map, standard PCI properties to define
>>>>>> +the mapping of the PCIe interface to interrupt numbers
>>>>>> +- interrupts: interrupt line wired to the generic GIC for INTx support
>>>>>> +
>>>>>>  MSI support (optional):
>>>>>>
>>>>>>  For older platforms without MSI integrated in the GIC, iProc PCIe core provides
>>>>>> @@ -77,9 +84,14 @@ Example:
>>>>>>                 compatible = "brcm,iproc-pcie";
>>>>>>                 reg = <0x18012000 0x1000>;
>>>>>>
>>>>>> +               interrupt-controller;
>>>>>>                 #interrupt-cells = <1>;
>>>>>> -               interrupt-map-mask = <0 0 0 0>;
>>>>>> -               interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
>>>>>> +               interrupt-map-mask = <0 0 0 7>;
>>>>>> +               interrupt-map = <0 0 0 1 &pcie0 1>,
>>>>>
>>>>> Are you sure this works? The irq parsing code will ignore
>>>>> interrupt-map if interrupt-controller is found. In other words, you
>>>>> should have one or the other, but not both.
>>>>>
>>>>> Maybe it happens to work because "pcie0" is this node and your irq
>>>>> numbers are the same.
>>>>>
>>>>> Arnd, any thoughts on this?
>>>>
>>>> To start with, I think the destination IRQ number is wrong, what the
>>>> mappings actually do is mapping the PCI interrupt line (ie #INTA, #INTB,
>>>> #INTC, #INTD) to input {0,1,2,3} of the PCI host bridge (pseudo)
>>>> interrupt controller.
>>>>
>>>> I really want to clean this up since currently there are different
>>>> DT bindings defining this in different ways which resulted in
>>>> non-consistent kernel code.
>>>>
>>>> AFAICS, the Aardvark PCIe controller bindings define the mapping
>>>> as I expect:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/aardvark-pci.txt?h=v4.19-rc4
>>>>
>>>> but I would like to get Rob and Arnd viewpoint on this so that
>>>> we can close this topic once for all.
>>>
>>> It seems ambiguous at best, as Rob suggested it may only
>>> work by accident. Since there is only one upstream interrupt,
>>> could we simply list <GIC_SPI 100 IRQ_TYPE_NONE> as
>>> the destination for any IntX?
>>
>> I think that would not be correct from an HW description standpoint
>> since there is some logic in the host bridge that behaves as an
>> interrupt controller (eg registers to ack/mask IRQs).
>>
>> AFAICS the aardvark (it is an example) bindings below should be correct,
>> with an interrupt controller node within the PCI host bridge:
>>
>>         pcie0: pcie@d0070000 {
>>                 compatible = "marvell,armada-3700-pcie";
>>                 device_type = "pci";
>>                 reg = <0 0xd0070000 0 0x20000>;
>>                 #address-cells = <3>;
>>                 #size-cells = <2>;
>>                 bus-range = <0x00 0xff>;
>>                 interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
>>                 #interrupt-cells = <1>;
>>                 msi-controller;
>>                 msi-parent = <&pcie0>;
>>                 ranges = <0x82000000 0 0xe8000000   0 0xe8000000 0 0x1000000 /* Port 0 MEM */
>>                           0x81000000 0 0xe9000000   0 0xe9000000 0 0x10000>; /* Port 0 IO*/
>>                 interrupt-map-mask = <0 0 0 7>;
>>                 interrupt-map = <0 0 0 1 &pcie_intc 0>,
>>                                 <0 0 0 2 &pcie_intc 1>,
>>                                 <0 0 0 3 &pcie_intc 2>,
>>                                 <0 0 0 4 &pcie_intc 3>;
>>                 pcie_intc: interrupt-controller {
>>                         interrupt-controller;
>>                         #interrupt-cells = <1>;
>>                 };
>>         };
>>
>> Thoughts ?
> 
> Yes, I think that's better. We probably still need to move the
> interrupts, msi-controller, msi-parent and interrupt-parent
> properties into the child node.

Okay thanks for all the feedback. In my case, I think I just to need
create a dummy 'intc' subnode under the pcie node and declare it as a
(dummy) interrupt controller).

I'll make the change in my next revision.

> 
>         Arnd
> 
