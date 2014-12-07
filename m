Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60555 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753725AbaLHCcz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 7 Dec 2014 21:32:55 -0500
Message-ID: <5484C77D.7060501@redhat.com>
Date: Sun, 07 Dec 2014 16:32:45 -0500
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Yuval Mintz <Yuval.Mintz@qlogic.com>,
	Eli Cohen <eli@dev.mellanox.co.il>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>
CC: linux-pci <linux-pci@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	"ogerlitz@mellanox.com" <ogerlitz@mellanox.com>,
	"yevgenyp@mellanox.com" <yevgenyp@mellanox.com>,
	Eli Cohen <eli@mellanox.com>
Subject: Re: [PATCH RFC] pci: Control whether VFs are probed on pci_enable_sriov
References: <1417957693-24979-1-git-send-email-eli@mellanox.com> <B5657A6538887040AD3A81F1008BEC63BA6616@avmb3.qlogic.org>
In-Reply-To: <B5657A6538887040AD3A81F1008BEC63BA6616@avmb3.qlogic.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/07/2014 12:05 PM, Yuval Mintz wrote:
>
>> This can save host side resource usage by VF instances which would be
>> eventually probed to VMs.
>
>> Use a parameter to pci_enable_sriov to control that policy, and modify
>> all current callers such that they retain the same functionality.
>
> What's the end-game here? How eventually would this be controlled?
>
>> Use a one shot flag on struct pci_device which is cleared after the
>> first probe is ignored so subsequent attempts go through.
>
> Does a one-shot flag suffice? E.g., consider assigning a VF to VM and
> than shutting down the VM. Assuming this feature is disabled,
> the VF didn't appear on the hypervisor prior to the assignment but
> will appear after its shutdown.
>
+1 to this question.
All I see is a one-shot savings in VF configuration time at pci_sriov_enable() time.
Please explain why this is so important for mlx5 (sriov) operation?

Can the vf driver probe be called & exit early the first time, and perform full
(host) configuration thereafter?

- Don
