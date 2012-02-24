Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49462 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932252Ab2BXRZl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2012 12:25:41 -0500
Received: by wgbdt10 with SMTP id dt10so2291082wgb.1
        for <linux-pci@vger.kernel.org>; Fri, 24 Feb 2012 09:25:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHM4w1k1_Yp56tpfPqDxT1WHQWRB5xe_Zs-BEj+n5rVmuyAJiw@mail.gmail.com>
References: <20120220191804.GA14499@avionic-0098.adnet.avionic-design.de>
 <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC302@HQMAIL01.nvidia.com>
 <20120222082449.GA15157@avionic-0098.adnet.avionic-design.de>
 <CAErSpo4TfpGmx+HZ1ZnZwj3ZP_cQMCzkMT+6JK6ztYp2zWJcxw@mail.gmail.com>
 <20120223060355.GA21091@avionic-0098.mockup.avionic-design.de>
 <CAErSpo7wSB-uCjV4YeA-fUOHPtugn4ASXScN3MndVybfkk8mOw@mail.gmail.com>
 <20120224065921.GA28932@avionic-0098.mockup.avionic-design.de> <CAHM4w1k1_Yp56tpfPqDxT1WHQWRB5xe_Zs-BEj+n5rVmuyAJiw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 24 Feb 2012 09:25:19 -0800
Message-ID: <CAErSpo7yfPyGUXCWmLRHO0Ga4o+BsDLc_zb9D2WBjrVYo9Ovow@mail.gmail.com>
Subject: Re: PCIe device tree support
To: Pratyush Anand <pratyush.anand@gmail.com>
Cc: "Olof Johansson (olof@lixom.net)" <olof@lixom.net>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Stephen Warren <swarren@nvidia.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 24, 2012 at 9:16 AM, Pratyush Anand
<pratyush.anand@gmail.com> wrote:
> I too had similar query.
> I have written a PCIe host driver for SPEAr platform (ARM Arch).
> This driver is registered on paltform bus.
> It is for Designware IP, so I believe that most of its part
> can be re-usaable for other person.
>  have kept common and SPEAr specific part separately.
> But,  I am not sure about its best location.
> I believe best would have been to keep in driver/pci/pcie/hosts/.
> But it uses pci_common_init function which is specific to ARM platform.
> So it limits option to arch/arm.
> But, if I keep it in arch/arm/mach-spear13xx/ , then it will limit others
> from using synopsys specific code.
>
> What do you suggest?

If it uses ARM-specific functions, I think somewhere in arch/arm/
makes the most sense.  There are some arches (parisc comes to mind)
that do have arch-specific code in drivers/, but until it can be
usefully shared, that doesn't seem worthwhile to me.  We can always
move it later.

Bjorn
