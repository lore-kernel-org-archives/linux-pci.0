Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751060AbdHSCz5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Aug 2017 22:55:57 -0400
Date: Fri, 18 Aug 2017 21:55:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [RFC PATCH v3] pci: Concurrency issue during pci enable bridge
Message-ID: <20170819025551.GP28977@bhelgaas-glaptop.roam.corp.google.com>
References: <1501858648-22228-1-git-send-email-srinath.mannam@broadcom.com>
 <20170816134354.GV32525@bhelgaas-glaptop.roam.corp.google.com>
 <CABe79T4ip3m4U_i4k-8hBcONONLXyy83v-BeWk7Rq24CD9Z-9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABe79T4ip3m4U_i4k-8hBcONONLXyy83v-BeWk7Rq24CD9Z-9w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 16, 2017 at 10:33:12PM +0530, Srinath Mannam wrote:
> Hi Bjorn,
> 
> Thank you for the feedback.
> 
> My comments are in lined.
> 
> On Wed, Aug 16, 2017 at 7:13 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Aug 04, 2017 at 08:27:28PM +0530, Srinath Mannam wrote:
> >> Concurrency issue is observed during pci enable bridge called
> >> for multiple pci devices initialization in SMP system.
> >>
> >> Setup details:
> >>  - SMP system with 8 ARMv8 cores running Linux kernel(4.11).
> >>  - Two EPs are connected to PCIe RC through bridge as shown
> >>    in the below figure.
> >>
> >>                    [RC]
> >>                     |
> >>                  [BRIDGE]
> >>                     |
> >>                -----------
> >>               |           |
> >>              [EP]        [EP]
> >>
> >> Issue description:
> >> After PCIe enumeration completed EP driver probe function called
> >> for both the devices from two CPUS simultaneously.
> >> From EP probe function, pci_enable_device_mem called for both the EPs.
> >> This function called pci_enable_bridge enable for all the bridges
> >> recursively in the path of EP to RC.
> >>
> >> Inside pci_enable_bridge function, at two places concurrency issue is
> >> observed.
> >>
> >> Place 1:
> >>   CPU 0:
> >>     1. Done Atomic increment dev->enable_cnt
> >>        in pci_enable_device_flags
> >>     2. Inside pci_enable_resources
> >>     3. Completed pci_read_config_word(dev, PCI_COMMAND, &cmd)
> >>     4. Ready to set PCI_COMMAND_MEMORY (0x2) in
> >>        pci_write_config_word(dev, PCI_COMMAND, cmd)
> >>   CPU 1:
> >>     1. Check pci_is_enabled in function pci_enable_bridge
> >>        and it is true
> >>     2. Check (!dev->is_busmaster) also true
> >>     3. Gone into pci_set_master
> >>     4. Completed pci_read_config_word(dev, PCI_COMMAND, &old_cmd)
> >>     5. Ready to set PCI_COMMAND_MASTER (0x4) in
> >>        pci_write_config_word(dev, PCI_COMMAND, cmd)
> >>
> >> By the time of last point for both the CPUs are read value 0 and
> >> ready to write 2 and 4.
> >> After last point final value in PCI_COMMAND register is 4 instead of 6.
> >>
> >> Place 2:
> >>   CPU 0:
> >>     1. Done Atomic increment dev->enable_cnt in
> >>        pci_enable_device_flags
> >>
> >> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> >> ---
> >>  drivers/pci/pci.c | 8 ++++++--
> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index af0cc34..12721df 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -52,6 +52,7 @@ static void pci_pme_list_scan(struct work_struct *work);
> >>  static LIST_HEAD(pci_pme_list);
> >>  static DEFINE_MUTEX(pci_pme_list_mutex);
> >>  static DECLARE_DELAYED_WORK(pci_pme_work, pci_pme_list_scan);
> >> +static DEFINE_MUTEX(pci_bridge_mutex);
> >>
> >>  struct pci_pme_device {
> >>       struct list_head list;
> >> @@ -1348,10 +1349,11 @@ static void pci_enable_bridge(struct pci_dev *dev)
> >>       if (bridge)
> >>               pci_enable_bridge(bridge);
> >>
> >> +     mutex_lock(&pci_bridge_mutex);
> >>       if (pci_is_enabled(dev)) {
> >>               if (!dev->is_busmaster)
> >>                       pci_set_master(dev);
> >> -             return;
> >> +             goto end;
> >>       }
> >>
> >>       retval = pci_enable_device(dev);
> >> @@ -1359,6 +1361,8 @@ static void pci_enable_bridge(struct pci_dev *dev)
> >>               dev_err(&dev->dev, "Error enabling bridge (%d), continuing\n",
> >>                       retval);
> >>       pci_set_master(dev);
> >> +end:
> >> +     mutex_unlock(&pci_bridge_mutex);
> >
> > I think this will deadlock because we're holding pci_bridge_mutex
> > while we call pci_enable_device(), which may recursively call
> > pci_enable_bridge(), which would try to acquire pci_bridge_mutex
> > again.  My original suggestion of a mutex in the host bridge would
> > have the same problem.
> 
> This extra check "if (bridge && !pci_is_enabled(bridge))" will resolve
> the deadlock in the present patch.

Oh, I see.  In pci_enable_bridge(X), the recursive call to enable
upstream bridges happens *before* acquiring pci_bridge_mutex, so when
we call pci_enable_device(X) while holding the mutex, any upstream
bridges will have been already enabled.

We recurse all the way to the top of the hierarchy, acquire the mutex,
enable the bridge, release the mutex, then unwind and repeat for each
bridge on the way down to the endpoint.

> > We talked about using device_lock() earlier.  You found some problems
> > with that, and I'd like to understand them better.  You said:
> >
> >> But the pci_enable_bridge is called in the context of the driver
> >> probe function, we will have nexted lock problem.
> >
> > The driver core does hold device_lock() while calling the driver probe
> > function, in this path:
> >
> >   device_initial_probe
> >     __device_attach
> >       device_lock(dev)                # <-- lock
> >       __device_attach_driver
> >         ...
> >           pci_device_probe
> >             ...
> >               ->probe                 # driver probe function
> >       device_unlock(dev)              # <-- unlock
> >
> > I didn't see your patch using device_lock(), but what I had in mind
> > was something like the patch below, where pci_enable_bridge() acquires
> > the device_lock() of the bridge.
> >
> > For the sake of argument, assume a hierarchy:
> >
> >   bridge A -> bridge B -> endpoint C
> >
> > Here's what I think will happen:
> >
> >   device_lock(C)                         # driver core
> >     ...
> >       ->probe(C)                         # driver probe function
> >         pci_enable_device_flags(C)
> >           pci_enable_bridge(B)           # enable C's upstream bridge
> >             device_lock(B)
> >             pci_enable_bridge(A)         # enable B's upstream bridge
> >               device_lock(A)             # A has no upstream bridge
> >               pci_enable_device(A)
> >                 do_pci_enable_device(A)  # update A PCI_COMMAND
> >               pci_set_master(A)          # update A PCI_COMMAND
> >               device_unlock(A)
> >             pci_enable_device(B)         # update B PCI_COMMAND
> >             pci_set_master(B)            # update B PCI_COMMAND
> >             device_unlock(B)
> >           do_pci_enable_device(C)        # update C PCI_COMMAND
> >   device_unlock(C)
> >
> > I don't see a nested lock problem here.  What am I missing?
> From the probe call device_lock will taken to that endpoint and also
> for the bus. In this order
> 
> pci register driver(C)              #(driver_register())
> device_lock(B);                       # lock for parent (__driver_attach())
> device_lock(C)                       # lock for endpoint (__driver_attach())
> driver probe(C)
> pci_enable_bridge()
> device_lock(B);  # here we see the deadlock.because of parent device lock

Oh, it's the "needed for USB" thing in __driver_attach();
is that right?

        if (dev->parent)        /* Needed for USB */
                device_lock(dev->parent);
        device_lock(dev);

Looks like that came from bf74ad5bc417 ("[PATCH] Hold the device's
parent's lock during probe and remove"), and it's probably not
practical to change it, even if it's not strictly needed for PCI.

So I think your patch is correct and I applied it to pci/enumeration
for v4.14.  Thanks for your patience.

I didn't quite understand the "Place 2" concurrency issue in your
changelog.  I *think* I understand "Place 1", and I updated the
changelog with an ordering that I think illustrates the problem and
added a comment to that effect in the code.


commit 40f11adc7cd9281227f0a6a627d966dd0a5f0cd9
Author: Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Fri Aug 18 21:50:48 2017 -0500

    PCI: Avoid race while enabling upstream bridges
    
    When we enable a device, we first enable any upstream bridges.  If a bridge
    has multiple downstream devices and we enable them simultaneously, the race
    to enable the upstream bridge may cause problems.  Consider this hierarchy:
    
      bridge A --+-- device B
                 +-- device C
    
    If drivers for B and C call pci_enable_device() simultaneously, both will
    attempt to enable A, which involves setting PCI_COMMAND_MASTER via
    pci_set_master() and PCI_COMMAND_MEMORY via pci_enable_resources().
    
    In the following sequence, B's update to set A's PCI_COMMAND_MEMORY is
    lost, and neither B nor C will work correctly:
    
          B                                C
      pci_set_master(A)
        cmd = read(A, PCI_COMMAND)
        cmd |= PCI_COMMAND_MASTER
                                       pci_set_master(A)
                                         cmd = read(A, PCI_COMMAND)
                                         cmd |= PCI_COMMAND_MASTER
        write(A, PCI_COMMAND, cmd)
      pci_enable_device(A)
        pci_enable_resources(A)
          cmd = read(A, PCI_COMMAND)
          cmd |= PCI_COMMAND_MEMORY
          write(A, PCI_COMMAND, cmd)
                                         write(A, PCI_COMMAND, cmd)
    
    Avoid this race by holding a new pci_bridge_mutex while enabling a bridge.
    This ensures that both PCI_COMMAND_MASTER and PCI_COMMAND_MEMORY will be
    updated before another thread can start enabling the bridge.
    
    Note that although pci_enable_bridge() is recursive, it enables any
    upstream bridges *before* acquiring the mutex.  When it acquires the mutex
    and calls pci_set_master() and pci_enable_device(), any upstream bridges
    have already been enabled so pci_enable_device() will not deadlock by
    calling pci_enable_bridge() again.
    
    Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
    [bhelgaas: changelog, comment]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af0cc3456dc1..7cb29a223b73 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -52,6 +52,7 @@ static void pci_pme_list_scan(struct work_struct *work);
 static LIST_HEAD(pci_pme_list);
 static DEFINE_MUTEX(pci_pme_list_mutex);
 static DECLARE_DELAYED_WORK(pci_pme_work, pci_pme_list_scan);
+static DEFINE_MUTEX(pci_bridge_mutex);
 
 struct pci_pme_device {
 	struct list_head list;
@@ -1348,10 +1349,16 @@ static void pci_enable_bridge(struct pci_dev *dev)
 	if (bridge)
 		pci_enable_bridge(bridge);
 
+	/*
+	 * Hold pci_bridge_mutex to prevent a race when enabling two
+	 * devices below the bridge simultaneously.  The race may cause a
+	 * PCI_COMMAND_MEMORY update to be lost (see changelog).
+	 */
+	mutex_lock(&pci_bridge_mutex);
 	if (pci_is_enabled(dev)) {
 		if (!dev->is_busmaster)
 			pci_set_master(dev);
-		return;
+		goto end;
 	}
 
 	retval = pci_enable_device(dev);
@@ -1359,6 +1366,8 @@ static void pci_enable_bridge(struct pci_dev *dev)
 		dev_err(&dev->dev, "Error enabling bridge (%d), continuing\n",
 			retval);
 	pci_set_master(dev);
+end:
+	mutex_unlock(&pci_bridge_mutex);
 }
 
 static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
@@ -1383,7 +1392,7 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 		return 0;		/* already enabled */
 
 	bridge = pci_upstream_bridge(dev);
-	if (bridge)
+	if (bridge && !pci_is_enabled(bridge))
 		pci_enable_bridge(bridge);
 
 	/* only skip sriov related */
