Return-Path: <SRS0=cv1o=P5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02470C7113B
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 11:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DC020663
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 11:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfAUL30 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:29:26 -0500
Received: from foss.arm.com ([217.140.101.70]:60224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728254AbfAUL3Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jan 2019 06:29:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BAECEBD;
        Mon, 21 Jan 2019 03:29:24 -0800 (PST)
Received: from [10.1.196.128] (ostrya.cambridge.arm.com [10.1.196.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C0FC3F5C1;
        Mon, 21 Jan 2019 03:29:21 -0800 (PST)
Subject: Re: [PATCH v7 0/7] Add virtio-iommu driver
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     mark.rutland@arm.com, virtio-dev@lists.oasis-open.org,
        kevin.tian@intel.com, tnowicki@caviumnetworks.com,
        devicetree@vger.kernel.org, marc.zyngier@arm.com,
        linux-pci@vger.kernel.org, will.deacon@arm.com,
        robin.murphy@arm.com, virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, robh+dt@kernel.org,
        kvmarm@lists.cs.columbia.edu, bhelgaas@google.com,
        frowand.list@gmail.com, jasowang@redhat.com
References: <20190115121959.23763-1-jean-philippe.brucker@arm.com>
 <20190118103235-mutt-send-email-mst@kernel.org>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <0ba215f5-e856-bf31-8dd9-a85710714a7a@arm.com>
Date:   Mon, 21 Jan 2019 11:29:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190118103235-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 18/01/2019 15:51, Michael S. Tsirkin wrote:
> 
> On Tue, Jan 15, 2019 at 12:19:52PM +0000, Jean-Philippe Brucker wrote:
>> Implement the virtio-iommu driver, following specification v0.9 [1].
>>
>> This is a simple rebase onto Linux v5.0-rc2. We now use the
>> dev_iommu_fwspec_get() helper introduced in v5.0 instead of accessing
>> dev->iommu_fwspec, but there aren't any functional change from v6 [2].
>>
>> Our current goal for virtio-iommu is to get a paravirtual IOMMU working
>> on Arm, and enable device assignment to guest userspace. In this
>> use-case the mappings are static, and don't require optimal performance,
>> so this series tries to keep things simple. However there is plenty more
>> to do for features and optimizations, and having this base in v5.1 would
>> be good. Given that most of the changes are to drivers/iommu, I believe
>> the driver and future changes should go via the IOMMU tree.
>>
>> You can find Linux driver and kvmtool device on v0.9.2 branches [3],
>> module and x86 support on virtio-iommu/devel. Also tested with Eric's
>> QEMU device [4]. Please note that the series depends on Robin's
>> probe-deferral fix [5], which will hopefully land in v5.0.
>>
>> [1] Virtio-iommu specification v0.9, sources and pdf
>>     git://linux-arm.org/virtio-iommu.git virtio-iommu/v0.9
>>     http://jpbrucker.net/virtio-iommu/spec/v0.9/virtio-iommu-v0.9.pdf
>>
>> [2] [PATCH v6 0/7] Add virtio-iommu driver
>>     https://lists.linuxfoundation.org/pipermail/iommu/2018-December/032127.html
>>
>> [3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.9.2
>>     git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.9.2
>>
>> [4] [RFC v9 00/17] VIRTIO-IOMMU device
>>     https://www.mail-archive.com/qemu-devel@nongnu.org/msg575578.html
>>
>> [5] [PATCH] iommu/of: Fix probe-deferral
>>     https://www.spinics.net/lists/arm-kernel/msg698371.html
> 
> Thanks for the work!
> So really my only issue with this is that there's no
> way for the IOMMU to describe the devices that it
> covers.
> 
> As a result that is then done in a platform-specific way.
> 
> And this means that for example it does not solve the problem that e.g.
> some power people have in that their platform simply does not have a way
> to specify which devices are covered by the IOMMU.

Isn't power using device tree? I haven't looked much at power because I
was told a while ago that they already paravirtualize their IOMMU and
don't need virtio-iommu, except perhaps for some legacy platforms. Or
something along those lines. But I would certainly be interested in
enabling the IOMMU for more architectures.

As for the enumeration problem, I still don't think we can get much
better than DT and ACPI as solutions (and IMO they are necessary to make
this device portable). But I believe that getting DT and ACPI support is
just a one-off inconvenience. That is, once the required bindings are
accepted, any future extension can then be done at the virtio level with
feature bits and probe requests, without having to update ACPI or DT.

Thanks,
Jean

> Solving that problem would make me much more excited about
> this device.
> 
> On the other hand I can see that while there have been some
> developments most of the code has been stable for quite a while now.
> 
> So what I am trying to do right about now, is making a small module that
> loads early and pokes at the IOMMU sufficiently to get the data about
> which devices use the IOMMU out of it using standard virtio config
> space.  IIUC it's claimed to be impossible without messy changes to the
> boot sequence.
> 
> If I succeed at least on some platforms I'll ask that this design is
> worked into this device, minimizing info that goes through DT/ACPI.  If
> I see I can't make it in time to meet the next merge window, I plan
> merging the existing patches using DT (barring surprises).
> 
> As I only have a very small amount of time to spend on this attempt, If
> someone else wants to try doing that in parallel, that would be great!
> 
> 
>> Jean-Philippe Brucker (7):
>>   dt-bindings: virtio-mmio: Add IOMMU description
>>   dt-bindings: virtio: Add virtio-pci-iommu node
>>   of: Allow the iommu-map property to omit untranslated devices
>>   PCI: OF: Initialize dev->fwnode appropriately
>>   iommu: Add virtio-iommu driver
>>   iommu/virtio: Add probe request
>>   iommu/virtio: Add event queue
>>
>>  .../devicetree/bindings/virtio/iommu.txt      |   66 +
>>  .../devicetree/bindings/virtio/mmio.txt       |   30 +
>>  MAINTAINERS                                   |    7 +
>>  drivers/iommu/Kconfig                         |   11 +
>>  drivers/iommu/Makefile                        |    1 +
>>  drivers/iommu/virtio-iommu.c                  | 1158 +++++++++++++++++
>>  drivers/of/base.c                             |   10 +-
>>  drivers/pci/of.c                              |    7 +
>>  include/uapi/linux/virtio_ids.h               |    1 +
>>  include/uapi/linux/virtio_iommu.h             |  161 +++
>>  10 files changed, 1449 insertions(+), 3 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
>>  create mode 100644 drivers/iommu/virtio-iommu.c
>>  create mode 100644 include/uapi/linux/virtio_iommu.h
>>
>> -- 
>> 2.19.1
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 

