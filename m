Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:36132 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932256AbbJ0QFS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2015 12:05:18 -0400
Received: by iodz80 with SMTP id z80so22685460iod.3
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2015 09:05:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20151027151542.GF8660@localhost>
References: <20151021183741.28724.71281.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20151021184250.28724.41928.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20151027151542.GF8660@localhost>
Date: Tue, 27 Oct 2015 14:05:17 -0200
Message-ID: <CAOMZO5CYTd+VKj8h6iP_g1A_OAHuFYhM=-wfS5+PzshkbFFnyg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] PCI: designware: Use common LTSSM_STATE_MASK definition
From: Fabio Estevam <festevam@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush Anand Thakur <pratyush.anand@gmail.com>,
	m-karicheri2 <m-karicheri2@ti.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Tue, Oct 27, 2015 at 1:15 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> [+cc Minghuan]
>
> On Wed, Oct 21, 2015 at 01:42:50PM -0500, Bjorn Helgaas wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Add a common #define for LTSSM_STATE_MASK and use it in all the
>> DesignWare-based drivers.
>>
>> Note that this changes LTSSM_STATE_MASK from 6 bits (0x3f) to 5 bits (0x1f)
>> for i.MX6 and Layerscape.  We believe this is safe for all DesignWare-based
>> PCIe cores.
>
> OK, DesignWare experts, what's the story on this LTSSM_STATE_MASK?
>
> Minghuan says Layerscape requires a mask of 0x3f and it actually uses
> states 0x20, 0x21, 0x22, and 0x23:
>
> MH> Our LTSSM mask is 0x3f because it includes the following states:
> MH> 0x20 S_RCVRY_EQ0
> MH> 0x21 S_RCVRY_EQ1
> MH> 0x22 S_RCVRY_EQ2
> MH> 0x23 S_RCVRY_EQ3
>
> MH> And I checked DesignWare Cores PCI Express Controller Databook
> MH> v4.21a and found the following descriptor:
>
> MH> [5:0]: smlh_ltssm_state: LTSSM current state. Encoding is defined in workspace/src/include/cxpl_defs.vh
>
> MH> So could we use the mask 0x3f for all SoCs?
>
> I couldn't find the "DesignWare Cores PCI Express Controller Databook
> v4.21a", but I do see the Keystone mask (sec 3.9.11 of
> http://www.ti.com/lit/ug/sprugs6d/sprugs6d.pdf) is definitely only 5
> bits, but that's clearly a TI register, not a generic DesignWare
> register.
>
> So it looks like a mistake to make a common LTSSM_STATE_MASK
> definition.  It looks like this is something with some variation and
> we shouldn't make assumptions about it being common.

Yes, what if we keep the original behaviour: define a common
LTSSM_STATE_MASK as 0x3f and then add KS_LTSSM_STATE_MASK as 0x1f for
Keystone only?

>
> Now I'm concerned that the LTSSM state definitions I put in
> drivers/pci/host/pcie-designware.h might not actually apply to
> everything derived from DW.  For example, the Layerscape S_RCVRY
> states appear to be Layerscape-specific.
>
> I don't want to put misleading stuff in
> drivers/pci/host/pcie-designware.h if it's not really generic.  Better
> to have it in the individual drivers, with a prefix that indicates
> that it applies to that driver, e.g., KS_LTSSM_MASK, LS_LTSSM_MASK,
> etc.

The LTSSM states we put in drivers/pci/host/pcie-designware.h are from
0-1f, so they are common.

Would you like to drop this series from your tree and then I can
resend it with the proposed changes above if everyone agrees?

Thanks,

Fabio Estevam
