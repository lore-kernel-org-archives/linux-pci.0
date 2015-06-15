Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jake Oshins <jakeo@microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: KY Srinivasan <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"pebolle@tiscali.nl" <pebolle@tiscali.nl>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Mike Ebersol <Michael.Ebersol@microsoft.com>
Subject: RE: [PATCH v2 4/6] drivers:hv: Export a function that maps Linux proc
 num onto Hyper-V proc num
Date: Mon, 15 Jun 2015 21:23:50 +0000
Message-ID: <DM2PR0301MB123258F63DE2BC6F4E1F3BCAABB80@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1434387999-1885-1-git-send-email-jakeo@microsoft.com>
 <1434387999-1885-5-git-send-email-jakeo@microsoft.com>
 <20150615195216.GB5257@kroah.com>
In-Reply-To: <20150615195216.GB5257@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Monday, June 15, 2015 12:52 PM
> To: Jake Oshins
> Cc: KY Srinivasan; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> vkuznets@redhat.com; bhelgaas@google.com; linux-pci@vger.kernel.org;
> pebolle@tiscali.nl; Haiyang Zhang; Mike Ebersol
> Subject: Re: [PATCH v2 4/6] drivers:hv: Export a function that maps Linux
> proc num onto Hyper-V proc num
> 
> > +/**
> > + * This function returns the mapping between the Linux processor
> > + * number and
> > + * the hypervisor's virtual processor number, useful in making
> > + * hypercalls and such that talk about specific processors.
> > + *
> > + * @param procnum - in Linux terms
> 
> What kind of comment structure is this?  It's not kernel doc :(
> 
> And "procnum" sounds like "process number", why not "cpu_number"?

Thanks.  I'll wait a little while to see if any other feedback comes in and then I'll fix these and resend.

-- Jake Oshins

