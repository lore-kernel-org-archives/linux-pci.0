Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171106162713.0a49ac3f@t450s.home>
References: <20171024200426.62811-1-jeffrey.t.kirsher@intel.com>
 <20171024234351.0af0ff4a@t450s.home> <B6CB929FEBC10D4FAC4BCA7EF2298E259DB59E36@FMSMSX110.amr.corp.intel.com>
 <20171025000654.7621b84e@t450s.home> <B6CB929FEBC10D4FAC4BCA7EF2298E259DB5ADD3@FMSMSX110.amr.corp.intel.com>
 <20171028001907.7b8fa60d@t450s.home> <1509146439.11655.60.camel@intel.com>
 <20171029061646.GA28105@infradead.org> <1509367141.11641.51.camel@infradead.org>
 <B6CB929FEBC10D4FAC4BCA7EF2298E259DB5BB50@FMSMSX110.amr.corp.intel.com> <20171106162713.0a49ac3f@t450s.home>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 6 Nov 2017 15:47:41 -0800
Message-ID: <CAKgT0UdSm9rHLsrCyfGLCpCaztK28V=VtYBR-LKS3Fx5OK0SUQ@mail.gmail.com>
Subject: Re: [PATCH] Enable SR-IOV instantiation through /sys file
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Wang, Liang-min" <liang-min.wang@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        "O'riordain, Seosamh" <seosamh.oriordain@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 6, 2017 at 3:27 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Tue, 31 Oct 2017 12:55:20 +0000
> "Wang, Liang-min" <liang-min.wang@intel.com> wrote:
>
>> > -----Original Message-----
>> > From: David Woodhouse [mailto:dwmw2@infradead.org]
>> > Sent: Monday, October 30, 2017 8:39 AM
>> > To: Christoph Hellwig <hch@infradead.org>; Duyck, Alexander H
>> > <alexander.h.duyck@intel.com>
>> > Cc: Wang, Liang-min <liang-min.wang@intel.com>;
>> > alex.williamson@redhat.com; linux-kernel@vger.kernel.org; Kirsher, Jeffrey T
>> > <jeffrey.t.kirsher@intel.com>; kvm@vger.kernel.org; bhelgaas@google.com;
>> > linux-pci@vger.kernel.org
>> > Subject: Re: [PATCH] Enable SR-IOV instantiation through /sys file
>> >
>> > On Sat, 2017-10-28 at 23:16 -0700, Christoph Hellwig wrote:
>> > > On Fri, Oct 27, 2017 at 11:20:41PM +0000, Duyck, Alexander H wrote:
>> > > >
>> > > > I don't see this so much as a security problem per-se. It all depends
>> > > > on the hardware setup. If I recall correctly, there are devices where
>> > > > the PF function doesn't really do much other than act as a bit more
>> > > > heavy-weight VF, and the actual logic is handled by a firmware engine
>> > > > on the device.
>> > >
>> > > Can you cite an example?  While those surely could exist in theory,
>> > > I can't think of a practical example.
>> >
>> > I have them, which is why I'm patching the UIO driver to allow num_vfs
>> > to be set. I don't even want to *use* the UIO driver for any purpose
>> > except to make that appear in sysfs. It's all handled in the device.
>> >
>> > (I think we might be able to just give the PF out to a guest as if it
>> > were just another VF, but I don't think we actually *do* that right
>> > now).
>>
>> Under UEFI secure boot environment, kernel puts restrictions on UIO and its derivatives.
>> So, user-space function/driver based upon UIO is no longer working under UEFI secure
>> boot environment. The next viable option is vfio-pci, hence this patch in parallel with
>> UIO work.
>
> If you want a PF driver that does nothing other than allow SR-IOV to be
> enabled, doesn't that scream pci-stub?  Trying to overlay it onto a
> driver that also allows userspace driver access to that device seems
> like the worst idea.  Thanks,
>
> Alex

So for the case where a user-space agent is running the actual PF how
is it you suggest we go about quarantining the interfaces? What kind
of behavior is it you are expecting to see? Should we look into a way
to clear match_driver for the VF interfaces so the drivers won't load
on them at all, or are you expecting something like vfio-pci to be
selected to auto-load on them since the PF is already running that?

Thanks.

- Alexander
