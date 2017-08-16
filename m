Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751649AbdHPNn5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Aug 2017 09:43:57 -0400
Date: Wed, 16 Aug 2017 08:43:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [RFC PATCH v3] pci: Concurrency issue during pci enable bridge
Message-ID: <20170816134354.GV32525@bhelgaas-glaptop.roam.corp.google.com>
References: <1501858648-22228-1-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501858648-22228-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 04, 2017 at 08:27:28PM +0530, Srinath Mannam wrote:
> Concurrency issue is observed during pci enable bridge called
> for multiple pci devices initialization in SMP system.
> 
> Setup details:
>  - SMP system with 8 ARMv8 cores running Linux kernel(4.11).
>  - Two EPs are connected to PCIe RC through bridge as shown
>    in the below figure.
> 
>                    [RC]
>                     |
>                  [BRIDGE]
>                     |
>                -----------
>               |           |
>              [EP]        [EP]
> 
> Issue description:
> After PCIe enumeration completed EP driver probe function called
> for both the devices from two CPUS simultaneously.
> From EP probe function, pci_enable_device_mem called for both the EPs.
> This function called pci_enable_bridge enable for all the bridges
> recursively in the path of EP to RC.
> 
> Inside pci_enable_bridge function, at two places concurrency issue is
> observed.
> 
> Place 1:
>   CPU 0:
>     1. Done Atomic increment dev->enable_cnt
>        in pci_enable_device_flags
>     2. Inside pci_enable_resources
>     3. Completed pci_read_config_word(dev, PCI_COMMAND, &cmd)
>     4. Ready to set PCI_COMMAND_MEMORY (0x2) in
>        pci_write_config_word(dev, PCI_COMMAND, cmd)
>   CPU 1:
>     1. Check pci_is_enabled in function pci_enable_bridge
>        and it is true
>     2. Check (!dev->is_busmaster) also true
>     3. Gone into pci_set_master
>     4. Completed pci_read_config_word(dev, PCI_COMMAND, &old_cmd)
>     5. Ready to set PCI_COMMAND_MASTER (0x4) in
>        pci_write_config_word(dev, PCI_COMMAND, cmd)
> 
> By the time of last point for both the CPUs are read value 0 and
> ready to write 2 and 4.
> After last point final value in PCI_COMMAND register is 4 instead of 6.
> 
> Place 2:
>   CPU 0:
>     1. Done Atomic increment dev->enable_cnt in
>        pci_enable_device_flags
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
>  drivers/pci/pci.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index af0cc34..12721df 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -52,6 +52,7 @@ static void pci_pme_list_scan(struct work_struct *work);
>  static LIST_HEAD(pci_pme_list);
>  static DEFINE_MUTEX(pci_pme_list_mutex);
>  static DECLARE_DELAYED_WORK(pci_pme_work, pci_pme_list_scan);
> +static DEFINE_MUTEX(pci_bridge_mutex);
>  
>  struct pci_pme_device {
>  	struct list_head list;
> @@ -1348,10 +1349,11 @@ static void pci_enable_bridge(struct pci_dev *dev)
>  	if (bridge)
>  		pci_enable_bridge(bridge);
>  
> +	mutex_lock(&pci_bridge_mutex);
>  	if (pci_is_enabled(dev)) {
>  		if (!dev->is_busmaster)
>  			pci_set_master(dev);
> -		return;
> +		goto end;
>  	}
>  
>  	retval = pci_enable_device(dev);
> @@ -1359,6 +1361,8 @@ static void pci_enable_bridge(struct pci_dev *dev)
>  		dev_err(&dev->dev, "Error enabling bridge (%d), continuing\n",
>  			retval);
>  	pci_set_master(dev);
> +end:
> +	mutex_unlock(&pci_bridge_mutex);

I think this will deadlock because we're holding pci_bridge_mutex
while we call pci_enable_device(), which may recursively call
pci_enable_bridge(), which would try to acquire pci_bridge_mutex
again.  My original suggestion of a mutex in the host bridge would
have the same problem.

We talked about using device_lock() earlier.  You found some problems
with that, and I'd like to understand them better.  You said:

> But the pci_enable_bridge is called in the context of the driver
> probe function, we will have nexted lock problem.

The driver core does hold device_lock() while calling the driver probe
function, in this path:

  device_initial_probe
    __device_attach
      device_lock(dev)                # <-- lock
      __device_attach_driver
        ...
          pci_device_probe
            ...
              ->probe                 # driver probe function
      device_unlock(dev)              # <-- unlock

I didn't see your patch using device_lock(), but what I had in mind
was something like the patch below, where pci_enable_bridge() acquires
the device_lock() of the bridge.

For the sake of argument, assume a hierarchy:

  bridge A -> bridge B -> endpoint C

Here's what I think will happen:

  device_lock(C)                         # driver core
    ...
      ->probe(C)                         # driver probe function
        pci_enable_device_flags(C)
	  pci_enable_bridge(B)           # enable C's upstream bridge
	    device_lock(B)
	    pci_enable_bridge(A)         # enable B's upstream bridge
	      device_lock(A)             # A has no upstream bridge
	      pci_enable_device(A)
	        do_pci_enable_device(A)  # update A PCI_COMMAND
	      pci_set_master(A)          # update A PCI_COMMAND
	      device_unlock(A)
	    pci_enable_device(B)         # update B PCI_COMMAND
	    pci_set_master(B)            # update B PCI_COMMAND
	    device_unlock(B)
	  do_pci_enable_device(C)        # update C PCI_COMMAND
  device_unlock(C)

I don't see a nested lock problem here.  What am I missing?

Bjorn


diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e8e40dea2842..38154ba628a9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1344,6 +1344,7 @@ static void pci_enable_bridge(struct pci_dev *dev)
 	struct pci_dev *bridge;
 	int retval;
 
+	device_lock(&dev->dev);
 	bridge = pci_upstream_bridge(dev);
 	if (bridge)
 		pci_enable_bridge(bridge);
@@ -1351,7 +1352,7 @@ static void pci_enable_bridge(struct pci_dev *dev)
 	if (pci_is_enabled(dev)) {
 		if (!dev->is_busmaster)
 			pci_set_master(dev);
-		return;
+		goto out;
 	}
 
 	retval = pci_enable_device(dev);
@@ -1359,6 +1360,9 @@ static void pci_enable_bridge(struct pci_dev *dev)
 		dev_err(&dev->dev, "Error enabling bridge (%d), continuing\n",
 			retval);
 	pci_set_master(dev);
+
+out:
+	device_unlock(&dev->dev);
 }
 
 static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
