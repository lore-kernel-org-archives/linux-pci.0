Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:43355 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756637Ab1LHCut (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 Dec 2011 21:50:49 -0500
Received: from /spool/local
	by e6.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Wed, 7 Dec 2011 21:50:48 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id pB82ojHP298106
	for <linux-pci@vger.kernel.org>; Wed, 7 Dec 2011 21:50:45 -0500
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id pB82oiqq015237
	for <linux-pci@vger.kernel.org>; Wed, 7 Dec 2011 19:50:45 -0700
Date: Thu, 8 Dec 2011 10:50:39 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Don Dutile <ddutile@redhat.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Nishanth Aravamudan <nacc@us.ibm.com>, prarit@redhat.com,
	brking@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 1/1]PCI: defer enablement of SRIOV BARS
Message-ID: <20111208025039.GH19129@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20111008075353.GK2980@ram-ThinkPad-T61>
 <1318060793.29415.347.camel@pasglop>
 <20111102140325.004b9dad@jbarnes-desktop>
 <20111103013014.GB393@ram-ThinkPad-T61>
 <20111106023310.GA2383@ram-ThinkPad-T61>
 <20111205103202.29faf6e1@jbarnes-desktop>
 <CAE9FiQXx_nkOFP2S=hXKyjcFHh4R4f5c+J-aCiDoYS=3Tgdmqw@mail.gmail.com>
 <20111207092531.GF19129@ram-ThinkPad-T61>
 <4EDFCB4A.60106@redhat.com>
 <CAE9FiQXOhn2HkqCh3DiSNUw7RwgAAk2Xe62z11AB=L+pcG__Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAE9FiQXOhn2HkqCh3DiSNUw7RwgAAk2Xe62z11AB=L+pcG__Qg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 07, 2011 at 03:11:56PM -0800, Yinghai Lu wrote:
> On Wed, Dec 7, 2011 at 12:23 PM, Don Dutile <ddutile@redhat.com> wrote:
> > why not something more explicit like:
> >
> >        for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> >                if ((i >=  PCI_IOV_RESOURCES) && (i <= PCI_IOV_RESOURCE_END))
> >                        continue; /* skip sriov related resources */
> >
> >                if (dev->resource[i].flags & flags)
> >                        bars |= (1 << i);
> >        }

I like this approach too. Offcourse the SRIOV skipping has to be one under #ifdef CONFIG_PCI_IOV.

Yinghai/Jesse, do you want to make a patch on top of the current jesse's to-linus
tree or want to revert my patch and apply your fix? If it is the former, do you want me
to make the patch?

RP

