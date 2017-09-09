Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout2.freenet.de ([195.4.92.92]:46064 "EHLO mout2.freenet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756862AbdIILL7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 Sep 2017 07:11:59 -0400
From: Andreas Hartmann <andihartmann@01019freenet.de>
Subject: Re: AVIC warning - what does it mean?
To: Radim Krcmar <rkrcmar@redhat.com>
Cc: Mason <slash.tmp@free.fr>, linux-pci@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <524102f8-8879-2ed2-3dcb-3162df9062b6@01019freenet.de>
 <48591d55-ba2f-9960-85ba-d2bede0b7aac@free.fr>
 <9d8c90a5-49a7-ce06-9c41-fa067e359b97@maya.org> <20170908133100.GA7160@flask>
Message-ID: <c41cc17a-6bcf-ce1e-aa40-0dc14afb2fc6@01019freenet.de>
Date: Sat, 9 Sep 2017 13:09:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170908133100.GA7160@flask>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Radim,

I tested your patch against 4.12.11 and 4.9.47. The warnings are gone.

But there is a side effect I faced during testing with netperf: The
tests with a passed through GB Ethernet interface showed massive
performance reduction (until 50% during a test period of about 10
minutes - each run repeatedly 10 seconds: TCP_STREAM / TCP_MAERTS /
TCP_SENDFILE).

I even could see rx overruns.

W/o the patch, the performance is flaky, too, but not as bad as with the patch.

Best is to disable AVIC at all. There are no overruns and throughput is
always between 105 and 112 MBytes/s as expected.

The big question therefore is: why should I use AVIC?

Passed through interface (as seen by VM):

00:06.0 Ethernet controller: Intel Corporation I211 Gigabit Network Connection (rev 03)
        Subsystem: ASUSTeK Computer Inc. Device 85f0
        Physical Slot: 6
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at febc0000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at c0a0 [size=32]
        Region 3: Memory at febf0000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [70] MSI-X: Enable+ Count=5 Masked-
                Vector table: BAR=3 offset=00000000
                PBA: BAR=3 offset=00002000
        Capabilities: [a0] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0.000W
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #6, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <2us, L1 <16us
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Kernel driver in use: igb
        Kernel modules: igb


VM: Centos 7


Thanks,
kind regards,
Andreas


On 09/08/2017 at 03:31 PM Radim Krcmar wrote:
> 2017-09-08 13:23+0200, Andreas Hartmann:
>> On 09/08/2017 at 12:58 PM Mason wrote:
>>> On 08/09/2017 11:58, Andreas Hartmann wrote:
>>>
>>>> If AVIC is enabled, I'm usually getting one warning like the one below a
>>>> few minutes after the VM has been started.
>>>>
>>>> What does it mean?
>>>>
>>>> There isn't any problem with that VM - it's just working as expected. If
>>>> AVIC is disabled, the warning doesn't come up and the VM works fine, too.
>>>>
>>>> Base is a Ryzen system (RMA'd CPU w/o gcc segfaults meanwhile and X370
>>>> chipset (ASUS Prime X370-PRO with Bios 0810)). Linux is 4.9.48.
>>>>
>>>>
>>>> [ 1603.482692] ------------[ cut here ]------------
>>>> [ 1603.482702] WARNING: CPU: 1 PID: 2936 at ../arch/x86/kvm/svm.c:1484 avic_vcpu_load+0x162/0x190 [kvm_amd]
>>>> [ 1603.482703] Modules linked in: sr_mod cdrom uas usb_storage vhost_net tun vhost macvtap macvlan igb dca nf_log_ipv4 nf_log_common xt_LOG ipt_REJECT nf_reject_ipv4 xt_tcpudp nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack iptable_filter ip_tables x_tables vfio_pci vfio_iommu_type1 vfio_virqfd vfio br_netfilter bridge stp llc iscsi_ibft iscsi_boot_sysfs snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep kvm_amd snd_pcm eeepc_wmi asus_wmi kvm sparse_keymap snd_seq rfkill video snd_seq_device mxm_wmi irqbypass snd_timer sp5100_tco i2c_piix4 snd pcspkr e1000e soundcore ptp pps_core fjes pinctrl_amd gpio_amdpt acpi_cpufreq gpio_generic 8250_dw tpm_tis shpchp i2c_designware_platform wmi i2c_designware_core tpm_tis_core button tpm nfsd auth_rp
>>>>   cgss nfs_acl
>>>> [ 1603.482740]  lockd grace sunrpc xfs libcrc32c dm_crypt algif_skcipher af_alg hid_generic usbhid raid1 md_mod amdkfd amd_iommu_v2 crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel radeon i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm serio_raw drm ccp xhci_pci xhci_hcd usbcore aesni_intel aes_x86_64 glue_helper lrw ablk_helper cryptd ata_generic pata_atiixp dm_mirror dm_region_hash dm_log sg thermal dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua
>>>> [ 1603.482766] CPU: 1 PID: 2936 Comm: CPU 2/KVM Not tainted 4.9.48-1.1-default #1
>>>> [ 1603.482767] Hardware name: System manufacturer System Product Name/PRIME X370-PRO, BIOS 0810 08/01/2017
>>>> [ 1603.482768]  ffffab614aa4fcb8 ffffffff893c14fa 0000000000000000 0000000000000000
>>>> [ 1603.482772]  ffffab614aa4fcf8 ffffffff89085da1 000005cc004b6f7f 0000000000000001
>>>> [ 1603.482774]  c0000007ea4bc001 0000000000000001 000001753dd1e17d ffff9e84ea7e0140
>>>> [ 1603.482776] Call Trace:
>>>> [ 1603.482798]  [<ffffffff893c14fa>] dump_stack+0x63/0x89
>>>> [ 1603.482804]  [<ffffffff89085da1>] __warn+0xd1/0xf0
>>>> [ 1603.482809]  [<ffffffff89085e8d>] warn_slowpath_null+0x1d/0x20
>>>> [ 1603.482813]  [<ffffffffc15ade42>] avic_vcpu_load+0x162/0x190 [kvm_amd]
>>>> [ 1603.482849]  [<ffffffffc0950da4>] ? kvm_cpu_has_interrupt+0x44/0x50 [kvm]
>>>> [ 1603.482852]  [<ffffffffc15ae138>] svm_vcpu_unblocking+0x18/0x20 [kvm_amd]
>>>> [ 1603.482868]  [<ffffffffc091b424>] kvm_vcpu_block+0xc4/0x310 [kvm]
>>>> [ 1603.482889]  [<ffffffffc0937fac>] kvm_arch_vcpu_ioctl_run+0x19c/0x400 [kvm]
>>>> [ 1603.482906]  [<ffffffffc091cc42>] kvm_vcpu_ioctl+0x312/0x5e0 [kvm]
>>>> [ 1603.482913]  [<ffffffff8910d10f>] ? do_futex+0x10f/0x510
>>>> [ 1603.482916]  [<ffffffff8923ec06>] do_vfs_ioctl+0x96/0x5b0
>>>> [ 1603.482921]  [<ffffffff89249767>] ? __fget+0x77/0xb0
>>>> [ 1603.482922]  [<ffffffff8923f199>] SyS_ioctl+0x79/0x90
>>>> [ 1603.482927]  [<ffffffff8900393b>] do_syscall_64+0x5b/0xd0
>>>> [ 1603.482932]  [<ffffffff89719c2f>] entry_SYSCALL64_slow_path+0x25/0x25
>>>> [ 1603.484799] ---[ end trace d24b045704bb6ae7 ]---
>>>
>>> For what it's worth...
>>>
>>> http://elixir.free-electrons.com/linux/v4.9.48/source/arch/x86/kvm/svm.c#L1484
>>>
>>>     entry = READ_ONCE(*(svm->avic_physical_id_cache));
>>>     WARN_ON(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK);
>>>
>>> Added by commit 8221c13700561
>>>
>>>     svm: Manage vcpu load/unload when enable AVIC
>>>         When a vcpu is loaded/unloaded to a physical core, we need to update
>>>     host physical APIC ID information in the Physical APIC-ID table
>>>     accordingly.
>>>         Also, when vCPU is blocking/un-blocking (due to halt instruction),
>>>     we need to make sure that the is-running bit in set accordingly in the
>>>     physical APIC-ID table.
>>
>> Thanks - I already found this - but I don't know how to estimate it. 
>>
>> Should I worry about? Or is it just informative? As it is working 
>> afterwards the same as before, it probably isn't critical? 
>> Could the WARN_ON be removed?
> 
> I'm thinking this happens if the VCPU is preempted in avic_set_running()
> after 'svm->avic_is_running = true' and before avic_vcpu_load().
> avic_vcpu_load() is then called from both avic_set_running() and
> svm_vcpu_load().
> 
> The warning does not reveal any harmful bug.  Disabling preemption in
> avic_set_running() would allow us to keep the protective warning.
> (It seems to be slightly better than remembeging and restoring the avic
>  state on sched out/in.)
> 
> Can you try the following patch?
> 
> Thanks.
> 
> 
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 968f38dcb864..6b123f375d66 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -1572,11 +1572,15 @@ static void avic_set_running(struct kvm_vcpu *vcpu, bool is_run)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  
> +	preempt_disable();
> +
>  	svm->avic_is_running = is_run;
>  	if (is_run)
>  		avic_vcpu_load(vcpu, vcpu->cpu);
>  	else
>  		avic_vcpu_put(vcpu);
> +
> +	preempt_enable();
>  }
>  
>  static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
> 
