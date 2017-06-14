Return-Path: <SRS0=Bbe8=5T=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=Bbe8=5T=arm.com=marc.zyngier@kernel.org>
Subject: Re: [PATCH v7 3/3] PCI: Add tango MSI controller support
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
 <e868f9b8-39e3-4501-a8c6-64bd28a4be8b@sigmadesigns.com>
 <9975fa6c-f426-519b-6b3e-a2d102d36fd5@arm.com>
 <82d6bf37-96b9-cd9d-134b-f01638fa2b1b@sigmadesigns.com>
 <d39b5b3a-48be-7aaa-b7dd-28d4ae1d2083@arm.com>
 <49b4138d-0030-1e8c-6a14-0e9151b63d24@sigmadesigns.com>
 <1588fa00-92c6-046d-ccfc-9a2deae61486@arm.com>
 <08d84ce3-5345-dc69-bbc3-37372a3df22b@sigmadesigns.com>
 <870f833b-6bff-b3b1-6591-7d46e374de66@sigmadesigns.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, Mason <slash.tmp@free.fr>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <a714b871-dd6c-4db0-3539-aabf7274938a@arm.com>
Date: Wed, 14 Jun 2017 10:32:24 +0100
MIME-Version: 1.0
In-Reply-To: <870f833b-6bff-b3b1-6591-7d46e374de66@sigmadesigns.com>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 14/06/17 10:19, Marc Gonzalez wrote:
> On 14/06/2017 11:00, Marc Gonzalez wrote:
> 
>> The MSI controller in Tango supports 256 message-signaled interrupts,
>> and a single doorbell address.
>>
>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>> ---
>> Changes from v6 to v7
>> o Call spin_lock() not spin_lock_irqsave() in the ISR
>> ---
>>  drivers/pci/host/pcie-tango.c | 225 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 225 insertions(+)
> 
> Someone on IRC suggested testing the driver with LOCKDEP.
> 
> If I understand the warning below correctly, I am not supposed
> to call irq_domain_set_info() while holding used_msi_lock?

Indeed. This creates an AB/BA situation, which will eventually deadlock.
Once again, lockdep saves the day.

> NB: in probe, my driver calls
> 
> 	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
> 
> This should not break LOCKDEP analysis, right?

It doesn't. The code is provably wrong, and lockdep proved that it is wrong.

	M.
-- 
Jazz is not dead. It just smells funny...
