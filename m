Return-Path: <yhlu.kernel@gmail.com>
Return-Path: <yhlu.kernel@gmail.com>
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <20160506182600.GA22909@localhost>
References: <CAE9FiQU_XSMfxFPSOrMjQ2DGnrM0D5T=0ORfDEBxqWggGrzc+Q@mail.gmail.com>
	<CAE9FiQX_8oXj=FD8pKe=eBL=YWZY-=C8sZ6yMbmkwegLVOR-fA@mail.gmail.com>
	<1462322260.30470.76.camel@kernel.crashing.org>
	<20160504012531.GB17170@localhost>
	<CAE9FiQU=e2bf=+KDrOETf_T-KPLQsSDiG5GqVFqgtvSWXwUz4w@mail.gmail.com>
	<CAE9FiQV19OUsSL34GzDXYtVG=Xs724CpwHNfu3HCmYMUqbmrqQ@mail.gmail.com>
	<20160504151722.GA22051@localhost>
	<CAE9FiQXEBkVak0No9dfOidzCrR+UVu44WyBEK8SqTUSiJKeJbg@mail.gmail.com>
	<CAE9FiQUEMq4aj2iAq=P0xu4=1MGuOWgOubpkn=2h+YLXgwJKRQ@mail.gmail.com>
	<CAE9FiQWJ0VH-PNsz96qW8_u14x6bJ6cd66+Zg=j3L4zXWvhq0Q@mail.gmail.com>
	<20160506182600.GA22909@localhost>
Date: Mon, 9 May 2016 23:18:41 -0700
Message-ID: <CAE9FiQUJAsJf_z7218q0Ar65sr4jPbm0hEQEg2QwaK=cypzJAg@mail.gmail.com>
Subject: Re: [PATCH v11 04/60] sparc/PCI: Use correct offset for bus address
 to resource
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>,
	Bjorn Helgaas <bhelgaas@google.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>, Khalid Aziz <khalid.aziz@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 6, 2016 at 11:26 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> v3, that have more change to pass *res to make powerpc prot setting simple.
>
> This looks corrupted.  On v4.6-rc2:
>
>   $ stg import -M m/yh3
>   Checking for changes in the working directory ... done
>   Importing patch "re-patch-v11-04-60-sparc-pci" ... fatal: corrupt patch at line 266
>   stg import: Diff does not apply cleanly

Just resent them in plain/text mail. Please have a look.

>
...
>
> This looks like it could possibly be split into several patches.  I
> think it's too big to apply as-is.

Not that big except it remove lots of lines.

>
> I'm not sure what bug this is fixing or what improvement it's making.

fix sparc64 proc mmap path, as it can not pass checking in pci_mmap_fits()
with comparing BAR value and resource adder without offset.

also it will make
   sparc/PCI: Use correct offset for bus address to resource
and other one much simple.

Thanks

Yinghai
