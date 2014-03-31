Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5339CC40.9050506@kernel.dk>
Date: Mon, 31 Mar 2014 14:12:48 -0600
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
To: Alexander Gordeev <agordeev@redhat.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Mike Miller <mike.miller@hp.com>, iss_storagedev@hp.com,
	linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
	Matthew Wilcox <willy@linux.intel.com>
Subject: Re: [PATCH v2 0/2] block: Use pci_enable_msix_exact() instead of
 pci_enable_msix()
References: <cover.1393404496.git.agordeev@redhat.com> <20140313041231.GC26657@google.com> <5321CE94.5070506@kernel.dk> <20140313173656.GA4939@dhcp-26-207.brq.redhat.com> <20140331195139.GA19867@dhcp-26-207.brq.redhat.com>
In-Reply-To: <20140331195139.GA19867@dhcp-26-207.brq.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/31/2014 01:52 PM, Alexander Gordeev wrote:
> On Thu, Mar 13, 2014 at 06:36:56PM +0100, Alexander Gordeev wrote:
>> Oh-oh, cciss patch #2 requires commit 3ce4e86 ("PCI/MSI: Add
>> pci_enable_msi_exact() and pci_enable_msix_exact()") which was
>> pulled to 3.14-rc4 only. Sorry for failing to clarify that :(
>>
>> And I also notice 3111cc3 ("skd: Use pci_enable_msix_exact() instead
>> of pci_enable_msix_range()") in your tree also should not compile :(
>
> Hi Jens,
>
> 3.14 contains prerequisite commits for the patches above.
> Would you pull them or do you want me to resend the two?

I'm assuming you are referring to the cciss patches? I can add those 
back, for a post-merge pull request.

-- 
Jens Axboe

