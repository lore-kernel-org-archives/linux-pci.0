Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db3on0057.outbound.protection.outlook.com ([157.55.234.57]:7424
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752427AbcCGHty convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2016 02:49:54 -0500
From: Ilya Lesokhin <ilyal@mellanox.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "helgaas@kernel.org" <helgaas@kernel.org>,
	Haggai Eran <haggaie@mellanox.com>
Subject: pci_enable_sriov is not thread safe
Date: Mon, 7 Mar 2016 07:17:57 +0000
Message-ID: <VI1PR05MB1119F15E98C4277F6FD1AA30D4B10@VI1PR05MB1119.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
I've noticed that pci_enable_sriov() is not thread safe. 
Running it in parallel with the following command:
echo 2 >  /sys/class/net/enp66s0f0/device/sriov_numvfs  & echo 2 >  /sys/class/net/enp66s0f0/device/sriov_numvfs
triggers the BUG_ON() at [1].
I'm wondering if device driver is supposed to prevent this?
Or whether this is acceptable because admin privileges are required to trigger it?

This issue concerns me because I'm working on VFIO sriov support[2] 
and I would like give untrusted VMs the ability to call pci_enable_sriov().

I've noticed that we do have an sriov mutex but we take it only inside virtfn_add()
rather than around the entire sriov_enable() function. Is there a good reason for that?

[1] http://lxr.free-electrons.com/source/drivers/pci/iov.c#L155
[2] http://www.spinics.net/lists/kvm/msg127075.html

Thanks,
Ilya
