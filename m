Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:43197 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbbA0Qi1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jan 2015 11:38:27 -0500
Received: by mail-qa0-f45.google.com with SMTP id n8so12149081qaq.4
        for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2015 08:38:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1422350550.15206.8.camel@pengutronix.de>
References: <1422269684-11527-1-git-send-email-l.stach@pengutronix.de>
 <20150126181236.GA4063@google.com> <1422350550.15206.8.camel@pengutronix.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 27 Jan 2015 10:38:06 -0600
Message-ID: <CAErSpo4hvC-BtQUj+Ybio7kdmGcAGOxYmD_v6FPLPcGGC4TttQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: designware: reject MSI-X irqs
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Jingoo Han <jg1.han@samsung.com>, Mohit Kumar <mohit.kumar@st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 27, 2015 at 3:22 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Hi Bjorn,
>
> Am Montag, den 26.01.2015, 12:12 -0600 schrieb Bjorn Helgaas:
>> On Mon, Jan 26, 2015 at 11:54:44AM +0100, Lucas Stach wrote:
>> > The DW PCIe MSI hardware does not support MSI-X irqs. Setting those up
>> > failed as a side effect of a bug which was fixed by 91f8ae823f2b
>> > (PCI: designware: Setup and clear exactly one MSI at a time).
>> >
>> > Now that this bug is fixed MSI-X irqs need to be rejected explicitly,
>> > otherwise devices trying to use them may end up with incorrectly working
>> > interrupts.
>> >
>> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>>
>> Applied with Jingoo's ack to pci/host-designware for v3.20, thanks!
>>
> I would be happier if this could still find its way into v3.19 if you
> are going to send another fixes pull, as this is clearly a regression
> even if it was already introduced with v3.18.

Added to for-linus for v3.19 and dropped from pci/host-designware.

In general, I apply changes for the next release unless it's clear
that they need to be in the current release.  In this case, I couldn't
tell from the changelog whether this was a theoretical issue or a
"device X worked on v3.17 but stopped working on v3.18 and this patch
fixes it" issue.

>> > Cc: <stable@vger.kernel.org> # 3.18
>> > ---
>> >  drivers/pci/host/pcie-designware.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
>> > index df781cdf13c1..17ca98657a28 100644
>> > --- a/drivers/pci/host/pcie-designware.c
>> > +++ b/drivers/pci/host/pcie-designware.c
>> > @@ -283,6 +283,9 @@ static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
>> >     struct msi_msg msg;
>> >     struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
>> >
>> > +   if (desc->msi_attrib.is_msix)
>> > +           return -EINVAL;
>> > +
>> >     irq = assign_irq(1, desc, &pos);
>> >     if (irq < 0)
>> >             return irq;
>> > --
>> > 2.1.4
>> >
>
>
