Return-Path: <SRS0=zG0X=3H=gmail.com=ddaney.cavm@kernel.org>
Return-Path: <SRS0=zG0X=3H=gmail.com=ddaney.cavm@kernel.org>
Subject: Re: [PATCH 5/5] PCI: remove pci_enable_msix
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20170327082936.6830-1-hch@lst.de>
 <20170327082936.6830-6-hch@lst.de>
 <83f97789-0817-7549-bfa9-1f8dcb0c26d9@gmail.com>
 <20170327171148.GB28815@lst.de>
 <1eaa46ad-9890-c738-3a85-6468161284ba@gmail.com>
 <20170328064148.GA20271@lst.de>
 <217ae0b0-1d0c-bde9-e3f1-c52cbd3bd112@gmail.com>
 <20170330225610.GA2496@bhelgaas-glaptop.roam.corp.google.com>
Cc: Christoph Hellwig <hch@lst.de>, bhelgaas@google.com, davem@davemloft.net,
 netanel@annapurnalabs.com, jcliburn@gmail.com, chris.snook@gmail.com,
 sgoutham@cavium.com, rric@kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org
From: David Daney <ddaney.cavm@gmail.com>
Message-ID: <b44e6740-2896-ef1a-c0ba-466a1680f7e6@gmail.com>
Date: Thu, 30 Mar 2017 16:00:32 -0700
MIME-Version: 1.0
In-Reply-To: <20170330225610.GA2496@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 03/30/2017 03:56 PM, Bjorn Helgaas wrote:
> On Tue, Mar 28, 2017 at 09:24:15AM -0700, David Daney wrote:
>> On 03/27/2017 11:41 PM, Christoph Hellwig wrote:
>>> On Mon, Mar 27, 2017 at 10:30:46AM -0700, David Daney wrote:
>>>>> Use pci_enable_msix_{exact,range} for now, as I told you before.
>>>>>
>>>>
>>>> That still results in twice as many MSI-X being provisioned than are needed.
>>>
>>> How so?  Except for the return value, a pci_enable_msix_exact call with the
>>> same arguments as your previous pci_enable_msix will work exactly the
>>> same.
>>>
>>
>> Sorry, I think it was my misunderstanding.  I didn't realize that we
>> had essentially renamed the function, but left the functionality
>> mostly unchanged.
>
> Does this mean you're OK with this patch?

Yes.  I have re-written my GPIO driver to use the newer functions, so I 
withdraw my objections to the patch.

Thanks,
David Daney


> I know it may require some
> work on out-of-tree drivers and so on, but if that work is possible
> and you don't actually lose functionality, I'm OK with this patch.
>
> Bjorn
>
