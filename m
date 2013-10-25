Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38278 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122Ab3JYO7r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Oct 2013 10:59:47 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id r9PExl5f021818
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2013 09:59:47 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id r9PExlP3024631
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2013 09:59:47 -0500
From: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
To: "Karicheri, Muralidharan" <m-karicheri2@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: intel e1000e pci driver issue on RT Linux kernel
Date: Fri, 25 Oct 2013 14:59:46 +0000
Message-ID: <3E54258959B69E4282D79E01AB1F32B7046258B0@DFLE11.ent.ti.com>
References: <cover.1382103786.git.agordeev@redhat.com>
 <6bc575621ef70f72b206e4aa944acd32f1a75718.1382103786.git.agordeev@redhat.com>
 <20131024105158.GB13159@mtj.dyndns.org>
 <AE90C24D6B3A694183C094C60CF0A2F6026B73AA@saturn3.aculab.com>
 <20131024114133.GA26610@dhcp-26-207.brq.redhat.com>
 <5269D5D1.60103@start.ca>
 <AE90C24D6B3A694183C094C60CF0A2F6026B73B0@saturn3.aculab.com>
 <20131025100103.GA317@dhcp-26-207.brq.redhat.com>
 <3E54258959B69E4282D79E01AB1F32B704625855@DFLE11.ent.ti.com>
In-Reply-To: <3E54258959B69E4282D79E01AB1F32B704625855@DFLE11.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Resending as there was a format issue

I am a first timer for this mailing list. I have tried sending email to the list after subscribing
successfully. I had sent an email before, but I can't see that in the mailing list as seen
through the web browser. So I am re-sending. My apologies if multiple copies appear in the
list.

I am working on my SMP kernel on an ARM A15 with RT patch applied against v3.10.10. I
have a setup to use the e1000e pci driver against the pcie root complex driver that I have
on this platform. It works well with non RT version of the kernel. I am able to do iperf on
UDP and TCP traffic. But against RT kernel, I am able to do only ping. If I run iperf, it seems
there is a deadlock happening. When I did suspend the core, it seems to be in the idle loop.
Some time I am able to do ctrl-c and get back to shell. When I try doing ping again, it times
out. If anyone has seen this issue and know how to fix, please reply.
 
 Thanks.
 
 Murali Karicheri

