Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0080.outbound.protection.outlook.com ([104.47.34.80]:12983
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752688AbdJTKog (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Oct 2017 06:44:36 -0400
Date: Fri, 20 Oct 2017 03:44:29 -0700
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        Wilson.Snyder@cavium.com, robert.richter@cavium.com,
        david.daney@cavium.com, mjaggi@caviumnetworks.com,
        Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
Subject: Re: [PATCH v7 0/2] PCI: quirks: Cavium ThunderX ACS quirk update
Message-ID: <20171020104429.GA7898@localhost.localdomain>
References: <1506536439-29318-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <1508244459-2615-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <20171019112645.GD6332@bhelgaas-glaptop.roam.corp.google.com>
 <20171019115921.GA6199@localhost.localdomain>
 <20171019185010.GE6332@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171019185010.GE6332@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 19, 2017 at 01:50:10PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 19, 2017 at 04:59:21AM -0700, Vadim Lomovtsev wrote:
> > On Thu, Oct 19, 2017 at 06:26:45AM -0500, Bjorn Helgaas wrote:
> > > On Tue, Oct 17, 2017 at 05:47:37AM -0700, Vadim Lomovtsev wrote:
> > > > From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> > > > 
> > > > version 7:
> > > > - update patch description accordingly to review comments;
> > > > - split for two patches: for ACS mask change and device id match change;
> > > > - remove macro #define of ACS flags, put it back to quirk function;
> > > > - remove '__inline_' from device id matching function;
> > > > - wrap code comments to fit into 80 columns;
> > > > - comment fix: change 0xa00 to 0xf800 for matching function description;
> > > > 
> > > > version 6:
> > > > - comment typo fix: change 0xa00 to 0xa000;
> > > > 
> > > > version 5:
> > > > - update code comments accordingly to review comments;
> > > > 
> > > > version 4:
> > > > - update ACS mask (remove TB and TD bits), update commit message (remove
> > > >   ACS register printout);
> > > > 
> > > > version 3:
> > > > - update subject: remove CN8XXX from subject line, replace it with ThunderX;
> > > > 
> > > > version 2:
> > > > - update match function in order to filter only ThunderX devices by device
> > > >   ids to properly filter CN8XXX devices, update subject & description with
> > > >   ACS register info (v2 was rejected by maillist due to triple X in subject);
> > > >   
> > > > Vadim Lomovtsev (2):
> > > >   PCI: quirks: Set Cavium ACS capability quirk flags to assert
> > > >     RR/CR/SV/UF.
> > > >   PCI: quirks: Apply Cavium ThunderX ACS quirk only to Root Ports
> > > > 
> > > >  drivers/pci/quirks.c | 26 ++++++++++++++++++++------
> > > >  1 file changed, 20 insertions(+), 6 deletions(-)
> > > 
> > > If I'm reading this correctly, the first patch is basically fixing a bug in
> > > the original Cavium ACS quirk (b404bcfbf035 ("PCI: Add ACS quirk for all
> > > Cavium devices")).  Right?
> > 
> > Yes, first patch fixes improper ACS flags in the patch you mentioned.
> > 
> > The second one fixes devid check from another patch
> > (b77d537d00d0 PCI: Apply Cavium ACS quirk only to CN81xx/CN83xx/CN88xx devices).
> > 
> > > 
> > > I put them on pci/virtualization for v4.15 as follows (patches unchanged,
> > > changelogs wordsmithed).
> > >
> > 
> > Good, thank you.
> > 
> > > You mentioned stable backports.  b404bcfbf035 ("PCI: Add ACS quirk for all
> > > Cavium devices") appeared in v4.6.  b77d537d00d0 ("PCI: Apply Cavium ACS
> > > quirk only to CN81xx/CN83xx/CN88xx devices") appeared in v4.12.  I assume
> > > you would ideally want all this backported as far as v4.6?  We'd have to
> > > figure out how to express that in stable tags.
> > 
> > Ideally yes, I think we would need to have them backported onto stable(s),
> > but so far I didn't see any bug-reports which could require these fixes.
> > 
> > Anyway, in term of backporting them - are there anything I can help with ?
> 
> I added the following tags, which I *think* should be sufficient:
> 
>   PCI: Set Cavium ACS capability quirk flags to assert RR/CR/SV/UF
>   Cc: stable@vger.kernel.org      # v4.6+: b77d537d00d0: PCI: Apply Cavium ACS quirk only to CN81xx/CN83xx/CN88xx devices
> 
>   PCI: Apply Cavium ThunderX ACS quirk to more Root Ports
>   Cc: stable@vger.kernel.org      # v4.12+

Looks good. Thank you.

-Vadim
