Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54653 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756498Ab2K2ASq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 28 Nov 2012 19:18:46 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so8107109lbb.19
        for <linux-pci@vger.kernel.org>; Wed, 28 Nov 2012 16:18:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0B81514A792D4D9FAB292ED315D48BE2@alyakaslap>
References: <0B81514A792D4D9FAB292ED315D48BE2@alyakaslap>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 28 Nov 2012 17:18:24 -0700
Message-ID: <CAErSpo5zNcoDLuhHw8TM1rQ71hsmknKAY3Dmcd14tEgJowPNKg@mail.gmail.com>
Subject: Re: pci_enable_msix() failure
To: Alex Lyakas <alex@zadarastorage.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 20, 2012 at 11:04 AM, Alex Lyakas <alex@zadarastorage.com> wrote:
> Hello list, I was advised to post this question by Jesse Barnes; I also
> posted to KVM list.

When you post a question to more than one list, you should always send
a *single* message with all the lists being copied.  That way
everybody can tell what progress is being made, and we can avoid
duplicating effort.

I see via a Google search that you've gotten responses on the KVM
list, e.g., http://www.spinics.net/lists/kvm/msg82997.html, so I
assume you don't need any more help from linux-pci.

If that's not the case, please add linux-pci to the CC: list of the
thread where you're working on this.

> I am running Ubuntu-Precise 3.2.0-29-generic #46, with stock KVM ("QEMU
> emulator version 1.0 (qemu-kvm-1.0)") on a Dell R510 server. I have one
> dual-port Intel's NIC 82599, of which I spawn 32 VFs from each port. I spawn
> virtual machines with KVM, each VM has 4 VFs attached (two from each PF).
>
> Once in a while, in particular when I spawn multiple VMs in parallel, I hit
> an issue that one of the VFs does not have an IRQ assigned to it. I am
> checking this in /proc/interrupts, looking for entries like
> "kvm:0000:03:14.6". In some cases, an entry is missing for a particular VF.
> As a result, the VF within the VM is non-functional.
>
> I debugged this issue further, by adding prints to kvm.ko code. I see that
> the failure happens in kvm_vm_ioctl_assigned_device/KVM_ASSIGN_DEV_IRQ path,
> which calls assigned_device_enable_host_msix() function, which calls
> pci_enable_msix(), which fails with EINVAL or with ENOMEM. This path is
> called twice for each VF.
>
> I see that first pci_enable_msix() returns -12/-22, and when
> kvm_vm_ioctl_set_msix_nr() is called again, it sees that adev->entries_nr !=
> 0 and fails the call with EINVAL. I can repro it only when spawning like 8
> or 10 VMs in parallel, but it doesn't happen every time. So it seems like
> this is not a resource shortage problem, but some race somewhere.
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
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
