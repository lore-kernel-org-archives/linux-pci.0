Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:32865 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbbJLM0z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2015 08:26:55 -0400
Received: by iodv82 with SMTP id v82so49079445iod.0
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2015 05:26:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1444645188.3364.5.camel@pengutronix.de>
References: <1444355306-21486-1-git-send-email-festevam@gmail.com>
	<1444645188.3364.5.camel@pengutronix.de>
Date: Mon, 12 Oct 2015 09:26:54 -0300
Message-ID: <CAOMZO5CmNEdjmsSmXx2Cv+SP_Dd81r6dxviS-ZVUJjK4+v_hbA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: designware: Move LTSSM state definitions to pcie-designware.h
From: Fabio Estevam <festevam@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Pratyush Anand Thakur <pratyush.anand@gmail.com>,
	m-karicheri2 <m-karicheri2@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lucas,

On Mon, Oct 12, 2015 at 7:19 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Donnerstag, den 08.10.2015, 22:48 -0300 schrieb Fabio Estevam:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Move LTSSM state definitions to common pcie-designware.h so that other
>> drivers can make use of them.
>>
>> Also, in order to avoid name collision define LTSSM_STATE_MASK_KS, as
>> keystone uses a different LTSSM mask.
>>
> Why? Is this some kind of difference between the DW PCIe core revisions?

This patch does not alter the LTSSM masks that are used currently and
they match the ones stated in the SoC manuals.

For keystone:
http://www.ti.com/lit/ug/sprugs6d/sprugs6d.pdf

Section "48.9.11 Debug Register 0 (PCIE_PL_DEBUG0)" shows that LTSSM
current state has 6 bits.

For i.MX6:

Section "3.9.11 Debug 0 Register (DEBUG0)" shows that LTSSM_STATE
field has 5 bits.

Regards,

Fabio Estevam
