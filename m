Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753145AbdASXlg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Jan 2017 18:41:36 -0500
Date: Thu, 19 Jan 2017 17:41:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan =?iso-8859-1?Q?R=FCth?= <rueth@comsys.rwth-aachen.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci/aspm: Fix null pointer dereference during
 re-enumeration of PCI bus in pcie_aspm_init_link_state even though ASPM is
 off
Message-ID: <20170119234124.GA6619@bhelgaas-glaptop.roam.corp.google.com>
References: <4cec62c2-218a-672b-8c12-d44e8df56aae@comsys.rwth-aachen.de>
 <20170103205350.GC25398@bhelgaas-glaptop.roam.corp.google.com>
 <122cc4bb-d95e-2b08-a1a4-6725361bfa14@comsys.rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <122cc4bb-d95e-2b08-a1a4-6725361bfa14@comsys.rwth-aachen.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jan,

On Wed, Jan 04, 2017 at 12:41:36PM +0100, Jan Rüth wrote:
> On 03/01/2017 21:53, Bjorn Helgaas wrote:
> > On Tue, Jan 03, 2017 at 09:04:36AM +0100, Jan Rüth wrote:
> >> This patch fixes a null pointer dereference during PCI bus enumeration
> >> when ASPM is off. On an IBM x3850 8664 this bug causes the kernel to
> >> halt, this behavior did not appear in 3.10, so this is a regression.
> >>
> >> pcie_aspm_sanity_check should only be called if ASPM is on.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=187731
> > 
> >> Signed-off-by: Jan Rueth <rueth@comsys.rwth-aachen.de>
> >> ---
> >>  drivers/pci/pcie/aspm.c | +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> >> index f981129..e758b56 100644
> >> --- a/drivers/pci/pcie/aspm.c
> >> +++ b/drivers/pci/pcie/aspm.c
> >> @@ -552,11 +552,12 @@ static struct pcie_link_state
> >> *alloc_pcie_link_state(struct pci_dev *pdev)
> >>  void pcie_aspm_init_link_state(struct pci_dev *pdev)
> >>  {
> >>         struct pcie_link_state *link;
> >> -       int blacklist = !!pcie_aspm_sanity_check(pdev);
> >> -
> >> +       int blacklist;
> >>         if (!aspm_support_enabled)
> >>                 return;
> >>
> >> +       blacklist = !!pcie_aspm_sanity_check(pdev);
> >> +
> >>         if (pdev->link_state)
> >>                 return;
> > 
> > For some reason this doesn't apply for me (complains about a malformed
> > patch), but I can apply it by hand easily enough.
> > 
> > However, this path is a little obtuse, and I'd like to understand
> > what's going on better.  We currently have:
> > 
> >   pci_scan_slot
> >     if (bus->self && nr)
> >       pcie_aspm_init_link_state(bus->self)
> >         pcie_aspm_sanity_check
> > 	  list_for_each_entry(child, &pdev->subordinate->devices, ...)
> > 
> > I assume the null pointer is pdev->subordinate, so maybe we're calling
> > pcie_aspm_init_link_state() for a bridge where we weren't able to
> > create a child bus ("pdev->subordinate")?
> 
> At the time when I debugged it could trace it back to the loop but I
> can't remember which part actually broke. But I can add some debug
> output and crash it again.

I'm pretty sure the null pointer would be pdev->subordinate, and your
patch certainly avoids dereferencing that as long as you boot with
"pcie_aspm=off".  But I think if you boot with your patch but without
"pcie_aspm=off", we'll probably dereference that null pointer again.

The only way I can see to have a null pdev->subordinate pointer is via
SR-IOV VF devices, and you should have some of those.  But I think we
should see the messages from pci_setup_device() for them, and I don't
see them in the dmesg log in the bugzilla, so I'm still confused about
this.

Why are you using "pcie_aspm=off"?  If it's due to Linux ASPM bugs, I
want to fix those, too.  If it's due to hardware problems on your
platform, maybe we can add some sort of quirk to do this
automatically.

Can you please apply the patches below (you should be able to feed
this whole email to "patch" at once), collect the complete dmesg logs
(both with and without "pcie_aspm=off"), and attach them to the
bugzilla?

Bjorn


commit 50deebe0077acdfafe08501b7da220d256743e36
Author: Jan Rüth <rueth@comsys.rwth-aachen.de>
Date:   Tue Jan 3 14:09:50 2017 -0600

    PCI/ASPM: Avoid ASPM sanity checking when ASPM is off
    
    Previously we called pcie_aspm_sanity_check() even if ASPM was disabled,
    which is unnecessary.  Delay the pcie_aspm_sanity_check() until we know
    that we should do some ASPM configuration.
    
    As a side effect, this avoids a null pointer dereference in
    pcie_aspm_sanity_check(), which we saw on IBM x3850 8664 (see bugzilla
    below).
    
    [bhelgaas: changelog, delay call a little more]
    Link: https://bugzilla.kernel.org/show_bug.cgi?id=187731
    Signed-off-by: Jan Rüth <rueth@comsys.rwth-aachen.de>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    CC: stable@vger.kernel.org

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 17ac1dce3286..99a15b2e4228 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -565,7 +565,7 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 void pcie_aspm_init_link_state(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link;
-	int blacklist = !!pcie_aspm_sanity_check(pdev);
+	int blacklist;
 
 	if (!aspm_support_enabled)
 		return;
@@ -586,6 +586,8 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 	    pdev->bus->self)
 		return;
 
+	blacklist = !!pcie_aspm_sanity_check(pdev);
+
 	down_read(&pci_bus_sem);
 	if (list_empty(&pdev->subordinate->devices))
 		goto out;
@@ -594,6 +596,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 	link = alloc_pcie_link_state(pdev);
 	if (!link)
 		goto unlock;
+
 	/*
 	 * Setup initial ASPM state. Note that we need to configure
 	 * upstream links also because capable state of them can be

commit 8cd2325c4360c6aa680dd32d804ae8dcc8f8cc5b
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Jan 19 17:21:10 2017 -0600

    aspm-debug

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 99a15b2e4228..c8695965b1d0 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -567,6 +567,13 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 	struct pcie_link_state *link;
 	int blacklist;
 
+	dev_info(&pdev->dev, "support %d PCIe %d link_state %d secondary %d subordinate %d\n",
+		 aspm_support_enabled ? 1 : 0,
+		 pci_is_pcie(pdev) ? 1 : 0,
+		 pdev->link_state ? 1 : 0,
+		 pdev->has_secondary_link ? 1 : 0,
+		 pdev->subordinate ? 1 : 0);
+
 	if (!aspm_support_enabled)
 		return;
 

commit b89fa357a592615c00c1b98d8c06a3df1d185078
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Jan 19 17:32:38 2017 -0600

    sriov-debug

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 47227820406d..98be6d6b119f 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -129,6 +129,8 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
 	if (!bus)
 		goto failed;
 
+	dev_info(&dev->dev, "add VF %d on %s\n", id, dev_name(&bus->dev));
+
 	virtfn = pci_alloc_dev(bus);
 	if (!virtfn)
 		goto failed0;
@@ -145,6 +147,9 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
 	virtfn->is_virtfn = 1;
 	virtfn->multifunction = 0;
 
+	dev_info(&virtfn->dev, "new VF %d, subordinate %d\n", id,
+		virtfn->subordinate ? 1 : 0);
+
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = &dev->resource[i + PCI_IOV_RESOURCES];
 		if (!res->parent)
