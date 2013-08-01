Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <51FA015E.10901@jp.fujitsu.com>
Date: Thu, 01 Aug 2013 15:34:06 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
To: bhelgaas@google.com
CC: rjw@sisk.pl, vgoyal@redhat.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, ishii.hironobu@jp.fujitsu.com,
	ddutile@redhat.com, bill.sumner@hp.com, alex.williamson@redhat.com,
	hbabu@us.ibm.com, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Reset PCIe devices to stop ongoing DMA
References: <1368509365-2260-1-git-send-email-indou.takao@jp.fujitsu.com> <51F85BCC.2070103@jp.fujitsu.com> <CAErSpo4yJ2yqCWv7GT7jWSVd_8SktU=xJXT78m8Vxp_wLA4Fow@mail.gmail.com> <1699397.FXoFYIGzbk@vostro.rjw.lan>
In-Reply-To: <1699397.FXoFYIGzbk@vostro.rjw.lan>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(2013/08/01 6:23), Rafael J. Wysocki wrote:
> On Wednesday, July 31, 2013 03:08:03 PM Bjorn Helgaas wrote:
>> [+cc Rafael, linux-acpi]
>>
>> On Tue, Jul 30, 2013 at 6:35 PM, Takao Indoh <indou.takao@jp.fujitsu.com> wrote:
>>
>>> On x86, currently IOMMU initialization run *after* PCI enumeration, but
>>> what you are talking about is that it should be changed so that x86
>>> IOMMU initialization is done *before* PCI enumeration like sparc, right?
>>
>> Yes.  I don't know whether or when that initialization order will ever
>> be changed, but I do think we should avoid building more
>> infrastructure that depends on the current order.
>>
>> Changing the order is a pretty big deal because it's a lot more than
>> just the IOMMU.  Basically I think we should be enumerating ACPI
>> devices, including the IOMMU, before PCI devices, but there's a lot of
>> legacy involved in that area.  Added Rafael in case he has any
>> thoughts.
> 
> Well, actually, I'm not really familiar with IOMMUs, sorry.
> 
> I do think that initializing IOMMU before PCI enumeration would be better,
> however.  At least if the ordering should be the same on all architectures,
> which I suppose is the case, that's the one I'd choose.

Ok guys. If x86 IOMMU maintainer also thinks changing order is
necessary, maybe I need to give up device reset in kdump kernel and
consider doing it in panic kernel.

Either way, I need bus reset interface to reset devices. Bjorn, could
you review the bus reset patches Alex posted yesterday?

Thanks,
Takao Indoh

