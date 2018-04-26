Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:34804 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753168AbeDZTcS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2018 15:32:18 -0400
Subject: Re: [PATCH 1/2] PCI: Add pci_bus_specific_read_dev_vendor_id() to
 workaround PCI switch specific issues prior to accessing newly added endpoint
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <16461819-82a1-8122-4a30-842f9a078988@oracle.com>
 <201804261426.2HZUSMma%fengguang.wu@intel.com>
From: James Puthukattukaran <james.puthukattukaran@oracle.com>
Message-ID: <32d9b7ce-0993-c749-3285-a51146fe37d6@oracle.com>
Date: Thu, 26 Apr 2018 15:32:00 -0400
MIME-Version: 1.0
In-Reply-To: <201804261426.2HZUSMma%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 04/26/2018 02:26 AM, kbuild test robot wrote:
> Hi James,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on pci/next]
> [also build test ERROR on v4.17-rc2 next-20180424]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/James-Puthukattukaran/PCI-SUpport-to-workaround-bus-level-HW-issues/20180426-092305
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> config: ia64-allnoconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=ia64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/probe.o: In function `pci_bus_read_dev_vendor_id':
>>> probe.c:(.text+0x3e02): undefined reference to `pci_bus_specific_read_dev_vendor_id'

Alex/Sinan -

Would it be an acceptable fix for this problem?


--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2097,6 +2097,13 @@ static bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l,
 	return true;
 }
 
+int __weak pci_bus_specific_read_dev_vendor_id(struct pci_bus *bus, int devfn, 
+					u32 *l, int timeout)
+{
+	return -ENOTTY;
+}
+
+
 bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 				int timeout)
 {


I ran the repro steps and it completes without issues. In addition, I will fix the typos Alex pointed out in the last submission and resubmit.
thanks
James
