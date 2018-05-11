Return-Path: <SRS0=VBTT=H6=linux.intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=VBTT=H6=linux.intel.com=keith.busch@kernel.org>
Date: Fri, 11 May 2018 11:26:11 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andrew Lutomirski <amluto@gmail.com>, Jesse Vincent <jesse@fsck.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@fb.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: Another NVMe failure, this time with AER info
Message-ID: <20180511172610.GB7344@localhost.localdomain>
References: <CAObL_7G5k7XNqXqDZASChiQd1mt+AJPAdNKz-DE+xQawhUy6ZA@mail.gmail.com>
 <20180511165752.GG190385@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180511165752.GG190385@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 11, 2018 at 11:57:52AM -0500, Bjorn Helgaas wrote:
> We reported several corrected errors before the nvme timeout:
> 
>   [12750.281158] nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
>   [12750.297594] nvme nvme0: I/O 455 QID 2 timeout, disable controller
>   [12750.305196] nvme 0000:01:00.0: enabling device (0000 -> 0002)
>   [12750.305465] nvme nvme0: Removing after probe failure status: -19
>   [12750.313188] nvme nvme0: I/O 456 QID 2 timeout, disable controller
>   [12750.329152] nvme nvme0: I/O 457 QID 2 timeout, disable controller
> 
> The corrected errors are supposedly recovered in hardware without
> software intervention, and AER logs them for informational purposes.
> 
> But it seems very likely that these corrected errors are related to
> the nvme timeout: the first corrected errors were logged at
> 12720.894411, nvme_io_timeout defaults to 30 seconds, and the nvme
> timeout was at 12750.281158.

The nvme_timeout handling is broken at the moment, but I'm not sure any
of the fixes being considered will help here if we're really getting
MMIO errors (that's what it looks like).
 
> I don't have any good ideas.  As a shot in the dark, you could try
> running these commands before doing a suspend:
> 
>   # setpci -s01:00.0 0x98.W
>   # setpci -s00:1c.0 0x68.W
>   # setpci -s01:00.0 0x198.L
>   # setpci -s00:1c.0 0x208.L
> 
>   # setpci -s01:00.0 0x198.L=0x00000000
>   # setpci -s01:00.0 0x98.W=0x0000
>   # setpci -s00:1c.0 0x208.L=0x00000000
>   # setpci -s00:1c.0 0x68.W=0x0000
> 
>   # lspci -vv -s00:1c.0
>   # lspci -vv -s01:00.0
> 
> The idea is to turn off ASPM L1.2 and LTR, just because that's new and
> we've had issues with it before.  If you try this, please collect the
> output of the commands above in addition to the dmesg log, in case my
> math is bad.

I trust you know the offsets here, but it's hard to tell what this
is doing with hard-coded addresses. Just to be safe and for clarity,
I recommend the 'CAP_*+<offset>' with a mask.

For example, disabling ASPM L1.2 can look like:

 # setpci -s <B:D.f> CAP_PM+8.l=0:4

And disabling LTR:

 # setpci -s <B:D.f> CAP_EXP+28.w=0:400
