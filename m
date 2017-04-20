Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <584359f9-5851-08c8-4b80-ae73abc4fe59@codeaurora.org>
References: <20170419003130.5302-1-yinghai@kernel.org> <584359f9-5851-08c8-4b80-ae73abc4fe59@codeaurora.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 20 Apr 2017 13:38:32 -0500
Message-ID: <CAErSpo7paKmVjvGhedCdbSNbARqDmE6jfLikp4SO75fob3pMzw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: disable SERR for kdump kernel
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Yinghai Lu <yinghai@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 20, 2017 at 12:14 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
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

In general, I would rather make the new kernel more tolerant than make
assumptions about how the old kernel shut down.  I don't know if
there's an explicit statement of kexec philosophy on this (it'd be
nice if there were), but it seems like a more robust strategy, e.g.,
less prone to revlock issues between the old/new kernels.

Bjorn
