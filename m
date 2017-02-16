Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170216181353.GB4357@lerouge>
References: <CA+55aFyYAztA+Onquy9ODeC9_YBL_fXAd-RgeUVUhpsjK81ZVQ@mail.gmail.com>
 <CA+55aFxU1D0hAPJuhkKaFBByi=8vpw7dJUX=FfpoqnZLWsvxig@mail.gmail.com>
 <CA+55aFwt6pbt2STzRh1yCdoo7AnCLFqnPkkrYk4_BGFuvT2VCw@mail.gmail.com>
 <CA+55aFzMiXXw9gqNCMCSc+O5HfcqWHXfqbdtbvcOmAHM9_wNig@mail.gmail.com>
 <CA+55aFxuXgsCyMgrRDHdM6BQaej68QoU8TwdM=3LYu9LMBf4fQ@mail.gmail.com>
 <20170215172303.GA15696@amd> <20170215232005.GA7877@amd> <CA+55aFyqsxjQPp=Y6MnvyMH_iA-TSiPrycnAHbBzw5bwQi7jjg@mail.gmail.com>
 <20170216111144.GA12377@amd> <20170216172535.GA7868@amd> <20170216181353.GB4357@lerouge>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 16 Feb 2017 10:20:14 -0800
Message-ID: <CA+55aFwhzMWR8QPGEK+8O8r0sFpHjn4XXraQ9K0Hq4VQi8Ru-w@mail.gmail.com>
Subject: Re: v4.10-rc8 (-rc6) boot regression on Intel desktop, does not boot
 after cold boots, boots after reboot
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, wanpeng.li@hotmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "# .39.x" <stable@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 16, 2017 at 10:13 AM, Frederic Weisbecker
<fweisbec@gmail.com> wrote:
>
> I haven't followed the discussion but this patch has a known issue which is fixed
> with:
>     7bdb59f1ad474bd7161adc8f923cdef10f2638d1
>     "tick/nohz: Fix possible missing clock reprog after tick soft restart"
>
> I hope this fixes your issue.

No, Pavel saw the problem with rc8 too, which already has that fix.

So I think we'll just need to revert that original patch (and that
means that we have to revert the commit you point to as well, since
that ->next_tick field was added by the original commit).

Pavel, can you verify that rc8 with both

  24b91e360ef521a2808771633d76ebc68bd5604b
  7bdb59f1ad474bd7161adc8f923cdef10f2638d1

reverted works reliably for you?

               Linus
