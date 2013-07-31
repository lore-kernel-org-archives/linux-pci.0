Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"ishii.hironobu@jp.fujitsu.com" <ishii.hironobu@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	"Sumner, William" <bill.sumner@hp.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	Haren Myneni <hbabu@us.ibm.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Reset PCIe devices to stop ongoing DMA
Date: Wed, 31 Jul 2013 23:23:28 +0200
Message-ID: <1699397.FXoFYIGzbk@vostro.rjw.lan>
In-Reply-To: <CAErSpo4yJ2yqCWv7GT7jWSVd_8SktU=xJXT78m8Vxp_wLA4Fow@mail.gmail.com>
References: <1368509365-2260-1-git-send-email-indou.takao@jp.fujitsu.com> <51F85BCC.2070103@jp.fujitsu.com> <CAErSpo4yJ2yqCWv7GT7jWSVd_8SktU=xJXT78m8Vxp_wLA4Fow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, July 31, 2013 03:08:03 PM Bjorn Helgaas wrote:
> [+cc Rafael, linux-acpi]
> 
> On Tue, Jul 30, 2013 at 6:35 PM, Takao Indoh <indou.takao@jp.fujitsu.com> wrote:
> 
> > On x86, currently IOMMU initialization run *after* PCI enumeration, but
> > what you are talking about is that it should be changed so that x86
> > IOMMU initialization is done *before* PCI enumeration like sparc, right?
> 
> Yes.  I don't know whether or when that initialization order will ever
> be changed, but I do think we should avoid building more
> infrastructure that depends on the current order.
> 
> Changing the order is a pretty big deal because it's a lot more than
> just the IOMMU.  Basically I think we should be enumerating ACPI
> devices, including the IOMMU, before PCI devices, but there's a lot of
> legacy involved in that area.  Added Rafael in case he has any
> thoughts.

Well, actually, I'm not really familiar with IOMMUs, sorry.

I do think that initializing IOMMU before PCI enumeration would be better,
however.  At least if the ordering should be the same on all architectures,
which I suppose is the case, that's the one I'd choose.

Thanks,
Rafael

