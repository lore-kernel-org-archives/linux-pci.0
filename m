Return-Path: <SRS0=bOp+=MB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E35AC433F4
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 14:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2206E2151B
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 14:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qw7o90oh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2206E2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbeISUDd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:03:33 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:42236 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbeISUDd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Sep 2018 16:03:33 -0400
Received: by mail-io1-f49.google.com with SMTP id n18-v6so4623705ioa.9;
        Wed, 19 Sep 2018 07:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Jtxbin5sc2lNOePO3XUm0CDNs+hhFSD/YeeG2BmLbZk=;
        b=qw7o90ohW/mAc4VUzfv2fjaPG3STYkN8ufZ+1ANUJxfgkDRHEdPcxVYdCew5IOqvH5
         mRuAuU6yMX+X+ulIAXE2IG0D2CKkOndIfyBg/WpUB6rbMxmY3hr0BbxJXZsVZ7GYaVQ5
         qH9+zGf4Wo497p0oBDcUqq2cMytk3B0KGohcJ5kjy0IF/ee4yGVpoI/yYwKzYgtwzwFG
         ZoUaZLwG+OfN17kKRzI4XACn/WitmhQKFp5L8B6A6ynhT/RU5NhjPEOBWM7XOAhqb7p7
         OqHJsZQD5k3H8OOfj6NUN0zhlYnU42ZdBfBUirf+9gT1/1p7pVNdxnc3NcGPzY7N7GXT
         hWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Jtxbin5sc2lNOePO3XUm0CDNs+hhFSD/YeeG2BmLbZk=;
        b=Z07Yb6KMIZRTlnGfEBmBD4uouPBm7QppujSSGnTLlSmy8G/ywnrG40iLti5VGQvWBZ
         1JpT/BZ3UHzYhsOVJlA0h6U/Bq7S9dR5MCZcZTcRi/cDF8VpoIHPZkpwMYd27e83eQSG
         vj/F8b1K+Ic6lWWH8ngm2kYJlIo2oHKCbWBsdo8pvn2UnlDJpEQsAQ5JN6FamJHJ4++f
         iYz40FfB6QttivRbcyAL7FZaQJTofvVz+dO2CDxkYGHZ0DYY9xdMOjxWx0GuBWbJ6eEi
         VXBcZLrYFuEAi9wvyW6CMHAK8SjoMC/GYjXeRUaSL2c17b7SIVI/BWFG34m2dRnLs5An
         6uQw==
X-Gm-Message-State: APzg51A8wModd0FoSENyux7iprgRLOsZSklzDINbw1R+7RlLNgGxKeGu
        Qc/jP+tNrZ5R6h+6UpP54Ot+42g2Anjkky2yvwI=
X-Google-Smtp-Source: ANB0VdZ5CgLDaIC+/zjGivhfkZyheaLpwAr3g1UIKgioDBle2h4+PDIMbG0crulWICCsoK22Dn6m+T69B5jWOIhgQnM=
X-Received: by 2002:a6b:dc3:: with SMTP id 186-v6mr28015077ion.231.1537367122630;
 Wed, 19 Sep 2018 07:25:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:9157:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 07:25:21
 -0700 (PDT)
In-Reply-To: <20180918204834.GB13616@bhelgaas-glaptop.roam.corp.google.com>
References: <abb9aa39-3128-3a4d-01f7-d0614d63f37e@cisco.com>
 <20180918132056.GA254348@bhelgaas-glaptop.roam.corp.google.com>
 <b5883e58-861a-807e-f4c8-3745b006ce0d@cisco.com> <20180918184706.GA13616@bhelgaas-glaptop.roam.corp.google.com>
 <b6281224-18cf-50af-aa38-6b048d741854@cisco.com> <20180918204834.GB13616@bhelgaas-glaptop.roam.corp.google.com>
From:   Oliver <oohall@gmail.com>
Date:   Thu, 20 Sep 2018 00:25:21 +1000
Message-ID:
 <CAOSf1CHcDqrwy5W-GAjJ-x+rBwbRMLoVsM8D6veFVPPXmdAsZQ@mail.gmail.com>
