Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <584359f9-5851-08c8-4b80-ae73abc4fe59@codeaurora.org>
References: <20170419003130.5302-1-yinghai@kernel.org> <584359f9-5851-08c8-4b80-ae73abc4fe59@codeaurora.org>
From: Yinghai Lu <yinghai@kernel.org>
Date: Thu, 20 Apr 2017 16:37:16 -0700
Message-ID: <CAE9FiQVQ4Mvc_SufENJcuO1309h+jqDdme9XNB3R9OvZJKzHvQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: disable SERR for kdump kernel
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 20, 2017 at 10:14 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 4/18/2017 8:31 PM, Yinghai Lu wrote:
>> * pci_setup_device - fill in class and map information of a device
>>   * @dev: the device structure to fill
>> @@ -1572,6 +1592,9 @@ int pci_setup_device(struct pci_dev *dev
>>       /* device class may be changed after fixup */
>>       class = dev->class >> 8;
>>
>> +     if (is_kdump_kernel())
>> +             pci_disable_serr(dev);
>> +
>
> This sounds like something that needs to be done while shutting down
> the first kernel as part of the kdump procedure rather than boot of
> the kdump kernel in pci setup.

For kdump path, first kernel shutdown path is not called.

We have to do sth in second kernel instead.

Thanks

Yinghai
