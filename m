Return-Path: <bharat.kumar.gogada@xilinx.com>
Return-Path: <bharat.kumar.gogada@xilinx.com>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>, nofooter <nofooter@xilinx.com>
Subject: RE: Why does BIOS assign memory to 16 byte BAR
Date: Wed, 27 Jul 2016 10:09:59 +0000
Message-ID: <8520D5D51A55D047800579B094147198258BC67A@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B094147198258BB59B@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160722151546.GA20646@localhost> <20160722155133.GB20646@localhost>
 <8520D5D51A55D047800579B094147198258BC23C@XAP-PVEXMBX01.xlnx.xilinx.com>
 <8520D5D51A55D047800579B094147198258BC2BB@XAP-PVEXMBX01.xlnx.xilinx.com>
 <CAE9FiQWaFAD0+biMmnKqSQ2K4AdRJJmeEZ=ASSsvEgiDsKAP6Q@mail.gmail.com>
 <8520D5D51A55D047800579B094147198258BC5E3@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160727093422.GA8334@red-moon>
In-Reply-To: <20160727093422.GA8334@red-moon>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

> > We see that similar test is passing in x86 machine, where function one
> > requesting 1GB BAR's is failing, but function two requesting BAR's
> > with 16byte is getting assigned BAR's.
> >
> > To my knowledge on x86 BIOS assigns resources, or will kernel assign
> > reosurces on x86 ?  If kernel does is there any difference between x86
> > and arm64 resource assignment logic ?
>
> We can't answer your question if you do not provide a full log of x86 and
> ARM PCI configurations you are testing I am afraid.
>
> It is also unclear to me what "a similar test is passing in x86 machine" =
means,
> in particular in relation to the HW configuration you are testing on x86.
>
> Yes, there are differences between x86 and ARM resources assignments,
> x86 tries to claim PCI resources as set-up by BIOS and assign them iff th=
e
> claiming fails whereas on ARM (and that's done in the host bridge driver)=
 FW
> configuration is always discarded and the kernel reassigns the whole PCI
> resource hierarchy entirely, but to help we need more data as I said abov=
e.
>

Thanks Lorenzo.
I will try to get x86 configuration details soon and post, as the setup is =
at different location.
On ARM we using pcie-xilinx-nwl.c configurations where we have where we hav=
e 240MB BAR space
as per device tree documentation. (The kernel log I posted for testing purp=
ose is using different address spaces,
if tests were successful, we will soon send patches for device tree)

Similar test case means, on x86 where we have multifunction device, where 1=
st function requests 1GB memory BAR's
and 2nd function requests 16byte memory BAR's, for 1st function BAR's are n=
ot assigned, but for 2nd function 16byte BAR assignment
is successful.

But on ARM similar test case fails to assign BAR's for both first function =
and second function.

What is the reason on ARM we are handling resource assignment in hierarchy =
format?
Because on ARM, in the above case due to lack of resources first function B=
AR assignment fails  which is fine but
even though we have enough resources for 16byte BAR allocations for second =
function, we are not assigning.


Thanks & Regards,
Bharat


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
