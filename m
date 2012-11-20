Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:36136 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab2KTSEc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Nov 2012 13:04:32 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so1855361eek.19
        for <linux-pci@vger.kernel.org>; Tue, 20 Nov 2012 10:04:30 -0800 (PST)
Message-ID: <0B81514A792D4D9FAB292ED315D48BE2@alyakaslap>
From: "Alex Lyakas" <alex@zadarastorage.com>
To: <linux-pci@vger.kernel.org>
Subject: pci_enable_msix()  failure
Date: Tue, 20 Nov 2012 20:04:29 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello list, I was advised to post this question by Jesse Barnes; I also 
posted to KVM list.

I am running Ubuntu-Precise 3.2.0-29-generic #46, with stock KVM ("QEMU 
emulator version 1.0 (qemu-kvm-1.0)") on a Dell R510 server. I have one 
dual-port Intel's NIC 82599, of which I spawn 32 VFs from each port. I spawn
virtual machines with KVM, each VM has 4 VFs attached (two from each PF).

Once in a while, in particular when I spawn multiple VMs in parallel, I hit 
an issue that one of the VFs does not have an IRQ assigned to it. I am 
checking this in /proc/interrupts, looking for entries like 
"kvm:0000:03:14.6". In some cases, an entry is missing for a particular VF. 
As a result, the VF within the VM is non-functional.

I debugged this issue further, by adding prints to kvm.ko code. I see that 
the failure happens in kvm_vm_ioctl_assigned_device/KVM_ASSIGN_DEV_IRQ path, 
which calls assigned_device_enable_host_msix() function, which calls
pci_enable_msix(), which fails with EINVAL or with ENOMEM. This path is 
called twice for each VF.

I see that first pci_enable_msix() returns -12/-22, and when 
kvm_vm_ioctl_set_msix_nr() is called again, it sees that adev->entries_nr != 
0 and fails the call with EINVAL. I can repro it only when spawning like 8 
or 10 VMs in parallel, but it doesn't happen every time. So it seems like 
this is not a resource shortage problem, but some race somewhere.

I tested this with several version of ixgbe drivers, including the in-tree 
version that comes with Precise. It reproduces with all the versions.

Can anybody pls advise on how to debug this issue further?

Thanks,
Alex. 

