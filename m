Return-Path: <noaos@mellanox.com>
Return-Path: <noaos@mellanox.com>
Subject: Re: [PATCH v1 0/3] Unmarking Mellanox devices with broken INTx
 masking
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1479196800-32191-1-git-send-email-noaos@mellanox.com>
 <20161116224109.GB16042@bhelgaas-glaptop.roam.corp.google.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <majd@mellanox.com>,
	<gwshan@linux.vnet.ibm.com>
From: Noa Osherovich <noaos@mellanox.com>
Message-ID: <0d1d7f27-514a-3b2c-0887-9fb2ea5001e9@mellanox.com>
Date: Thu, 17 Nov 2016 08:52:36 +0200
MIME-Version: 1.0
In-Reply-To: <20161116224109.GB16042@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

On 11/17/2016 12:41 AM, Bjorn Helgaas wrote:

> On Tue, Nov 15, 2016 at 09:59:57AM +0200, Noa Osherovich wrote:
>> The following 3 patches unmark some Mellanox devices as having broken
>> INTx masking.
>>
>> The first patch moves all broken INTx masking to FINAL instead of
>> HEADER so that the fixup can execute on all archs.
>> The second fixup changes the Mellanox marking to be according to a
>> list of devices rather than a general fixup by vendor.
>> The third patch excludes some Mellanox devices from the INTx broken
>> marking according to device ID / firmware version.
>>
>> v0 -> v1
>> Fixes according to Gavin Shan's comments:
>> - Patch numbering was wrong
>> - Fixed logic of mellanox_check_broken_intx_masking
>>
>> Noa Osherovich (3):
>>   PCI: Use FINAL fixup to mark broken INTx masking
>>   PCI: Convert Mellanox quirks to be for listed devices only
>>   PCI: Add checks to mellanox_check_broken_intx_masking
>>
>>  drivers/pci/quirks.c | 175 ++++++++++++++++++++++++++++++++++++++++-----------
>>  1 file changed, 139 insertions(+), 36 deletions(-)
> I applied these (with the tweaks Gavin & I talked about) to
> pci/virtualization for v4.10.  Please take a look and make sure it still
> works for you.
>
> I also removed the device ID #defines in the interest of brevity and moved
> the Mellanox code out of the middle of the other INTx quirks.
>
> Bjorn

Hi Bjorn,

This may have broken the kbuild robot - it sent an error saying those defines were undeclared.
How do you want to proceed?

Thanks,
Noa
