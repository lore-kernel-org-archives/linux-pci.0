Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 11 May 2018 12:55:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@linux.intel.com>
Subject: Re: Another NVMe failure, this time with AER info
Message-ID: <20180511175538.GH190385@bhelgaas-glaptop.roam.corp.google.com>
References: <CAObL_7G5k7XNqXqDZASChiQd1mt+AJPAdNKz-DE+xQawhUy6ZA@mail.gmail.com>
 <20180511165752.GG190385@bhelgaas-glaptop.roam.corp.google.com>
 <20180511172610.GB7344@localhost.localdomain>
 <20180511174241.GC7344@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20180511174241.GC7344@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jesse Vincent <jesse@fsck.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci@vger.kernel.org, Andrew Lutomirski <amluto@gmail.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 11, 2018 at 11:42:42AM -0600, Keith Busch wrote:
> On Fri, May 11, 2018 at 11:26:11AM -0600, Keith Busch wrote:
> > I trust you know the offsets here, but it's hard to tell what this
> > is doing with hard-coded addresses. Just to be safe and for clarity,
> > I recommend the 'CAP_*+<offset>' with a mask.
> > 
> > For example, disabling ASPM L1.2 can look like:
> > 
> >  # setpci -s <B:D.f> CAP_PM+8.l=0:4
> 
> My mistake above: CAP_PM is a different capability, not the intended
> one. It looks like setpci doesn't even have a convenient symbol for the
> L1 PM extended capability, so the hard-coded offsets are the only way
> for this setting. Sorry about the mistake.

No problem, would be a nice janitor job to add more of those symbolic
offsets to setpci.  I recently added more cap ID decoding to lspci, but
didn't think about updating these things for setpci.

Using the symbols would definitely make this easier and better!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
