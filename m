Return-Path: <SRS0=GPaa=3H=redhat.com=prarit@kernel.org>
Return-Path: <SRS0=GPaa=3H=redhat.com=prarit@kernel.org>
Message-ID: <58DCF310.7000001@redhat.com>
Date: Thu, 30 Mar 2017 07:59:12 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci@vger.kernel.org, alex.williamson@redhat.com,
 darcari@redhat.com, mstowe@redhat.com, bhelgaas@google.com,
 lukas@wunner.de, keith.busch@intel.com, mika.westerberg@linux.intel.com
Subject: Re: [PATCH] pci: Only disable MSI/X and enable INTx if shutdown function
 has been called
References: <1485457667-791-1-git-send-email-prarit@redhat.com> <20170309215718.GC19517@bhelgaas-glaptop.roam.corp.google.com> <58C29C80.8040904@redhat.com>
In-Reply-To: <58C29C80.8040904@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 03/10/2017 07:30 AM, Prarit Bhargava wrote:
> 
> 
> On 03/09/2017 04:57 PM, Bjorn Helgaas wrote:
>> Hi Prarit,
>>
>> My abject apologies for taking so long to deal with this.
> 
> np.  It's only two lines but it is also complex code and I know you're busy.
> 

<snip>

>>
>> What do you think of the following two patches?  Thanks for all the
>> details in your changelog -- I think they finally helped me gel all
>> the pieces in my mind, and it all seems obvious now.  I tried to
>> distill it down to just the critical pieces.
>>
> 
> I'm good with these two patches.

Bjorn, I just am making sure that these don't get left on the floor (so to speak).

P.

> 
> P.
> 
>> Bjorn
>>
>>
>> commit fda78d7a0ead144f4b2cdb582dcba47911f4952c
>> Author: Prarit Bhargava <prarit@redhat.com>
>> Date:   Thu Jan 26 14:07:47 2017 -0500
>>
>>     PCI/MSI: Stop disabling MSI/MSI-X in pci_device_shutdown()
>>     
>>     The pci_bus_type .shutdown method, pci_device_shutdown(), is called from
>>     device_shutdown() in the kernel restart and shutdown paths.
>>     
>>     Previously, pci_device_shutdown() called pci_msi_shutdown() and
>>     pci_msix_shutdown().  This disables MSI and MSI-X, which causes the device
>>     to fall back to raising interrupts via INTx.  But the driver is still bound
>>     to the device, it doesn't know about this change, and it likely doesn't
>>     have an INTx handler, so these INTx interrupts cause "nobody cared"
>>     warnings like this:
>>     
>>       irq 16: nobody cared (try booting with the "irqpoll" option)
>>       CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.2-1.el7_UNSUPPORTED.x86_64 #1
>>       Hardware name: Hewlett-Packard HP Z820 Workstation/158B, BIOS J63 v03.90 06/
>>       ...
>>     
>>     The MSI disabling code was added by d52877c7b1af ("pci/irq: let
>>     pci_device_shutdown to call pci_msi_shutdown v2") because a driver left MSI
>>     enabled and kdump failed because the kexeced kernel wasn't prepared to
>>     receive the MSI interrupts.
>>     
>>     Subsequent commits 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even
>>     if kernel doesn't support MSI") and  e80e7edc55ba ("PCI/MSI: Initialize MSI
>>     capability for all architectures") changed the kexeced kernel to disable
>>     all MSIs itself so it no longer depends on the crashed kernel to clean up
>>     after itself.
>>     
>>     Stop disabling MSI/MSI-X in pci_device_shutdown().  This resolves the
>>     "nobody cared" unhandled IRQ issue above.  It also allows PCI serial
>>     devices, which may rely on the MSI interrupts, to continue outputting
>>     messages during reboot/shutdown.
>>     
>>     [bhelgaas: changelog, drop pci_msi_shutdown() and pci_msix_shutdown() calls
>>     altogether]
>>     Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=187351
>>     Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>     CC: Alex Williamson <alex.williamson@redhat.com>
>>     CC: David Arcari <darcari@redhat.com>
>>     CC: Myron Stowe <mstowe@redhat.com>
>>     CC: Lukas Wunner <lukas@wunner.de>
>>     CC: Keith Busch <keith.busch@intel.com>
>>     CC: Mika Westerberg <mika.westerberg@linux.intel.com>
>>
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index afa72717a979..8ec136164e93 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -461,8 +461,6 @@ static void pci_device_shutdown(struct device *dev)
>>  
>>  	if (drv && drv->shutdown)
>>  		drv->shutdown(pci_dev);
>> -	pci_msi_shutdown(pci_dev);
>> -	pci_msix_shutdown(pci_dev);
>>  
>>  	/*
>>  	 * If this is a kexec reboot, turn off Bus Master bit on the
>>
>> commit 688769f643bfce894f14dc7141bfc6c010f52750
>> Author: Bjorn Helgaas <bhelgaas@google.com>
>> Date:   Thu Mar 9 15:45:14 2017 -0600
>>
>>     PCI/MSI: Make pci_msi_shutdown() and pci_msix_shutdown() static
>>     
>>     pci_msi_shutdown() and pci_msix_shutdown() are used only in
>>     drivers/pci/msi.c, so make them static.
>>     
>>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index d571bc330686..4d062c3bf5f0 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -882,7 +882,7 @@ int pci_msi_vec_count(struct pci_dev *dev)
>>  }
>>  EXPORT_SYMBOL(pci_msi_vec_count);
>>  
>> -void pci_msi_shutdown(struct pci_dev *dev)
>> +static void pci_msi_shutdown(struct pci_dev *dev)
>>  {
>>  	struct msi_desc *desc;
>>  	u32 mask;
>> @@ -994,7 +994,7 @@ int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
>>  }
>>  EXPORT_SYMBOL(pci_enable_msix);
>>  
>> -void pci_msix_shutdown(struct pci_dev *dev)
>> +static void pci_msix_shutdown(struct pci_dev *dev)
>>  {
>>  	struct msi_desc *entry;
>>  
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index eb3da1a04e6c..10917c122974 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1297,11 +1297,9 @@ struct msix_entry {
>>  
>>  #ifdef CONFIG_PCI_MSI
>>  int pci_msi_vec_count(struct pci_dev *dev);
>> -void pci_msi_shutdown(struct pci_dev *dev);
>>  void pci_disable_msi(struct pci_dev *dev);
>>  int pci_msix_vec_count(struct pci_dev *dev);
>>  int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec);
>> -void pci_msix_shutdown(struct pci_dev *dev);
>>  void pci_disable_msix(struct pci_dev *dev);
>>  void pci_restore_msi_state(struct pci_dev *dev);
>>  int pci_msi_enabled(void);
>> @@ -1327,13 +1325,11 @@ int pci_irq_get_node(struct pci_dev *pdev, int vec);
>>  
>>  #else
>>  static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
>> -static inline void pci_msi_shutdown(struct pci_dev *dev) { }
>>  static inline void pci_disable_msi(struct pci_dev *dev) { }
>>  static inline int pci_msix_vec_count(struct pci_dev *dev) { return -ENOSYS; }
>>  static inline int pci_enable_msix(struct pci_dev *dev,
>>  				  struct msix_entry *entries, int nvec)
>>  { return -ENOSYS; }
>> -static inline void pci_msix_shutdown(struct pci_dev *dev) { }
>>  static inline void pci_disable_msix(struct pci_dev *dev) { }
>>  static inline void pci_restore_msi_state(struct pci_dev *dev) { }
>>  static inline int pci_msi_enabled(void) { return 0; }
>>
> 
> 
