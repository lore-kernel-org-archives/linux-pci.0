Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34900 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750876AbeCPSb2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Mar 2018 14:31:28 -0400
Date: Fri, 16 Mar 2018 18:31:58 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: Re: [PATCH v4 3/4] PCI: hv: Remove hbus->enum_sem
Message-ID: <20180316183158.GA13569@red-moon>
References: <KL1P15301MB0006E2FA71F87B312D9DECA4BFD00@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180316105424.GA24198@e107981-ln.cambridge.arm.com>
 <KL1P15301MB00064DA6B4D221123B5241CFBFD70@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <KL1P15301MB00064DA6B4D221123B5241CFBFD70@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 16, 2018 at 05:41:27PM +0000, Dexuan Cui wrote:
> > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Sent: Friday, March 16, 2018 03:54
> > ...
> > Dexuan,
> > while applying/updating these patches I notice this one may be squashed
> > into: https://patchwork.ozlabs.org/patch/886266/
> > 
> > since they logically belong in the same patch. Are you OK with me doing
> > that ? Is my reading correct ?
> > Lorenzo
> 
> I'm OK. 
> I used two patches
> [PATCH v4 1/2] PCI: hv: Serialize the present and eject work items
> [PATCH v4 3/4] PCI: hv: Remove hbus->enum_sem
> only because the first fixed a real issue and hence IMO should go into
> stable kernels, and the second is only a cleanup patch, which doesn't
> need go into stable kernels.
> 
> Either way is ok to me. 
> Please feel free to do whatever you think is better. :-)

OK, patch series reworked and queued in my pci/hv branch please have
a look and let me know if that looks OK for you, I won't ask Bjorn
to move it into -next till you give me the go-ahead.

Thanks,
Lorenzo
