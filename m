Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 28 Sep 2017 16:52:55 -0700
From: Govindarajulu Varadarajan <gvaradar@cisco.com>
To: Sinan Kaya <okaya@codeaurora.org>
CC: <benve@cisco.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jlbec@evilplan.org>, <hch@lst.de>, <mingo@redhat.com>,
        <peterz@infradead.org>
Subject: Re: [PATCH 1/4] pci: introduce __pci_walk_bus for caller with
 pci_bus_sem held
In-Reply-To: <5bbeefd2-a409-168c-b596-bcaa29a54eb7@codeaurora.org>
Message-ID: <alpine.LNX.2.20.1709281652280.24635@cae-iprp-alln-lb.cisco.com>
References: <20170927214220.41216-1-gvaradar@cisco.com> <20170927214220.41216-2-gvaradar@cisco.com> <5bbeefd2-a409-168c-b596-bcaa29a54eb7@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 28 Sep 2017, Sinan Kaya wrote:

> On 9/27/2017 5:42 PM, Govindarajulu Varadarajan wrote:
>> +void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
>> +		    void *userdata);
>
> pci_walk_bus_locked would be a better name as you are assuming that caller is
> holding the lock.
>

Will change and resubmit for v2.
