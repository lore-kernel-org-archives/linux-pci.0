Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:37606 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352Ab1KNEd1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2011 23:33:27 -0500
Received: from /spool/local
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Sun, 13 Nov 2011 21:33:26 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id pAE4XOdC165158
	for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2011 21:33:24 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id pAE4XNPv021424
	for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2011 21:33:24 -0700
Date: Mon, 14 Nov 2011 12:33:18 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Nishanth Aravamudan <nacc@us.ibm.com>, prarit@redhat.com,
	brking@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 1/1]PCI: defer enablement of SRIOV BARS
Message-ID: <20111114043318.GA2435@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1317970100.29415.305.camel@pasglop>
 <CAErSpo58okGsDW4dOK4i0g_RUejkuQa=iw2uQ5HAJJZCwFtsbw@mail.gmail.com>
 <20111007232516.GF2980@ram-ThinkPad-T61>
 <1318057168.29415.333.camel@pasglop>
 <20111008075353.GK2980@ram-ThinkPad-T61>
 <1318060793.29415.347.camel@pasglop>
 <20111102140325.004b9dad@jbarnes-desktop>
 <20111103013014.GB393@ram-ThinkPad-T61>
 <20111106023310.GA2383@ram-ThinkPad-T61>
 <20111111100143.545ead31@jbarnes-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111111100143.545ead31@jbarnes-desktop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 11, 2011 at 10:01:43AM -0800, Jesse Barnes wrote:
> On Sun, 6 Nov 2011 10:33:10 +0800
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> >   All the PCI BARs of a device are enabled when the device is enabled using
> >   pci_enable_device().  This unnecessarily enables SRIOV BARs of the device.
> > 
> >   On some platforms, which do not support SRIOV as yet, the pci_enable_device()
> >   fails to enable the device if its SRIOV BARs are not allocated resources
> >   correctly.
> > 
> >   The following patch fixes the above problem. The SRIOV BARs are now enabled
> >   when IOV capability of the device is enabled in sriov_enable().
> > 
> >   NOTE: Note, there is subtle change in the pci_enable_device() API.
> >   Any driver that depends on SRIOV BARS to be enabled in pci_enable_device()
> >   can fail.
> > 
> >   The patch has been touch tested on power and x86 platform.
> > 
> >   Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> 
> I think this is a good direction, but I'd like to get a tested-by or
> two from people using SR-IOV...

I have people within IBM who have tested this patch successfully.
Michael Wang/Nish: Can you provide us a tested-by for this patch?

Prarit: Can you give this patch and the other patch a try?
the other patch is: [RFC PATCH 1/1] PCI:delay configuration of SRIOV capability

RP

