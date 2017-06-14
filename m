Return-Path: <SRS0=ZFNK=5T=sigmadesigns.com=marc_gonzalez@kernel.org>
Return-Path: <SRS0=ZFNK=5T=sigmadesigns.com=marc_gonzalez@kernel.org>
Subject: Re: [PATCH v7 3/3] PCI: Add tango MSI controller support
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
To: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>
CC: Bjorn Helgaas <helgaas@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Liviu Dudau
	<liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>, linux-pci
	<linux-pci@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	Mason <slash.tmp@free.fr>
References: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
 <e868f9b8-39e3-4501-a8c6-64bd28a4be8b@sigmadesigns.com>
 <9975fa6c-f426-519b-6b3e-a2d102d36fd5@arm.com>
 <82d6bf37-96b9-cd9d-134b-f01638fa2b1b@sigmadesigns.com>
 <d39b5b3a-48be-7aaa-b7dd-28d4ae1d2083@arm.com>
 <49b4138d-0030-1e8c-6a14-0e9151b63d24@sigmadesigns.com>
 <1588fa00-92c6-046d-ccfc-9a2deae61486@arm.com>
 <08d84ce3-5345-dc69-bbc3-37372a3df22b@sigmadesigns.com>
Message-ID: <870f833b-6bff-b3b1-6591-7d46e374de66@sigmadesigns.com>
Date: Wed, 14 Jun 2017 11:19:04 +0200
MIME-Version: 1.0
In-Reply-To: <08d84ce3-5345-dc69-bbc3-37372a3df22b@sigmadesigns.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 14/06/2017 11:00, Marc Gonzalez wrote:

> The MSI controller in Tango supports 256 message-signaled interrupts,
> and a single doorbell address.
>=20
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
> Changes from v6 to v7
> o Call spin_lock() not spin_lock_irqsave() in the ISR
> ---
>  drivers/pci/host/pcie-tango.c | 225 ++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 225 insertions(+)

Someone on IRC suggested testing the driver with LOCKDEP.

If I understand the warning below correctly, I am not supposed
to call irq_domain_set_info() while holding used_msi_lock?

NB: in probe, my driver calls

=09add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);

This should not break LOCKDEP analysis, right?

Regards.


[    0.685615] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    0.685621] [ INFO: possible circular locking dependency detected ]
[    0.685632] 4.9.20-1-rc3 #2 Tainted: G          I   =20
[    0.685638] -------------------------------------------------------
[    0.685644] swapper/0/1 is trying to acquire lock:
[    0.685650]  (&(&pcie->used_msi_lock)->rlock){......}, at: [<c0352e5c>] =
update_msi_enable+0x2c/0x58

[    0.685692] but task is already holding lock:
[    0.685698]  (&irq_desc_lock_class){......}, at: [<c017586c>] __setup_ir=
q+0xa4/0x5f0

