Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:52649 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753255Ab2IIOnF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 9 Sep 2012 10:43:05 -0400
Subject: Re: [PATCH v2] PCI: use dev->irq instead of dev->pin to enable non MSI/INTx interrupt
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=US-ASCII
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAErSpo78VePbVtz1CQrKA5f6tmpU7v_qY6ZYozh9FrW-m0g2rA@mail.gmail.com>
Date: Sun, 9 Sep 2012 09:42:41 -0500
Cc: Zang Roy-R61911 <r61911@freescale.com>,
	Liu Shengzhou-B36685 <B36685@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	Wood Scott-B07421 <B07421@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Message-Id: <E01863CB-C76F-4498-8520-BE1817F122BC@kernel.crashing.org>
References: <1342591614-1840-1-git-send-email-Shengzhou.Liu@freescale.com> <3F453DDFF675A64A89321A1F35281021771A8B@039-SN1MPN1-003.039d.mgd.msft.net> <3E027F8168735B46AC006B1D0C7BB002079D6153@039-SN2MPN1-012.039d.mgd.msft.net> <CAErSpo78VePbVtz1CQrKA5f6tmpU7v_qY6ZYozh9FrW-m0g2rA@mail.gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On Sep 7, 2012, at 5:08 PM, Bjorn Helgaas wrote:

> On Mon, Aug 6, 2012 at 8:45 PM, Zang Roy-R61911 <r61911@freescale.com> wrote:
>> 
>> 
>>> -----Original Message-----
>>> From: Linuxppc-dev [mailto:linuxppc-dev-bounces+tie-
>>> fei.zang=freescale.com@lists.ozlabs.org] On Behalf Of Liu Shengzhou-B36685
>>> Sent: Thursday, July 26, 2012 11:45 AM
>>> To: bhelgaas@google.com; linux-pci@vger.kernel.org; akpm@linux-
>>> foundation.org
>>> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org; Liu Shengzhou-B36685
>>> Subject: RE: [PATCH v2] PCI: use dev->irq instead of dev->pin to enable non
>>> MSI/INTx interrupt
>>> 
>>> Hello,
>>> 
>>> A gentle reminder!
>>> Any comments are appreciated.
>> 
>> Who can help to review and pick up this patch?
> 
> I merged this to a staging branch and will merge it to my "next"
> branch as soon as it gets a build/smoke test by Fengguang.  Thanks!
> 
> Bjorn

Thanks

- k