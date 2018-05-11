Return-Path: <SRS0=VBTT=H6=linux.intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=VBTT=H6=linux.intel.com=keith.busch@kernel.org>
Date: Fri, 11 May 2018 11:42:42 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jesse Vincent <jesse@fsck.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org, Andrew Lutomirski <amluto@gmail.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@fb.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: Another NVMe failure, this time with AER info
Message-ID: <20180511174241.GC7344@localhost.localdomain>
References: <CAObL_7G5k7XNqXqDZASChiQd1mt+AJPAdNKz-DE+xQawhUy6ZA@mail.gmail.com>
 <20180511165752.GG190385@bhelgaas-glaptop.roam.corp.google.com>
 <20180511172610.GB7344@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180511172610.GB7344@localhost.localdomain>
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 11, 2018 at 11:26:11AM -0600, Keith Busch wrote:
> I trust you know the offsets here, but it's hard to tell what this
> is doing with hard-coded addresses. Just to be safe and for clarity,
> I recommend the 'CAP_*+<offset>' with a mask.
> 
> For example, disabling ASPM L1.2 can look like:
> 
>  # setpci -s <B:D.f> CAP_PM+8.l=0:4

My mistake above: CAP_PM is a different capability, not the intended
one. It looks like setpci doesn't even have a convenient symbol for the
L1 PM extended capability, so the hard-coded offsets are the only way
for this setting. Sorry about the mistake.
