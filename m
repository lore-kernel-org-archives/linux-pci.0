Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:48585 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208Ab2ICIvQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Sep 2012 04:51:16 -0400
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Mon, 3 Sep 2012 02:51:15 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 3C8D43E4003D
	for <linux-pci@vger.kernel.org>; Mon,  3 Sep 2012 02:51:12 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q838pCGq225852
	for <linux-pci@vger.kernel.org>; Mon, 3 Sep 2012 02:51:12 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q838pBiX028344
	for <linux-pci@vger.kernel.org>; Mon, 3 Sep 2012 02:51:12 -0600
Date: Mon, 3 Sep 2012 16:51:06 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Jiang Liu <liuj97@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	ksummit-2012-discuss
	<ksummit-2012-discuss@lists.linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PCI mini-summit notes
Message-ID: <20120903085106.GB2438@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <CAErSpo73r3yzzndUek-NJ3d0pDKtg8zTrnjk4ihudBE5gngBAA@mail.gmail.com>
 <503E39DE.7000109@gmail.com>
 <CAPoiz9yRzEr68=NB53SVXb5+nRmEa_J4Mtt6eGAAo5EWFbDbmQ@mail.gmail.com>
 <CAE9FiQWEE0aCPbM=aVfH4kYzWqpJ4orseh2isWuuGFj3yFxKqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQWEE0aCPbM=aVfH4kYzWqpJ4orseh2isWuuGFj3yFxKqQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 29, 2012 at 03:54:56PM -0700, Yinghai Lu wrote:
> On Wed, Aug 29, 2012 at 3:44 PM, Jon Mason <jdmason@kudzu.us> wrote:
> >> Hi Bjorn,
> >>         One of my team member reported another corner case for SR-IOV. There's
> >> are two NIC cards in the system driven by the same driver, but one supports
> >> SR-IOV and the other doesn't. It runs into trouble if "max_vfs" parameter is
> >> set for the NIC driver.
> >>         --Gerry
> >
> > I believe it was decided that a per-pf sysfs interface would be used
> > to replace the current module parameter that specifies the number of
> > vf's.  This should enable different numbers of vf's for each physical
> > device.  The driver interface that was discussed would introduce new
> > function pointers for handlers to setup/teardown the vf's.  I believe
> > this will solve your problem once it has been implemented.
> 
> now we have ixgbe.max_vfs=63
> 
> so if change to per pci device (PF),
> 
> how about having the driver built-in?
> what kind of kernel parameters will be passed?

 The driver parameter has to go away. The parameter makes more sense to
 be associated with a PF than with the driver. It has to be a
 run time interface to enable/disable the number of VFs for a given PF.


 RP

