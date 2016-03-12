Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 12 Mar 2016 10:39:15 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Yinghai Lu <yinghai@kernel.org>
cc: Bjorn Helgaas <helgaas@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 06/59] PCI: Kill wrong quirk about M7101
In-Reply-To: <CAE9FiQWeq=VssPtW86KcOuW5rLr+t5628Fid7e4RG_R_gZ+Aaw@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1603121039020.32556@math.ut.ee>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org> <1456366370-28995-7-git-send-email-yinghai@kernel.org> <20160310174030.GB17238@localhost> <CAE9FiQVAPfb-PYGQoRJzXdn3NAOK-X25M9pWvR2m7_9qT5qQ+w@mail.gmail.com> <alpine.LRH.2.20.1603120951320.32556@math.ut.ee>
 <CAE9FiQWeq=VssPtW86KcOuW5rLr+t5628Fid7e4RG_R_gZ+Aaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On Fri, Mar 11, 2016 at 11:52 PM, Meelis Roos <mroos@linux.ee> wrote:
> >> On Thu, Mar 10, 2016 at 9:40 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> > On Wed, Feb 24, 2016 at 06:11:57PM -0800, Yinghai Lu wrote:
> >> >> Meelis reported that qla2000 driver does not get loaded on one sparc system.
> >> >>
> >> >> schizo f00732d0: PCI host bridge to bus 0001:00
> >> >> pci_bus 0001:00: root bus resource [io  0x7fe01000000-0x7fe01ffffff] (bus address [0x0000-0xffffff])
> >> >> pci 0001:00:06.0: quirk: [io  0x7fe01000800-0x7fe0100083f] claimed by ali7101 ACPI
> >> >> pci 0001:00:06.0: quirk: [io  0x7fe01000600-0x7fe0100061f] claimed by ali7101 SMB
> >> >> pci 0001:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: address conflict with 0001:00:06.0 [io  0x7fe01000600-0x7fe0100061f]
> >> >>
> >> >> So the quirk for M7101 claim the io range early.
> >
> > But why did it work until 4.2 and only with 4.3 the allocations broke?
> >
> 
> My understanding is we really install the root bus resource and try to
> do the sanitary checking
> for device resource.
> 
> Or did you find exact commit between 4.2 and 4.3 cause the problem ?

No, I have not bisected that.

-- 
Meelis Roos (mroos@linux.ee)
