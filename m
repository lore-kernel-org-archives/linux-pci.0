Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1448314314.15591.1.camel@oracle.com>
Subject: Re: [PATCH v8 00/61] PCI: Resource allocation cleanup for v4.4
From: Khalid Aziz <khalid.aziz@oracle.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 23 Nov 2015 14:31:54 -0700
In-Reply-To: <CAE9FiQU5YkwFVuEiDOCT+BDrrSLGhTiDfW7GZV6qVtBRKDBpDw@mail.gmail.com>
References: <1445979353-1728-1-git-send-email-yinghai@kernel.org>
	 <5633E570.6040906@oracle.com>
	 <CAE9FiQU5YkwFVuEiDOCT+BDrrSLGhTiDfW7GZV6qVtBRKDBpDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2015-10-30 at 18:53 -0700, Yinghai Lu wrote:
> On Fri, Oct 30, 2015 at 2:47 PM, Khalid Aziz <khalid.aziz@oracle.com> wrote:
> >
> > I applied patches 1-8 and 11-16 to 4.3.0-rc7 to test on sparc platforms. I
> > am seeing a "can't claim BAR" message on a T4:
> >
> > pci 0000:04:00.0: can't claim BAR 6 [mem 0x84000000000-0x8400000ffff]:
> > address conflict with 0000:04:00.0 [mem 0x84000000000-0x840007fffff]
> 
> PCI: scan_bus[/pci@400/pci@1/pci@0/pci@0/pci@0] bus no 4
>   * /pci@400/pci@1/pci@0/pci@0/pci@0/display@0
>     create device, devfn: 0, type: display
>     class: 0x30000 device name: 0000:04:00.0
>     parse addresses (80 bytes) @ fff8001fffe34f40
>   start: 84000000000, end: 840007fffff, i: 10
>   start: 84000800000, end: 8400081ffff, i: 14
>   start: 85100000000, end: 8510000007f, i: 18
>   start: 84000000000, end: 8400000ffff, i: 30
> 
> so the BAR 6 the ROM bar is overlapping with BAR0.
> and the ROM bar get rejected.
> 
> Looks like only the device BAR6 is not assigned form OF?
> 

Hi Yinghai,

Any progress on this? Do you need any more information from me?

Thanks,
Khalid

