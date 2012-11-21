Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:36648 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab2KUNsI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Nov 2012 08:48:08 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so2799508eaa.19
        for <linux-pci@vger.kernel.org>; Wed, 21 Nov 2012 05:48:07 -0800 (PST)
Message-ID: <104076AA577A456AA79FACBEC7DDA561@alyakaslap>
From: "Alex Lyakas" <alex@zadarastorage.com>
To: "Don Dutile" <ddutile@redhat.com>
Cc: <linux-pci@vger.kernel.org>
References: <0B81514A792D4D9FAB292ED315D48BE2@alyakaslap> <50ABE45C.4080509@redhat.com>
In-Reply-To: <50ABE45C.4080509@redhat.com>
Subject: Re: pci_enable_msix()  failure
Date: Wed, 21 Nov 2012 15:48:10 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Don,

I had indeed iqrbalance set on. So I rested without it, and was able to 
reproduce the issue. However, now the failure happens on call to 
request_threaded_irq() within assigned_device_enable_host_msix() function of 
KVM. The problem is that request_threaded_irq() returns -16 (EBUSY).  Will 
this help somehow to debug the issue further?

Thanks,
Alex.


-----Original Message----- 
From: Don Dutile
Sent: 20 November, 2012 10:13 PM
To: Alex Lyakas
Subject: Re: pci_enable_msix() failure

On 11/20/2012 01:04 PM, Alex Lyakas wrote:
> Hello list, I was advised to post this question by Jesse Barnes; I also 
> posted to KVM list.
>
> I am running Ubuntu-Precise 3.2.0-29-generic #46, with stock KVM ("QEMU 
> emulator version 1.0 (qemu-kvm-1.0)") on a Dell R510 server. I have one 
> dual-port Intel's NIC 82599, of which I spawn 32 VFs from each port. I 
> spawn
> virtual machines with KVM, each VM has 4 VFs attached (two from each PF).
>
> Once in a while, in particular when I spawn multiple VMs in parallel, I 
> hit an issue that one of the VFs does not have an IRQ assigned to it. I am 
> checking this in /proc/interrupts, looking for entries like 
> "kvm:0000:03:14.6". In some cases, an entry is missing for a particular 
> VF. As a result, the VF within the VM is non-functional.
>
> I debugged this issue further, by adding prints to kvm.ko code. I see that 
> the failure happens in kvm_vm_ioctl_assigned_device/KVM_ASSIGN_DEV_IRQ 
> path, which calls assigned_device_enable_host_msix() function, which calls
> pci_enable_msix(), which fails with EINVAL or with ENOMEM. This path is 
> called twice for each VF.
>
> I see that first pci_enable_msix() returns -12/-22, and when 
> kvm_vm_ioctl_set_msix_nr() is called again, it sees that adev->entries_nr 
> != 0 and fails the call with EINVAL. I can repro it only when spawning 
> like 8 or 10 VMs in parallel, but it doesn't happen every time. So it 
> seems like this is not a resource shortage problem, but some race 
> somewhere.
>
> I tested this with several version of ixgbe drivers, including the in-tree 
> version that comes with Precise. It reproduces with all the versions.
>
> Can anybody pls advise on how to debug this issue further?
>
> Thanks,
> Alex.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
Is your system running w/irqbalance on?
if so, can you test with it off? 

