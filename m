Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:53766 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732701AbeGJT12 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Jul 2018 15:27:28 -0400
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
References: <20180627174650.27433-1-logang@deltatee.com>
 <20180627174650.27433-4-logang@deltatee.com>
 <20180706165655.62306b6f@t450s.home>
 <01dfc5ba-43cb-fbea-93e6-4963c411c750@deltatee.com>
 <20180710131915.0d669e7a@t450s.home>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b426dd67-44eb-7309-6dd1-ef527cf5d50f@deltatee.com>
Date: Tue, 10 Jul 2018 13:26:18 -0600
MIME-Version: 1.0
In-Reply-To: <20180710131915.0d669e7a@t450s.home>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v5 3/3] PCI: Introduce the disable_acs_redir parameter
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 10/07/18 01:19 PM, Alex Williamson wrote:
> Note that these devices don't have an ACS capability, so they should
> drop out just as any other device without an ACS capability would.
> Should pci_disable_acs_redir() perhaps issue the pci_warn() for all
> such devices, removing this device specific disable function?

Ok, that sounds like a good idea.


> Kind of cumbersome, and as above, maybe the reverse path is optional.
> I wonder if there's a better callback we should use or if we should not
> rely on quirks providing both.

Well, keep in mind enable_acs() and disable_acs_redir() are not inverse
operations. The disable function is only disabling specific ACS bits to
enable redirect -- which are not the same bits being set by the enable
function.

>>  	{ 0 }
>>  };
>>
>>  int pci_dev_specific_enable_acs(struct pci_dev *dev)
>>  {
>> -	const struct pci_dev_enable_acs *i;
>> +	const struct pci_dev_acs_ops *i;
>>  	int ret;
>>
>> -	for (i = pci_dev_enable_acs; i->enable_acs; i++) {
>> +	for (i = pci_dev_acs_ops; i->enable_acs; i++) {
> 
> Perhaps this would walk via ARRAY_SIZE if we decide one or the other
> callback is optional.

> Test i->disable_acs_redir?

Yes, both points make sense if we start saying the operations are optional.


> static inline version for !CONFIG_PCI_QUIRKS?  Thanks,

Oops, yes, I forgot that.

Logan
