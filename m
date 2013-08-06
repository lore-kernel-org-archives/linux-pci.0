Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:37191 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315Ab3HFNo0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Aug 2013 09:44:26 -0400
Received: by mail-qc0-f182.google.com with SMTP id c11so201247qcv.27
        for <linux-pci@vger.kernel.org>; Tue, 06 Aug 2013 06:44:25 -0700 (PDT)
Date: Tue, 6 Aug 2013 07:44:21 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 4/4] PCI: fix the io resource alignment calculation in
 pbus_size_io()
Message-ID: <20130806134421.GD31970@google.com>
References: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1375435866-16332-5-git-send-email-weiyang@linux.vnet.ibm.com>
 <CAErSpo5Lv7-Op3hg_ZRgSjzMNYZpZGphQFJyxxP6B8xLpwrSkw@mail.gmail.com>
 <20130806061924.GB10876@weiyang.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130806061924.GB10876@weiyang.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 06, 2013 at 02:19:24PM +0800, Wei Yang wrote:
> On Mon, Aug 05, 2013 at 11:58:50AM -0600, Bjorn Helgaas wrote:
> >[+cc Yinghai]
> >
> >On Fri, Aug 2, 2013 at 3:31 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> >> In commit 462d9303 ("PCI: Align P2P windows using pcibios_window_alignment()"),
> >> it introduce a new method to calculate the window alignment of P2P bridge.
> >>
> >> When the io_window_1k is set,  the calculation for the io resource alignment
> >> is different from the original one. In the original logic before 462d9303,
> >> the alignment is no bigger than 4K even the io_window_1k is set. The logic
> >> introduced in 462d9303 will limit the alignment to 1k in this case.
> >>
> >> This patch fix this issue.
> >
> >Presumably this fixes a bug, but you don't say what it is.  "different
> >from the original" is not a description of a problem.  You need
> >something like "with the current code, we allocate the wrong window
> >size in situation X, or we allocate a window with incorrect alignment
> >in situation Y, etc."
> >
> 
> With current code, we allocate the wrong window size when upstream bridge
> could be 1k aligned and one of the downstream port is 4k aligned.
> 
> In this case, the "min_align" should be 4k. But the current code set
> "min_align" to 1k.

I would expect that we allocate a window with incorrect *alignment*,
not incorrect size.  If you include a dmesg log and lspci output and point
out the problem, that will avoid a lot of confusion.

Bjorn
