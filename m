Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150817234931.GP26431@google.com>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
	<1438039809-24957-5-git-send-email-yinghai@kernel.org>
	<20150817234931.GP26431@google.com>
Date: Tue, 18 Aug 2015 13:29:57 -0700
Message-ID: <CAE9FiQWAAYETicaq1WZ9KFf12ieGs56_DA5mhp9DinnRHEkPOA@mail.gmail.com>
Subject: Re: [PATCH v3 04/51] PCI: Optimize bus align/size calculation during sizing
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 17, 2015 at 4:49 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Jul 27, 2015 at 04:29:22PM -0700, Yinghai Lu wrote:
>> Current code try to get align as small as possible and use that to
>> align final size. But it does not handle resource that size is bigger
>> than align in optimal way, kernel only use max align for them.
>>
>> For example:
>>  when we have resources with align/size: 1M/2M, 512M/512M,
>>    bus resource min_align/size0 will be 512M/1024M,
>>    but optimal value should be 256M/768M.
>
> I want to understand what makes 256M/768M "optimal."
>
> This is basically a bin packing problem, and I'd like to have an
> explicit statement of the constraints and the goal.  Right now the
> goal is fuzzy and the code seems ad hoc.

that code is trying to use different offset to make sure it is safe
to reduce the alignment.

>
> Here are the possibilities I can see.  The placement notes are the
> offsets into the allocated space:
>
>   align  size    512M placement   2M placement    unused
>   1024M  514M    [0-512]          [512-514]       [514-1024]
>    512M  514M    [0-512]          [512-514]       none
>    256M  768M    [256-768]        [254-256]       [0-254]
>    128M  896M    [384-896]        [382-384]       [0-382]
>
> Obviously, we would never choose 1024M/514M or any larger alignment:
> it requires no more space than 512M/514M, but it fails in some cases
> where 512M/514M would succeed.
>
> Also obviously, we would never choose 128M/896M or a smaller
> alignment: if we could get that, we could also get 256M/768M and it
> would consume less space.
>
> But it's not quite so obvious how to choose between 512M/514M and
> 256M/768M.  The former (if we can get it) consumes much less space.
> The latter requires less alignment but wastes a lot of space.

one is smaller alignment and size is aligned to min_align.
other one is smaller size, but size is not aligned to max_align.

let's call them min_align solution and alt_size solution.

in following patches will have support for alt_size.

the problem for alt_size is that we can not keep on using them on
parent's sizing. for example two bridges have 512M/514M, 512M/514M,
for their parent bridge simple calculation will have 512M/1028M.
with trying out, we will need 512M/1536M instead.

and with min_align solution, two children will be 256M/768M, 256M/768M
and their parent bridge will be 256M/1536M.

so min_align will have smaller alignment and same size.

Final solution in the patchset: we are trying min_align at first, and
if it fails
then try alt_size. And during alt_size sizing will check if min_align even
could have smaller alignment and smaller size.

>
>> For following cases that we have resource size that is bigger
>> than resource alignment:
>> 1. SRIOV bar.
>> 2. PCI bridges with several bridges or devices as children.
>
> This doesn't have anything to do with how many children a bridge has,
> does it?  As long as there are two or more BARs (1MB or larger) below
> a bridge, we'll have the situation where the bridge window has to
> contain both BARs but only needs to be aligned for (at most) the
> larger one.

Yes. even one child could request several pref MMIO.

>
>> We can keep on trying to allocate children devices resources under range
>> [half_align, half_align + aligned_size).
>> If sucesses, we can use that half_align as new min_align.
>>
>> After this patch, we get:
>>  align/size: 1M/2M, 2M/4M, 4M/8M, 8M/16M
>>  new min_align/min_size: 4M/32M, and old is 8M/32M
>>
>>  align/size: 1M/2M, 2M/4M, 4M/8M
>>  new min_align/min_size: 2M/14M, and old is 4M/16M
>>
>>  align/size: 1M/2M, 512M/512M
>>  new min_align/min_size: 256M/768M, and old is 512M/1024M
>>
>> The real result from one system with one pcie card that has
>> four functions that support sriov:
>>  align/size:
>>    00800000/00800000
>>    00800000/00800000
>>    00800000/00800000
>>    00800000/00800000
>>    00010000/00200000
>>    00010000/00200000
>>    00010000/00200000
>>    00010000/00200000
>>    00008000/00008000
>>    00008000/00008000
>>    00008000/00008000
>>    00008000/00008000
>>    00004000/00080000
>>    00004000/00080000
>>    00004000/00080000
>>    00004000/00080000
>>  old min_align/min_size: 00400000/02c00000
>>      min_align/min_size: 00100000/02b00000
>
> I don't know if this example is essential, but if it is, it needs a
> little more interpretation.  I assume the BARs above where
> "align < size" are for SR-IOV, where size include multiple VFs.
> In any case, please connect the dots from the raw data to the
> conclusion.

ok.

>
>> So align will be 1M instead of 4M.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=81431
>> Reported-by: TJ <linux@iam.tj>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> ---
>>  drivers/pci/setup-bus.c | 195 ++++++++++++++++++++++++++++++++++++++----------
>>  1 file changed, 157 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index 27cb0f0..ecdf011 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -30,6 +30,34 @@
>>
>>  unsigned int pci_flags;
>>
>> +static inline bool is_before(resource_size_t align1, resource_size_t size1,
>> +                          resource_size_t align2, resource_size_t size2)
>
> Can this take two struct resource pointers instead of four numbers?  I
> haven't looked at all the callers, so maybe there's a caller that
> doesn't have a struct resource.
>
That is called in double loop, so i want to save some calculation.
also it would take (dev1, res1, dev2, res2).
