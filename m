Return-Path: <SRS0=85J+=KW=gmail.com=jingoohan1@kernel.org>
Return-Path: <SRS0=85J+=KW=gmail.com=jingoohan1@kernel.org>
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Felipe Balbi'" <felipe.balbi@linux.intel.com>,
	"'Bjorn Helgaas'" <helgaas@kernel.org>
Cc: "'Bjorn Helgaas'" <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20180803065120.29322-1-felipe.balbi@linux.intel.com> <20180806182327.GA30691@bhelgaas-glaptop.roam.corp.google.com> <87lg9ia8q6.fsf@linux.intel.com>
In-Reply-To: <87lg9ia8q6.fsf@linux.intel.com>
Subject: Re: [PATCH] PCI: Fix bit definitions for LNKCAP2 register
Date: Tue, 7 Aug 2018 14:18:23 -0400
Message-ID: <000001d42e7b$07990170$16cb0450$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, August 7, 2018 4:21 AM, Felipe Balbi wrote:
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

Hi Balbi,

I can understand your situation. The detail of PCIe spec is very confusing.
Actually, I was one of those who misunderstood. However, after reviewing
the PCIe spec carefully, I found that the bit definition was wrong. At that
time,
I already checked that my patch works properly with Exynos SoCs. Thank you.

Best regards,
Jingoo Han

> 
> --
> balbi
