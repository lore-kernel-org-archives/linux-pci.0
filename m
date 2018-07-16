Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:37002 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbeGPRqU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Jul 2018 13:46:20 -0400
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
References: <20180713233158.19528-1-logang@deltatee.com>
 <20180713233158.19528-5-logang@deltatee.com>
 <20180716111543.6ddf584c@t450s.home>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0a195c47-0a3d-e2f0-588b-214f6720528a@deltatee.com>
Date: Mon, 16 Jul 2018 11:17:07 -0600
MIME-Version: 1.0
In-Reply-To: <20180716111543.6ddf584c@t450s.home>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v6 4/4] PCI: Introduce the disable_acs_redir parameter
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 16/07/18 11:15 AM, Alex Williamson wrote:
>> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
>> +	if (!pos) {
>> +		pci_warn(dev, "cannot disable ACS redirect for this hardware as it does not have ACS capabilities\n");
>> +		return;
>> +	}
>> +
>> +	if (!pci_dev_specific_disable_acs_redir(dev))
>> +		return;
> 
> Shouldn't this come before the above ACS capability test?  The PCH
> quirk without a disable_acs_redir callback will fall out with the
> pci_warn() above either way, but this ordering precludes that a quirk
> could be written for that device since it doesn't have an ACS
> capability.  Otherwise the series looks ok to me.  Thanks,

Yup, nice catch. I'll respin a v7 shortly.

Thanks,

Logan
