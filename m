Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:52267 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdJDSJW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Oct 2017 14:09:22 -0400
Received: by mail-qt0-f177.google.com with SMTP id o52so20852624qtc.9
        for <linux-pci@vger.kernel.org>; Wed, 04 Oct 2017 11:09:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1f6c8249-0684-b988-02b5-60680741f7db@mellanox.com>
References: <1f6c8249-0684-b988-02b5-60680741f7db@mellanox.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 4 Oct 2017 13:09:00 -0500
Message-ID: <CAErSpo7DPoAxTTSyCc--0QNw9L8c=ZyjYK40ypMHzObP_e3zqg@mail.gmail.com>
Subject: Re: Issue caused by "Dont update VF BARs while VF memory space is enabled"
To: Huy Nguyen <huyn@mellanox.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This sounds like a regression.  Can you please repost this as a
plain-text email so linux-pci doesn't reject it (see
http://vger.kernel.org/majordomo-info.html)?

546ba9f8f22f ("PCI: Don't update VF BARs while VF memory space is
enabled") appeared in v4.10, so v4.9 should work and v4.10 is broken.
Please verify that.

There have been some recent changes that might have fixed this.  For
example, 0fc690a7c3f7 ("PCI: Disable VF decoding before
pcibios_sriov_disable() updates resources") appeared in v4.14-rc1.
Can you test that?

Bjorn

On Wed, Oct 4, 2017 at 11:44 AM, Huy Nguyen <huyn@mellanox.com> wrote:
> Dear Bjorn and Gavin,
>
> Would you please look at the below issue?
>
>
>
> Mellanox experiences this warning on PowerPC when disable the sriov on our
> NIC. Please see the below trace for more details.
>
>     mlx5_core 0002:01:00.0: can't update enabled VF BAR0
>
>
>
> The warning is caused by this check in "pci_iov_update_resource". This is
> committed on Nov, 28, 2016 in commit id
> 546ba9f8f22f71b0202b6ba8967be5cc6dae4e21 by Bjorn Helgaas
> <bhelgaas@google.com> reviewed by Gavin Shan <gwshan@linux.vnet.ibm.com>
>
> if ((cmd & PCI_SRIOV_CTRL_VFE) && (cmd & PCI_SRIOV_CTRL_MSE)) {
>
> dev_WARN(&dev->dev, "can't update enabled VF BAR%d %pR\n",
>
>  vf_bar, res);
>
> return;
>
> }
>
>
>
> PowerPC has the architecture specific implementation for
> "pcibios_sriov_disable". This function is called before the VFE and the MSE
> bits are disabled in "sriov_disable" function. The function was checked in
> a8b2f8288a3fdef8d93efef2b1ead7563004275e on 03/25/2015 by Gavin Shan.
>
>
>
> Trace
>
> root@powerqa-9140:~# echo '16' >
> /sys/bus/pci/devices/0002:01:00.0/sriov_numvfs
>
> root@powerqa-9140:~# echo '0' >
> /sys/bus/pci/devices/0002:01:00.0/sriov_numvfs
>
>
>
> root@powerqa-9140:~# dmesg
>
> ....
>
> [  899.436536] mlx5_core 0002:01:00.0: VF BAR0: [mem
> 0x24000a000000-0x2401ffffffff 64bit pref] shifted to [mem
> 0x240000000000-0x2401ffffffff 64bit pref] (Disabling 16 VFs shifted by -5)
>
> [  899.436550] mlx5_core 0002:01:00.0: can't update enabled VF BAR0 [mem
> 0x240000000000-0x2401ffffffff 64bit pref]
>
> [  899.436567] ------------[ cut here ]------------
>
> [  899.436575] WARNING: CPU: 104 PID: 9408 at
> /build/linux-SKvs47/linux-4.10.0/drivers/pci/iov.c:584
> pci_iov_update_resource+0x178/0x1d0
>
> [  899.436576] Modules linked in: xt_CHECKSUM iptable_mangle ipt_MASQUERADE
> nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat libcrc32c
> nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT
> nf_reject_ipv4 xt_tcpudp kvm_hv kvm_pr kvm ebtable_filter ebtables
> ip6table_filter ip6_tables iptable_filter rdma_ucm(OE) ib_ucm(OE)
> rdma_cm(OE) iw_cm(OE) configfs ib_ipoib(OE) ib_cm(OE) ib_uverbs(OE)
> ib_umad(OE) mlx5_fpga_tools(OE) mlx5_ib(OE) mlx4_ib(OE) ib_core(OE)
> binfmt_misc vmx_crypto ofpart ipmi_powernv cmdlinepart ipmi_devintf
> powernv_flash ibmpowernv ipmi_msghandler mtd at24 nvmem_core opal_prd
> powernv_rng input_leds joydev mac_hid uio_pdrv_genirq uio bridge stp llc
> nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables x_tables autofs4
> mlx4_en(OE) hid_generic usbhid hid uas usb_storage
>
> [  899.436639]  ast i2c_algo_bit ttm drm_kms_helper crc32c_vpmsum
> syscopyarea sysfillrect sysimgblt fb_sys_fops drm ahci mlx4_core(OE)
> mlx5_core(OE) libahci tg3 mlxfw(OE) devlink mlx_compat(OE)
>
> [  899.436658] CPU: 104 PID: 9408 Comm: bash Tainted: G           OE
> 4.10.0-35-generic #39-Ubuntu
>
> [  899.436660] task: c00000193e8f7000 task.stack: c00000193e928000
>
> [  899.436662] NIP: c000000000689848 LR: c000000000689844 CTR:
> 0000000000000000
>
> [  899.436663] REGS: c00000193e92b5a0 TRAP: 0700   Tainted: G           OE
> (4.10.0-35-generic)
>
> [  899.436664] MSR: 900000000282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>
>
> [  899.436672]   CR: 42424422  XER: 20000000
>
> [  899.436673] CFAR: c000000000b5f934 SOFTE: 1
>
>                GPR00: c000000000689844 c00000193e92b820 c00000000145c800
> 0000000000000063
>
>                GPR04: 0000000000000001 00000000000004e3 c000001fff070000
> 000000000001cd18
>
>                GPR08: 0000000000000007 0000000000000007 0000000000000001
> 656d5b2030524142
>
>                GPR12: 0000000000004400 c00000000fbba800 0000000010180df8
> 0000000010189e60
>
>                GPR16: 0000000010189ed8 0000000010151270 c000001e11babc00
> c000001fff24dee0
>
>                GPR20: c000001fff24df80 c000000000d6fd20 c000000000d628a0
> c000000000d6f1d0
>
>                GPR24: c000000000d6f1d8 c000001e3672a098 fffffffffffffffb
> 0000000000000000
>
>                GPR28: c000001e36655f00 0000000000000000 c000001e3672a578
> c000001e3672a000
>
> [  899.436701] NIP [c000000000689848] pci_iov_update_resource+0x178/0x1d0
>
> [  899.436704] LR [c000000000689844] pci_iov_update_resource+0x174/0x1d0
>
> [  899.436705] Call Trace:
>
> [  899.436708] [c00000193e92b820] [c000000000689844]
> pci_iov_update_resource+0x174/0x1d0 (unreliable)
>
> [  899.436712] [c00000193e92b8d0] [c000000000673de4]
> pci_update_resource+0x94/0x2e0
>
> [  899.436716] [c00000193e92b990] [c000000000095f60]
> pnv_pci_vf_resource_shift+0x1c0/0x260
>
> [  899.436719] [c00000193e92ba80] [c00000000009bb38]
> pnv_pci_sriov_disable+0x2e8/0x2f0
>
> [  899.436722] [c00000193e92bb50] [c00000000009c448]
> pcibios_sriov_disable+0x28/0x50
>
> [  899.436725] [c00000193e92bb80] [c000000000688eac]
> pci_disable_sriov+0xac/0x1b0
>
> [  899.436747] [c00000193e92bbc0] [d000000012f9f7f0]
> mlx5_core_sriov_configure+0x68/0x2f0 [mlx5_core]
>
> [  899.436750] [c00000193e92bc50] [c000000000672104]
> sriov_numvfs_store+0x134/0x1a0
>
> [  899.436753] [c00000193e92bce0] [c000000000749d7c]
> dev_attr_store+0x3c/0x60
>
> [  899.436757] [c00000193e92bd00] [c000000000404638]
> sysfs_kf_write+0x68/0xa0
>
> [  899.436759] [c00000193e92bd20] [c0000000004034cc]
> kernfs_fop_write+0x17c/0x250
>
> [  899.436763] [c00000193e92bd70] [c00000000034624c] __vfs_write+0x3c/0x70
>
> [  899.436766] [c00000193e92bd90] [c000000000347cd4] vfs_write+0xd4/0x240
>
> [  899.436769] [c00000193e92bde0] [c000000000349888] SyS_write+0x68/0x110
>
> [  899.436773] [c00000193e92be30] [c00000000000b184] system_call+0x38/0xe0
>
> [  899.436774] Instruction dump:
>
> [  899.436776] 480c2231 60000000 e8bf00e8 7c641b78 2fa50000 419e0024
> 3c62ff98 7fc7f378
>
> [  899.436782] 7f66db78 3863ff18 484d6095 60000000 <0fe00000> 4bffff20
> e8bf00a8 4bffffdc
>
> [  899.436788] ---[ end trace 568fdcef5fefb499 ]---
>
>
>
>
