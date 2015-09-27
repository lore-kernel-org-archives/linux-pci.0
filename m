Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAL-B5D3FgF+o7BcLBe7O_gcxy2jf3w43bXeDJuRH2VS2ES0A7Q@mail.gmail.com>
References: <CAL-B5D3FgF+o7BcLBe7O_gcxy2jf3w43bXeDJuRH2VS2ES0A7Q@mail.gmail.com>
Date: Sun, 27 Sep 2015 14:19:25 -0600
Message-ID: <CAL-B5D2N_DQCEtJtbq6DtV+6FsrB_4=sb2mO64xv2z4HsrOPhw@mail.gmail.com>
Subject: Re: [RFC] PCI: Unassigned Expansion ROM BARs
From: Myron Stowe <myron.stowe@gmail.com>
To: linux-pci <linux-pci@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 23, 2015 at 8:47 PM, Myron Stowe <myron.stowe@gmail.com> wrote:
snip
>
> There is a kernel boot parameter, pci=norom, that is intended to disable the
> kernel's resource assignment actions for Expansion ROMs that do not already
> have BIOS assigned address ranges.  Note however, if I remember correctly,
> that this only works if the Expansion ROM BAR is set to "0" by the BIOS
> before hand-off.

In private conversations I was asked: Why do you propose asking the BIOS
to assign setting Expansion ROM BARs to "0"?

That is not what I'm advocating.  I think it's a complete hack.

  Some background context - this is effectively the defacto detente that
  has come to be somehow with one of the major vendor's BIOS' to
  circumvent 'dmesg' entries corresponding to unassigned Expansion ROM
  BARs which draws customer attention.

Unless something has changed recently, specifying "pci=norom" when booting
does not cause the kernel to completely ignore Expansion ROM BARs
all together as one would expect.  The kernel still outputs 'dmesg's
corresponding to unassigned Expansion ROM BARs and also attempts to
allocate such.  This is a kernel bug in my opinion.  It's only if both
"pci=norom" has been specified, and, the BIOS has set the Expansion ROM
BARs to "0" that the kernel completely ignores Expansion ROM BARs and no
'dmesg's are output.

Customers don't want to, and shouldn't have to, utilize kernel parameters.
They are indispensable for kernel engineers to use for debugging and such
but not for normal, every day, (i.e. customer) use.  So, no, I am not
advocating the current defacto detente that is in place today
