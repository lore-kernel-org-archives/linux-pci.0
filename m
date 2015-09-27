Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAL-B5D3FgF+o7BcLBe7O_gcxy2jf3w43bXeDJuRH2VS2ES0A7Q@mail.gmail.com>
References: <CAL-B5D3FgF+o7BcLBe7O_gcxy2jf3w43bXeDJuRH2VS2ES0A7Q@mail.gmail.com>
Date: Sun, 27 Sep 2015 13:29:23 -0600
Message-ID: <CAL-B5D3LxL1VqEba8wChnqPZ9EhtGvqN+MxN-v2DgQHiFAJS7w@mail.gmail.com>
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
> The kernel expects device Expansion ROM BARs to be programmed with valid
> values - even if the respective Expansion ROM's Enable bit is 0 (i.e. the
> device’s expansion ROM address space is disabled).  This seems to be the
> main contention point with said BIOS engineers.  If an Expansion ROM BAR is
> not programmed, the kernel will attempt to find available resources and, if
> successful, program it.  As this occurs various 'dmesg' entries
> related to kernel's actions are output.
>

The respective BIOS engineers from the two major vendors exhibiting the
behavior outlined are aware of, and monitoring, this thread.  With the
exception of Daniel's recent post, there hasn't been much substance presented
supporting the OS's viewpoint to encourage the BIOS engineers to enter
into any kind of discussion.  The majority of the responses have gone
straight towards how the OS can effectively work around platform's that
exhibit such setups.  I'd like to step back and present known instances of
the OS's need(s) to access the Expansion (a.k.a. option) ROMs - something
for the BIOS engineers to consider; something with which to start a
dialogue.


There are at least three known major reasons why Linux uses the ROMs:

1) For many of the video cards, Linux has drivers that assume the card has
been initialized by the ROM.  The drivers work fine, but they aren't smart
enough to work with the card straight out of reset - a lot of which is due
to specific vendor's keeping their devices closed; the code remains
proprietary.  When such devices are reset when the OS is running (i.e.
when X is restarted), the OS has to run the ROM before the driver works
again.  Alex Williamson and Daniel Blueman both covered this fairly well,
including the current dificiencies of such, in prior threads.

2) As Daniel further expressed, hot-plug scenarios and PCI domains which
may not be visible to the BIOS at initial boot, may need to access the
ROMs.  In these environments - PCI hiearchies shared among multiple,
distinct, servers; hiearchies using non-transparent bridges - option ROMs
handed off by the BIOS unassigned need to be allocated by the OS so that
they can be accessed under these circumstances.

3) Virtualized guest environments where a device may be assigned to a
virtualized guest is an interesting case.  In such environments the host
OS effectively functions as the meta-level BIOS, setting up a guest's
environment (virtual platform) prior to instantianting it.  Within such a
context consider a simple example:

  NIC devices often have Preboot Execution Environment (PXE) code in their
  ROMs.  In a bare-metal scenario, the BIOS (a.k.a. platform firmware)
  obtains the PXE code from the ROM and initiates its execution.  In this
  scenario, once the OS is up and running there would seem to be no
  further need to access such device's ROMs.

  If we now extend the scenario one meta-level to include virtualization,
  the host OS [1] assumes the role of bare-metal environment's BIOS and
  the virtualized guest takes on the role of bare-metal OS.  As such, if
  the guest is booted via PXE from a NIC device, the meta-level BIOS
  (QEMU/seabios) needs the ROM's content in order initiate PXE execution
  to bring up the guest.

So in virtualized environments, it becomes obvious that all the
traditional BIOS ROM related actions extend to the (host) OS - PXE
booting, device initialization, hot-plug, and directly assigning physical
devices to virtualized guests, etc.


[1]  "host OS" is used here in the generalized sence (i.e. it is in
control and thus the subsequent use of QEMU and seabios are not
specifically differentiated).
