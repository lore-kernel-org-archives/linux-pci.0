Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48458 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957AbaBUWDK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 21 Feb 2014 17:03:10 -0500
Message-ID: <1393020186.9111.91.camel@ul30vt.home>
Subject: Re: Architectural question regarding IOV support in Linux 3.13.4
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yu Zhao <yuzhao@google.com>
Date: Fri, 21 Feb 2014 15:03:06 -0700
In-Reply-To: <CAErSpo4OkgGrrZ9anAJ2vSZJDYikv4WC6hjt4T2-mMXpGA=w6A@mail.gmail.com>
References: <B756807489D6244883AC0B799A6EEC15EAB2E8@storexdag02.amd.com>
	 <CAErSpo4OkgGrrZ9anAJ2vSZJDYikv4WC6hjt4T2-mMXpGA=w6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2014-02-21 at 14:11 -0700, Bjorn Helgaas wrote:
> [+cc Alex, Yu]
> 
> On Fri, Feb 21, 2014 at 10:45 AM, Zytaruk, Kelly <Kelly.Zytaruk@amd.com> wrote:
> >
> > I am working with SR-IOV and I have a question regarding the function
> > sriov_init() in ../drivers/pci/iov.c (linux versions 3.4.9 and 3.13.4)
> >
> > In sriov_init() the code first checks whether the PF is a Root complex
> >  endpoint (0x9) or an Express Endpoint (0x0) as shown in the code
> >  snippet below.  If it is neither it returns the No device error.
> >
> > static int sriov_init(struct pci_dev *dev, int pos)
> > {
> >          int i;
> >          int rc;
> >          int nres;
> >          u32 pgsz;
> >          u16 ctrl, total, offset, stride;
> >          struct pci_sriov *iov;
> >          struct resource *res;
> >          struct pci_dev *pdev;
> >
> >        if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END &&
> >              pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT)
> >                  return -ENODEV;
> >
> > My question is why PCI_EXP_TYPE_LEG_END (0x1) is omitted as being a
> >  valid endpoint.  By excluding Legacy endpoints it fails enabling
> >  SR-IOV on a VGA PF.
> >
> > Is there a design/specification reason why legacy was excluded or was
> >  it just an assumption that VGA would never support SR-IOV?
> >
> > If there is no valid reason to exclude PCI_EXP_TYPE_LEG_END, I would
> >  like to discuss having it included as a valid endpoint for SR-IOV.
> 
> Good question.  It looks like it's been that way since the beginning
> [1], but I don't know why.  I don't see any restriction in the spec
> about SR-IOV and legacy endpoints.
> 
> I also don't know whether VGA is an issue.  There are some legacy
> addressing issues for [mem 0xa0000-0xbffff] and [io 0x3b0-0x3bb] and
> [io 0x3c0-0x3df].  For example, when a bridge has its VGA Enable bit
> set, it positively decodes [mem 0xa0000-0xbffff] even if that range
> isn't included in one of the bridge windows.  I don't know whether a
> VGA device is similarly allowed to decode that range even if it's not
> in a BAR.  If it is, I could imagine issues if enabling SR-IOV created
> several VGA VFs.

VFs cannot support I/O port space by definition, so I don't think a "VGA
VF" could actually exist.  There would be nothing wrong with a non-VGA
GPU VF though.  I also don't see how the differences in Legacy Endpoint
rules versus a standard Endpoint would preclude supporting SR-IOV.  I
don't think the SR-IOV spec makes any demands on whether the PF requires
I/O port resources, which I assume is the main reason for this to call
itself Legacy.  I'd guess it was likely just an oversight and we should
add legacy endpoints (or remove the test altogether and trust that if a
device has an SR-IOV capability, we should initialize it).  Thanks,

Alex

