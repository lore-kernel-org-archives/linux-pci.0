Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171029061646.GA28105@infradead.org>
References: <20171024200426.62811-1-jeffrey.t.kirsher@intel.com>
 <20171024234351.0af0ff4a@t450s.home> <B6CB929FEBC10D4FAC4BCA7EF2298E259DB59E36@FMSMSX110.amr.corp.intel.com>
 <20171025000654.7621b84e@t450s.home> <B6CB929FEBC10D4FAC4BCA7EF2298E259DB5ADD3@FMSMSX110.amr.corp.intel.com>
 <20171028001907.7b8fa60d@t450s.home> <1509146439.11655.60.camel@intel.com> <20171029061646.GA28105@infradead.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 29 Oct 2017 14:12:52 -0700
Message-ID: <CAKgT0UdyyCZT7+eMEvJwd=Q-Lr0k0HGwr9kJoqF7mq8sTS7LSA@mail.gmail.com>
Subject: Re: [PATCH] Enable SR-IOV instantiation through /sys file
To: Christoph Hellwig <hch@infradead.org>
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        "Wang, Liang-min" <liang-min.wang@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Oct 28, 2017 at 11:16 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Oct 27, 2017 at 11:20:41PM +0000, Duyck, Alexander H wrote:
>> I don't see this so much as a security problem per-se. It all depends
>> on the hardware setup. If I recall correctly, there are devices where
>> the PF function doesn't really do much other than act as a bit more
>> heavy-weight VF, and the actual logic is handled by a firmware engine
>> on the device.
>
> Can you cite an example?  While those surely could exist in theory,
> I can't think of a practical example.

If I recall the neterion vxge driver fell into that category if I
recall correctly. Basically the hardware is preconfigured for some
number of VFs and their driver just calls pci_enable_sriov and enables
them.

One other thing I forgot about is the fact that we already have
drivers such as igb, ixgbe, and vxge floating around that will leave
SR-IOV enabled if the driver is loaded while VFs are direct assigned
to guests. As a side effect we can sort of already support assigning
vfio-pci to a driver that has SR-IOV enabled.

> Maybe we can start with the practical use case for this patch.  That
> is what device is this intended for?

If I am not mistaken the typical use case for a patch like this is to
support loading something like DPDK on a networking device PF, whlie
the VFs are assigned to virtualized guests and/or containers. It would
move the control of the PF/VFs into use space, but in the grand scheme
of things it isn't much different then when a virtualized guest has a
VF and has no direct control over the configuration of it since the
host is managing that.

So if the root user is enabling SR-IOV and allocating VFs on a device
that is running the vfio-pci driver the assumption is that the root
user must be trusting the application that is running on top of the
vfio-pci driver to behave correctly.
