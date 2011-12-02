Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:34412
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932066Ab1LBS1I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2011 13:27:08 -0500
Message-ID: <4ED91876.2030408@freescale.com>
Date: Fri, 2 Dec 2011 12:27:02 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Bhushan Bharat-R65777 <R65777@freescale.com>
CC: Stuart Yoder <b08248@gmail.com>,
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
	Wood Scott-B07421 <B07421@freescale.com>,
	"benve@cisco.com" <benve@cisco.com>
Subject: Re: [Qemu-devel] [RFC PATCH] vfio: VFIO Driver core framework
References: <20111103195452.21259.93021.stgit@bling.home> <4ED43AD9.5090509@au1.ibm.com>	<4ED43CFE.8040009@au1.ibm.com> <1322538856.19120.126.camel@bling.home> <1322594768.19120.194.camel@bling.home> <CALRxmdDEGwA787gEgC3d_yU99TqOZOtWeDJ9N-QCQ3gxV8yyMw@mail.gmail.com> <1322610273.19120.209.camel@bling.home> <CALRxmdBaguEZD8CnogHv+mSPuLx9et1CGRAa8oO_182Pjjp6-Q@mail.gmail.com> <1322672293.19120.232.camel@bling.home> <CALRxmdAjeyyM3Ta+DCTxtdc_J69fnVko_9hzmjcLUCe8SskNnQ@mail.gmail.com> <1322774717.26545.118.camel@bling.home> <CALRxmdDZjFGjdrEC5e1ANGV+PYd5Mz7j3zeaKNiEUwLdNzmiEA@mail.gmail.com> <B8D6CA50DACE9E4AAADE9A4D56FBAAE62BC98C@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <B8D6CA50DACE9E4AAADE9A4D56FBAAE62BC98C@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/02/2011 12:11 PM, Bhushan Bharat-R65777 wrote:
> How do we determine whether guest is ready or not? There can be multiple device get ready at different time.

The guest makes a hypercall with a device handle -- at least that's how
we do it in Topaz.

> Further if guest have given the device to it user level process or its guest. Should not there be some mechanism for a guest to enable/disable on per device or group?

Yes, the same mechanism can be used for that -- though in that case
we'll also want the ability for the guest to be able to control another
layer of mapping (which will get quite tricky with PAMU's limitations).
 This isn't really VFIO's concern, though (unless you're talking about
the VFIO implementation in the guest).

-Scott

