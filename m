Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:41577 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbaJ0RXt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Oct 2014 13:23:49 -0400
Received: by mail-qg0-f54.google.com with SMTP id q108so929842qgd.27
        for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2014 10:23:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bug-86951-41252@https.bugzilla.kernel.org/>
References: <bug-86951-41252@https.bugzilla.kernel.org/>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 27 Oct 2014 11:23:26 -0600
Message-ID: <CAErSpo7LiM9zpxhNgOYWRg1njE4XSDh8OxU1SOJBG-VReaADeA@mail.gmail.com>
Subject: Re: [Bug 86951] New: iommu regression
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+to linux-pci, +cc Alex]

On Sun, Oct 26, 2014 at 7:56 AM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=86951
>
>             Bug ID: 86951
>            Summary: iommu regression
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 3.13
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: nodenet@hotmail.com
>         Regression: No
>
> I am trying to make a Digium TDM410 PCI card available to a guest VM via VT-d /
> IOMMU. This appears to work under kernel 3.2 but not via any later kernel
> tested since.
>
> I noted pci_find_upstream_pcie_bridge errors
> (https://bugzilla.kernel.org/show_bug.cgi?id=44881) which appear resolved in
> 3.17 and above but was advised to file a new bug as this appears to be a new
> problem.
>
> Working kernel linux 3.2.0-70-generic
> Tested but not working 3.5.0-54-generic, 3.13.0-37-generic,
> 3.16.6-031606-generic, 3.17.1-031701-generic or 3.18.0-031800rc1-generic.
>
> 3.17.1 and 3.18.0-rc1 resolve the pci_find_upstream_pcie_bridge error message
> both still have the DMAR errors, the later has both read and write errors.
>
> https://bugs.launchpad.net/ubuntu/+source/linux-lts-trusty/+bug/1385388
>
> I believe this type of configuration is often achieved using Xen but I am using
> virtualbox 4.1.34 and it is possible there are some quirks associated with my
> motherboard.
>
> Motherboard: Gigabyte Technology Co., Ltd. Z87X-D3H/Z87X-D3H-CF, BIOS F9
> 08/25/2014 (latest)
>
> 03:00.0 Ethernet controller: Digium, Inc. Wildcard TDM410 4-port analog card
> (rev 11)
> 03:00.0 0200: d161:8005 (rev 11)
>
> 02:00.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 41) (prog-if 01
> [Subtractive decode])
> 02:00.0 0604: 8086:244e (rev 41)
>
> typical errors shown on the host when module loaded via modprobe in the
> guest....
>
> Oct 26 06:35:39 kernel: [ 227.795652] dmar: DRHD: handling fault status reg 3
> Oct 26 06:35:39 kernel: [ 227.795678] dmar: DMAR:[DMA Read] Request device
> [03:00.0] fault addr 73ac6000
> Oct 26 06:35:39 kernel: [ 227.795678] DMAR:[fault reason 06] PTE Read access is
> not set
>
> Modprobe freezes in the guest, guest is causing a high cpu load and freezes on
> reboot due to possible spin lock.
>
> --
> You are receiving this mail because:
> You are watching the assignee of the bug.
