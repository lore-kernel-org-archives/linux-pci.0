Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933455AbdIHNbF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Sep 2017 09:31:05 -0400
Date: Fri, 8 Sep 2017 15:31:00 +0200
From: Radim Krcmar <rkrcmar@redhat.com>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: Mason <slash.tmp@free.fr>, linux-pci@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: AVIC warning - what does it mean?
Message-ID: <20170908133100.GA7160@flask>
References: <524102f8-8879-2ed2-3dcb-3162df9062b6@01019freenet.de>
 <48591d55-ba2f-9960-85ba-d2bede0b7aac@free.fr>
 <9d8c90a5-49a7-ce06-9c41-fa067e359b97@maya.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <9d8c90a5-49a7-ce06-9c41-fa067e359b97@maya.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2017-09-08 13:23+0200, Andreas Hartmann:
> On 09/08/2017 at 12:58 PM Mason wrote:
> > On 08/09/2017 11:58, Andreas Hartmann wrote:
> > 
> >> If AVIC is enabled, I'm usually getting one warning like the one below a
> >> few minutes after the VM has been started.
> >>
> >> What does it mean?
> >>
> >> There isn't any problem with that VM - it's just working as expected. If
> >> AVIC is disabled, the warning doesn't come up and the VM works fine, too.
> >>
> >> Base is a Ryzen system (RMA'd CPU w/o gcc segfaults meanwhile and X370
> >> chipset (ASUS Prime X370-PRO with Bios 0810)). Linux is 4.9.48.
> >>
> >>
> >> [ 1603.482692] ------------[ cut here ]------------
> >> [ 1603.482702] WARNING: CPU: 1 PID: 2936 at ../arch/x86/kvm/svm.c:1484 avic_vcpu_load+0x162/0x190 [kvm_amd]
> >> [ 1603.482703] Modules linked in: sr_mod cdrom uas usb_storage vhost_net tun vhost macvtap macvlan igb dca nf_log_ipv4 nf_log_common xt_LOG ipt_REJECT nf_reject_ipv4 xt_tcpudp nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack iptable_filter ip_tables x_tables vfio_pci vfio_iommu_type1 vfio_virqfd vfio br_netfilter bridge stp llc iscsi_ibft iscsi_boot_sysfs snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep kvm_amd snd_pcm eeepc_wmi asus_wmi kvm sparse_keymap snd_seq rfkill video snd_seq_device mxm_wmi irqbypass snd_timer sp5100_tco i2c_piix4 snd pcspkr e1000e soundcore ptp pps_core fjes pinctrl_amd gpio_amdpt acpi_cpufreq gpio_generic 8250_dw tpm_tis shpchp i2c_designware_platform wmi i2c_designware_core tpm_tis_core button tpm nfsd auth_rp
> >>   cgss nfs_acl
> >> [ 1603.482740]  lockd grace sunrpc xfs libcrc32c dm_crypt algif_skcipher af_alg hid_generic usbhid raid1 md_mod amdkfd amd_iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel radeon i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm serio_raw drm ccp xhci_pci xhci_hcd usbcore aesni_intel aes_x86_64 glue_helper lrw ablk_helper cryptd ata_generic pata_atiixp dm_mirror dm_region_hash dm_log sg thermal dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
> >> [ 1603.482766] CPU: 1 PID: 2936 Comm: CPU 2/KVM Not tainted 4.9.48-1.1-default #1
> >> [ 1603.482767] Hardware name: System manufacturer System Product Name/PRIME X370-PRO, BIOS 0810 08/01/2017
> >> [ 1603.482768]  ffffab614aa4fcb8 ffffffff893c14fa 0000000000000000 0000000000000000
> >> [ 1603.482772]  ffffab614aa4fcf8 ffffffff89085da1 000005cc004b6f7f 0000000000000001
> >> [ 1603.482774]  c0000007ea4bc001 0000000000000001 000001753dd1e17d ffff9e84ea7e0140
> >> [ 1603.482776] Call Trace:
> >> [ 1603.482798]  [<ffffffff893c14fa>] dump_stack+0x63/0x89
> >> [ 1603.482804]  [<ffffffff89085da1>] __warn+0xd1/0xf0
> >> [ 1603.482809]  [<ffffffff89085e8d>] warn_slowpath_null+0x1d/0x20
> >> [ 1603.482813]  [<ffffffffc15ade42>] avic_vcpu_load+0x162/0x190 [kvm_amd]
> >> [ 1603.482849]  [<ffffffffc0950da4>] ? kvm_cpu_has_interrupt+0x44/0x50 [kvm]
> >> [ 1603.482852]  [<ffffffffc15ae138>] svm_vcpu_unblocking+0x18/0x20 [kvm_amd]
> >> [ 1603.482868]  [<ffffffffc091b424>] kvm_vcpu_block+0xc4/0x310 [kvm]
> >> [ 1603.482889]  [<ffffffffc0937fac>] kvm_arch_vcpu_ioctl_run+0x19c/0x400 [kvm]
> >> [ 1603.482906]  [<ffffffffc091cc42>] kvm_vcpu_ioctl+0x312/0x5e0 [kvm]
> >> [ 1603.482913]  [<ffffffff8910d10f>] ? do_futex+0x10f/0x510
> >> [ 1603.482916]  [<ffffffff8923ec06>] do_vfs_ioctl+0x96/0x5b0
> >> [ 1603.482921]  [<ffffffff89249767>] ? __fget+0x77/0xb0
> >> [ 1603.482922]  [<ffffffff8923f199>] SyS_ioctl+0x79/0x90
> >> [ 1603.482927]  [<ffffffff8900393b>] do_syscall_64+0x5b/0xd0
> >> [ 1603.482932]  [<ffffffff89719c2f>] entry_SYSCALL64_slow_path+0x25/0x25
> >> [ 1603.484799] ---[ end trace d24b045704bb6ae7 ]---
> > 
> > For what it's worth...
> > 
> > http://elixir.free-electrons.com/linux/v4.9.48/source/arch/x86/kvm/svm.c#L1484
> > 
> >     entry = READ_ONCE(*(svm->avic_physical_id_cache));
> >     WARN_ON(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK);
> > 
> > Added by commit 8221c13700561
> > 
> >     svm: Manage vcpu load/unload when enable AVIC
> >         When a vcpu is loaded/unloaded to a physical core, we need to update
> >     host physical APIC ID information in the Physical APIC-ID table
> >     accordingly.
> >         Also, when vCPU is blocking/un-blocking (due to halt instruction),
> >     we need to make sure that the is-running bit in set accordingly in the
> >     physical APIC-ID table.
> 
> Thanks - I already found this - but I don't know how to estimate it. 
> 
> Should I worry about? Or is it just informative? As it is working 
> afterwards the same as before, it probably isn't critical? 
> Could the WARN_ON be removed?

I'm thinking this happens if the VCPU is preempted in avic_set_running()
after 'svm->avic_is_running = true' and before avic_vcpu_load().
avic_vcpu_load() is then called from both avic_set_running() and
svm_vcpu_load().

The warning does not reveal any harmful bug.  Disabling preemption in
avic_set_running() would allow us to keep the protective warning.
(It seems to be slightly better than remembeging and restoring the avic
 state on sched out/in.)

Can you try the following patch?

Thanks.


diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 968f38dcb864..6b123f375d66 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1572,11 +1572,15 @@ static void avic_set_running(struct kvm_vcpu *vcpu, bool is_run)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	preempt_disable();
+
 	svm->avic_is_running = is_run;
 	if (is_run)
 		avic_vcpu_load(vcpu, vcpu->cpu);
 	else
 		avic_vcpu_put(vcpu);
+
+	preempt_enable();
 }
 
 static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
