Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUB6wshovj=TBmCEL140nZB5K40BfKPYGNmmpZx536F+Q@mail.gmail.com>
References: <1346622653-30741-1-git-send-email-yinghai@kernel.org>
	<1346622653-30741-7-git-send-email-yinghai@kernel.org>
	<CAErSpo4wmnnFKZeY4XyZdmoOZeQz8sj-5VoAhGhCSqWTBi0GRw@mail.gmail.com>
	<CAE9FiQUB6wshovj=TBmCEL140nZB5K40BfKPYGNmmpZx536F+Q@mail.gmail.com>
Date: Mon, 17 Sep 2012 22:36:41 -0700
Message-ID: <CAE9FiQWFcVNKMnV1qaHchwCXfZuMpyxf_f7GQy3FZid9YuLD3w@mail.gmail.com>
Subject: Re: [PATCH part2 6/6] PCI: Claim hw/fw allocated resources in hot add path.
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, x86 <x86@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 17, 2012 at 9:44 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Mon, Sep 17, 2012 at 5:12 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Sun, Sep 2, 2012 at 3:50 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>
>>> -static void __init pcibios_allocate_bridge_resources(struct pci_dev *dev)
>>> +static void pcibios_allocate_bridge_resources(struct pci_dev *dev)
>>
>> This patch has a little too much going on at the same time.  Can you
>> split the __init removal into its own patch so we can focus on what's
>> left by itself?
>
> ok.
>
>>
>>>  {
>>>         int idx;
>>>         struct resource *r;
>>>
>>>         for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
>>>                 r = &dev->resource[idx];
>>> +               if (r->parent)  /* Already allocated */
>>> +                       continue;
>>
>> This is also a potentially interesting change that maybe should be in
>> its own patch.
>
> oh, we don't need that extra checking anymore. because support
> removing non-root bus is dropped.

I updated for-pci-root-bus-hotplug-part2.

http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=shortlog;h=refs/heads/for-pci-root-bus-hotplug-part2

Thanks

Yinghai