[    0.685718] which lock already depends on the new lock.
[    0.685718]=20
[    0.685725]=20
[    0.685725] the existing dependency chain (in reverse order) is:
[    0.685731]=20
[    0.685731] -> #1 (&irq_desc_lock_class){......}:
[    0.685758]        __irq_get_desc_lock+0x54/0x94
[    0.685768]        __irq_set_handler+0x24/0x54
[    0.685778]        irq_domain_set_info+0x38/0x4c
[    0.685786]        tango_irq_domain_alloc+0x98/0xbc
[    0.685795]        msi_domain_alloc+0x68/0x130
[    0.685802]        __irq_domain_alloc_irqs+0x11c/0x2ac
[    0.685809]        msi_domain_alloc_irqs+0x78/0x188
[    0.685816]        __pci_enable_msi_range+0x200/0x37c
[    0.685824]        pcie_port_device_register+0x3cc/0x494
[    0.685831]        pcie_portdrv_probe+0x2c/0xa4
[    0.685844]        pci_device_probe+0x8c/0xe8
[    0.685852]        driver_probe_device+0x1c8/0x2ac
[    0.685863]        bus_for_each_drv+0x60/0x94
[    0.685870]        __device_attach+0xb4/0x118
[    0.685883]        pci_bus_add_device+0x44/0x90
[    0.685891]        pci_bus_add_devices+0x3c/0x80
[    0.685898]        pci_host_common_probe+0x100/0x314
[    0.685906]        platform_drv_probe+0x50/0xb0
[    0.685912]        driver_probe_device+0x21c/0x2ac
[    0.685918]        __driver_attach+0xc0/0xc4
[    0.685926]        bus_for_each_dev+0x68/0x9c
[    0.685933]        bus_add_driver+0x108/0x214
[    0.685939]        driver_register+0x78/0xf4
[    0.685947]        do_one_initcall+0x44/0x174
[    0.685961]        kernel_init_freeable+0x158/0x1e8
[    0.685971]        kernel_init+0x8/0x10c
[    0.685980]        ret_from_fork+0x14/0x24
[    0.685985]=20
[    0.685985] -> #0 (&(&pcie->used_msi_lock)->rlock){......}:
[    0.686003]        _raw_spin_lock_irqsave+0x44/0x58
[    0.686012]        update_msi_enable+0x2c/0x58
[    0.686019]        irq_enable+0x30/0x44
[    0.686025]        irq_startup+0x80/0x84
[    0.686031]        __setup_irq+0x558/0x5f0
[    0.686038]        request_threaded_irq+0xe4/0x184
[    0.686044]        pcie_pme_probe+0xc4/0x1f0
[    0.686051]        pcie_port_probe_service+0x34/0x70
[    0.686057]        driver_probe_device+0x21c/0x2ac
[    0.686065]        bus_for_each_drv+0x60/0x94
[    0.686071]        __device_attach+0xb4/0x118
[    0.686079]        bus_probe_device+0x88/0x90
[    0.686085]        device_add+0x3f4/0x584
[    0.686092]        pcie_port_device_register+0x228/0x494
[    0.686099]        pcie_portdrv_probe+0x2c/0xa4
[    0.686106]        pci_device_probe+0x8c/0xe8
[    0.686113]        driver_probe_device+0x1c8/0x2ac
[    0.686120]        bus_for_each_drv+0x60/0x94
[    0.686126]        __device_attach+0xb4/0x118
[    0.686134]        pci_bus_add_device+0x44/0x90
[    0.686141]        pci_bus_add_devices+0x3c/0x80
[    0.686149]        pci_host_common_probe+0x100/0x314
[    0.686155]        platform_drv_probe+0x50/0xb0
[    0.686161]        driver_probe_device+0x21c/0x2ac
[    0.686167]        __driver_attach+0xc0/0xc4
[    0.686175]        bus_for_each_dev+0x68/0x9c
[    0.686182]        bus_add_driver+0x108/0x214
[    0.686188]        driver_register+0x78/0xf4
[    0.686194]        do_one_initcall+0x44/0x174
[    0.686203]        kernel_init_freeable+0x158/0x1e8
[    0.686210]        kernel_init+0x8/0x10c
[    0.686218]        ret_from_fork+0x14/0x24
[    0.686222]=20
[    0.686222] other info that might help us debug this:
[    0.686222]=20
[    0.686229]  Possible unsafe locking scenario:
[    0.686229]=20
[    0.686235]        CPU0                    CPU1
[    0.686239]        ----                    ----
[    0.686243]   lock(&irq_desc_lock_class);
[    0.686251]                                lock(&(&pcie->used_msi_lock)-=
>rlock);
[    0.686260]                                lock(&irq_desc_lock_class);
[    0.686267]   lock(&(&pcie->used_msi_lock)->rlock);
[    0.686275]=20
[    0.686275]  *** DEADLOCK ***
[    0.686275]=20
[    0.686283] 5 locks held by swapper/0/1:
[    0.686288]  #0:  (&dev->mutex){......}, at: [<c03939e4>] __driver_attac=
h+0x50/0xc4
[    0.686303]  #1:  (&dev->mutex){......}, at: [<c03939f4>] __driver_attac=
h+0x60/0xc4
[    0.686318]  #2:  (&dev->mutex){......}, at: [<c0393574>] __device_attac=
h+0x20/0x118
[    0.686333]  #3:  (&dev->mutex){......}, at: [<c0393574>] __device_attac=
h+0x20/0x118
[    0.686348]  #4:  (&irq_desc_lock_class){......}, at: [<c017586c>] __set=
up_irq+0xa4/0x5f0
[    0.686363]=20
[    0.686363] stack backtrace:
[    0.686373] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G          I     4.9.=
20-1-rc3 #2
[    0.686379] Hardware name: Sigma Tango DT
[    0.686398] [<c010f8a0>] (unwind_backtrace) from [<c010b540>] (show_stac=
k+0x10/0x14)
[    0.686411] [<c010b540>] (show_stack) from [<c0309f40>] (dump_stack+0x98=
/0xc4)
[    0.686423] [<c0309f40>] (dump_stack) from [<c0165ce4>] (print_circular_=
bug+0x214/0x334)
[    0.686432] [<c0165ce4>] (print_circular_bug) from [<c016934c>] (__lock_=
acquire+0x171c/0x1a28)
[    0.686441] [<c016934c>] (__lock_acquire) from [<c0169a28>] (lock_acquir=
e+0x6c/0x88)
[    0.686452] [<c0169a28>] (lock_acquire) from [<c0533004>] (_raw_spin_loc=
k_irqsave+0x44/0x58)
[    0.686464] [<c0533004>] (_raw_spin_lock_irqsave) from [<c0352e5c>] (upd=
ate_msi_enable+0x2c/0x58)
[    0.686475] [<c0352e5c>] (update_msi_enable) from [<c0177614>] (irq_enab=
le+0x30/0x44)
[    0.686484] [<c0177614>] (irq_enable) from [<c01776a8>] (irq_startup+0x8=
0/0x84)
[    0.686493] [<c01776a8>] (irq_startup) from [<c0175d20>] (__setup_irq+0x=
558/0x5f0)
[    0.686502] [<c0175d20>] (__setup_irq) from [<c0175f60>] (request_thread=
ed_irq+0xe4/0x184)
[    0.686511] [<c0175f60>] (request_threaded_irq) from [<c034fed0>] (pcie_=
pme_probe+0xc4/0x1f0)
[    0.686520] [<c034fed0>] (pcie_pme_probe) from [<c034d8a8>] (pcie_port_p=
robe_service+0x34/0x70)
[    0.686530] [<c034d8a8>] (pcie_port_probe_service) from [<c0393904>] (dr=
iver_probe_device+0x21c/0x2ac)
[    0.686540] [<c0393904>] (driver_probe_device) from [<c0391d18>] (bus_fo=
r_each_drv+0x60/0x94)
[    0.686550] [<c0391d18>] (bus_for_each_drv) from [<c0393608>] (__device_=
attach+0xb4/0x118)
[    0.686560] [<c0393608>] (__device_attach) from [<c0392b14>] (bus_probe_=
device+0x88/0x90)
[    0.686570] [<c0392b14>] (bus_probe_device) from [<c0390ef0>] (device_ad=
d+0x3f4/0x584)
[    0.686580] [<c0390ef0>] (device_add) from [<c034dba4>] (pcie_port_devic=
e_register+0x228/0x494)
[    0.686589] [<c034dba4>] (pcie_port_device_register) from [<c034e26c>] (=
pcie_portdrv_probe+0x2c/0xa4)
[    0.686600] [<c034e26c>] (pcie_portdrv_probe) from [<c0341ff0>] (pci_dev=
ice_probe+0x8c/0xe8)
[    0.686611] [<c0341ff0>] (pci_device_probe) from [<c03938b0>] (driver_pr=
obe_device+0x1c8/0x2ac)
[    0.686620] [<c03938b0>] (driver_probe_device) from [<c0391d18>] (bus_fo=
r_each_drv+0x60/0x94)
[    0.686630] [<c0391d18>] (bus_for_each_drv) from [<c0393608>] (__device_=
attach+0xb4/0x118)
[    0.686641] [<c0393608>] (__device_attach) from [<c03381fc>] (pci_bus_ad=
d_device+0x44/0x90)
[    0.686651] [<c03381fc>] (pci_bus_add_device) from [<c0338284>] (pci_bus=
_add_devices+0x3c/0x80)
[    0.686662] [<c0338284>] (pci_bus_add_devices) from [<c0352bf4>] (pci_ho=
st_common_probe+0x100/0x314)
[    0.686673] [<c0352bf4>] (pci_host_common_probe) from [<c03950dc>] (plat=
form_drv_probe+0x50/0xb0)
[    0.686682] [<c03950dc>] (platform_drv_probe) from [<c0393904>] (driver_=
probe_device+0x21c/0x2ac)
[    0.686690] [<c0393904>] (driver_probe_device) from [<c0393a54>] (__driv=
er_attach+0xc0/0xc4)
[    0.686700] [<c0393a54>] (__driver_attach) from [<c0391c70>] (bus_for_ea=
ch_dev+0x68/0x9c)
[    0.686711] [<c0391c70>] (bus_for_each_dev) from [<c0392d2c>] (bus_add_d=
river+0x108/0x214)
[    0.686721] [<c0392d2c>] (bus_add_driver) from [<c0394170>] (driver_regi=
ster+0x78/0xf4)
[    0.686730] [<c0394170>] (driver_register) from [<c01017dc>] (do_one_ini=
tcall+0x44/0x174)
[    0.686742] [<c01017dc>] (do_one_initcall) from [<c0800dc0>] (kernel_ini=
t_freeable+0x158/0x1e8)
[    0.686754] [<c0800dc0>] (kernel_init_freeable) from [<c052c918>] (kerne=
l_init+0x8/0x10c)
[    0.686765] [<c052c918>] (kernel_init) from [<c01077d0>] (ret_from_fork+=
0x14/0x24)

[    0.686824] pcieport 0000:00:00.0: Signaling PME through PCIe PME interr=
upt
[    0.686835] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    0.686849] pcie_pme 0000:00:00.0:pcie001: service driver pcie_pme loade=
d
[    0.687049] aer 0000:00:00.0:pcie002: service driver aer loaded
[    0.687276] pci 0000:01:00.0: enabling device (0140 -> 0142)
