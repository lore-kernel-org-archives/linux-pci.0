Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:52099 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060Ab3ADTTW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2013 14:19:22 -0500
Received: by mail-vc0-f180.google.com with SMTP id p16so17010287vcq.11
        for <linux-pci@vger.kernel.org>; Fri, 04 Jan 2013 11:19:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130104190833.4586.16520.stgit@bhelgaas.mtv.corp.google.com>
References: <20130104190833.4586.16520.stgit@bhelgaas.mtv.corp.google.com>
Date: Fri, 4 Jan 2013 14:19:21 -0500
Message-ID: <CADnq5_MYtqg=JHs+-cXCigRCba4g59a7zwpQmswSGgMPWDocLQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm_pcie_get_speed_cap_mask() cleanups
From: Alex Deucher <alexdeucher@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Betty Dall <betty.dall@hp.com>,
	Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
	Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 4, 2013 at 2:10 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> These are minor cleanups for drm_pcie_get_speed_cap_mask() to use
> standard #defines and PCIe capability accessors.  They depend on
> a pci_regs.h change (130f1b8f35) that appeared in v3.8-rc2.
>
> They don't address the issue of DRM devices directly below a host
> bridge that doesn't appear as a PCI device (the issue Lucas has
> been working on).
>
> I'm a little skeptical about the premise of drm_pcie_get_speed_cap_mask()
> to begin with.  Link speed seems like something fairly generic that should
> be handled in the core, not in individual drivers.  Sec 6.11, "Link Speed
> Management", in the PCIe 3.0 spec seems relevant and suggests that the
> hardware should automatically use the highest speed supported by both ends
> of the link unless software sets a lower maximum via Target Link Speed.
>
> But I can't match up the code, e.g., evergreen_pcie_gen2_enable(), to
> anything in the generic PCIe specs, so maybe this driver code is
> essentially quirks for misbehaving hardware?

At least for radeon, there is an asic specific sequence required to
change the PCIE gen link speed at runtime.  Depending on the bios, the
board may come up in the highest mode supported by either side or
something lower.  If it comes up at a lower speed than the hardware is
capable of, we can increase it in the driver to improve performance.
Additionally, you can select a lower link speed to save power.  I
don't know if there is a generic non-asic specific way to change the
link speed of a device at runtime, but I'm not really a PCI expert.

Alex
