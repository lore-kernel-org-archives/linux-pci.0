Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:51154 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932945AbaD2RFT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Apr 2014 13:05:19 -0400
Message-ID: <535FDA81.3020508@wwwdotorg.org>
Date: Tue, 29 Apr 2014 10:59:45 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	shiv prakash Agarwal <chhotu.shiv@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux NICS <linux.nics@intel.com>,
	"e1000-devel@lists.sourceforge.net"
	<e1000-devel@lists.sourceforge.net>,
	Thierry Reding <thierry.reding@gmail.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: Intel NIC testing on ARM
References: <CAHH3p5+9VCYwS6JdB8aFJ0i4JLcFTMgSgiKOaE2GMnhfWM1bWA@mail.gmail.com> <CAErSpo7cDPa0vujMmppWV2RM3vn6=WJ7MCcP8CvwhT4Zn==MwA@mail.gmail.com> <CAHH3p5+qEeYaNKm-L4_RmnkmXeA2030u4t3D+J2wUwBEWiPBPQ@mail.gmail.com> <CAErSpo6+_Tnh9+r50_qK-v0ubpv_pqTcnS7DhMiNi8GbWmsgJA@mail.gmail.com> <CAHH3p5+xTwMaDW-k-0UUZ+21EhCCt2voWXP2jZf_PbRqOdukiA@mail.gmail.com> <CAErSpo7jd2smdoju31r7SWVp4KjNmN+qDAxSUxmVCnUSUOfKTw@mail.gmail.com> <CAHH3p5LKay-1gcgCn1fatM0hOL1Tc+a81Za+ePVjJ6oPo8+6rg@mail.gmail.com> <CAErSpo5VWnAG3xnhn0zgpyC22Eum=ZVR=BM8j2Rvt+=i7LZgjA@mail.gmail.com> <CAHH3p5+aRDq3j_au2Kou6Ef9L+iLaCUVV7hwZPhmD_HU6TxzqQ@mail.gmail.com> <CAHH3p5KYoPdRO-SEBGMwEPC5dhRd0j_nq_jDz+Z2WMuzOPKREA@mail.gmail.com> <CAErSpo7gtOoh_swzOtSyzkjRXUuZvLWwWpBeqHgy-9J4oB6b7g@mail.gmail.com>
In-Reply-To: <CAErSpo7gtOoh_swzOtSyzkjRXUuZvLWwWpBeqHgy-9J4oB6b7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/29/2014 10:21 AM, Bjorn Helgaas wrote:
> [+cc igb, tegra folks]
> 
> On Tue, Apr 29, 2014 at 9:25 AM, shiv prakash Agarwal
> <chhotu.shiv@gmail.com> wrote:
>> Also if I disable enabling bus master from igb driver, then ethernet
>> functionality does not work due to below issue:
> 
> This looks like an igb or (more likely) a tegra host bridge driver
> issue, so hopefully somebody there can help you.
> 
>> root@tegra-ubuntu:~# dhclient eth0

Are you running mainline Linux, or NVIDIA's "Linux4Tegra"? IIRC, that
shell prompt is the L4T default, and I think kernel version 3.10
(mentioned in some of your logs) is the current L4T kernel version.

If you're running L4T, you should contact the NVIDIA L4T team for
support (linux-tegra-bugs@nvidia.com).

If you can reproduce this issue on a recent mainline Linux (say 3.14,
3.15-rc* or or linux-next), we can continue this conversation here. In
this case, I'd like to see:

* Details re: which HW/board you're running on, how you're plugging in
the PCIe device, etc.

* U-Boot version/commit ID, so we can check any setup it's doing.

* Link to source tree, so we can double-check the driver code you're
running. It would be best to try a more recent source tree.

Then perhaps we'll be able to try and repro this problem, although I
don't have that NIC so that might be hard...

>> [   82.642468] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
>> [   86.741124] igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
>> RX
>> [   86.763938] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
>> [   96.748110] ------------[ cut here ]------------
>> [   96.756653] WARNING: at
>> /home/shiv/kernel_builds/linux/kernel/net/sched/sch_generic.c:255
>> dev_watchdog+0x264/0
>> x284()
>> [   96.775062] NETDEV WATCHDOG: eth0 (igb): transmit queue 0 timed out
...
>> [  259.740507] igb 0000:01:00.0 eth0: Reset adapter
>> [  263.738512] igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
>> RX
>> [  278.749107] igb 0000:01:00.0 eth0: Reset adapter
>> [  282.739504] igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
>> RX
>> ------------------------CONTINUES for
>> EVER---------------------------------------------------

Hmmm. This is a completely different problem than the first one or two
in this thread, which were about an external abort while enabling the
device's bus-master access... I assume there's no longer a problem with
enabling bus-master?
