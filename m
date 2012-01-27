Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Heasley, Seth" <seth.heasley@intel.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Ralston, James D" <james.d.ralston@intel.com>
Subject: RE: [PATCH 6/6] pci: irq and pci_ids patch for Intel Lynx Point
 DeviceIDs
Date: Fri, 27 Jan 2012 18:56:39 +0000
Message-ID: <DEC3922D1904474A8862C7BFF516EA9A2EAE3732@ORSMSX101.amr.corp.intel.com>
References: <201201231646.24194.seth.heasley@intel.com>
 <20120127103110.2a4d667f@jbarnes-desktop>
In-Reply-To: <20120127103110.2a4d667f@jbarnes-desktop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> This patch adds the LPC Controller DeviceIDs for the Intel Lynx Point
>PCH.
>>
>> Signed-off-by: Seth Heasley <seth.heasley@intel.com>
>> ---
>>  arch/x86/pci/irq.c      |    4 +++-
>>  include/linux/pci_ids.h |    2 ++
>>  2 files changed, 5 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c index
>> 372e9b8..22468b6 100644
>> --- a/arch/x86/pci/irq.c
>> +++ b/arch/x86/pci/irq.c
>> @@ -604,7 +604,9 @@ static __init int intel_router_probe(struct
>irq_router *r, struct pci_dev *route
>>  	||  (device >= PCI_DEVICE_ID_INTEL_DH89XXCC_LPC_MIN &&
>>  	     device <= PCI_DEVICE_ID_INTEL_DH89XXCC_LPC_MAX)
>>  	||  (device >= PCI_DEVICE_ID_INTEL_PANTHERPOINT_LPC_MIN &&
>> -	     device <= PCI_DEVICE_ID_INTEL_PANTHERPOINT_LPC_MAX)) {
>> +	     device <= PCI_DEVICE_ID_INTEL_PANTHERPOINT_LPC_MAX)
>> +	||  (device >= PCI_DEVICE_ID_INTEL_LYNXPOINT_LPC_MIN &&
>> +	     device <= PCI_DEVICE_ID_INTEL_LYNXPOINT_LPC_MAX)) {
>>  		r->name = "PIIX/ICH";
>>  		r->get = pirq_piix_get;
>>  		r->set = pirq_piix_set;
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h index
>> 31d77af..6a0359a 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -2800,6 +2800,8 @@
>>  #define PCI_DEVICE_ID_INTEL_82454NX     0x84cb
>>  #define PCI_DEVICE_ID_INTEL_84460GX	0x84ea
>>  #define PCI_DEVICE_ID_INTEL_IXP4XX	0x8500
>> +#define PCI_DEVICE_ID_INTEL_LYNXPOINT_LPC_MIN	0x8c40
>> +#define PCI_DEVICE_ID_INTEL_LYNXPOINT_LPC_MAX	0x8c5f
>>  #define PCI_DEVICE_ID_INTEL_IXP2800	0x9004
>>  #define PCI_DEVICE_ID_INTEL_S21152BB	0xb152
>>
>
>Seems we add every new GMCH or PCH anyway, why not just use the piix
>routines for any unknown (therefore presumably new) Intel PCH device?

Makes sense to me.
-Seth
