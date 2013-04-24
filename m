Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:65163 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758268Ab3DXXsk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2013 19:48:40 -0400
Received: by mail-ie0-f179.google.com with SMTP id 16so2901543iea.10
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2013 16:48:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVY2wNoTxnmbRCNf0rQpUXdStFaaPC4idTfjh2+zzp_vw@mail.gmail.com>
References: <516FB479.1060601@cn.fujitsu.com>
	<CAE9FiQWtC4S52BUeDQvAJS2L=q6i_R6eZeEoAPPohg60NcY0UA@mail.gmail.com>
	<5177A782.5050603@cn.fujitsu.com>
	<CAE9FiQVY2wNoTxnmbRCNf0rQpUXdStFaaPC4idTfjh2+zzp_vw@mail.gmail.com>
Date: Wed, 24 Apr 2013 16:48:40 -0700
Message-ID: <CAE9FiQWai_7yc9R-=rqUhK7BTaGzMcBX8kHm6NW4ppUETmnzHQ@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary=089e0149476efb186104db23f0f4
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--089e0149476efb186104db23f0f4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2013 at 10:11 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Apr 24, 2013 at 2:36 AM, Gu Zheng <guz.fnst@cn.fujitsu.com> wrote=
:
>> On 04/19/2013 03:43 AM, Yinghai Lu wrote:
> [...]
>>> I can not find where that reference count get reduced!
>>> in the my test patches that I sent, it does have have that in remove pa=
th.
>>>
>>> What is reason for you to remove that line?
>>>
>>> After put the line back, your test still can pass?
>>
>> Hi Yinghai,
>>         The remove test script still can pass if we reduce the reference=
 of pci_bus when destroying
>> the pci_dev, so does your patch, but a list_del corruption warning occur=
s in the bottom half routine:
>
> That is not clear.
>
> your patchset does not have list_del corruption warning?
>
>> ------------[ cut here ]------------
>> WARNING: at lib/list_debug.c:53 __list_del_entry+0x63/0xd0()
>> Hardware name: PRIMEQUEST 1800E
>> list_del corruption, ffff8807d1b6c000->next is LIST_POISON1 (dead0000001=
00100)
>> Modules linked in: shpchp ebtable_nat ebtables xt_CHECKSUM iptable_mangl=
e bridge stp llc autofs4 sunrpc cpufreq_ondemand ipt_REJECT nf_conntrack_ip=
v4 nf_defrag_ipv4 iptable_filter ip_tables ip6t_REJECT nf_conntrack_ipv6 nf=
_defrag_ipv6 xt_state nf_conntrack ip6table_filter ip6_tables ipv6 vfat fat=
 dm_mirror dm_region_hash dm_log dm_mod vhost_net macvtap macvlan tun uinpu=
t iTCO_wdt iTCO_vendor_support acpi_cpufreq freq_table mperf coretemp kvm_i=
ntel kvm crc32c_intel microcode pcspkr sg i2c_i801 lpc_ich mfd_core i7core_=
edac edac_core ioatdma e1000e igb dca i2c_algo_bit i2c_core ptp pps_core ex=
t4(F) mbcache(F) jbd2(F) sd_mod(F) crc_t10dif(F) megaraid_sas(F) mptsas(F) =
mptscsih(F) mptbase(F) scsi_transport_sas(F)
>> Pid: 6, comm: kworker/u:0 Tainted: GF       W    3.9.0-rc7-pci-remove-te=
st+ #59
>> Call Trace:
>>  [<ffffffff81056d4f>] warn_slowpath_common+0x7f/0xc0
>>  [<ffffffff81056e46>] warn_slowpath_fmt+0x46/0x50
>>  [<ffffffff81280b13>] __list_del_entry+0x63/0xd0
>>  [<ffffffff81280b91>] list_del+0x11/0x40
>>  [<ffffffff81298331>] pci_destroy_dev+0x31/0xc0
>>  [<ffffffff812985bb>] pci_remove_bus_device+0x5b/0x70
>>  [<ffffffff812985ee>] pci_stop_and_remove_bus_device+0x1e/0x30
>>  [<ffffffff8129fc89>] remove_callback+0x29/0x40
>>  [<ffffffff811f3b84>] sysfs_schedule_callback_work+0x24/0x70
>>  [<ffffffff81073d85>] process_one_work+0x185/0x3f0
>>  [<ffffffff810763e9>] worker_thread+0x119/0x380
>>  [<ffffffff810762d0>] ? manage_workers+0x180/0x180
>>  [<ffffffff8107b6ae>] kthread+0xce/0xe0
>>  [<ffffffff8107b5e0>] ? kthread_freezable_should_stop+0x70/0x70
>>  [<ffffffff815724ac>] ret_from_fork+0x7c/0xb0
>>  [<ffffffff8107b5e0>] ? kthread_freezable_should_stop+0x70/0x70
>> ---[ end trace 9c05e382f933a515 ]---

Attached patch on top of current linus tree should fix the racing problem.

We don't need to bother to add get bus ref. etc.

Let us know your test result.

Yinghai

--089e0149476efb186104db23f0f4
Content-Type: application/octet-stream; name="fix_racing_removing.patch"
Content-Disposition: attachment; filename="fix_racing_removing.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hfx5i6go0

LS0tCiBkcml2ZXJzL3BjaS9wY2ktc3lzZnMuYyB8ICAgIDkgKysrKysrKystCiAxIGZpbGUgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpJbmRleDogbGludXgtMi42L2Ry
aXZlcnMvcGNpL3BjaS1zeXNmcy5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LTIuNi5vcmlnL2RyaXZl
cnMvcGNpL3BjaS1zeXNmcy5jCisrKyBsaW51eC0yLjYvZHJpdmVycy9wY2kvcGNpLXN5c2ZzLmMK
QEAgLTMxMCw5ICszMTAsMTYgQEAgZGV2X3Jlc2Nhbl9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYs
IHN0cgogc3RhdGljIHZvaWQgcmVtb3ZlX2NhbGxiYWNrKHN0cnVjdCBkZXZpY2UgKmRldikKIHsK
IAlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRvX3BjaV9kZXYoZGV2KTsKKwlpbnQgZG9tYWluID0g
cGNpX2RvbWFpbl9ucihwZGV2LT5idXMpOworCXU4IGJ1cyA9IHBkZXYtPmJ1cy0+bnVtYmVyOwor
CXU4IGRldmZuID0gcGRldi0+ZGV2Zm47CiAKIAltdXRleF9sb2NrKCZwY2lfcmVtb3ZlX3Jlc2Nh
bl9tdXRleCk7Ci0JcGNpX3N0b3BfYW5kX3JlbW92ZV9idXNfZGV2aWNlKHBkZXYpOworCXBkZXYg
PSBwY2lfZ2V0X2RvbWFpbl9idXNfYW5kX3Nsb3QoZG9tYWluLCBidXMsIGRldmZuKTsKKwlpZiAo
cGRldikgeworCQlwY2lfZGV2X3B1dChwZGV2KTsKKwkJcGNpX3N0b3BfYW5kX3JlbW92ZV9idXNf
ZGV2aWNlKHBkZXYpOworCX0KIAltdXRleF91bmxvY2soJnBjaV9yZW1vdmVfcmVzY2FuX211dGV4
KTsKIH0KIAo=
--089e0149476efb186104db23f0f4--
