Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 1/1] PCI: Add MCFG quirk for 2nd node of Cavium ThunderX
 pass2.x host controller
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1490789773-21506-1-git-send-email-tn@semihalf.com>
 <20170421165614.GA17916@bhelgaas-glaptop.roam.corp.google.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <1e1aef81-3d0e-02a3-8005-47d9c1d9d5f3@semihalf.com>
Date: Fri, 21 Apr 2017 19:30:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170421165614.GA17916@bhelgaas-glaptop.roam.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo.Pieralisi@arm.com, Sunil.Goutham@cavium.com, rafael@kernel.org,
 linux-pci@vger.kernel.org, linu.cherian@cavium.com, ddaney@caviumnetworks.com,
 geethasowjanya.akula@gmail.com, linux-acpi@vger.kernel.org,
 robert.richter@caviumnetworks.com, Vadim.Lomovtsev@caviumnetworks.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 21.04.2017 18:56, Bjorn Helgaas wrote:
> On Wed, Mar 29, 2017 at 02:16:13PM +0200, Tomasz Nowicki wrote:
>> Currently SoCs pass2.x do not emulate EA headers for ACPI boot method at all.
>> However, for pass2.x some devices (like EDAC) advertise incorrect base addresses
>> in their BARs which results in driver probe failure during resource request.
>> Since all problematic blocks are on 2nd NUMA node under domain 10 add necessary
>> quirk entry to obtain BAR addresses correction using EA header emulation.
>>
>> Fixes: 44f22bd91e88 ("PCI: Add MCFG quirks for Cavium ThunderX pass2.x host controller")
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> CC: stable@vger.kernel.org	# v4.10+
>
> Sorry Tomasz, I must have mistakenly marked this "accepted" in
> patchwork, so it fell off my to-do list.  It's too late to get this in
> v4.11, but I can still apply it for v4.12.
>
> I put it on my pci/host-thunder branch with Robert's ack.  I added a preceding
> patch to tidy up whitespace, which makes this patch look like just:
>
>         /* SoC pass2.x */
>         THUNDER_PEM_QUIRK(1, 0),
>         THUNDER_PEM_QUIRK(1, 1),
> +       THUNDER_ECAM_QUIRK(1, 10),
>
> Please double-check it to make sure this is what you need.

This is exactly what we need. Thank you Bjorn.

Tomasz

>
>> ---
>>  drivers/acpi/pci_mcfg.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>> index a6a4cea..a0a391e 100644
>> --- a/drivers/acpi/pci_mcfg.c
>> +++ b/drivers/acpi/pci_mcfg.c
>> @@ -90,13 +90,14 @@ static struct mcfg_fixup mcfg_quirks[] = {
>>  	  &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x894057000000UL, node) },  \
>>  	{ "CAVIUM", "THUNDERX", rev, 9 + (10 * (node)), MCFG_BUS_ANY,	    \
>>  	  &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x89808f000000UL, node) }
>> +#define THUNDER_ECAM_QUIRK(rev, seg)					\
>> +	{ "CAVIUM", "THUNDERX", rev, seg, MCFG_BUS_ANY,			\
>> +	&pci_thunder_ecam_ops }
>>  	/* SoC pass2.x */
>>  	THUNDER_PEM_QUIRK(1, 0),
>>  	THUNDER_PEM_QUIRK(1, 1),
>> +	THUNDER_ECAM_QUIRK(1, 10),
>>
>> -#define THUNDER_ECAM_QUIRK(rev, seg)					\
>> -	{ "CAVIUM", "THUNDERX", rev, seg, MCFG_BUS_ANY,			\
>> -	&pci_thunder_ecam_ops }
>>  	/* SoC pass1.x */
>>  	THUNDER_PEM_QUIRK(2, 0),	/* off-chip devices */
>>  	THUNDER_PEM_QUIRK(2, 1),	/* off-chip devices */
>> --
>> 2.7.4
>>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
