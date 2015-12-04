Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5661C863.3070308@arm.com>
Date: Fri, 04 Dec 2015 17:07:47 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Phil Edworthy <phil.edworthy@renesas.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: MSI: Only use the generic MSI layer when domain
 is hierarchical
References: <1448288826-19058-1-git-send-email-marc.zyngier@arm.com> <PS1PR06MB11808365B312F6C3DAE2DB35F5000@PS1PR06MB1180.apcprd06.prod.outlook.com> <20151204002758.GA10479@localhost> <20151204081350.2113b7e6@why.wild-wind.fr.eu.org> <20151204161735.GA13427@localhost>
In-Reply-To: <20151204161735.GA13427@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 04/12/15 16:17, Bjorn Helgaas wrote:
> On Fri, Dec 04, 2015 at 08:13:50AM +0000, Marc Zyngier wrote:
>> On Thu, 3 Dec 2015 18:27:59 -0600
>> Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>>> On Mon, Nov 30, 2015 at 10:25:34AM +0000, Phil Edworthy wrote:
>>>> Cc'd linux-pci ml
>>>>
>>>> On 23 November 2015 14:27, Marc Zyngier wrote:
>>>>
>>>> Since d8a1cb757550 ("PCI/MSI: Let pci_msi_get_domain use struct
>>>> device::msi_domain"), we use the MSI domain associated to the PCI device.
>>>>
>>>> But finding a MSI domain doesn't mean that the domain is implemented
>>>> using the generic MSI domain API, and a number of MSI controllers
>>>> are still using the arch_setup_msi_irq/arch_teardown_msi_irqs.
>>>>
>>>> In order to avoid a firework on these systems, check that the domain
>>>> we just obtained is hierarchical. If not, don't use the generic MSI
>>>> stuff and stick with the old one. Not pretty, but reliable.
>>>>
>>>> Another insentive to rework those drivers and phase out this API.
>>>>
>>>> Reported-by: Phil Edworthy <phil.edworthy@renesas.com>
>>>> Tested-by: Phil Edworthy <phil.edworthy@renesas.com>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>
>>> Thanks, I applied this with Thomas' ack to pci/msi for v4.5.
>>>
>>> It looks like d8a1cb757550 appeared in v4.3.  Is this a fix for that
>>> commit?  Does this need to be backported via a stable tag?
>>
>> Hi Bjorn,
>>
>> I think this really deserves to be queued as an immediate fix for 4.4
>> rather than 4.5, as some systems in mainline are affected by this bug:
>>
>> http://www.spinics.net/lists/arm-kernel/msg465792.html
>>
>> It would also deserve a stable tag for 4.3.
> 
> OK, I can do that.  It would save me a lot of time to get a hint when
> this is the case.  I couldn't tell if this issue happened on mainline
> or with some still out-of-tree patches.  I'd also like to know what
> machines are affected.

Sorry, I should have been more clear. At the moment, I've had reports of
at least RCar, Tegra and Armada 370 being affected. Anything using the
Designware driver will probably also fall over.

> I did look at d8a1cb757550, and the connection between that and this
> patch is not completely obvious; would you regard this as a fix to
> d8a1cb757550?  Should this patch be backported to every kernel that
> includes d8a1cb757550?  Or is this more closely tied to some other
> change?

d8a1cb757550 is indeed the source of the problem: we assumes that
finding a domain identified by a given device is enough to decide that
we're using the generic MSI layer. Unfortunately, this is not the case,
and a number of ARM drivers are actually registering their own domain
the same way, without using the generic MSI layer. I didn't spot this on
arm64, as all my platforms are using this layer.

So it seems better to merge this in 4.4, with a backport to 4.3 (which
is the first kernel to contain this commit).

Sorry for the mess - I'll make it clearer next time.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
