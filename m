Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"Marsan, Luugi" <Luugi.Marsan@amd.com>
Subject: BUGZILLA [112941] - Cannot reenable SRIOV after disabling SRIOV on
 AMD GPU
Date: Tue, 23 Feb 2016 15:52:13 +0000
Message-ID: <CY1PR12MB0262D12DAC0897F8DC74541CFEA40@CY1PR12MB0262.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

As per our offline discussions I have created Bugzilla #112941 for the SRIOV issue.

When trying to enable SRIOV on AMD GPU after doing a previous enable / disable sequence the following warning is shown in dmesg.  I suspect that there might be something missing from the cleanup on the disable.  

I had a quick look at the code and it is checking for something in the iommu, something to do with being attached to a domain.  I am not familiar with this code yet (what does it mean to be attached to a domain?) so it might take a little while before I can get the time to check it out and understand it.

>From a quick glance I notice that during SRIOV enable the function do_attach()  in amd_iommu.c is called but during disable I don't see a corresponding call to do_detach (...).  
do_detach(...) is called in the second enable SRIOV  sequence as a cleanup because it thinks that the iommu is still attached which it shouldn't be (as far as I understand).

If the iommu reports that the device is being removed why isn't it also detached??? Is this by design or an omission?
I see the following in dmesg when I do a disable, note the device is removed.

[  131.674066] pci 0000:02:00.0: PME# disabled
[  131.682191] iommu: Removing device 0000:02:00.0 from group 2

Stack trace of warn is shown below.

[  368.510742] pci 0000:02:00.2: calling pci_fixup_video+0x0/0xb1
[  368.510847] pci 0000:02:00.3: [1002:692f] type 00 class 0x030000
[  368.510888] pci 0000:02:00.3: Max Payload Size set to 256 (was 128, max 256)
[  368.510907] pci 0000:02:00.3: calling quirk_no_pm_reset+0x0/0x1a
[  368.511005] vgaarb: device added: PCI:0000:02:00.3,decodes=io+mem,owns=none,locks=none
[  368.511421] ------------[ cut here ]------------
[  368.511426] WARNING: CPU: 1 PID: 3390 at drivers/pci/ats.c:85 pci_disable_ats+0x26/0xa4()
[  368.511428] Modules linked in: sriov(O) parport_pc ppdev bnep lp parport rfcomm bluetooth rfkill binfmt_misc nfsd auth_rpcgss oid_registry nfs_acl nfs lockd grace fscache sunrpc bridge stp llc loop hid_generic usbhid hid kvm_amd snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_hda_codec kvm snd_hda_core ohci_pci xhci_pci xhci_hcd snd_hwdep ohci_hcd acpi_cpufreq ehci_pci irqbypass ehci_hcd snd_pcm usbcore ghash_clmulni_intel tpm_tis drbg ansi_cprng sp5100_tco i2c_piix4 tpm aesni_intel i2c_core fam15h_power edac_mce_amd snd_seq snd_timer snd_seq_device snd soundcore k10temp edac_core aes_x86_64 usb_common ablk_helper wmi evdev cryptd pcspkr processor video lrw gf128mul glue_helper button ext4 crc16 mbcache jbd2 sg sd_mod ata_generic ahci libahci pata_atiixp sdhci_pci sdhci tg3 ptp libata crc32c_intel pps_core mmc_core libphy scsi_mod
[  368.511483] CPU: 1 PID: 3390 Comm: bash Tainted: G        W  O    4.5.0-rc3+ #2
[  368.511484] Hardware name: AMD BANTRY/Bantry, BIOS TBT4521N_03 05/21/2014
[  368.511486]  0000000000000000 ffff880840e8b948 ffffffff8124558c 0000000000000000
[  368.511490]  0000000000000009 ffff880840e8b988 ffffffff8105d643 ffff880840e8b998
[  368.511492]  ffffffff8128dd0a ffff88084034f000 ffff88084034f098 0000000000000292
[  368.511496] Call Trace:
[  368.511500]  [<ffffffff8124558c>] dump_stack+0x63/0x7f
[  368.511504]  [<ffffffff8105d643>] warn_slowpath_common+0x9c/0xb6
[  368.511507]  [<ffffffff8128dd0a>] ? pci_disable_ats+0x26/0xa4
[  368.511510]  [<ffffffff8105d672>] warn_slowpath_null+0x15/0x17
[  368.511513]  [<ffffffff8128dd0a>] pci_disable_ats+0x26/0xa4
[  368.511516]  [<ffffffff8147fed3>] ? _raw_write_unlock_irqrestore+0x20/0x34
[  368.511518]  [<ffffffff81328f9f>] detach_device+0x83/0x90
[  368.511520]  [<ffffffff81329067>] amd_iommu_attach_device+0x62/0x2eb
[  368.511523]  [<ffffffff81322e21>] __iommu_attach_device+0x1c/0x71
[  368.511525]  [<ffffffff8132418a>] iommu_group_add_device+0x260/0x300
[  368.511528]  [<ffffffff81323e6d>] ? pci_device_group+0xa6/0x10e
[  368.511530]  [<ffffffff813242ac>] iommu_group_get_for_dev+0x82/0xa0
[  368.511532]  [<ffffffff81326bb0>] amd_iommu_add_device+0x110/0x2c8
[  368.511534]  [<ffffffff81323149>] iommu_bus_notifier+0x30/0xa5
[  368.511537]  [<ffffffff81076134>] notifier_call_chain+0x32/0x5c
[  368.511541]  [<ffffffff8107626b>] __blocking_notifier_call_chain+0x41/0x5a
[  368.511544]  [<ffffffff81076293>] blocking_notifier_call_chain+0xf/0x11
[  368.511547]  [<ffffffff8133b01a>] device_add+0x38b/0x52a
[  368.511550]  [<ffffffff81271d32>] pci_device_add+0x25c/0x27c
[  368.511553]  [<ffffffff8128e69d>] pci_enable_sriov+0x44c/0x642
[  368.511557]  [<ffffffffa051471f>] sriov_enable+0x94/0xde [sriov]
[  368.511560]  [<ffffffffa05147bd>] cmd_sriov+0x54/0x8d [sriov]
[  368.511563]  [<ffffffffa0514352>] dev_write+0x95/0xb8 [sriov]
[  368.511566]  [<ffffffff81165577>] __vfs_write+0x23/0xa2
[  368.511570]  [<ffffffff811deeda>] ? security_file_permission+0x37/0x40
[  368.511573]  [<ffffffff81165fbe>] ? rw_verify_area+0x67/0xcc
[  368.511575]  [<ffffffff811668fe>] vfs_write+0x86/0xdc
[  368.511578]  [<ffffffff81166af0>] SyS_write+0x50/0x85
[  368.511632]  [<ffffffff814804ae>] entry_SYSCALL_64_fastpath+0x12/0x71
[  368.511634] ---[ end trace 69e2140f488cb003 ]---

Thanks,
Kelly