Subject: Re: PCI: Enforce bus address limits in resource allocation
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Daniel Walker <danielwa@cisco.com>, linux-pci@vger.kernel.org,
        Yinghai Lu <yinghai@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Device Tree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180919142521.D0cGgdvkdwFm9HTaro13FJT91ucFWZCoSiUsYksdHf4@z>

On Wed, Sep 19, 2018 at 6:48 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> [+cc Rob, Frank, devicetree list,
>
> thread starts here:
> https://lkml.kernel.org/r/abb9aa39-3128-3a4d-01f7-d0614d63f37e@cisco.com
>
> dmesg snippets here:
> https://lkml.kernel.org/r/20180918184706.GA13616@bhelgaas-glaptop.roam.corp.google.com]
>
> On Tue, Sep 18, 2018 at 11:56:20AM -0700, Daniel Walker wrote:
>> On 09/18/2018 11:47 AM, Bjorn Helgaas wrote:
>> > On Tue, Sep 18, 2018 at 07:24:02AM -0700, Daniel Walker wrote:
>> > > On 09/18/2018 06:20 AM, Bjorn Helgaas wrote:
>> > > > On Fri, Sep 14, 2018 at 08:16:35AM -0700, Daniel Walker wrote:
>> > > > > I have a powerpc system with PCI, and some devices attached to
>> > > > > the PCI bus.  In 3.10 everything worked fine, then we moved to
>> > > > > 4.9 and we had some issues.  I was able to bisect the issue down
>> > > > > to the patch in the subject line.
>> > > > >
>> > > > > f75b99d PCI: Enforce bus address limits in resource allocation
>> > > > >
>> > > > >   From 3.10 here is part of the PCI initialization,
>> > > > >
>> > > > > |pci 0001:0e:00.0: BAR 0: assigned [mem 0xfc0000000-0xfc00fffff pref]|
>> > > > > |pci 0001:07:09.0: PCI bridge to [bus 0e]|
>> > > > > |pci 0001:07:09.0: bridge window [mem 0xfc0000000-0xfc00fffff 64bit pref]|
>> > > > >                   |||In this section the memory resource for the bridge is
>> > > > > 64bit, and the device "BAR 0" gets a 64bit range. However, it seems the
>> > > > > device is 32bit.|
>> >
>> > > > > |Now fast forward to 4.9 we get this,|
>> > > >
>> > > > > pci 0001:0e:00.0: BAR 0: no space for [mem size 0x00100000 pref]
>> > > > > pci 0001:0e:00.0: BAR 0: failed to assign [mem size 0x00100000 pref]
>> > > > > pci 0001:07:09.0: PCI bridge to [bus 0e]
>> > > > > pci 0001:07:09.0: bridge window [mem 0xfc0000000-0xfc00fffff 64bit pref]
>> > > > >
>> > > > > |Here it seems to have a larger size, I'm not sure where the size is coming
>> > > > > from.
>> > > >
>> > > > The size is 0x00100000 (1MB), which is the same size as
>> > > > [mem 0xfc0000000-0xfc00fffff pref].
>> > > >
>> > > > The size is normally discovered by probing the BAR (write all 1's to
>> > > > the BAR then read it back to find which bits are writable and which
>> > > > are read-only).  On powerpc we might learn it from DT instead.  But in
>> > > > any case, we to get the same 1MB size, which is the same size as the
>> > > > bridge window.  So this should still work unless there are other BARs
>> > > > in that window.
>> > >
>> > > As far as I know there is only one BAR connected to this window.
>> > >
>> > > It kind of strikes me as an off-by-one problem because it says "no space"
>> > > but the window is the same size as what's requested. With the patch removed
>> > > you get the whole window assigned.
>> > >
>> > > In the context of the patch if you change the pci_32_bit to pci_64_bit for
>> > > the region when calling pci_bus_alloc_from_region() in the 32bit case this
>> > > problem disappears. I do have CONFIG_ARCH_DMA_ADDR_T_64BIT enabled in my
>> > > config.
>> > >
>> > > > > I was able to work around the issue by setting IORESOURCE_MEM_64 on
>> > > > > the resource for this device. I also was able to work around it by setting
>> > > > > "max = avail.end" to "max = (-1);" inside pci_bus_alloc_resource(). |
>> > > > > ||
>> > > > > ||I don't know if the problem is the patch, or something else inside our
>> > > > > system, but any thoughts are appreciated.
>> > > >
>> > > > It seems like we think the bridge window contains only 64-bit space
>> > > > and therefore contains nothing usable by the 32-bit BAR.
>> > > >
>> > > > You said later that the same problem exists on v4.19-rc4.  Can you
>> > > > collect the complete dmesg log with that kernel?  That should tell us
>> > > > about any host bridge address translation.
>> > >
>> > > Sure. I have attached the dmesg.
>> >
>> > The relevant parts are below.  I think your DT is incorrect.  Either
>> > it neglects to describe the host bridge address translation for the
>> > ffb240000.pcie and ffb250000.pcie bridges, or it incorrectly describes
>> > the BARs of devices below those bridges as 32-bit BARs when they are
>> > really 64-bit BARs.
>>
>> I don't know if the DTS is correct, it very well could be incorrect. Here
>> are the relevant parts of the DTS. The BAR at issue is connected to PCI1.
>
> The DTS matches what I pointed out in the dmesg log.  I think you need
> to reconcile it with your hardware and firmware, which I don't know
> anything about, so I don't know what else I can do at this point.  I
> copied some DT folks in case they have advice.
>
>>         pci0: pcie@ffb240000 {
>>                 compatible = "fsl,t1040-pcie", "fsl,qoriq-pcie-v2.4",
>> "fsl,qoriq-pcie";
>>                 device_type = "pci";
>>                 #size-cells = <2>;
>>                 #address-cells = <3>;
>>                 bus-range = <0x0 0xff>;
>>                 interrupts = <20 2 0 0>;
>>                 fsl,iommu-parent = <&pamu0>;
>>                 reg = <0xf 0xfb240000 0 0x10000>;
>>                 ranges = <0x03000000 0xf 0xe0000000 0xf 0xe0000000 0
>> 0x01000000>;
>>
>>                 pcie@0 {
>>                         reg = <0 0 0 0 0>;
>>                         #size-cells = <2>;
>>                         #address-cells = <3>;
>>                         device_type = "pci";
>>                 };
>>         };
>>
>>         pci1: pcie@ffb250000 {
>>                 compatible = "fsl,t1040-pcie", "fsl,qoriq-pcie-v2.4",
>> "fsl,qoriq-pcie";
>>                 device_type = "pci";
>>                 #size-cells = <2>;
>>                 #address-cells = <3>;
>>                 bus-range = <0 0xff>;
>>                 interrupts = <21 2 0 0>;
>>                 fsl,iommu-parent = <&pamu0>;
>>                 reg = <0xf 0xfb250000 0 0x10000>;
>>
>>                 ranges = <0x03000000 0x4 0x00000000 0x4 0x00000000 0xc
>> 0x00000000>;
>>
>>                 pcie@0 {
>>                         reg = <0 0 0 0 0>;
>>                         #size-cells = <2>;
>>                         #address-cells = <3>;
>>                         device_type = "pci";
>>                 };
>>         };

The upstream fsl-pci driver seems to configure the bridge windows
based on what's in the ranges property rather than just consuming it.
It might be possible to add some 32bit BAR space by tweaking the
ranges to something like:

        ranges = <0x02000000 0x0 0x80000000 0x4 0x0 0x0 0x80000000>;

That said, it looks Daniel's kernel has some patches that change how
PCI setup works so it might not be using the upstream driver.

>>
>>         pci3: pcie@ffb270000 {
>>                 compatible = "fsl,t1040-pcie", "fsl,qoriq-pcie-v2.4",
>> "fsl,qoriq-pcie";
>>                 device_type = "pci";
>>                 #size-cells = <2>;
>>                 #address-cells = <3>;
>>                 bus-range = <0x0 0xff>;
>>                 interrupts = <23 2 0 0>;
>>                 fsl,iommu-parent = <&pamu0>;
>>                 reg = <0xf 0xfb270000 0 0x10000>;
>>                 ranges = <0x03000000 0x0 0xe2000000 0xf 0xe2000000 0
>> 0x00100000>;
>>
>>                 pcie@0 {
>>                         reg = <0 0 0 0 0>;
>>                         #size-cells = <2>;
>>                         #address-cells = <3>;
>>                         device_type = "pci";
>>                 };
>>         };
>>
>>
>>
>> Daniel
