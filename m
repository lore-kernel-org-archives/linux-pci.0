Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37239 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756660AbaD2RXn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Apr 2014 13:23:43 -0400
Received: by mail-ig0-f176.google.com with SMTP id r10so452919igi.15
        for <linux-pci@vger.kernel.org>; Tue, 29 Apr 2014 10:23:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <535FDA81.3020508@wwwdotorg.org>
References: <CAHH3p5+9VCYwS6JdB8aFJ0i4JLcFTMgSgiKOaE2GMnhfWM1bWA@mail.gmail.com>
 <CAErSpo7cDPa0vujMmppWV2RM3vn6=WJ7MCcP8CvwhT4Zn==MwA@mail.gmail.com>
 <CAHH3p5+qEeYaNKm-L4_RmnkmXeA2030u4t3D+J2wUwBEWiPBPQ@mail.gmail.com>
 <CAErSpo6+_Tnh9+r50_qK-v0ubpv_pqTcnS7DhMiNi8GbWmsgJA@mail.gmail.com>
 <CAHH3p5+xTwMaDW-k-0UUZ+21EhCCt2voWXP2jZf_PbRqOdukiA@mail.gmail.com>
 <CAErSpo7jd2smdoju31r7SWVp4KjNmN+qDAxSUxmVCnUSUOfKTw@mail.gmail.com>
 <CAHH3p5LKay-1gcgCn1fatM0hOL1Tc+a81Za+ePVjJ6oPo8+6rg@mail.gmail.com>
 <CAErSpo5VWnAG3xnhn0zgpyC22Eum=ZVR=BM8j2Rvt+=i7LZgjA@mail.gmail.com>
 <CAHH3p5+aRDq3j_au2Kou6Ef9L+iLaCUVV7hwZPhmD_HU6TxzqQ@mail.gmail.com>
 <CAHH3p5KYoPdRO-SEBGMwEPC5dhRd0j_nq_jDz+Z2WMuzOPKREA@mail.gmail.com>
 <CAErSpo7gtOoh_swzOtSyzkjRXUuZvLWwWpBeqHgy-9J4oB6b7g@mail.gmail.com> <535FDA81.3020508@wwwdotorg.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 29 Apr 2014 11:23:22 -0600
Message-ID: <CAErSpo4BB4viHRBrMupMWMO8fU827AR=GBsq9bTwt5Eyn=8BZQ@mail.gmail.com>
Subject: Re: Intel NIC testing on ARM
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: shiv prakash Agarwal <chhotu.shiv@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux NICS <linux.nics@intel.com>,
	"e1000-devel@lists.sourceforge.net"
	<e1000-devel@lists.sourceforge.net>,
	Thierry Reding <thierry.reding@gmail.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 29, 2014 at 10:59 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:

>>> [   82.642468] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
>>> [   86.741124] igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
>>> RX
>>> [   86.763938] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
>>> [   96.748110] ------------[ cut here ]------------
>>> [   96.756653] WARNING: at
>>> /home/shiv/kernel_builds/linux/kernel/net/sched/sch_generic.c:255
>>> dev_watchdog+0x264/0
>>> x284()
>>> [   96.775062] NETDEV WATCHDOG: eth0 (igb): transmit queue 0 timed out
> ...
>>> [  259.740507] igb 0000:01:00.0 eth0: Reset adapter
>>> [  263.738512] igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
>>> RX
>>> [  278.749107] igb 0000:01:00.0 eth0: Reset adapter
>>> [  282.739504] igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
>>> RX
>>> ------------------------CONTINUES for
>>> EVER---------------------------------------------------
>
> Hmmm. This is a completely different problem than the first one or two
> in this thread, which were about an external abort while enabling the
> device's bus-master access... I assume there's no longer a problem with
> enabling bus-master?

I thought he meant that he just left Bus Master disabled completely.
I wouldn't expect the driver to work at all in that case, so this just
looked like a red herring.
