Return-Path: <SRS0=VxNY=NN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05151C32789
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 09:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05FA2082E
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 09:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05FA2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbeKBS7l (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Nov 2018 14:59:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43018 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeKBS7l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Nov 2018 14:59:41 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id q6_VM_YTgKXV; Fri,  2 Nov 2018 10:53:04 +0100 (CET)
Received: from zn.tnic (p200300EC2BCD3B00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:3b00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 906E21EC02E6;
        Fri,  2 Nov 2018 10:53:04 +0100 (CET)
Date:   Fri, 2 Nov 2018 10:53:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI/AER: Option to leave System Error Interrupts
 as-is
Message-ID: <20181102095300.GB14602@zn.tnic>
References: <1540585146-31876-1-git-send-email-jonathan.derrick@intel.com>
 <20181029210651.GB13681@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181029210651.GB13681@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 29, 2018 at 04:06:51PM -0500, Bjorn Helgaas wrote:
> [+cc Rafael, Len, Tony, Borislav, Tyler, Christoph, linux-acpi, LKML]
> 
> On Fri, Oct 26, 2018 at 02:19:04PM -0600, Jon Derrick wrote:
> > Add a bit in pci_host_bridge to indicate to leave the System Error
> > Interrupts as configured by the pre-boot environment. Propagate this to
> > the AER driver which disables System Error Interrupts.

This commit message should not explain what the patch does - that's
obvious - but why it is doing it.


> > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > ---
> >  drivers/pci/pcie/aer.c | 7 +++++--
> >  include/linux/pci.h    | 3 +++
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 83180ed..6a4af63 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1360,6 +1360,7 @@ static void set_downstream_devices_error_reporting(struct pci_dev *dev,
> >  static void aer_enable_rootport(struct aer_rpc *rpc)
> >  {
> >  	struct pci_dev *pdev = rpc->rpd;
> > +	struct pci_host_bridge *host;
> >  	int aer_pos;
> >  	u16 reg16;
> >  	u32 reg32;
> > @@ -1369,8 +1370,10 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
> >  	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, reg16);
> >  
> >  	/* Disable system error generation in response to error messages */
> > -	pcie_capability_clear_word(pdev, PCI_EXP_RTCTL,
> > -				   SYSTEM_ERROR_INTR_ON_MESG_MASK);
> > +	host = pci_find_host_bridge(pdev->bus);
> > +	if (!host->no_disable_sys_err)

Double negation

	if (! .. ->no..

could simply be

	if (host->disable_sys_err...

> > +		pcie_capability_clear_word(pdev, PCI_EXP_RTCTL,
> > +					   SYSTEM_ERROR_INTR_ON_MESG_MASK);
> 
> If I squint hard enough this sort of makes sense, but it also makes me
> confused about the normal APEI firmware-first model works.
> 
> In the NON-firmare-first case, firmware isn't involved in handling AER
> errors.  The Linux AER driver fields an interrupt from a Root Port,
> reads AER log registers, etc.
> 
> In the normal APEI firmware-first case, when the hardware reports an
> AER event, I think firmware gets control first, and *it* reads the AER
> log registers, packages them up, and generates an interrupt to the OS,
> which reads the packaged error state from the firmware via the HEST.
> 
> If I understand this special Intel VMD firmware-first case correctly,
> firmware gets control first, reads the AER log registers, and
> synthesizes what looks to the OS like a normal AER interrupt.  The

Why?

Why the faking?

If firmware needs to get control, why doesn't it then *retain* control
and report the error through HEST, like others do?

AFAIUC, fw wants to do something underneath. What's wrong with making it
a normal firmware-first case?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
