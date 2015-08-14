Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39056 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754994AbbHNPoH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 14 Aug 2015 11:44:07 -0400
Message-ID: <55CE0CC2.7010705@arm.com>
Date: Fri, 14 Aug 2015 16:44:02 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Will Deacon <Will.Deacon@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	"agraf@suse.de" <agraf@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/3] powerpc: PCI: Fix lookup of linux,pci-probe-only
 property
References: <1439563268-13418-1-git-send-email-marc.zyngier@arm.com> <1439563268-13418-3-git-send-email-marc.zyngier@arm.com> <20150814145755.GE26431@google.com>
In-Reply-To: <20150814145755.GE26431@google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 14/08/15 15:57, Bjorn Helgaas wrote:
> Hi Marc,
> 
> On Fri, Aug 14, 2015 at 03:41:07PM +0100, Marc Zyngier wrote:
>> When find_and_init_phbs() looks for the probe-only property, it seems
>> to trust the firmware to be correctly written, and assumes that there
>> is a parameter to the property.
>>
>> It is conceivable that the firmware could not be that perfect, and it
>> could expose this property naked (at least one arm64 platform seems to
>> exhibit this exact behaviour). The setup code the ends up making
>> a decision based on whatever the property pointer points to, which
>> is likely to be junk.
>>
>> Instead, let's check for the validity of the property, and ignore
>> it if the firmware couldn't make up its mind.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/powerpc/platforms/pseries/setup.c | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
>> index df6a704..6bdc1f9 100644
>> --- a/arch/powerpc/platforms/pseries/setup.c
>> +++ b/arch/powerpc/platforms/pseries/setup.c
>> @@ -490,14 +490,19 @@ static void __init find_and_init_phbs(void)
>>  	 */
>>  	if (of_chosen) {
>>  		const int *prop;
>> +		int len;
>>  
>>  		prop = of_get_property(of_chosen,
>> -				"linux,pci-probe-only", NULL);
>> +				"linux,pci-probe-only", &len);
>>  		if (prop) {
>> -			if (*prop)
>> -				pci_add_flags(PCI_PROBE_ONLY);
>> -			else
>> -				pci_clear_flags(PCI_PROBE_ONLY);
>> +			if (len) {
>> +				if (be32_to_cpup(prop))
>> +					pci_add_flags(PCI_PROBE_ONLY);
>> +				else
>> +					pci_clear_flags(PCI_PROBE_ONLY);
>> +			} else {
>> +				pr_warn("linux,pci-probe-only set without value, ignoring\n");
>> +			}
> 
> This seems essentially identical to the pci-host-generic version.
> Is there a way we can factor it out so there's only one copy?

Probably. drivers/of/of_pci.c seems like a good landing place for it.
I'll hack something and repost it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
