Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:56236 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756000Ab3DXRLA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2013 13:11:00 -0400
Received: by mail-ia0-f175.google.com with SMTP id i38so1825383iae.6
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2013 10:11:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5177A782.5050603@cn.fujitsu.com>
References: <516FB479.1060601@cn.fujitsu.com>
	<CAE9FiQWtC4S52BUeDQvAJS2L=q6i_R6eZeEoAPPohg60NcY0UA@mail.gmail.com>
	<5177A782.5050603@cn.fujitsu.com>
Date: Wed, 24 Apr 2013 10:11:00 -0700
Message-ID: <CAE9FiQVY2wNoTxnmbRCNf0rQpUXdStFaaPC4idTfjh2+zzp_vw@mail.gmail.com>
Subject: Re: [PATCH 0/3] PCI: fix the object lifetime issue of parallel device
 removal on different pci hierarchy
From: Yinghai Lu <yinghai@kernel.org>
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	tangchen <tangchen@cn.fujitsu.com>,
	Lin Feng <linfeng@cn.fujitsu.com>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 24, 2013 at 2:36 AM, Gu Zheng <guz.fnst@cn.fujitsu.com> wrote:
> On 04/19/2013 03:43 AM, Yinghai Lu wrote:
[...]
>> I can not find where that reference count get reduced!
>> in the my test patches that I sent, it does have have that in remove path.
>>
>> What is reason for you to remove that line?
>>
>> After put the line back, your test still can pass?
>
> Hi Yinghai,
>         The remove test script still can pass if we reduce the reference of pci_bus when destroying
> the pci_dev, so does your patch, but a list_del corruption warning occurs in the bottom half routine:

That is not clear.

your patchset does not have list_del corruption warning?

> ------------[ cut here ]------------
> WARNING: at lib/list_debug.c:53 __list_del_entry+0x63/0xd0()
> Hardware name: PRIMEQUEST 1800E
> list_del corruption, ffff8807d1b6c000->next is LIST_POISON1 (dead000000100100)
> Modules linked in: shpchp ebtable_nat ebtables xt_CHECKSUM iptable_mangle bridge stp llc autofs4 sunrpc cpufreq_ondemand ipt_REJECT nf_conntrack_ipv4 nf_defrag_ipv4 iptable_filter ip_tables ip6t_REJECT nf_conntrack_ipv6 nf_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables ipv6 vfat fat dm_mirror dm_region_hash dm_log dm_mod vhost_net macvtap macvlan tun uinput iTCO_wdt iTCO_vendor_support acpi_cpufreq freq_table mperf coretemp kvm_intel kvm crc32c_intel microcode pcspkr sg i2c_i801 lpc_ich mfd_core i7core_edac edac_core ioatdma e1000e igb dca i2c_algo_bit i2c_core ptp pps_core ext4(F) mbcache(F) jbd2(F) sd_mod(F) crc_t10dif(F) megaraid_sas(F) mptsas(F) mptscsih(F) mptbase(F) scsi_transport_sas(F)
> Pid: 6, comm: kworker/u:0 Tainted: GF       W    3.9.0-rc7-pci-remove-test+ #59
> Call Trace:
>  [<ffffffff81056d4f>] warn_slowpath_common+0x7f/0xc0
>  [<ffffffff81056e46>] warn_slowpath_fmt+0x46/0x50
>  [<ffffffff81280b13>] __list_del_entry+0x63/0xd0
>  [<ffffffff81280b91>] list_del+0x11/0x40
>  [<ffffffff81298331>] pci_destroy_dev+0x31/0xc0
>  [<ffffffff812985bb>] pci_remove_bus_device+0x5b/0x70
>  [<ffffffff812985ee>] pci_stop_and_remove_bus_device+0x1e/0x30
>  [<ffffffff8129fc89>] remove_callback+0x29/0x40
>  [<ffffffff811f3b84>] sysfs_schedule_callback_work+0x24/0x70
>  [<ffffffff81073d85>] process_one_work+0x185/0x3f0
>  [<ffffffff810763e9>] worker_thread+0x119/0x380
>  [<ffffffff810762d0>] ? manage_workers+0x180/0x180
>  [<ffffffff8107b6ae>] kthread+0xce/0xe0
>  [<ffffffff8107b5e0>] ? kthread_freezable_should_stop+0x70/0x70
>  [<ffffffff815724ac>] ret_from_fork+0x7c/0xb0
>  [<ffffffff8107b5e0>] ? kthread_freezable_should_stop+0x70/0x70
> ---[ end trace 9c05e382f933a515 ]---
