Return-Path: <SRS0=Y6al=NC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F260C004D3
	for <linux-pci@archiver.kernel.org>; Mon, 22 Oct 2018 11:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E552064E
	for <linux-pci@archiver.kernel.org>; Mon, 22 Oct 2018 11:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E552064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeJVTqR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:46:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45498 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbeJVTqR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Oct 2018 15:46:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C35180D;
        Mon, 22 Oct 2018 04:28:07 -0700 (PDT)
Received: from [10.1.196.78] (ostrya.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A6643F6A8;
        Mon, 22 Oct 2018 04:28:04 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 3/7] PCI: OF: Allow endpoints to bypass the iommu
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jean-philippe Brucker <jphilippe.brucker@gmail.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        kevin.tian@intel.com, tnowicki@caviumnetworks.com,
        peter.maydell@linaro.org, marc.zyngier@arm.com,
        linux-pci@vger.kernel.org, jasowang@redhat.com,
        will.deacon@arm.com, virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, robh+dt@kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>, robin.murphy@arm.com,
        kvmarm@lists.cs.columbia.edu
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
 <20181012145917.6840-4-jean-philippe.brucker@arm.com>
 <20181012194158.GX5906@bhelgaas-glaptop.roam.corp.google.com>
 <20181015065024-mutt-send-email-mst@kernel.org>
 <482d0eb9-8c4c-9d64-7b32-25d5d11a8b8f@gmail.com>
 <20181017111100-mutt-send-email-mst@kernel.org>
Message-ID: <e5c44d21-7b43-32dd-4f5f-3136bacb07e0@arm.com>
Date:   Mon, 22 Oct 2018 12:27:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181017111100-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 17/10/2018 16:14, Michael S. Tsirkin wrote:
>>> Thinking about this comment, I would like to ask: can't the
>>> virtio device indicate the ranges in a portable way?
>>> This would minimize the dependency on dt bindings and ACPI,
>>> enabling support for systems that have neither but do
>>> have virtio e.g. through pci.
>>
>> I thought about adding a PROBE request for this in virtio-iommu, but it
>> wouldn't be usable by a Linux guest because of a bootstrapping problem.
> 
> Hmm. At some level it seems wrong to design hardware interfaces
> around how Linux happens to probe things. That can change at any time
> ...

I suspect that most other OS will also solve this class of problem using
a standard such as DT or ACPI, because they also provide dependency for
clock, interrupts, power management, etc. We can add a self-contained
PROBE method if someone makes a case for it, but it's unlikely to get
used at all, and nearly impossible to implement in Linux. The host would
still need a method to tell the guest which device to probe first, for
example with kernel parameters.

>> Early on, Linux needs a description of device dependencies, to determine
>> in which order to probe them. If the device dependency was described by
>> virtio-iommu itself, the guest could for example initialize a NIC,
>> allocate buffers and start DMA on the physical address space (which aborts
>> if the IOMMU implementation disallows DMA by default), only to find out
>> once the virtio-iommu module is loaded that it needs to cancel all DMA and
>> reconfigure the NIC. With a static description such as iommu-map in DT or
>> ACPI remapping tables, the guest can defer probing of the NIC until the
>> IOMMU is initialized.
>>
>> Thanks,
>> Jean
> 
> Could you point me at the code you refer to here?

In drivers/base/dd.c, really_probe() calls dma_configure() before the
device driver's probe(). dma_configure() ends up calling either
of_dma_configure() or acpi_dma_configure(), which return -EPROBE_DEFER
if the device's IOMMU isn't yet available. In that case the device is
added to the deferred pending list.

After another device is successfully bound to a driver, all devices on
the pending list are retried (driver_deferred_probe_trigger()), and if
the dependency has been resolved, then dma_configure() succeeds.

Another method (used by Intel and AMD IOMMU drivers) is to initialize
the IOMMU as early as possible, after discovering it in the ACPI tables
and before probing other devices. This can't work for virtio-iommu
because the driver might be a module, in which case early init isn't
possible. We have to defer probe of all dependent devices until the
virtio and virtio-iommu modules are loaded.

Thanks,
Jean
