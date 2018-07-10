Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20180709160008.GA1490@wunner.de>
References: <CAK9iUCM=zWexWow9TwkRfO186Hwr5WyGy0NHZF1vtXn3wbbZGQ@mail.gmail.com>
 <12fc8de5-ff03-cb00-52cb-25a43c71d03a@codeaurora.org>
 <20180708171418.GA11476@wunner.de>
 <CAK9iUCMcic5mzGiT20KNxgwPo6AuajHFsoj7GOjSht5SwrQevg@mail.gmail.com>
 <20180709160008.GA1490@wunner.de>
From: Sinan Kaya <Okaya@kernel.org>
Date: Tue, 10 Jul 2018 14:30:11 -0400
Message-ID: <CAK9iUCMMVR114msKiMHu7ik0VK8T5j=LAYAKsEkdnocTqkdMjQ@mail.gmail.com>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
To: Lukas Wunner <lukas@wunner.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, Keith Busch <keith.busch@intel.com>,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 9, 2018 at 12:00 PM, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Mon, Jul 09, 2018 at 08:48:44AM -0600, Sinan Kaya wrote:
> > On 7/8/18, Lukas Wunner <lukas@wunner.de> wrote:
> > > On Tue, Jul 03, 2018 at 11:43:26AM -0400, Sinan Kaya wrote:
> > > > My solution doesn't help if link down interrupt is observed before the
> > > > AER
> > > > or DPC services.
> > >
> > > If pciehp gets an interrupt quicker than dpc/aer, it will (at least with
> > > my patches) remove all devices, check if the presence bit is set,
> > > and if so, try to bring the slot up again.
> >
> > Hotplug driver should only observe a link down interrupt. Link would
> > come up in response to a secondary bus reset initiated by the AER
> > driver.
>
> PCIe hotplug doesn't have separate Link Down and Link Up interrupts,
> there is only a Link State *Changed* event.
>
> > Can you point me to the code that would bring up the link in hp code?
>
> I was referring to the situation with my recently posted pciehp patches
> applied, in particular patch [21/32] ("PCI: pciehp: Become resilient to
> missed events"):
> https://patchwork.ozlabs.org/patch/930389/
>
> When I get a presence or link changed event, I turn the slot off.  That
> includes removing all devices in the slot.  Because even if the slot is
> still occupied or link is up, there was definitely a change and the safe
> behavior is to assume that the card in the slot is now a different one
> than before.
>

We do have a bit of mess unfortunately. Error handling and hotplug drivers
do not play nicely with each other.

When hotplug driver observes a link down, we are not checking if the
link down happened because user really wanted to remove a card or
if it was because it was originated by an error handling service such
as AER/DPC.

I'm thinking that we could potentially check if a hotplug event is pending
at the entrance of fatal error handling. If it is pending, we could poll until
the status bit clears. That should flush the link down event.

Even then, link down indication of hotplug seem to turn off slot power
and LED.

If AER/DPC service runs after the hotplug driver, link won't come back
up as the power to the slot is turned off.

I'd like to hear about Bjorn's opinion before we throw something else
into this problem.

> Afterwards, I check if the slot is occupied or link is up.  If either
> of those conditions is true, I try to bring the slot up again.
>
> Thanks,
>
> Lukas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
