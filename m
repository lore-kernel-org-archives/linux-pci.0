Return-Path: <SRS0=ixJP=27=semihalf.com=tn@kernel.org>
Return-Path: <SRS0=ixJP=27=semihalf.com=tn@kernel.org>
Subject: Re: [PATCH 0/2] ThunderX external PCI fixes for legacy&new ACPI
 firmware
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1489564155-3881-1-git-send-email-tn@semihalf.com>
 <20170321174325.GB13150@bhelgaas-glaptop.roam.corp.google.com>
Cc: Lorenzo.Pieralisi@arm.com, robert.richter@caviumnetworks.com,
 ddaney@caviumnetworks.com, Vadim.Lomovtsev@caviumnetworks.com,
 rafael@kernel.org, Sunil.Goutham@cavium.com, geethasowjanya.akula@gmail.com,
 linu.cherian@cavium.com, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <9a200f93-32e3-f225-649d-670af5e84b10@semihalf.com>
Date: Wed, 22 Mar 2017 15:19:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170321174325.GB13150@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 21.03.2017 18:43, Bjorn Helgaas wrote:
> On Wed, Mar 15, 2017 at 08:49:13AM +0100, Tomasz Nowicki wrote:
>> This patch series update ThunderX PEM driver to be able to boot with legacy
>> and new ACPI firmware:
>> 1. New firmware uses registered Cavium harware ID "CAV", but kernel instead
>>    uses "THRX". Fix kernel to use "CAV".
>> 2. Legacy firmware misses PEM quirks information so for this case kernel
>>    should not assume anything from FW and figure out PEM resources on its own.
>>
>> Fix this all together in the following branch:
>> git@github.com:semihalf-nowicki-tomasz/linux.git (thunderx-pci-legacy-fw-v1)
>>
>> Tomasz Nowicki (2):
>>   PCI: Use Cavium assigned hardware ID for ThunderX host controller
>>   PCI: Add legacy firmware support for Cavium ThunderX host controller
>>
>>  drivers/pci/host/pci-thunder-pem.c | 58 ++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 55 insertions(+), 3 deletions(-)
>
> Applied with Robert's acks to pci/host-thunder for v4.12, thanks!
>

Thanks Bjorn!

Tomasz
