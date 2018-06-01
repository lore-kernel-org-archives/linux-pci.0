Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:35024 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751777AbeFAPqq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Jun 2018 11:46:46 -0400
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>,
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
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180531235010.5279-1-logang@deltatee.com>
 <20180531235010.5279-3-logang@deltatee.com>
 <CAHp75Vc4yxeM+jz2biMBoWB-h_dG1_Qx91VCP+f1mhvvgPVPxQ@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <be1bdb61-325a-1848-9724-55dc6e3fb983@deltatee.com>
Date: Fri, 1 Jun 2018 09:46:31 -0600
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc4yxeM+jz2biMBoWB-h_dG1_Qx91VCP+f1mhvvgPVPxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v2 2/3] PCI: Allow specifying devices using a base bus and
 path of devfns
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 01/06/18 04:41 AM, Andy Shevchenko wrote:
>> -                               specified in one of two formats:
>> +                               specified in one of three formats:
> 
> ...in one of the following formats:
> 
> in the first place and don't fix it each time you add/remove one?

Sure, I'll make the change in v3.

Thanks,

Logan
