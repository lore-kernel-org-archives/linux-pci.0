Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:23239
	"EHLO AM1EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751028Ab1LBSwp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2011 13:52:45 -0500
Message-ID: <4ED91E72.9040303@freescale.com>
Date: Fri, 2 Dec 2011 12:52:34 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Bhushan Bharat-R65777 <R65777@freescale.com>
CC: Wood Scott-B07421 <B07421@freescale.com>,
	Stuart Yoder <b08248@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Alexey Kardashevskiy <aik@au1.ibm.com>,
	"aafabbri@cisco.com" <aafabbri@cisco.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pmac@au1.ibm.com" <pmac@au1.ibm.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"joerg.roedel@amd.com" <joerg.roedel@amd.com>,
	"konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
	"agraf@suse.de" <agraf@suse.de>,
	"dwg@au1.ibm.com" <dwg@au1.ibm.com>,
	"chrisw@sous-sol.org" <chrisw@sous-sol.org>,
	Yoder Stuart-B08248 <B08248@freescale.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"avi@redhat.com" <avi@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"benve@cisco.com" <benve@cisco.com>
Subject: Re: [Qemu-devel] [RFC PATCH] vfio: VFIO Driver core framework
References: <20111103195452.21259.93021.stgit@bling.home> <4ED43AD9.5090509@au1.ibm.com>	<4ED43CFE.8040009@au1.ibm.com> <1322538856.19120.126.camel@bling.home> <1322594768.19120.194.camel@bling.home> <CALRxmdDEGwA787gEgC3d_yU99TqOZOtWeDJ9N-QCQ3gxV8yyMw@mail.gmail.com> <1322610273.19120.209.camel@bling.home> <CALRxmdBaguEZD8CnogHv+mSPuLx9et1CGRAa8oO_182Pjjp6-Q@mail.gmail.com> <1322672293.19120.232.camel@bling.home> <CALRxmdAjeyyM3Ta+DCTxtdc_J69fnVko_9hzmjcLUCe8SskNnQ@mail.gmail.com> <1322774717.26545.118.camel@bling.home> <CALRxmdDZjFGjdrEC5e1ANGV+PYd5Mz7j3zeaKNiEUwLdNzmiEA@mail.gmail.com> <B8D6CA50DACE9E4AAADE9A4D56FBAAE62BC98C@039-SN1MPN1-004.039d.mgd.msft.net> <4ED91876.2030408@freescale.com> <B8D6CA50DACE9E4AAADE9A4D56FBAAE62BCAE8@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <B8D6CA50DACE9E4AAADE9A4D56FBAAE62BCAE8@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/02/2011 12:45 PM, Bhushan Bharat-R65777 wrote:
> Scott, I am not sure if there is any real use case where device needed to assigned beyond 2 level (host + immediate guest) in nested virtualization.

Userspace drivers in the guest is a more likely scenario than nested
virtualization, at least for us.  Our hardware doesn't support nested
virtualization, so it would have to be some slow emulation-based
approach (worse than e500v2, since we don't have multiple PID registers).

> But if there any exists then will not it be better to virtualizes the iommu (PAMU for Freescale)?

We can't virtualize the PAMU in any sort of transparent manner.  It's
not flexible enough to handle arbitrary mappings.  The guest will need
to cooperate with the host to figure out what mappings it can do.

-Scott

