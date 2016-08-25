Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 25 Aug 2016 13:09:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Po Liu <po.liu@nxp.com>
Subject: Re: [PATCH v1] arm64:pci: fix the IOV device enabled crash issue in
 designware
Message-ID: <20160825180935.GD11257@localhost>
References: <1471932072-6980-1-git-send-email-po.liu@nxp.com>
 <20160824205059.GG23914@localhost>
 <VI1PR0401MB1709E238FDD324547EE8B13D92ED0@VI1PR0401MB1709.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <VI1PR0401MB1709E238FDD324547EE8B13D92ED0@VI1PR0401MB1709.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Roy Zang <roy.zang@nxp.com>,
 Arnd Bergmann <arnd@arndb.de>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Pratyush Anand <pratyush.anand@gmail.com>, Stuart Yoder <stuart.yoder@nxp.com>,
 Yang-Leo Li <leoyang.li@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Ley Foon Tan <lftan@altera.com>, Michal Simek <michal.simek@xilinx.com>,
 S?ren Brinkmann <soren.brinkmann@xilinx.com>
Content-Type: text/plain; charset="iso-8859-1"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 25, 2016 at 04:53:19AM +0000, Po Liu wrote:
> >  -----Original Message-----
> >  From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> >  Sent: Thursday, August 25, 2016 4:51 AM
> >  To: Po Liu
> >  Cc: linux-pci@vger.kernel.org; Roy Zang; Arnd Bergmann; Stuart Yoder;
> >  Yang-Leo Li; linux-arm-kernel@lists.infradead.org; Bjorn Helgaas;
> >  Mingkai Hu; Ley Foon Tan; Michal Simek; S=F6ren Brinkmann; Jingoo Han;
> >  Pratyush Anand
> >  Subject: Re: [PATCH v1] arm64:pci: fix the IOV device enabled crash
> >  issue in designware
> >  =

> >  [+cc Jingoo, Pratyush, Michal, S=F6ren, Ley]
> >  =

> >  On Tue, Aug 23, 2016 at 02:01:12PM +0800, Po Liu wrote:
> >  > When echo a number to /sys/bus/pci/devices/xxx/sriov_numvfs to enable
> >  > the VF devices. A crash log occurred. This found to be access the IOV
> >  > devices config space failure issue.
> >  =

> >  What was the actual crash?  The mere fact that we made a config read
> >  fail should not cause a crash.  We might erroneously prevent access to
> >  VF devices, but it shouldn't crash.  So maybe there's another bug
> >  elsewhere that we should fix first.
> =

> I built with CONFIG_PCI_IOV=3Dy and notice a crash when I use it:
> =

> centqds-60 cd /sys/class/net/
> centqds-61 ls
> enP1p1s0@ enP2p1s0f0@ enP2p1s0f1@ lo@ sit0@
> centqds-62 cd enP2p1s0f1/device
> centqds-63 ls
> broken_parity_status driver_override msi_irqs/ sriov_numvfs
> class enable net/ sriov_totalvfs
> config iommu_group@ power/ subsystem@
> consistent_dma_mask_bits irq remove subsystem_device
> device local_cpulist rescan subsystem_vendor
> devspec local_cpus reset uevent
> dma_mask_bits modalias resource vendor
> driver@ msi_bus rom
> centqds-64 zcat /proc/config.gz | grep _IOV
> CONFIG_PCI_IOV=3Dy
> centqds-65 sudo su
> [root@centqds 0002:01:00.1]# echo 2 > sriov_numvfs
> [ 317.604543] ixgbe 0002:01:00.1 enP2p1s0f1: SR-IOV enabled with 2 VFs
> [ 317.714431] (null): of_irq_parse_pci() failed with rc=3D134


