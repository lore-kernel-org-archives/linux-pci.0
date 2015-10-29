Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36358 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbbJ2XTz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2015 19:19:55 -0400
Subject: Re: [PATCH 4/5] iov: Variable and loop cleanup for sriov_disable and
 sriov_enable
To: Bjorn Helgaas <helgaas@kernel.org>,
	Alexander Duyck <aduyck@mirantis.com>
References: <20151027204607.14626.59671.stgit@localhost.localdomain>
 <20151027205233.14626.98836.stgit@localhost.localdomain>
 <20151029214349.GC921@localhost>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Alexander Duyck <alexander.duyck@gmail.com>
Message-ID: <5632A999.6000305@gmail.com>
Date: Thu, 29 Oct 2015 16:19:53 -0700
MIME-Version: 1.0
In-Reply-To: <20151029214349.GC921@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/29/2015 02:43 PM, Bjorn Helgaas wrote:
> Hi Alex,
>
> On Tue, Oct 27, 2015 at 01:52:33PM -0700, Alexander Duyck wrote:
>> This patch is just a minor cleanup to go through and group all of the
>> variables into one declaration instead of a long string of single
>> declarations for each int.  It also changes the direction for a couple
>> loops as we are able to loop with less code this way as testing against 0
>> can be done as a part of the decrement operation.
>>
>> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>> ---
>>   drivers/pci/iov.c |   13 ++++---------
>>   1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index cecc242c1af0..c0fc88fa7c4d 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -241,15 +241,11 @@ int __weak pcibios_sriov_disable(struct pci_dev *pdev)
>>   
>>   static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>>   {
>> -	int rc;
>> -	int i;
>> -	int nres;
>>   	u16 offset, stride, initial;
>>   	struct resource *res;
>>   	struct pci_dev *pdev;
>>   	struct pci_sriov *iov = dev->sriov;
>> -	int bars = 0;
>> -	int bus;
>> +	int rc, i, nres, bars, bus;
> I don't have a strong opinion on combining the declarations to one line,
> and I would apply it if you wanted to do the same for the whole file
> at once, in a patch by itself.

Maybe I will work on that tonight.  It doesn't look like it would be 
much work.

>
>>   	if (!nr_virtfn)
>>   		return 0;
>> @@ -271,8 +267,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>>   	if (!offset || (nr_virtfn > 1 && !stride))
>>   		return -EIO;
>>   
>> -	nres = 0;
>> -	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>> +	for (nres = 0, bars = 0, i = PCI_SRIOV_NUM_BARS; i--;) {
> But I don't agree that this is easier to read.  I suppose it could be
> a tiny bit more efficient, but I think the benefit to the reader of
> the usual "for (i = 0; i < limit; i++)" loop is larger.

I agree with you.  Pulling nres and bars into the loop was probably a 
bad idea on my part.

As far as reordering the loops that is just a bad habit I have kind of 
developed from doing driver performance tuning.  Running the loop 
backwards you are able to combine the test and decrement so it saves a 
few instructions since compare against 0 or signed is usually built in 
for free with the decrement instructions.  For something like this it 
really isn't needed.

>>   		bars |= (1 << (i + PCI_IOV_RESOURCES));
>>   		res = &dev->resource[i + PCI_IOV_RESOURCES];
>>   		if (res->parent)
>> @@ -366,13 +361,13 @@ err_pcibios:
>>   
>>   static void sriov_disable(struct pci_dev *dev)
>>   {
>> -	int i;
>>   	struct pci_sriov *iov = dev->sriov;
>> +	int i = iov->num_VFs;
>>   
>>   	if (!iov->num_VFs)
>>   		return;
>>   
>> -	for (i = 0; i < iov->num_VFs; i++)
>> +	while (i--)
>>   		virtfn_remove(dev, i, 0);
> I do like the change to remove devices in the reverse order as we
> added them.  But I'm really partial to the way a "for" loop keeps all
> the loop control in one spot.  So I would apply a patch that made it
> look like this:
>
>    for (i = iov->num_VFs - 1; i >= 0; i--)
>      virtfn_remove(dev, i, 0);
>

Yeah, this was a section I had gone back and forth on.  I originally had 
it doing a '!i' check at the start instead of '!iov->num_VFs'.  I think 
that was why I pulled it out like that.  I started to undo parts of it 
for readability sake, but I probably should have undone the move.


