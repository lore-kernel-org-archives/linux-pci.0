Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <556331A7.60909@st.com>
Date: Mon, 25 May 2015 16:28:55 +0200
From: Fabrice Gasnier <fabrice.gasnier@st.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	Gabriel FERNANDEZ <gabriel.fernandez@st.com>
CC: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Russell King <linux@arm.linux.org.uk>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	Tanmay Inamdar <tinamdar@apm.com>, <m-karicheri2@ti.com>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Liviu Dudau <liviu.dudau@arm.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kernel@stlinux.com>,
	<linux-pci@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Gabriel Fernandez <gabriel.fernandez@linaro.org>
Subject: Re: [PATCH v3 4/5] pci: designware: remove pci_common_init_dev()
References: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org> <1428657168-12495-5-git-send-email-gabriel.fernandez@linaro.org> <20150506192201.GF24643@google.com>
In-Reply-To: <20150506192201.GF24643@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 05/06/2015 09:22 PM, Bjorn Helgaas wrote:
> It's not completely obvious that replacing pci_common_init_dev() with
> dw_pcie_setup() is equivalent.  Here are my notes from trying to convince
> myself that this is correct.  I think your changelog could stand some
> enhancement.  It would be ideal if you could break this into a few smaller
> patches that were more obviously correct, but I suspect it's too
> intertwined to do that.

Thanks you for your review !

Sorry for the late reply, from your detailed analysis bellow, yes, it 
looks like pci_common_init_dev isn't
completely equivalent.
I'm wondering about PCI_PROBE_ONLY flag...

The idea in the first place, to move to generic probing directly, instead of
pci_common_init_dev() was to avoid being assigned default I/O (e.g. in 
bios32.c).
Please refer to discussion with Arnd :
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/317726.html
But, I don't see how to be fully compatible (e.g. ARM specific option 
like PCI_PROBE_ONLY)
without calling pci_common_init_dev() or duplicating code from bios32.c.

Maybe should I fall back to the first idea of using specifc handling of 
an "empty" IO space, and keep pci_common_init_dev() ?

Please advise,

BR,
Fabrice

> Here's an outline of pci_common_init_dev():
>
>    pci_common_init_dev(parent, hw)
>      pci_add_flags(PCI_REASSIGN_ALL_RSRC)           # [1]
>      if (hw->preinit)
>        hw->preinit                                  # [2]
>      pcibios_init_hw
>        for (nr = 0; nr < hw->nr_controllers;        # [3]
>            sys = kzalloc                            # [4]
>            sys->msi_ctrl = hw->msi_ctrl             # [5]
>            sys->busnr = busnr                       # [6]
>            sys->swizzle = hw->swizzle               # [7]
>            sys->map_irq = hw->map_irq               # [8]
>            sys->align_resource = hw->align_resource # [9]
>            INIT_LIST_HEAD(&sys->resources)          # [10]
>            sys->private_data = hw->private_data     # [11]
>            hw->setup                                # [12]
>            pcibios_init_resources                   # [13]
>            hw->scan                                 # [14]
>      if (hw->postinit)
>        hw->postinit                                 # [15]
>      pci_fixup_irqs                                 # [16]
>      list_for_each_entry(sys, &head,                # [17]
>        if (!pci_has_flag(PCI_PROBE_ONLY))           # [18]
>          pci_bus_size_bridges                       # [19]
>          pci_bus_assign_resources
>        pci_bus_add_devices
>      list_for_each_entry(sys, &head,
>        ...
>          pcie_bus_configure_settings                # [20]
>
> [1] You don't set PCI_REASSIGN_ALL_RSRC; have you verified that nobody
> cares about that?
>
> [2] dw_pci.preinit was NULL, so skipping this doesn't matter; looks OK.
>
> [3] dw_pci.nr_controllers was always 1, so skipping the loop doesn't
> matter; looks OK.
>
> [4] You added struct pci_sys_data sysdata as a member of struct
> pcie_port, so it is now allocated by dw_pcie_host_init() callers, e.g.,
> st_pcie_probe(); looks OK.
>
> [5] You set pp->sysdata.msi_ctrl in dw_pcie_host_init() instead of
> pcibios_init_hw(); looks OK.
>
> [6] Since dw_pci.nr_controllers was always 1, sys->busnr was always 0.
> You don't set sys->busnr, so it will retain its initial zero value.  OK, I
> guess.  It's still a little broken that we have both pp->busn and
> pp->sysdata.busnr, but you didn't break it and it's OK that you didn't
> change anything in this regard.
>
> [7] dw_pci.swizzle was NULL, so pcibios_swizzle() would default to
> pci_common_swizzle(), which is what you use when you call pci_fixup_irqs()
> in dw_pcie_scan_bus(); looks OK.
>
> [8] dw_pci.map_irq was dw_pcie_map_irq() (which used
> of_irq_parse_and_map_pci()) and sys->map_irq was used by pcibios_map_irq().
> You call pci_fixup_irqs() and pass a pointer to of_irq_parse_and_map_pci();
> looks OK.
>
> [9] dw_pci.align_resource was NULL, and I assume
> pcie_port.sysdata.align_resource was initialized to zeroes; looks OK.
>
> [10] You call INIT_LIST_HEAD() in dw_pcie_host_init() instead of
> pcibios_init_hw(); looks OK.
>
> [11] You set sys->private_data in dw_pcie_host_init() instead of
> pcibios_init_hw(); looks OK.
>
> [12] dw_pci.setup was dw_pcie_setup(), and you call that from
> dw_pcie_host_init(); looks OK.
>
> [13] You no longer call pcibios_init_resources().  You don't want the
> default I/O space, which makes sense; looks OK (but you need to audit other
> users and make sure they don't need it either).
>
> [14] dw_pci.scan was dw_pcie_scan_bus(), and you call that from
> dw_pcie_host_init(); looks OK.
>
> [15] dw_pci.postinit was NULL, so skipping this doesn't matter; looks OK.
>
> [16] You call pci_fixup_irqs() from dw_pcie_scan_bus() instead of
> pci_common_init_dev(); looks OK.
>
> [17] "head" is a local list in pci_common_init_dev(), and you don't need
> anything similar because dw_pcie_host_init() is called once per host
> bridge; looks OK.
>
> [18] You don't test PCI_PROBE_ONLY; it looks like it can still be set by
> booting with "pci=firmware".  So previously, "pci=firmware" prevented
> resource assignment, but it no longer does.  Is that right?  Is that what
> you intend?
>
> [19] Instead of pci_bus_size_bridges() and pci_bus_assign_resources(), you
> call pci_assign_unassigned_bus_resources() from dw_pcie_scan_bus().  That
> seems like an improvement because it holds pci_bus_sem and supplies
> add_list; looks OK.
>
> [20] I think you no longer call pcie_bus_configure_settings().  That
> configured MPS settings, and I think you still want to do that, don't you?

