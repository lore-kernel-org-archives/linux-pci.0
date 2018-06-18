Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:44692 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933073AbeFRVuJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Jun 2018 17:50:09 -0400
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
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180618193636.16210-1-logang@deltatee.com>
 <20180618193636.16210-2-logang@deltatee.com>
 <20180618154430.1af3d42f@t450s.home>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c2053508-0880-5b7b-fd2f-260d260f33f9@deltatee.com>
Date: Mon, 18 Jun 2018 15:49:49 -0600
MIME-Version: 1.0
In-Reply-To: <20180618154430.1af3d42f@t450s.home>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v3 1/3] PCI: Make specifying PCI devices in kernel
 parameters reusable
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6/18/2018 3:44 PM, Alex Williamson wrote:
>> + *
>> + * The second format matches devices using IDs in the configuration
>> + * space which may match multiple devices in the system. A value of 0
>> + * for any field will match all devices.
> 
> I realize this is not a change in behavior, but since we're spelling it
> out in a proper comment rather than burying it in the implementation,
> using 0 as a wildcard is rather questionable behavior.  It always
> surprises me when I read this because pci_match_one_device() uses
> PCI_ANY_ID (~0) as a wildcard and as a result of struct pci_device_id
> using __u32 for these fields, we actually need to specify ffffffff on
> the commandline to get a wildcard match for dynamic ids.  The latter is
> tedious to use, but I think it's more correct, and the use of a __u32 is
> probably attributed to the fact that 0xffff is only reserved for vendor
> ID, the spec doesn't seem to reserve any entries from the vendor's
> device ID range.
> 
> There's probably really no path to resolve these, but acknowledging the
> difference in this comment block might be helpful in the future.

Ok, I'll add a note in the comment.
>> +		ret = pci_dev_str_match(dev, p, &p);
>> +		if (ret == 1) {
>> +			*resize = true;
>> +			if (align_order == -1)
>> +				align = PAGE_SIZE;
>> +			else
>> +				align = 1 << align_order;
>> +			break;
>> +		} else if (ret < 0) {
>> +			pr_info("PCI: Can't parse resource_alignment parameter: pci:%s\n",
> 
> 
> The "pci:" prefix on %s doesn't make sense now, it was used above when
> the pointer was already advanced past this token, now I believe it would
> lead to "pci:pci:xxxx:yyyy" or "pci:xx:yy.z".  Thanks,

Yup, nice catch. I'll fix it for v4.

Logan
