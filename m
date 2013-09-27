Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:58297 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab3I0Dwz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2013 23:52:55 -0400
Received: by mail-we0-f181.google.com with SMTP id p61so2107319wes.12
        for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2013 20:52:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130927021925.GF25146@S2101-09.ap.freescale.net>
References: <1379319655-20210-1-git-send-email-xobs@kosagi.com>
	<1379319655-20210-4-git-send-email-xobs@kosagi.com>
	<CAJ+vNU32oMZq=jrSCpk_ZjYc08kRBAqhOS8uYfor28gY8WGhnw@mail.gmail.com>
	<0E83723C55F66F43A6041464FE31119D3F7E6A@039-SN2MPN1-012.039d.mgd.msft.net>
	<20130927021925.GF25146@S2101-09.ap.freescale.net>
Date: Thu, 26 Sep 2013 20:52:53 -0700
Message-ID: <CAJ+vNU1zz21EbuL4xrxSyZ_cNH2Y=_+zFLE9mqnqHst4vuhHKw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
From: Tim Harvey <tharvey@gateworks.com>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Zhu Richard-R65037 <r65037@freescale.com>,
	Sean Cross <xobs@kosagi.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 26, 2013 at 7:19 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Fri, Sep 27, 2013 at 01:38:39AM +0000, Zhu Richard-R65037 wrote:
>> Hi Tim:
>> Thanks for your tests.
>> Yes, it is. There are some problems when the PCIe switch is used on the 3.1x kernel at my side too, although the PCIe switch
>> is ok on FSL imx_3.0.35 kernels.
>> I'm debugging this issue now, and would summit the patches asap.
>>
>
> From what I read, it seems Sean's series does not support PCIe switch.
> At least, he hasn't got any device to test it.  And there is some
> problem with PCIe switch running the latest kernel, which might not be
> related to the controller driver.
>
> I suggest we ask Bjorn to merge the v7 I sent yesterday, so that people
> can have a same base to work on, and add PCIe switch support with
> incremental patches.   Does that sound good to you, Tim?
>
> Shawn
>

Agreed - I would like to get this out there to a broader audience as well.

Thanks,

Tim
