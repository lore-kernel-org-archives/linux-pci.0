Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:58836 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221AbaLGSmr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 7 Dec 2014 13:42:47 -0500
Received: by mail-wg0-f46.google.com with SMTP id x13so2100185wgg.19
        for <linux-pci@vger.kernel.org>; Sun, 07 Dec 2014 10:42:46 -0800 (PST)
From: Eli Cohen <eli@dev.mellanox.co.il>
Date: Sun, 7 Dec 2014 20:42:43 +0200
To: Yuval Mintz <Yuval.Mintz@qlogic.com>
Cc: Eli Cohen <eli@dev.mellanox.co.il>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	linux-pci <linux-pci@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	"ogerlitz@mellanox.com" <ogerlitz@mellanox.com>,
	"yevgenyp@mellanox.com" <yevgenyp@mellanox.com>,
	Donald Dutile <ddutile@redhat.com>
Subject: Re: [PATCH RFC] pci: Control whether VFs are probed on
 pci_enable_sriov
Message-ID: <20141207184242.GA24790@mtldesk30>
References: <1417957693-24979-1-git-send-email-eli@mellanox.com>
 <B5657A6538887040AD3A81F1008BEC63BA6616@avmb3.qlogic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B5657A6538887040AD3A81F1008BEC63BA6616@avmb3.qlogic.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Dec 07, 2014 at 05:05:06PM +0000, Yuval Mintz wrote:
> 
> >This can save host side resource usage by VF instances which would be
> >eventually probed to VMs.
> 
> >Use a parameter to pci_enable_sriov to control that policy, and modify
> >all current callers such that they retain the same functionality.
> 
> What's the end-game here? How eventually would this be controlled?

You can probe any VF at the hypervisor through sysfs files
(bind/unbind). You can also pass them through to a VM. Nothing
changes.

> 
> >Use a one shot flag on struct pci_device which is cleared after the
> >first probe is ignored so subsequent attempts go through.
> 
> Does a one-shot flag suffice? E.g., consider assigning a VF to VM and
> than shutting down the VM. Assuming this feature is disabled,
> the VF didn't appear on the hypervisor prior to the assignment but
> will appear after its shutdown.

Sorry, I don't follow you here. Please clarify.

To be clear, the functionality proposed here is really one shot. It
just prevents calling probe once; besides that nothing changes.
