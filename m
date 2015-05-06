Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:34852 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbbEFPbB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2015 11:31:01 -0400
Received: by qgej70 with SMTP id j70so6363790qge.2
        for <linux-pci@vger.kernel.org>; Wed, 06 May 2015 08:31:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150506060933.GA19030@richard>
References: <1428655984-26903-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150505212905.GB24643@google.com> <20150506060933.GA19030@richard>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 6 May 2015 10:30:39 -0500
Message-ID: <CAErSpo7xis8=QWOeOubZmRxY0v3jSqC0WxGCo-KaEJisCJGB6Q@mail.gmail.com>
Subject: Re: [PATCH] pci/iov: return a reference to PF on destroying VF
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 6, 2015 at 1:09 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> On Tue, May 05, 2015 at 04:29:05PM -0500, Bjorn Helgaas wrote:

>>Prior to your patch, the VF reference was released in virtfn_remove(),
>>which is only called via pci_disable_sriov().  This typically happens in
>>a driver .remove() method.  The reference is *not* released if we call
>>pci_stop_and_remove_bus_device(VF) directly, as we would via the
>>remove_store() (sysfs "remove" file) or hot unplug paths, e.g.,
>>pciehp_unconfigure_device().
>
> You want to say the reference for VF or PF?

Yes, I meant the PF reference.

The hot unplug paths call pci_stop_and_remove_bus_device() for the VFs
first, then the PF.  Calling it for the VF releases the VF reference
but not the PF one.  Calling it for the PF will call virtfn_remove()
via the driver's .remove() method, but it probably does nothing
because when it calls pci_get_domain_bus_and_slot() to get the virtfn,
it gets a NULL because the VF has already been removed.

>>What about the other things done in virtfn_remove(), e.g., the sysfs link
>>removal?  Your patch fixes a reference count leak, but don't we still have
>>a sysfs link leak?
>
> Agree, I am afraid the sysfs would have a leak too.
>
> While I am not that familiar with the sysfs part, I don't dare to move that to
> pci_destroy_dev(). Need more investigation.

OK.  I don't want to fix half of the leak problem.  I want to fix the
whole thing at once.

Bjorn
