Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89783C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 13:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6452820854
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 13:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbfCYNAJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:00:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47326 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731133AbfCYNAJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Mar 2019 09:00:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A32DC80D;
        Mon, 25 Mar 2019 06:00:08 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05BA03F575;
        Mon, 25 Mar 2019 06:00:06 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 1/2] dt-bindings: Add external-facing PCIe port property
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        Grant Likely <Grant.Likely@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190318182124.53859-1-jean-philippe.brucker@arm.com>
 <20190318182124.53859-2-jean-philippe.brucker@arm.com>
 <20190320220338.GH251185@google.com>
Message-ID: <598b0675-38b2-9e52-d903-016dc548756c@arm.com>
Date:   Mon, 25 Mar 2019 12:59:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190320220338.GH251185@google.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20/03/2019 22:03, Bjorn Helgaas wrote:
> On Mon, Mar 18, 2019 at 06:21:23PM +0000, Jean-Philippe Brucker wrote:
>> Provide a way for the firmware to tell the OS which devices are external
>> to the machine and therefore untrusted. The property can describe for
>> example thunderbolt and other hot-pluggable ports, which should always
>> have the strongest IOMMU protection.
> 
> s/thunderbolt/Thunderbolt/
> 
> I think the important bit is that the port is user-accessible, whether
> it is hot-pluggable or not, right?

Yes, I'll change this

> 
> I think I'm OK with this from a PCI perspective.
> 
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> ---
>>  Documentation/devicetree/bindings/pci/pci.txt | 47 +++++++++++++++++++
>>  1 file changed, 47 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
>> index c77981c5dd18..55cdbc5d2804 100644
>> --- a/Documentation/devicetree/bindings/pci/pci.txt
>> +++ b/Documentation/devicetree/bindings/pci/pci.txt
>> @@ -24,3 +24,50 @@ driver implementation may support the following properties:
>>     unsupported link speed, for instance, trying to do training for
>>     unsupported link speed, etc.  Must be '4' for gen4, '3' for gen3, '2'
>>     for gen2, and '1' for gen1. Any other values are invalid.
>> +
>> +PCI-PCI Bridge properties
>> +-------------------------
>> +
>> +Root ports and switch ports may be described explicitly in the device
> 
> Maybe "PCIe root ports and switch ports" since pci.txt seems to apply
> to both conventional PCI and PCIe?

Ok

> 
>> +tree, as children of the host bridge node. Even though those devices are
>> +discoverable by probing, it might be necessary to describe properties that
>> +aren't provided by standard PCIe capabilities.
>> +
>> +Required properties:
>> +
>> +- reg:
>> +   Identifies the PCI-PCI bridge. As defined in the IEEE Std 1275-1994
>> +   document, it is a five-cell address encoded as (phys.hi phys.mid
>> +   phys.lo size.hi size.lo). phys.hi should contain the device's BDF as
>> +   0b00000000 bbbbbbbb dddddfff 00000000. The other cells should be zero.
>> +
>> +   The bus number is defined by firmware, through the standard bridge
>> +   configuration mechanism. If this port is a switch port, then firmware
>> +   allocates the bus number and writes it into the Secondary Bus Number
>> +   register of the bridge directly above this port. Otherwise, the bus
>> +   number of a root port is the first number in the bus-range property,
>> +   defaulting to zero.
>> +
>> +   If firmware leaves the ARI Forwarding Enable bit set in the bridge
>> +   above this port, then phys.hi contains the 8-bit function number as
>> +   0b00000000 bbbbbbbb ffffffff 00000000. Note that the PCIe specification
>> +   recommends that firmware only leaves ARI enabled when it knows that the
>> +   OS is ARI-aware.
>> +
>> +Optional properties:
>> +
>> +- external-facing:
>> +   When present, the port is external facing. All bridges and endpoints
>> +   downstream of this port are external to the machine.
> 
> Maybe include a note about why this is important, ie, we care because
> malicious devices may be attached to an external port?  I know you
> have that in the commit log but it would be more visible here.
> 
> Elsewhere you use "external-facing", here too for consistency?

Makes sense, I'll add a note. I currently have:

- external-facing:
   When present, the port is external-facing. All bridges and endpoints
   downstream of this port are external to the machine. The OS can, for
   example, use this information to identify devices that cannot be
   trusted with relaxed DMA protection, as users could easily attach
   malicious devices to this port.

Thanks for reviewing, I'll resend shortly

Jean

> 
>> +Example:
>> +
>> +pcie@10000000 {
>> +	compatible = "pci-host-ecam-generic";
>> +	...
>> +	pcie@0008 {
>> +		/* Root port 00:01.0 is external-facing */
>> +		reg = <0x00000800 0 0 0 0>;
>> +		external-facing;
>> +	};
>> +};
>> -- 
>> 2.21.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

