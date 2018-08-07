Return-Path: <SRS0=MFNn=KW=google.com=bhelgaas@kernel.org>
Return-Path: <SRS0=MFNn=KW=google.com=bhelgaas@kernel.org>
MIME-Version: 1.0
References: <20180803065120.29322-1-felipe.balbi@linux.intel.com>
 <20180806182327.GA30691@bhelgaas-glaptop.roam.corp.google.com> <87lg9ia8q6.fsf@linux.intel.com>
In-Reply-To: <87lg9ia8q6.fsf@linux.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 7 Aug 2018 15:13:16 -0500
Message-ID: <CAErSpo595gmyeWNtY4Ur6VQoxS82bx8JQ-PoSv0oUdn-j7pJCA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Fix bit definitions for LNKCAP2 register
To: felipe.balbi@linux.intel.com
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, stable@vger.kernel.org,
	Jingoo Han <jingoohan1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 7, 2018 at 3:24 AM Felipe Balbi
<felipe.balbi@linux.intel.com> wrote:
>
>
> Hi,
>
> Bjorn Helgaas <helgaas@kernel.org> writes:
> > On Fri, Aug 03, 2018 at 09:51:20AM +0300, Felipe Balbi wrote:
> >> Even thhough commit b891b4dc1eed claimed that original bit definitions
> >> were wrong, that's not really the case. After verifying PCI
> >> Specification Revisions 3.0, 3.1 and 4.0, Link Capabilites 2
> >> Register's bit definitions were always starting from Bit 0.
> >>
> >> This has been causing issues reporting correct link speeds on sysfs.
> >
> > Can you elaborate on this a bit?  b891b4dc1eed still looks correct to
> > me.  I'm looking at PCIe r4.0, sec 7.5.3.18, where it shows:
> >
> >   bit    0  RsvdP
> >   bits 7:1  Supported Link Speeds Vector
>
> I had missed this detail, actually. It was a misinterpretation of the
> spec. Sorry for the noise.

No problem.  You were seeing something incorrect in sysfs, so if we
can help diagnose or fix whatever the real problem is, don't hesitate
to ask!
