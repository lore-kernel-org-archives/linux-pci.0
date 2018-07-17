Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:45146 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729980AbeGQSXw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Jul 2018 14:23:52 -0400
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20180717170204.30470-1-logang@deltatee.com>
 <20180717170204.30470-5-logang@deltatee.com>
 <20180717114848.2914d547@t450s.home>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a3197c27-1b41-7784-374b-948e43471789@deltatee.com>
Date: Tue, 17 Jul 2018 11:49:22 -0600
MIME-Version: 1.0
In-Reply-To: <20180717114848.2914d547@t450s.home>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v7 4/4] PCI: Introduce the disable_acs_redir parameter
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 17/07/18 11:48 AM, Alex Williamson wrote:
> On Tue, 17 Jul 2018 11:02:04 -0600
> Logan Gunthorpe <logang@deltatee.com> wrote:
> 
>> In order to support P2P traffic on a segment of the PCI hierarchy,
>> we must be able to disable the ACS redirect bits for select
>> PCI bridges. The bridges must be selected before the devices are
>> discovered by the kernel and the IOMMU groups created. Therefore,
>> a kernel command line parameter is created to specify devices
>> which must have their ACS bits disabled.
>>
>> The new parameter takes a list of devices separated by a semicolon.
>> Each device specified will have it's ACS redirect bits disabled.
>> This is similar to the existing 'resource_alignment' parameter.
>>
>> The ACS Request P2P Request Redirect, P2P Completion Redirect and P2P
>> Egress Control bits are disabled which is sufficient to always allow
>> passing P2P traffic uninterrupted. The bits are set after the kernel
>> (optionally) enables the ACS bits itself. It is also done regardless of
>> whether the kernel sets the bits or not seeing some BIOS firmware is known
>> to set the bits on boot.
>>
>> If the user tries to disable the ACS redirct for a device without the
>> ACS capability, a warning is printed to dmesg.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Reviewed-by: Stephen Bates <sbates@raithlin.com>
>> Acked-by: Christian König <christian.koenig@amd.com>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt |  9 +++
>>  drivers/pci/pci.c                               | 76 ++++++++++++++++++++++++-
>>  2 files changed, 83 insertions(+), 2 deletions(-)
> 
> Thanks for the re-spins!
> 
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


Thanks for all the thorough review!

Logan
