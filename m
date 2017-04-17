Return-Path: <SRS0=6Kxz=3Z=google.com=bhelgaas@kernel.org>
Return-Path: <SRS0=6Kxz=3Z=google.com=bhelgaas@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1492293974.25766.30.camel@kernel.crashing.org>
References: <1491825494-19331-1-git-send-email-elohimes@gmail.com>
 <1491825494-19331-4-git-send-email-elohimes@gmail.com> <20170414155849.GB5864@bhelgaas-glaptop.roam.corp.google.com>
 <1492206774.25766.14.camel@kernel.crashing.org> <CAErSpo5Orx8c453Fn6-PX-7woseSkZFcYO1Yu+1L+B-h6w0T+A@mail.gmail.com>
 <1492293974.25766.30.camel@kernel.crashing.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 17 Apr 2017 10:51:09 -0500
Message-ID: <CAErSpo6X0JwjqfPN3A5XGqKTdsXw3crTOvn9n+jvN86XHgriVw@mail.gmail.com>
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

On Sat, Apr 15, 2017 at 5:06 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sat, 2017-04-15 at 11:36 -0500, Bjorn Helgaas wrote:
>> > I agree in principle. I'm surprised that PowerPC is the only one
>> > interested here though, what about other platforms who want to use
>> > KVM and PCI pass-through and use Linux to assign BARs ?
>>
>> If I understand correctly, the problem is with BARs smaller than a
>> page, and this happens more on PowerPC because larger page sizes are
>> more common there.
>
> Yes, it happens "more". That doesn't mean it doesn't happen at all on
> others :-) Anyway, I'm not objecting, just surprised.

Yeah, I agree.  Maybe the devices interesting for pass-through tend to
have BARs of least 4KB?  Those would never be a problem on x86.  But I
have absolutely no data either way.
