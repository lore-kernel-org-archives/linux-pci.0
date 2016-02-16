Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0145.outbound.protection.outlook.com ([207.46.100.145]:64311
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750929AbcBPWsP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Feb 2016 17:48:15 -0500
From: Jake Oshins <jakeo@microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	KY Srinivasan <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>,
	Hadden Hoppert <haddenh@microsoft.com>
Subject: RE: [PATCH RESEND v2 3/3] PCI: hv: New paravirtual PCI front-end for
 Hyper-V VMs
Date: Tue, 16 Feb 2016 22:48:12 +0000
Message-ID: <DM2PR0301MB123215E8246483C89FBCB6C1ABAD0@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1455045869-38341-1-git-send-email-jakeo@microsoft.com>
 <1455045869-38341-4-git-send-email-jakeo@microsoft.com>
 <20160216164544.GA18685@localhost>
 <DM2PR0301MB1232A3F01DC9DB4F3BF97C18ABAD0@DM2PR0301MB1232.namprd03.prod.outlook.com>
 <20160216224415.GA11805@localhost>
In-Reply-To: <20160216224415.GA11805@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Tuesday, February 16, 2016 2:44 PM
> To: Jake Oshins <jakeo@microsoft.com>
> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org;
> gregkh@linuxfoundation.org; KY Srinivasan <kys@microsoft.com>; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; vkuznets@redhat.com; tglx@linutronix.de; Haiyang
> Zhang <haiyangz@microsoft.com>; marc.zyngier@arm.com; Hadden
> Hoppert <haddenh@microsoft.com>
> Subject: Re: [PATCH RESEND v2 3/3] PCI: hv: New paravirtual PCI front-end
> for Hyper-V VMs
> 
> On Tue, Feb 16, 2016 at 09:46:55PM +0000, Jake Oshins wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > > Sent: Tuesday, February 16, 2016 8:46 AM
> > > To: Jake Oshins <jakeo@microsoft.com>
> > > Cc: bhelgaas@google.com; linux-pci@vger.kernel.org;
> > > gregkh@linuxfoundation.org; KY Srinivasan <kys@microsoft.com>;
> > > linux- kernel@vger.kernel.org; devel@linuxdriverproject.org;
> > > olaf@aepfle.de; apw@canonical.com; vkuznets@redhat.com;
> > > tglx@linutronix.de; Haiyang Zhang <haiyangz@microsoft.com>;
> > > marc.zyngier@arm.com; Hadden Hoppert <haddenh@microsoft.com>
> > > Subject: Re: [PATCH RESEND v2 3/3] PCI: hv: New paravirtual PCI
> > > front-end for Hyper-V VMs
> > >
> > > Hi Jake,
> > >
> > > Looks good to me overall; I marked a few nits below.
> > >
> > > The only real question I have is about domain number allocation.
> > > See the note below.
> > >
> > [snip]
> > > > +
> > > > +	/*
> > > > +	 * The PCI bus "domain" is what is called "segment" in
> > > > +	 * ACPI and other specs.  Pull it from the instance ID,
> > > > +	 * to get something unique.  Bytes 8 and 9 are what is used
> > > > +	 * in Windows guests, so do the same thing for consistency.
> > > > +	 */
> > > > +
> > > > +	hbus->sysdata.domain = hdev->dev_instance.b[9] |
> > > > +			       hdev->dev_instance.b[8] << 8;
> > >
> > > How do we know this is unique?  We don't have any idea what the
> > > platform will put in _SEG, so I think there's a potential conflict
> > > here.  The Intel VMD driver (arch/x86/pci/vmd.c) has a similar
> > > problem, and it looks for unused domain numbers starting at 0x10000
> > > (see vmd_find_free_domain()).
> > >
> >
> > Bjorn, thank you for your very thorough reviews.  I deeply appreciate it.  I
> checked the Hyper-V code and it currently does guarantee that these values
> are unique.  When I resend the series, I'll add a comment to that effect.  I'll
> also add a comment to Hyper-V that says that it has to stay that way.
> 
> I'm not familiar with how Hyper-V works, but I guess you're saying that
> Hyper-V controls what the guest sees via _SEG as well as what it sees via the
> instance ID.
> 
> Bjorn

Yes, exactly.  To the point, the Hyper-V Generation 1 VM (which is an emulation of a 440BX/PIIX4 platform) has one root PCI bus with no _SEG object at all, which implies a value of zero.  The Hyper-V Generation 2 VM (which doesn't emulate any existing machine) doesn't have any root PCI bus at all until a device is passed through and this driver is loaded.

-- Jake
