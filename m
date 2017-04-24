Return-Path: <SRS0=iY1L=4A=google.com=bhelgaas@kernel.org>
Return-Path: <SRS0=iY1L=4A=google.com=bhelgaas@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170424093429.GT16981@rric.localdomain>
References: <1490789773-21506-1-git-send-email-tn@semihalf.com>
 <20170421165614.GA17916@bhelgaas-glaptop.roam.corp.google.com> <20170424093429.GT16981@rric.localdomain>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 24 Apr 2017 12:05:05 -0500
Message-ID: <CAErSpo4-a4jKEpxZX3YKeAzE-oVdE3gtRDGSx7nrGuVzK9OKGA@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI: Add MCFG quirk for 2nd node of Cavium ThunderX
 pass2.x host controller
To: Robert Richter <robert.richter@cavium.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Tomasz Nowicki <tn@semihalf.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, David Daney <ddaney@caviumnetworks.com>,
	Vadim.Lomovtsev@caviumnetworks.com, "Rafael J. Wysocki" <rafael@kernel.org>,
	Sunil.Goutham@cavium.com, geethasowjanya.akula@gmail.com,
	linu.cherian@cavium.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 24, 2017 at 4:34 AM, Robert Richter
<robert.richter@cavium.com> wrote:
> On 21.04.17 11:56:14, Bjorn Helgaas wrote:
>> On Wed, Mar 29, 2017 at 02:16:13PM +0200, Tomasz Nowicki wrote:
>> > Currently SoCs pass2.x do not emulate EA headers for ACPI boot method at all.
>> > However, for pass2.x some devices (like EDAC) advertise incorrect base addresses
>> > in their BARs which results in driver probe failure during resource request.
>> > Since all problematic blocks are on 2nd NUMA node under domain 10 add necessary
>> > quirk entry to obtain BAR addresses correction using EA header emulation.
>> >
>> > Fixes: 44f22bd91e88 ("PCI: Add MCFG quirks for Cavium ThunderX pass2.x host controller")
>> > Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> > CC: stable@vger.kernel.org  # v4.10+
>>
>> Sorry Tomasz, I must have mistakenly marked this "accepted" in
>> patchwork, so it fell off my to-do list.  It's too late to get this in
>> v4.11, but I can still apply it for v4.12.
>>
>> I put it on my pci/host-thunder branch with Robert's ack.  I added a preceding
>> patch to tidy up whitespace, which makes this patch look like just:
>>
>>         /* SoC pass2.x */
>>         THUNDER_PEM_QUIRK(1, 0),
>>         THUNDER_PEM_QUIRK(1, 1),
>> +       THUNDER_ECAM_QUIRK(1, 10),
>>
>> Please double-check it to make sure this is what you need.
>
> Bjorn,
>
> since the second is marked stable there will be conflicts when
> applying it to stable (or built errors). The best would be to change
> order of both (128cd6e8249f^, 128cd6e8249f) for smooth backporting
> which makes it then more close to Tomasz's version again.

Thanks, I should have noticed that.  Could go either way; I just
marked 128cd6e8249f^ for stable as well, since it seemed marginally
easier to read to split the whitespace changes from the real change.

>> > ---
>> >  drivers/acpi/pci_mcfg.c | 7 ++++---
>> >  1 file changed, 4 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
>> > index a6a4cea..a0a391e 100644
>> > --- a/drivers/acpi/pci_mcfg.c
>> > +++ b/drivers/acpi/pci_mcfg.c
>> > @@ -90,13 +90,14 @@ static struct mcfg_fixup mcfg_quirks[] = {
>> >       &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x894057000000UL, node) },  \
>> >     { "CAVIUM", "THUNDERX", rev, 9 + (10 * (node)), MCFG_BUS_ANY,       \
>> >       &thunder_pem_ecam_ops, THUNDER_PEM_RES(0x89808f000000UL, node) }
>> > +#define THUNDER_ECAM_QUIRK(rev, seg)                                       \
>> > +   { "CAVIUM", "THUNDERX", rev, seg, MCFG_BUS_ANY,                 \
>> > +   &pci_thunder_ecam_ops }
>> >     /* SoC pass2.x */
>> >     THUNDER_PEM_QUIRK(1, 0),
>> >     THUNDER_PEM_QUIRK(1, 1),
>> > +   THUNDER_ECAM_QUIRK(1, 10),
>> >
>> > -#define THUNDER_ECAM_QUIRK(rev, seg)                                       \
>> > -   { "CAVIUM", "THUNDERX", rev, seg, MCFG_BUS_ANY,                 \
>> > -   &pci_thunder_ecam_ops }
>> >     /* SoC pass1.x */
>> >     THUNDER_PEM_QUIRK(2, 0),        /* off-chip devices */
>> >     THUNDER_PEM_QUIRK(2, 1),        /* off-chip devices */
>> > --
>> > 2.7.4
>> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
