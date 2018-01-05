Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0062.outbound.protection.outlook.com ([104.47.41.62]:27328
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751100AbeAEAYD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Jan 2018 19:24:03 -0500
Subject: Re: [PATCH 1/9] PCI: Add pci_enable_atomic_ops_to_root
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, oded.gabbay@gmail.com,
        Jay Cornwall <Jay.Cornwall@amd.com>, linux-pci@vger.kernel.org,
        Ram Amrani <Ram.Amrani@cavium.com>,
        Doug Ledford <dledford@redhat.com>
References: <1515104268-25087-1-git-send-email-Felix.Kuehling@amd.com>
 <1515104268-25087-2-git-send-email-Felix.Kuehling@amd.com>
 <20180105001725.GL189897@bhelgaas-glaptop.roam.corp.google.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <2a1cb1fb-9b7c-5357-f1a3-4dbaf19f442c@amd.com>
Date: Thu, 4 Jan 2018 19:23:56 -0500
MIME-Version: 1.0
In-Reply-To: <20180105001725.GL189897@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-01-04 07:17 PM, Bjorn Helgaas wrote:
> @@ -3066,6 +3066,86 @@ int pci_rebar_set_size(struct pci_dev *pdev,
> int bar, int size)
>>  }
>>  
>>  /**
>> + * pci_enable_atomic_ops_to_root - enable AtomicOp requests to root port
>> + * @dev: the PCI device
>> + * @comp_caps: Caps required for atomic request completion
>> + *
>> + * Return 0 if all upstream bridges support AtomicOp routing, egress
>> + * blocking is disabled on all upstream ports, and the root port
>> + * supports the requested completion capabilities (32-bit, 64-bit
>> + * and/or 128-bit AtomicOp completion), or negative otherwise.
>> + */
>> +int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 comp_caps)
> I still want to see this used to replace qedr_pci_set_atomic() if
> that's possible.  I'm not convinced yet that they need to be
> different.

I agree. This should be possible now. I've convinced myself that the
functions do the same thing. But I have no way of testing it. I'd also
do this in a separate patch. Maybe Ram or Doug could test it.

Regards,
  Felix

>
> Bjorn
