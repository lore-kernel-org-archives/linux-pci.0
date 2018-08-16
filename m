Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33574 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388154AbeHPLEo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2018 07:04:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 16 Aug 2018 13:37:58 +0530
From: poza@codeaurora.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
In-Reply-To: <5bd99bcacb772b588771fce62c61a59fdeb167f3.camel@kernel.crashing.org>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
 <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
 <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
 <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
 <903394c04d6ad468ed06dc0a779200e7555345a7.camel@kernel.crashing.org>
 <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
 <e931bc7a7e468e8bb2ee3766b3fcf96f1800f552.camel@kernel.crashing.org>
 <5bd99bcacb772b588771fce62c61a59fdeb167f3.camel@kernel.crashing.org>
Message-ID: <290750445f084c479963f54dd36af63a@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-08-16 12:29, Benjamin Herrenschmidt wrote:
> On Thu, 2018-08-16 at 16:51 +1000, Benjamin Herrenschmidt wrote:
>> > refering Sepc: 6.2.2.2.1 Fatal Errors, where link is unreliable and it
>> > might need AER style reset of link or DPC style HW recovery
>> > In both cases, the shutdown callbacks are expected to be called,
>> 
>> No, this is wrong and not the intent of the error handling.
>> 
>> You seem to be applying PCIe specific concepts brain-farted at Intel
>> that are way way away from what we care about in practice and in 
>> Linux.
>> 
>> > e.g.  some driver handle errors ERR_NONFATAL or FATAL in similar ways
>> > e.g.
>> > ioat_pcie_error_detected();  calls  ioat_shutdown(); in case of
>> > ERR_NONFATAL
>> > otherwise ioat_shutdown() in case of ERR_FATAL.
>> 
>> Since when the error handling callbacks even have the concept of FATAL
>> vs. non-fatal ? This doesn't appear anyhwhere in the prototype of the
>> struct pci_error_handlers and shouldn't.
> 
> In fact looking at pcie_do_nonfatal_recovery() it's indeed completely
> broken. It tells the driver that the slot was reset without actually
> resetting anything... Ugh.
> 
> Ben.

pcie_do_nonfatal_recovery() exhibit the same behavior with or without 
the patch-series.
in short, there was no functional change brought in to 
pcie_do_nonfatal_recovery()

Regards,
Oza.
