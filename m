Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF52C4332F
	for <linux-pci@archiver.kernel.org>; Mon,  6 Nov 2023 18:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjKFSS0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 6 Nov 2023 13:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjKFSSZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 13:18:25 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960AE94
        for <linux-pci@vger.kernel.org>; Mon,  6 Nov 2023 10:18:22 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 82750104310B1;
        Mon,  6 Nov 2023 19:18:18 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 590FA119432; Mon,  6 Nov 2023 19:18:18 +0100 (CET)
Date:   Mon, 6 Nov 2023 19:18:18 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Danilo Krummrich <dakr@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xinhui Pan <Xinhui.Pan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 6/9] PCI: Rename is_thunderbolt to is_tunneled
Message-ID: <20231106181818.GB18564@wunner.de>
References: <20231103190758.82911-1-mario.limonciello@amd.com>
 <20231103190758.82911-7-mario.limonciello@amd.com>
 <20231105173946.GA31955@wunner.de>
 <9b1a5e36-337b-4750-9dad-b54e28cde03a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b1a5e36-337b-4750-9dad-b54e28cde03a@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 06, 2023 at 10:59:13AM -0600, Mario Limonciello wrote:
> On 11/5/2023 11:39, Lukas Wunner wrote:
> > On Fri, Nov 03, 2023 at 02:07:55PM -0500, Mario Limonciello wrote:
> > > The `is_thunderbolt` bit has been used to indicate that a PCIe device
> > > contained the Intel VSEC which is used by various parts of the kernel
> > > to change behavior. To later allow usage with USB4 controllers as well,
> > > rename this to `is_tunneled`.
> > 
> > This doesn't seem to make sense.  is_thunderbolt indicates that a device
> > is part of a Thunderbolt controller.  See the code comment:
> > 
> > > -	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
> > 
> > A Thunderbolt controller is not necessarily tunneled.  The PCIe switch,
> > NHI and XHCI of the Thunderbolt host controller are not tunneled at all.
> 
> I could really use some clarification which PCIe devices actually contain
> the Intel VSEC.
> 
> Is it in all 3 of those PCIe devices and not just the switch?

Yes, I've just double-checked Light Ridge, Cactus Ridge, Alpine Ridge.

Thanks,

Lukas
