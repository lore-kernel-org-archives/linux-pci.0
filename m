Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56991 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752293AbbJ2Ult (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 29 Oct 2015 16:41:49 -0400
Date: Thu, 29 Oct 2015 15:41:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Duyck <aduyck@mirantis.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iov: Fix sriov_enable exception handling path
Message-ID: <20151029204143.GA921@localhost>
References: <20151027204607.14626.59671.stgit@localhost.localdomain>
 <20151027205227.14626.13514.stgit@localhost.localdomain>
 <20151029163209.GA19083@localhost>
 <CAMt9YRrL+uYz7=TFSmxJngspCDfoORJ5ykaBSZAwM0qfmjYHjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMt9YRrL+uYz7=TFSmxJngspCDfoORJ5ykaBSZAwM0qfmjYHjQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 29, 2015 at 09:54:00AM -0700, Alex Duyck wrote:
> On Thu, Oct 29, 2015 at 9:32 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Hi Alex,
> >
> > Thanks, this definitely clears up some problems.  Two minor questions
> > below.
> >
> > On Tue, Oct 27, 2015 at 01:52:27PM -0700, Alexander Duyck wrote:
> >> >From what I can tell there were several errors in the sriov_enable
> >> exception handling path.  Below is a brief list of what I believe I am
> >> fixing:
> >>
> >> 1.  If pcibios_enable_sriov failed, we returned without disabling SR-IOV on
> >>     the device.
> >> 2.  If virtfn_add failed we didn't call pcibios_disable_sriov to undo
> >>     pcibios_enable_sriov.
> >> 3.  We were resetting numvfs to 0 before a second had passed for the VFs to
> >>     quiesce.
> >> 4.  Minor coding style issues for white space and for assignment in
> >>     conditional check.
> >>
> >> Beyond addressing these 4 issues there were also 2 other minor issues in
> >> that retval was a redundant variable with rc, and j wasn't actually needed
> >> as we could simply reverse the loop we were running when setting up i.  As
> >> such I have updated the code to address those two items.
> >>
> >> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> >> ---
> >>  drivers/pci/iov.c |   31 +++++++++++++++++--------------
> >>  1 file changed, 17 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> >> index 238950412de0..cecc242c1af0 100644
> >> --- a/drivers/pci/iov.c
> >> +++ b/drivers/pci/iov.c
> >> @@ -231,13 +231,18 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
> >>
> >>  int __weak pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
> >>  {
> >> -       return 0;
> >> +     return 0;
> >> +}
> >> +
> >> +int __weak pcibios_sriov_disable(struct pci_dev *pdev)
> >> +{
> >> +     return 0;
> >>  }
> >>
> >>  static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> >>  {
> >>       int rc;
> >> -     int i, j;
> >> +     int i;
> >>       int nres;
> >>       u16 offset, stride, initial;
> >>       struct resource *res;
> >> @@ -245,7 +250,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> >>       struct pci_sriov *iov = dev->sriov;
> >>       int bars = 0;
> >>       int bus;
> >> -     int retval;
> >>
> >>       if (!nr_virtfn)
> >>               return 0;
> >> @@ -322,10 +326,11 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> >>       if (nr_virtfn < initial)
> >>               initial = nr_virtfn;
> >>
> >> -     if ((retval = pcibios_sriov_enable(dev, initial))) {
> >> +     rc = pcibios_sriov_enable(dev, initial);
> >> +     if (rc) {
> >>               dev_err(&dev->dev, "failure %d from pcibios_sriov_enable()\n",
> >> -                     retval);
> >> -             return retval;
> >> +                     rc);
> >> +             goto err_pcibios;
> >>       }
> >>
> >>       for (i = 0; i < initial; i++) {
> >> @@ -340,25 +345,23 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> >>       return 0;
> >>
> >>  failed:
> >> -     for (j = 0; j < i; j++)
> >> -             virtfn_remove(dev, j, 0);
> >> +     while (i--)
> >> +             virtfn_remove(dev, i, 0);
> >>
> >> +     pcibios_sriov_disable(dev);
> >> +err_pcibios:
> >>       iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
> >>       pci_cfg_access_lock(dev);
> >>       pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
> >> -     pci_iov_set_numvfs(dev, 0);
> >>       ssleep(1);
> >>       pci_cfg_access_unlock(dev);
> >>
> >>       if (iov->link != dev->devfn)
> >>               sysfs_remove_link(&dev->dev.kobj, "dep_link");
> >>
> >> -     return rc;
> >> -}
> >> +     pci_iov_set_numvfs(dev, 0);
> >
> > Do you have a spec pointer for the 1 sec delay before clearing NumVFs?
> 
> The text from the SR-IOV spec v1.1 in relation to clearing VF enable reads:
> 
> If software Clears VF Enable, software must allow 1.0 s second after
> VF Enable is Cleared before
> reading any field in the SR-IOV Extended Capability or the VF
> Migration State Array (see
> Section 3.3.15.1).
> 
> I'm assuming the same would apply to writing to the region after VFE
> has been cleared.

Yep, thanks.  Sec 3.3.3.1 clearly says we have to wait 1.0s after
clearing VF Enable before reading anything in the capability.  And
pci_iov_set_numvfs() *does* read PCI_SRIOV_VF_OFFSET and
PCI_SRIOV_VF_STRIDE.

> > Does we need to clear NumVFs while holding the cfg access lock?
> 
> I don't think so.
> 
> Earlier in the function pci_iov_set_numvfs was getting set before
> without taking the lock.  I think the lock is being used to enforce
> the required grace period on configuration space access following
> setting or clearing the VFE bit.  The code as it is now matches what
> we have in sriov_disable so I suspect it likely works this way as that
> path has likely seen much more validation than the exception handling
> path for sriov_enable has.

Right.  I think the important part is that we hold the lock during the
ssleep(1).

Slightly different problem: I'm a little worried about the places in
sriov_enable() and sriov_restore_state() where we set VF Enable and
msleep for 100ms.  Sec. 3.3.3.1 requires the 100ms before we issue
config requests to the VFs, the msleep satisfies that.

But 3.3.3.1 goes on to say the new VFs can return CRS status for up to
1.0s, and they can silently drop Memory Requests for up to 1.0s.  I
don't think the VF add path checks for CRS status: it doesn't call
pci_bus_read_dev_vendor_id().  So I'm not sure we're quite covered
here.

Bjorn