> [ 317.719906] -----------[ cut here ]-----------
> [ 317.724525] WARNING: CPU: 6 PID: 3179 at drivers/pci/probe.c:1555 pci_d=
evice_add+0x144/0x148()
> [ 317.733123] Modules linked in:
> [ 317.736175] CPU: 6 PID: 3179 Comm: bash Not tainted 4.1.8-00024-g0a32d6=
5-dirty #32
> [ 317.743731] Hardware name: Freescale Layerscape 2088a QDS Board (DT)
> [ 317.750077] Call trace:
> [ 317.752516] [<fffffe0000096cf8>] dump_backtrace+0x0/0x12c
> Message from[ 317.757916] [<fffffe0000096e34>] show_stack+0x10/0x1c
> syslogd@centqds[ 317.764341] [<fffffe00008937fc>] dump_stack+0x84/0xd4
> at Jul 26 15:51[ 317.770770] [<fffffe00000be590>] warn_slowpath_common+0x=
94/0xcc
> :10 ...
> kerne[ 317.778067] [<fffffe00000be68c>] warn_slowpath_null+0x14/0x20
> l:Call trace:
> [ 317.785192] [<fffffe00003c5fa4>] pci_device_add+0x140/0x148
> [ 317.792133] [<fffffe00003de784>] pci_enable_sriov+0x470/0x7a0
> [ 317.797873] [<fffffe00005fa9dc>] ixgbe_pci_sriov_configure+0x8c/0x148
> [ 317.804302] [<fffffe00003cf354>] sriov_numvfs_store+0x78/0x11c
> [ 317.810129] [<fffffe0000443d80>] dev_attr_store+0x14/0x28
> [ 317.815521] [<fffffe0000200164>] sysfs_kf_write+0x40/0x4c
> [ 317.820908] [<fffffe00001ff5ec>] kernfs_fop_write+0xb8/0x180
> [ 317.826561] [<fffffe000019a568>] __vfs_write+0x28/0x10c
> [ 317.831775] [<fffffe000019ad00>] vfs_write+0x90/0x1a0
> [ 317.836819] [<fffffe000019b584>] SyS_write+0x40/0xa0
> [ 317.841772] --[ end trace 83725a9784fd702a ]--
> [ 317.846393] BUG: failure at fs/sysfs/file.c:481/sysfs_create_bin_file()!
> [ 317.853081] Kernel panic - not syncing: BUG!
> [ 317.857339] CPU: 6 PID: 3179 Comm: bash Tainted: G W 4.1.8-00024-g0a32d=
65-dirty #32
> [ 317.866110] Hardware name: Freescale Layerscape 2088a QDS Board (DT)
> [ 317.872451] Call trace:
> [ 317.874887] [<fffffe0000096cf8>] dump_backtrace+0x0/0x12c
> [ 317.880274] [<fffffe0000096e34>] show_stack+0x10/0x1c
> [ 317.885315] [<fffffe00008937fc>] dump_stack+0x84/0xd4
> [ 317.890354] [<fffffe00008909e8>] panic+0xe4/0x21c
> [ 317.895047] [<fffffe0000200988>] sysfs_create_bin_file+0x60/0x64
> [ 317.901041] [<fffffe00003cf52c>] pci_create_sysfs_dev_files+0x48/0x2a8
> [ 317.907556] [<fffffe00003c4238>] pci_bus_add_device+0x20/0x6c
> =

> The code process is that: "echo 2 > sriov_numvf" makes driver load .sriov=
_configure. At last to load pci_enable_sriov().
> The first time vf device operate the config space in the pci_setup_device=
() (this function was load in the virtfn_add()) is pci_read_config_byte(dev=
, PCI_HEADER_TYPE, &hdr_type) return failure. So the virtfn didn't initiali=
zed proper.
> =

> This found to be "bus->primary =3D=3D pp->root_bus_nr && dev > 0" then re=
turn failure in host controller. The dev came from devfn must not zero(is a=
bout 0x10).
> =

> then read config space failure. This makes the dev->bus is NULL. Lead to =
upper crash.

I think the crash (BUG: failure at fs/sysfs/file.c:481/sysfs_create_bin_fil=
e())
happens in this path:

  sriov_numvfs_store
    ixgbe_pci_sriov_configure
      ixgbe_pci_sriov_enable
        pci_enable_sriov
          sriov_enable
            pci_iov_add_virtfn
              virtfn =3D pci_alloc_dev()
              pci_setup_device(virtfn)
                if (pci_read_config_byte(dev, PCI_HEADER_TYPE, &hdr_type))
                  return -EIO
              pci_bus_add_device(virtfn)
                pci_create_sysfs_dev_files
                  sysfs_create_bin_file
                    BUG_ON(!kobj)

If the config read of PCI_HEADER_TYPE fails, pci_setup_device() returns
-EIO, but pci_iov_add_virtfn() doesn't check it.  Can you update
pci_iov_add_virtfn() so it checks that return value?  That should fix the
crash, even without your designware patch.

Obviously, it won't make SR-IOV work, so we still need both patches.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
