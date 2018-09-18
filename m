Return-Path: <SRS0=7uyK=MA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755F4C433F4
	for <linux-pci@archiver.kernel.org>; Tue, 18 Sep 2018 18:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E93F2150C
	for <linux-pci@archiver.kernel.org>; Tue, 18 Sep 2018 18:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="ZOX4nT2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E93F2150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeISAaV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:30:21 -0400
Received: from alln-iport-6.cisco.com ([173.37.142.93]:3936 "EHLO
        alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbeISAaU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2018 20:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5991; q=dns/txt; s=iport;
  t=1537296983; x=1538506583;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Xr8EHObpE2CCiSW6MPIvjp/LVpRL/wIS41DarKJBY50=;
  b=ZOX4nT2+QV1FkqiYCTwVyNxZqBJiRV2kf16WBnTPva5bQqv/hAdkj3Vv
   Tm6jz0YhNs+f8+gU6SiCmliEljaAgdojkmdwB3O+jiMiR6LcVOdjc/M2R
   MRB2TVEooSYCj+i+uwwju6suxKCJ2B6jIR00HlVE/1NNun8C4Chg6a5pN
   0=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AVAACzSaFb/5BdJa1bGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYFQggiBZIQaiBWML4FgLZZMFIFmC4RsAoMmITQYAQMBAQI?=
 =?us-ascii?q?BAQJtKIU5AQUjFUEQCxgCAiYCAlcGDQgBAYMdggKlHIEuhHeFFoELiWIXgUE?=
 =?us-ascii?q?/gTmCPS6EZoMZglcCiDOFdjFGjTEJgguOEAYXgUOHKSaGApRqgUI4gVUzGgg?=
 =?us-ascii?q?bFYMogiQXjjcfjXcBAQ?=
X-IronPort-AV: E=Sophos;i="5.53,390,1531785600"; 
   d="scan'208";a="172786758"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by alln-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 18:56:22 +0000
Received: from [10.24.34.59] ([10.24.34.59])
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTP id w8IIuKEa022027;
        Tue, 18 Sep 2018 18:56:21 GMT
Subject: Re: PCI: Enforce bus address limits in resource allocation
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <abb9aa39-3128-3a4d-01f7-d0614d63f37e@cisco.com>
 <20180918132056.GA254348@bhelgaas-glaptop.roam.corp.google.com>
 <b5883e58-861a-807e-f4c8-3745b006ce0d@cisco.com>
 <20180918184706.GA13616@bhelgaas-glaptop.roam.corp.google.com>
From:   Daniel Walker <danielwa@cisco.com>
Message-ID: <b6281224-18cf-50af-aa38-6b048d741854@cisco.com>
Date:   Tue, 18 Sep 2018 11:56:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918184706.GA13616@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Outbound-SMTP-Client: 10.24.34.59, [10.24.34.59]
X-Outbound-Node: rcdn-core-8.cisco.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180918185620.1euOupKzBCOmsowyZEi601Ni9C5vdoxxXrgVe95Z70k@z>

On 09/18/2018 11:47 AM, Bjorn Helgaas wrote:
> On Tue, Sep 18, 2018 at 07:24:02AM -0700, Daniel Walker wrote:
>> On 09/18/2018 06:20 AM, Bjorn Helgaas wrote:
>>> On Fri, Sep 14, 2018 at 08:16:35AM -0700, Daniel Walker wrote:
>>>> I have a powerpc system with PCI, and some devices attached to
>>>> the PCI bus.  In 3.10 everything worked fine, then we moved to
>>>> 4.9 and we had some issues.  I was able to bisect the issue down
>>>> to the patch in the subject line.
>>>>
>>>> f75b99d PCI: Enforce bus address limits in resource allocation
>>>>
>>>>   From 3.10 here is part of the PCI initialization,
>>>>
>>>> |pci 0001:0e:00.0: BAR 0: assigned [mem 0xfc0000000-0xfc00fffff pref]|
>>>> |pci 0001:07:09.0: PCI bridge to [bus 0e]|
>>>> |pci 0001:07:09.0: bridge window [mem 0xfc0000000-0xfc00fffff 64bit pref]|
>>>>                   |||In this section the memory resource for the bridge is
>>>> 64bit, and the device "BAR 0" gets a 64bit range. However, it seems the
>>>> device is 32bit.|
> 
>>>> |Now fast forward to 4.9 we get this,|
>>>
>>>> pci 0001:0e:00.0: BAR 0: no space for [mem size 0x00100000 pref]
>>>> pci 0001:0e:00.0: BAR 0: failed to assign [mem size 0x00100000 pref]
>>>> pci 0001:07:09.0: PCI bridge to [bus 0e]
>>>> pci 0001:07:09.0: bridge window [mem 0xfc0000000-0xfc00fffff 64bit pref]
>>>>
>>>> |Here it seems to have a larger size, I'm not sure where the size is coming
>>>> from.
>>>
>>> The size is 0x00100000 (1MB), which is the same size as
>>> [mem 0xfc0000000-0xfc00fffff pref].
>>>
>>> The size is normally discovered by probing the BAR (write all 1's to
>>> the BAR then read it back to find which bits are writable and which
>>> are read-only).  On powerpc we might learn it from DT instead.  But in
>>> any case, we to get the same 1MB size, which is the same size as the
>>> bridge window.  So this should still work unless there are other BARs
>>> in that window.
>>
>> As far as I know there is only one BAR connected to this window.
>>
>> It kind of strikes me as an off-by-one problem because it says "no space"
>> but the window is the same size as what's requested. With the patch removed
>> you get the whole window assigned.
>>
>> In the context of the patch if you change the pci_32_bit to pci_64_bit for
>> the region when calling pci_bus_alloc_from_region() in the 32bit case this
>> problem disappears. I do have CONFIG_ARCH_DMA_ADDR_T_64BIT enabled in my
>> config.
>>
>>>> I was able to work around the issue by setting IORESOURCE_MEM_64 on
>>>> the resource for this device. I also was able to work around it by setting
>>>> "max = avail.end" to "max = (-1);" inside pci_bus_alloc_resource(). |
>>>> ||
>>>> ||I don't know if the problem is the patch, or something else inside our
>>>> system, but any thoughts are appreciated.
>>>
>>> It seems like we think the bridge window contains only 64-bit space
>>> and therefore contains nothing usable by the 32-bit BAR.
>>>
>>> You said later that the same problem exists on v4.19-rc4.  Can you
>>> collect the complete dmesg log with that kernel?  That should tell us
>>> about any host bridge address translation.
>>
>> Sure. I have attached the dmesg.
> 
> The relevant parts are below.  I think your DT is incorrect.  Either
> it neglects to describe the host bridge address translation for the
> ffb240000.pcie and ffb250000.pcie bridges, or it incorrectly describes
> the BARs of devices below those bridges as 32-bit BARs when they are
> really 64-bit BARs.

I don't know if the DTS is correct, it very well could be incorrect. 
Here are the relevant parts of the DTS. The BAR at issue is connected to 
PCI1.

         pci0: pcie@ffb240000 {
                 compatible = "fsl,t1040-pcie", "fsl,qoriq-pcie-v2.4", 
"fsl,qoriq-pcie";
                 device_type = "pci";
                 #size-cells = <2>;
                 #address-cells = <3>;
                 bus-range = <0x0 0xff>;
                 interrupts = <20 2 0 0>;
                 fsl,iommu-parent = <&pamu0>;
                 reg = <0xf 0xfb240000 0 0x10000>;
                 ranges = <0x03000000 0xf 0xe0000000 0xf 0xe0000000 0 
0x01000000>;

                 pcie@0 {
                         reg = <0 0 0 0 0>;
                         #size-cells = <2>;
                         #address-cells = <3>;
                         device_type = "pci";
                 };
         };

         pci1: pcie@ffb250000 {
                 compatible = "fsl,t1040-pcie", "fsl,qoriq-pcie-v2.4", 
"fsl,qoriq-pcie";
                 device_type = "pci";
                 #size-cells = <2>;
                 #address-cells = <3>;
                 bus-range = <0 0xff>;
                 interrupts = <21 2 0 0>;
                 fsl,iommu-parent = <&pamu0>;
                 reg = <0xf 0xfb250000 0 0x10000>;

                 ranges = <0x03000000 0x4 0x00000000 0x4 0x00000000 0xc 
0x00000000>;

                 pcie@0 {
                         reg = <0 0 0 0 0>;
                         #size-cells = <2>;
                         #address-cells = <3>;
                         device_type = "pci";
                 };
         };

         pci3: pcie@ffb270000 {
                 compatible = "fsl,t1040-pcie", "fsl,qoriq-pcie-v2.4", 
"fsl,qoriq-pcie";
                 device_type = "pci";
                 #size-cells = <2>;
                 #address-cells = <3>;
                 bus-range = <0x0 0xff>;
                 interrupts = <23 2 0 0>;
                 fsl,iommu-parent = <&pamu0>;
                 reg = <0xf 0xfb270000 0 0x10000>;
                 ranges = <0x03000000 0x0 0xe2000000 0xf 0xe2000000 0 
0x00100000>;

                 pcie@0 {
                         reg = <0 0 0 0 0>;
                         #size-cells = <2>;
                         #address-cells = <3>;
                         device_type = "pci";
                 };
         };



Daniel
