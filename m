Return-Path: <SRS0=HZWG=3X=google.com=bhelgaas@kernel.org>
Return-Path: <SRS0=HZWG=3X=google.com=bhelgaas@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1492206774.25766.14.camel@kernel.crashing.org>
References: <1491825494-19331-1-git-send-email-elohimes@gmail.com>
 <1491825494-19331-4-git-send-email-elohimes@gmail.com> <20170414155849.GB5864@bhelgaas-glaptop.roam.corp.google.com>
 <1492206774.25766.14.camel@kernel.crashing.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 15 Apr 2017 11:36:10 -0500
Message-ID: <CAErSpo5Orx8c453Fn6-PX-7woseSkZFcYO1Yu+1L+B-h6w0T+A@mail.gmail.com>
Subject: Re: [PATCH v10 3/4] powerpc/powernv: Override pcibios_default_alignment()
 to force PCI devices to be page aligned
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Yongji Xie <elohimes@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Ellerman <mpe@ellerman.id.au>,
	"paulus@samba.org" <paulus@samba.org>, Li Zhong <zhong@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 14, 2017 at 4:52 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2017-04-14 at 10:58 -0500, Bjorn Helgaas wrote:
>> On Mon, Apr 10, 2017 at 07:58:13PM +0800, Yongji Xie wrote:
>> > This overrides pcibios_default_alignment() to set default alignment
>> > to PAGE_SIZE for all PCI devices on PowerNV platform. Thus sub-page
>> > BARs would not share a page and could be mapped into guest when
>> > VFIO
>> > passthrough them.
>>
>> Thanks for doing this.  This looks like a reasonable strategy to me,
>> but it would be good to get a powerpc ack for it.
>
> I agree in principle. I'm surprised that PowerPC is the only one
> interested here though, what about other platforms who want to use
> KVM and PCI pass-through and use Linux to assign BARs ?

If I understand correctly, the problem is with BARs smaller than a
page, and this happens more on PowerPC because larger page sizes are
more common there.

Bjorn
