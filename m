Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56762 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081AbcBEQqk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Feb 2016 11:46:40 -0500
Date: Fri, 5 Feb 2016 10:46:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH] PCI: Support SRIOV on Legacy EndPoint device
Message-ID: <20160205164631.GE29306@localhost>
References: <1454597306-26189-1-git-send-email-kelly.zytaruk@amd.com>
 <20160204151425.GA27474@localhost>
 <CY1PR12MB02628AFFB28DCA6AF01167D0FED10@CY1PR12MB0262.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CY1PR12MB02628AFFB28DCA6AF01167D0FED10@CY1PR12MB0262.namprd12.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 04, 2016 at 04:21:08PM +0000, Zytaruk, Kelly wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > Sent: Thursday, February 04, 2016 10:14 AM
> > To: Zytaruk, Kelly
> > Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Alex Williamson; Yu Zhao
> > Subject: Re: [PATCH] PCI: Support SRIOV on Legacy EndPoint device
> > 
> > [+cc Alex, Yu (participants in previous discussion)]
> > 
> > Hi Kelly,
> > 
> > On Thu, Feb 04, 2016 at 09:48:26AM -0500, Kelly Zytaruk wrote:
> > > Some AMD GPUs have hardware support for grapics SRIOV.
> > > If the GPU has a display output then the GPU needs to support Legacy VGA
> > operation.
> > > If CLASS_CODE = VGA then the device should have a Port Type = Legacy
> > EndPoint.
> > > Therefore in order to enable SRIOV on a GPU with a display output
> > LEGACY_END_POINT is supported as a valid Port Type.
> > >
> > > Signed-off-by: Kelly Zytaruk <kelly.zytaruk@amd.com>
> > 
> > We had an interesting discussion about this two years ago:
> > http://lkml.kernel.org/r/B756807489D6244883AC0B799A6EEC15EAB2E8@store
> > xdag02.amd.com
> 
> Unfortunately 2 years ago I couldn't complete your request as it
> would have disclosed Information about an unannounced technology
> that we were working on.  We have recently made that technology
> public and I can now send you the requested information.

> > Please include a reference to that discussion in your changelog.  In that
> > discussion, I also asked for some details (dmesg and lspci info) that motivate the
> > change, so please collect and add a reference to them as well.
> 
> The information that you ask for is included below.  I have
> abbreviated it so that this does not become a huge email.  I can
> send full logs if you want them.

Can you open a bugzilla at http://bugzilla.kernel.org and attach the full
logs there?  Then we can include the URL in your patch changelog.

> > It's not clear to me why we check the device type at all.  If
> > there's no spec restriction on the types of devices that can have
> > an SR-IOV capability, we should consider removing the test
> > altogether (Alex mentioned this possiblity in the earlier
> > discussion).
> 
> I am as well not clear why the check is in there.  I would be just
> as happy either adding TYPE_LEG_END or removing the check all
> together.  I don't know what the side effects of removing the check
> would be. I don't have any sriov devices other than a graphics card
> to test with so I wouldn't be able to test other scenarios.

If we don't have a reason to do the check, I think we should just
remove it altogether.

Bjorn
