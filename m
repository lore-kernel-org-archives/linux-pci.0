Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 16 Feb 2017 19:13:56 +0100
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        wanpeng.li@hotmail.com, peterz@infradead.org, riel@redhat.com,
        tglx@linutronix.de, stable@kernel.org,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: v4.10-rc8 (-rc6) boot regression on Intel desktop, does not boot
 after cold boots, boots after reboot
Message-ID: <20170216181353.GB4357@lerouge>
References: <CA+55aFyYAztA+Onquy9ODeC9_YBL_fXAd-RgeUVUhpsjK81ZVQ@mail.gmail.com>
 <CA+55aFxU1D0hAPJuhkKaFBByi=8vpw7dJUX=FfpoqnZLWsvxig@mail.gmail.com>
 <CA+55aFwt6pbt2STzRh1yCdoo7AnCLFqnPkkrYk4_BGFuvT2VCw@mail.gmail.com>
 <CA+55aFzMiXXw9gqNCMCSc+O5HfcqWHXfqbdtbvcOmAHM9_wNig@mail.gmail.com>
 <CA+55aFxuXgsCyMgrRDHdM6BQaej68QoU8TwdM=3LYu9LMBf4fQ@mail.gmail.com>
 <20170215172303.GA15696@amd>
 <20170215232005.GA7877@amd>
 <CA+55aFyqsxjQPp=Y6MnvyMH_iA-TSiPrycnAHbBzw5bwQi7jjg@mail.gmail.com>
 <20170216111144.GA12377@amd>
 <20170216172535.GA7868@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170216172535.GA7868@amd>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 16, 2017 at 06:25:35PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > 4.10-rc4 broken
> > > > 4.10-rc3 ok
> > > 
> > > Hmm. If those actually end up being reliable, then there's not a whole
> > > lot in between them wrt PCI or USB.
> > > 
> > > What looked like the most likely candidate seems to be xhci-specific, though.
> > > 
> > > But maybe it's something that isn't directly in drivers/{pci,usb}/ and
> > > just interacts badly.
> > 
> > Ok. I _hope_ my tests are ok. Bisect log so far is:
> 
> And the winner is:
> 
> pavel@half:/data/l/linux$ git bisect bad
> 24b91e360ef521a2808771633d76ebc68bd5604b is the first bad commit
> commit 24b91e360ef521a2808771633d76ebc68bd5604b
> Author: Frederic Weisbecker <fweisbec@gmail.com>
> Date:   Wed Jan 4 15:12:04 2017 +0100
> 
>     nohz: Fix collision between tick and other hrtimers

I haven't followed the discussion but this patch has a known issue which is fixed
with:
    7bdb59f1ad474bd7161adc8f923cdef10f2638d1
    "tick/nohz: Fix possible missing clock reprog after tick soft restart"

I hope this fixes your issue.
