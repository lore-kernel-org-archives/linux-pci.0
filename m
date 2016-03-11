Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160310035415.GA17238@localhost>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
	<1456366370-28995-2-git-send-email-yinghai@kernel.org>
	<20160310035415.GA17238@localhost>
Date: Fri, 11 Mar 2016 13:21:46 -0800
Message-ID: <CAE9FiQUfHCC+3c+hOeOcpRWwedL02KKw0O2qNNLZMymUnwW5-g@mail.gmail.com>
Subject: Re: [PATCH v10 01/59] PCI: Add pci_find_root_bus_resource()
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Thanks for taking time to look at those patches!

On Wed, Mar 9, 2016 at 7:54 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, Feb 24, 2016 at 06:11:52PM -0800, Yinghai Lu wrote:
>> Add pci_find_root_bus_resource() to return root bus resource
>> for input resource.
>>
>> For sparc mem64 support, We need that host bridge window res:
>>   1. we need direct parent for request_resource_conflict() calling in
>>       pci_register_legacy_regions().
>>   2. check if return is NULL to decide if region is valid or not.
>
> Whenever somebody proposes a new interface that's only required for
> one architecture, the obvious question is "what is unique about that
> architecture that makes the new interface necessary?"

Good point.

I was thinking to keep the current behavior in sparc64 arch,
as I don't want to break old setups.

Later we can try to make it more like arch.

>
> Neither this patch nor the follow-on patch that adds the use of
> pci_find_root_bus_resource() answers that question.
>

would be better to keep those two in same patch?

Thanks

Yinghai
