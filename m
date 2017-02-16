Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36164 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932740AbdBPUVP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2017 15:21:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170216200624.GA4274@amd>
References: <CA+55aFxuXgsCyMgrRDHdM6BQaej68QoU8TwdM=3LYu9LMBf4fQ@mail.gmail.com>
 <20170215172303.GA15696@amd> <20170215232005.GA7877@amd> <CA+55aFyqsxjQPp=Y6MnvyMH_iA-TSiPrycnAHbBzw5bwQi7jjg@mail.gmail.com>
 <20170216111144.GA12377@amd> <20170216172535.GA7868@amd> <20170216181353.GB4357@lerouge>
 <CA+55aFwhzMWR8QPGEK+8O8r0sFpHjn4XXraQ9K0Hq4VQi8Ru-w@mail.gmail.com>
 <20170216183421.GC4357@lerouge> <alpine.DEB.2.20.1702162033200.4049@nanos> <20170216200624.GA4274@amd>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 16 Feb 2017 12:21:13 -0800
Message-ID: <CA+55aFz9bEfwMFUgj2zX+X9Cy_Rv0994AWX4DW+YmqdK8wCa1Q@mail.gmail.com>
Subject: Re: v4.10-rc8 (-rc6) boot regression on Intel desktop, does not boot
 after cold boots, boots after reboot
To: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        wanpeng.li@hotmail.com, Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>,
        "# .39.x" <stable@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 16, 2017 at 12:06 PM, Pavel Machek <pavel@ucw.cz> wrote:
>
> Hmm, that would explain problems at boot _and_ problems during
> suspend/resume.

I've committed the revert, and I'm just assuming that the revert also
fixed your suspend/resume issues, but I wanted to just double-check
that since it's only implied, no staed explicitly..

     Linus
