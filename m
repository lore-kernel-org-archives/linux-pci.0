Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:46527 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab2D1IVo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 28 Apr 2012 04:21:44 -0400
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Sat, 28 Apr 2012 08:16:32 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q3S8LeiU32899196
	for <linux-pci@vger.kernel.org>; Sat, 28 Apr 2012 18:21:40 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q3S8Ld0o013561
	for <linux-pci@vger.kernel.org>; Sat, 28 Apr 2012 18:21:40 +1000
Date: Sat, 28 Apr 2012 16:21:37 +0800
From: Richard Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org
Subject: Re: Does my understanding correct?
Message-ID: <20120428082137.GB8402@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
References: <20120427092704.GA22529@richard>
 <CAErSpo6xy6AEQwROSOU6yrfdWpBgRpd+-hOGOyg0mv9UzKwOUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo6xy6AEQwROSOU6yrfdWpBgRpd+-hOGOyg0mv9UzKwOUA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 27, 2012 at 08:17:48AM -0600, Bjorn Helgaas wrote:
>I assume your question relates to the Stratus ftServer topology.  If
>so, the lspci details might clarify things.
>
>In that system, my understanding is that 03:01.0 is a downstream port,
>not an upstream port.
>
>I think your picture is slightly misleading because PCIe links are not
>buses; they're point-to-point links between two devices.  You've drawn
>#3 and #5 as buses that can have several devices on them, which is not
>really the case.  The link from a downstream port should lead to
>exactly one device.
Hmm... if this is a PCI bridge, then it will have both internal bus and
externel bus? or no internal pci bus, just one external bus?
>
>That's one thing that's strange in the ftServer topology: apparently
>there are *two* devices on bus 03: the 03:00.0 upstream port and the
>03:01.0 downstream port.  I think 03:00.0 is the upstream port of a
>PCIe switch, which is perfectly normal.  My understanding is that
>03:01.0 is another *downstream* port that leads to several more
>devices (USB, NIC, etc).
>
>Bjorn

-- 
Richard Yang
Help you, Help me

