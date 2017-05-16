Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750924AbdEPUsW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 May 2017 16:48:22 -0400
Date: Tue, 16 May 2017 14:48:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: David Daney <ddaney@caviumnetworks.com>
Cc: Auger Eric <eric.auger@redhat.com>,
        David Daney <david.daney@cavium.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jon Masters <jcm@redhat.com>,
        Robert Richter <robert.richter@cavium.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: Avoid bus reset for Cavium cn8xxx root ports.
Message-ID: <20170516144804.1e52b616@w520.home>
In-Reply-To: <3fbbda8a-a6ea-976e-46ba-d23646500b3a@caviumnetworks.com>
References: <20170516001736.4001-1-david.daney@cavium.com>
        <20170516001736.4001-3-david.daney@cavium.com>
        <235a9a51-df06-84af-4e5d-b6408ceb0b7d@redhat.com>
        <3fbbda8a-a6ea-976e-46ba-d23646500b3a@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 16 May 2017 13:29:58 -0700
David Daney <ddaney@caviumnetworks.com> wrote:

> On 05/16/2017 01:14 PM, Auger Eric wrote:
> > Hi,
> > 
> > On 16/05/2017 02:17, David Daney wrote:  
> >> Root ports of cn8xxx do not function after bus reset when used with
> >> some e1000e and LSI HBA devices.  Add a quirk to prevent bus reset on
> >> these root ports.  
> > I understand the bus reset would work along with a variety of other
> > child devices. I guess there is no way to be more accurate and forbid
> > the bus reset only when incompatible child devices are found?  
> 
> That's right.  Conceptually we have a 2 dimensional array of all 
> possible upstream devices vs. all possible downstream devices.  The 
> maintenance burden of correctly populating this and keeping it up to 
> date would be impossible.
> 
> The e1000e works well, I am sure, with most Intel root ports.  We 
> haven't investigated exactly which end of the link is responsible for 
> the failures against the cn8890 root port, but the simplest way forward 
> is to just say it cannot support bus reset.

That's a pretty serious limitation though, you only need to look at the
world of graphics cards where the device offers no capability for
function level reset and PM reset does nothing useful.  The only way we
can get the device to a fairly reproducible state is via bus reset.  So
let's just throw out GPU assignment on this platform as unsupportable.
What other sorts of devices are we going to find have inconsistent
behavior compared to platforms where bus reset is possible?  What's
going to be the user experience?  Tracking which devices have trouble
with bus reset is a problem, but so is limiting access to bus reset
where it really is useful.  Thanks,

Alex

> >>
> >> Signed-off-by: David Daney <david.daney@cavium.com>
> >> ---
> >>   drivers/pci/quirks.c | 8 ++++++++
> >>   1 file changed, 8 insertions(+)
> >>
> >> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >> index 085fb78..02cd847 100644
> >> --- a/drivers/pci/quirks.c
> >> +++ b/drivers/pci/quirks.c
> >> @@ -3347,6 +3347,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0032, quirk_no_bus_reset);
> >>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
> >>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
> >>   
> >> +/*
> >> + * Root port on some Cavium CN8xxx chips do not successfully complete
> >> + * a bus reset when used with certain types child devices.  Config  
> > s/types /types of  
> 
> Yeah, I need to be more careful.  We really need to improve the 
> grammatical analysis capabilities of checkpatch.pl, I think I will lay 
> the blame there.
> 
> I can resubmit or Bjorn can fix it before committing, I will let him decide.
> 
> David.
> 
> 
> > Thanks
> > 
> > Eric  
> >> + * space access to the child may quit responding.  Flag the root port
> >> + * as not supporting bus reset.
> >> + */
> >> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
> >> +
> >>   static void quirk_no_pm_reset(struct pci_dev *dev)
> >>   {
> >>   	/*
> >>  
> 
