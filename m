Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17345 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759992Ab2JaVtv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 31 Oct 2012 17:49:51 -0400
Message-ID: <50919CF1.9010906@redhat.com>
Date: Wed, 31 Oct 2012 17:49:37 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Donald Dutile <ddutile@redhat.com>
CC: linux-pci@vger.kernel.org, bhelgaas@google.com,
	yuvalmin@broadcom.com, bhutchings@solarflare.com,
	gregory.v.rose@intel.com, yinghai@kernel.org, davem@davemloft.net
Subject: Re: [PATCH] SRIOV device enable and disable via sysfs
References: <1351718353-6124-1-git-send-email-ddutile@redhat.com>
In-Reply-To: <1351718353-6124-1-git-send-email-ddutile@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sorry, $Subject should be [PATCH] not [RFC]  ... I don't know why
it prefixed by [RFC] .... I blame it on Hurricane Sandy ! ;-)

On 10/31/2012 05:19 PM, Donald Dutile wrote:
> Provide files under sysfs to determine the max number of vfs
> an SRIOV-capable PCIe device supports, and methods to enable and
> disable the vfs on a per device basis.
>
> Currently, VF enablement by SRIOV-capable PCIe devices is done
> in driver-specific module parameters.  If not setup in modprobe files,
> it requires admin to unload&  reload PF drivers with number of desired
> VFs to enable.  Additionally, the enablement is system wide: all
> devices controlled by the same driver have the same number of VFs
> enabled.  Although the latter is probably desired, there are PCI
> configurations setup by system BIOS that may not enable that to occur.
>
> Two files are created if a PCIe device has SRIOV support:
> sriov_totalvfs -- cat-ing this file returns the maximum number
>                    of VFs a PCIe device supports.
> sriov_numvfs -- echo'ing a positive number to this file enables
>                  &  configures this number of VFs for this given PCIe
>                  device.
> 	     -- echo'ing 0 to this file disables and deconfigures
>                  all VFs for this given PCIe device.
>               -- cat-ing this file will return the number of VFs
>                  currently enabled on this PCIe device.
>
> VF enable and disablement is invoked much like other PCIe
> configuration functions -- via a registered callback in the driver,
> i.e., probe, release, etc.  In this case, sriov_configure
>
> RFC V3->PATCH:
> -- incorporate feedback from Ben Hutchings.
> -- clean up poor RFC patches&  sanitize through checkpatch.pl
>
> RFC v2->v3:
> -- change the file names to reflect the names used in the SRIOV spec
> -- change to a single file for enable&  disable;
>     change driver interface to a single interface.
> -- add more informative messages on failures
> -- add a core method that a driver can invoke to modify
>     the totalvfs reported&  supported by a driver.
> -- a set of patches for ixgbe provided by Greg Rose to use the
>     new interfaces; the last patch modified from the original
>     two file, enable/disable interface to the current single file
>     enable/disable. Greg will eventually post the final version
>     of these patches via Intel's usual process for driver patches.
>     Provided here as an example, and enable other SRIOV drivers
>     to see how adoption of the interface can be added.
>
> RFC v1->v2:
> This patch is based on previous 2 patches by Yinghai Lu
> that cleaned up the vga attributes for PCI devices under sysfs,
> and uses visibility-checking group attributes as recommended by
> Greg K-H.
>
> Signed-off-by: Donald Dutile<ddutile@redhat.com>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

