Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ausxipps301.us.dell.com ([143.166.148.223]:56069 "EHLO
	ausxipps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756323Ab2EQRwB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 May 2012 13:52:01 -0400
From: <Shyam_Iyer@Dell.com>
To: <prarit@redhat.com>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>
Date: Thu, 17 May 2012 23:21:30 +0530
Subject: RE: [PATCH] pci, Add AER_panic sysfs file
Message-ID: <DBFB1B45AF80394ABD1C807E9F28D15707BC8F0CF7@BLRX7MCDC203.AMER.DELL.COM>
References: <1337274270-18785-1-git-send-email-prarit@redhat.com>
 <DBFB1B45AF80394ABD1C807E9F28D15707BC8F0CE9@BLRX7MCDC203.AMER.DELL.COM>
 <4FB537B4.1040505@redhat.com>
In-Reply-To: <4FB537B4.1040505@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Prarit Bhargava [mailto:prarit@redhat.com]
> Sent: Thursday, May 17, 2012 1:39 PM
> To: Iyer, Shyam
> Cc: linux-pci@vger.kernel.org; bhelgaas@google.com
> Subject: Re: [PATCH] pci, Add AER_panic sysfs file
> 
> 
> 
> On 05/17/2012 01:29 PM, Shyam_Iyer@Dell.com wrote:
> >
> >
> >> -----Original Message-----
> >> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> >> owner@vger.kernel.org] On Behalf Of Prarit Bhargava
> >> Sent: Thursday, May 17, 2012 1:05 PM
> >> To: linux-pci@vger.kernel.org
> >> Cc: Prarit Bhargava; Bjorn Helgaas
> >> Subject: [PATCH] pci, Add AER_panic sysfs file
> >>
> >> Consider the following case
> >>
> >> 		[ RP ]
> >> 		  |
> >> 		  |
> >> 	+---------+-----------+
> >> 	|	  |	      |
> >>        [H1]      [H2]        [X1]
> >>
> >> where RP is a PCIE Root Port, H1 and H2 are devices with drivers
> that
> >> support
> >> PCIE AER driver error handling (ie, they have pci_error_handlers
> >> defined in
> >> the driver), and X1 is a device with a driver that does not support
> >> PCIE
> >> AER driver error handling.
> >>
> >> If the Root Port takes an error what currently happens is that the
> >> bus resets and H1 & H2 call their slot_reset functions.  X1 does
> >> nothing.
> >>
> >> In some cases a user may not wish the system to continue because X1
> is
> >> an unhardened driver.  In these cases, the system should not do a
> bus
> >> reset,
> >> but rather the system should panic to avoid any further possible
> data
> >> corruption.
> >
> > Do we neeed to panic for both correctable and uncorrectable errors..
> ?
> >
> > I thought correctable errors could recover without a bus reset.
> 
> Will a bus reset be issued on a correctable error?  I thought the code
> path was
> that the bus reset was issued on the uncorrectable error.
> 
> drivers/pci/pcie/aer/aerdrv_core.c: do_recovery()
> 
>         if (severity == AER_FATAL) {
>                 result = reset_link(dev);
>                 if (result != PCI_ERS_RESULT_RECOVERED)
>                         goto failed;
>         }
> 
> I may not be looking at the right spot of code.  Care to enlighten me?
> :)
> 
> P.

Actually I was reading the documentation .. 
Documentation/PCI/pcieaer-howto.txt

"
Correctable errors pose no impacts on the functionality of the
interface. The PCI Express protocol can recover without any software
intervention or any loss of data. These errors are detected and
corrected by hardware. Unlike correctable errors, uncorrectable
errors impact functionality of the interface. Uncorrectable errors
can cause a particular transaction or a particular PCI Express link
to be unreliable. Depending on those error conditions, uncorrectable
errors are further classified into non-fatal errors and fatal errors.
Non-fatal errors cause the particular transaction to be unreliable,
but the PCI Express link itself is fully functional. Fatal errors, on
the other hand, cause the link to be unreliable.
"

But anyways the AER_FATAL is true for uncorrectable errors only and not for correctable errors which means reset_link doesn't happen for correctable errors.

drivers/pci/pcie/aer/aerdrv_core.c

if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
                e_info->id = ERR_UNCOR_ID(e_src->id);
        
                if (e_src->status & PCI_ERR_ROOT_FATAL_RCV)
                        e_info->severity = AER_FATAL;
                else
                        e_info->severity = AER_NONFATAL;
                
                if (e_src->status & PCI_ERR_ROOT_MULTI_UNCOR_RCV)
                        e_info->multi_error_valid = 1;
                else    
                        e_info->multi_error_valid = 0;
                        
                aer_print_port_info(p_device->port, e_info);
        
                if (find_source_device(p_device->port, e_info))
                        aer_process_err_devices(p_device, e_info);
        }               
