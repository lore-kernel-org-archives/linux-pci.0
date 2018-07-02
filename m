Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:49329 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932145AbeGBA71 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 1 Jul 2018 20:59:27 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sam Bobroff <sbobroff@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, bryantly@linux.vnet.ibm.com
Subject: Re: [PATCH v2 1/1] powerpc/pseries: fix EEH recovery of some IOV devices
In-Reply-To: <7598ffeb48c16c88a34937ad93b18f806222b8df.1527208281.git.sbobroff@linux.ibm.com>
References: <7598ffeb48c16c88a34937ad93b18f806222b8df.1527208281.git.sbobroff@linux.ibm.com>
Date: Mon, 02 Jul 2018 10:59:24 +1000
Message-ID: <87in5ymp03.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sam Bobroff <sbobroff@linux.ibm.com> writes:

> EEH recovery currently fails on pSeries for some IOV capable PCI
> devices, if CONFIG_PCI_IOV is on and the hypervisor doesn't provide
> certain device tree properties for the device. (Found on an IOV
> capable device using the ipr driver.)
>
> Recovery fails in pci_enable_resources() at the check on r->parent,
> because r->flags is set and r->parent is not.  This state is due to
> sriov_init() setting the start, end and flags members of the IOV BARs
> but the parent not being set later in
> pseries_pci_fixup_iov_resources(), because the
> "ibm,open-sriov-vf-bar-info" property is missing.
>
> Correct this by zeroing the resource flags for IOV BARs when they
> can't be configured.
>
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> ---
> Hi,
>
> This is a fix to allow EEH recovery to succeed in a specific situation,
> which I've tried to explain in the commit message.
>
> As with the RFC version, the IOV BARs are disabled by setting the resource
> flags to 0 but the other fields are now left as-is because that is what is done
> elsewhere (see sriov_init() and __pci_read_base()).
>
> I've also examined the concern raised by Bjorn Helgaas, that VFs could be
> enabled later after the BARs are disabled, and it already seems safe: enabling
> VFs (on pseries) depends on another device tree property,
> "ibm,number-of-configurable-vfs" as well as support for the RTAS function
> "ibm_map_pes". Since these are all part of the hypervisor's support for IOV it
> seems unlikely that we would ever see some of them but not all. (None are
> currently provided by QEMU/KVM.) (Additionally, the ipr driver on which the EEH
> recovery failure was discovered doesn't even seem to have SR-IOV support so it
> certainly can't enable VFs.)

Can you fold/reword the above into the change log, it seems like useful
detail.

cheers
