Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:59725 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063Ab3DVXL6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 19:11:58 -0400
Received: by mail-oa0-f51.google.com with SMTP id k14so12905oag.24
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:11:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5167564e.c628320a.6610.1710SMTPIN_ADDED_BROKEN@mx.google.com>
References: <1365130473-7413-1-git-send-email-shangw@linux.vnet.ibm.com> <5167564e.c628320a.6610.1710SMTPIN_ADDED_BROKEN@mx.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 22 Apr 2013 17:11:37 -0600
Message-ID: <CAErSpo5hseSsR65cUd5ivVf=pC_x25HSHQHMH+MXbA3fOZC-wQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Retrieve MSI/MSIX cap struct for once on setup
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 11, 2013 at 6:33 PM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> On Fri, Apr 05, 2013 at 11:01:18AM +0800, Gavin Shan wrote:
>>On Fri, Apr 05, 2013 at 10:54:29AM +0800, Gavin Shan wrote:
>>
>>The subject should be "[0/4]" instead of "[0/5]". Forgot to change
>>that accordingly. Sorry for the confusion ;-)
>>
>
> Bjorn, did you get change taking a look on this? Please let me know
> if you have more comments :-)

I did look at it; it looks good, and I made some more cleanups, which
I just posted as a "v4" series.  Take a look and see if it makes sense
to you.

Bjorn

>>>While we setup MSI or MSI-X for specific PCI device, the address of
>>>MSI or MSI-X capability structure is figured out from the config
>>>space for multiple times. That's unnecessary and the patchset addresses
>>>that. With the patchset applied, the latency for MSI or MSI-X setup
>>>would be decreased hopefully.
>>>
>>>v2 -> v3:
>>>      * Remove checking on MSI/MSI-X capability offset in msi_set_enable()
>>>        and msix_set_enable(). Let the caller does the check
>>>      * Using "u8" for MSI/MSI-X/PM capability
>>>      * Let caller of pci_msi_check_device() checks MSI/MSI-X capability
>>>      * Replace msi_control_reg() with "pos + PCI_MSI_FLAGS"
>>>      * Merge [4/5] to [3/5]
>>>v1 -> v2:
>>>      * Cache the MSI/MSI-X capability offset to pci_dev directly according
>>>        to Bjorn's suggestion.
>>>      * Rebase to 3.9.RC5
>>>
>>>---
>>>
>>>drivers/pci/msi.c   |  110 +++++++++++++++++++++++----------------------------
>>>drivers/pci/msi.h   |    1 -
>>>include/linux/pci.h |    4 +-
>>>3 files changed, 52 insertions(+), 63 deletions(-)
>>>
>>>Thanks,
>>>Gavin
>>>
>
