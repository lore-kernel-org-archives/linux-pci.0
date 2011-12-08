Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy9.bluehost.com ([69.89.24.6]:39912 "HELO
	oproxy9.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751267Ab1LHNyC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2011 08:54:02 -0500
Date: Thu, 8 Dec 2011 05:53:55 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Don Dutile <ddutile@redhat.com>,
	linux-pci@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Nishanth Aravamudan <nacc@us.ibm.com>, prarit@redhat.com,
	brking@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 1/1]PCI: defer enablement of SRIOV BARS
Message-ID: <20111208055355.19c346a8@jbarnes-desktop>
In-Reply-To: <20111208025039.GH19129@ram-ThinkPad-T61>
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
	<20111208025039.GH19129@ram-ThinkPad-T61>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 8 Dec 2011 10:50:39 +0800
Ram Pai <linuxram@us.ibm.com> wrote:

> On Wed, Dec 07, 2011 at 03:11:56PM -0800, Yinghai Lu wrote:
> > On Wed, Dec 7, 2011 at 12:23 PM, Don Dutile <ddutile@redhat.com> wrote:
> > > why not something more explicit like:
> > >
> > >        for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
> > >                if ((i >=  PCI_IOV_RESOURCES) && (i <= PCI_IOV_RESOURCE_END))
> > >                        continue; /* skip sriov related resources */
> > >
> > >                if (dev->resource[i].flags & flags)
> > >                        bars |= (1 << i);
> > >        }
> 
> I like this approach too. Offcourse the SRIOV skipping has to be one under #ifdef CONFIG_PCI_IOV.
> 
> Yinghai/Jesse, do you want to make a patch on top of the current jesse's to-linus
> tree or want to revert my patch and apply your fix? If it is the former, do you want me
> to make the patch?

I like the above best as well with the comment.

Can you send me a replacement patch?  I'd rather have that than some
breakage in the patches I have in my for-linus branch.

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
