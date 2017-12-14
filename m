Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751719AbdLNMWg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Dec 2017 07:22:36 -0500
Date: Thu, 14 Dec 2017 12:22:29 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>
Subject: Re: [PATCH v5 01/18] PCI: dwc: Use the DMA-API to get the MSI address
Message-ID: <20171214122229.GB27348@e107981-ln.cambridge.arm.com>
References: <20171120133222.27771-1-niklas.cassel@axis.com>
 <20171120133222.27771-2-niklas.cassel@axis.com>
 <20171130152843.GC12096@red-moon>
 <20171213135953.GA30833@axis.com>
 <ff784f40-a629-b9cb-0d85-d1356eb69a38@synopsys.com>
 <ac5ceb21-b547-427c-f5fc-a3deb6398c99@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ac5ceb21-b547-427c-f5fc-a3deb6398c99@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 14, 2017 at 12:16:38PM +0000, Gustavo Pimentel wrote:
> Hi Niklas and Lorenzo,
> 
> I'm going to work on PCI software development now as told by Joao and I will
> test your code now.
> 
> I was retrieving the patches through the patchwork
> https://patchwork.ozlabs.org/project/linux-pci/list/?submitter=65580 and I
> notice that its missing the patch 13 and 17, is this right?

No, you just have to refine the filter, I marked the DT bindings as
ready to be applied that's why they do not show up (and by the way
you can test the series even without those two patches - that are just
DT bindings).

Thanks,
Lorenzo

> If not, can you give me both patches location?
> 
> Thanks.
> 
> 
> On 13/12/2017 17:21, Joao Pinto wrote:
> > Hi Niklas,
> >
> > ??s 1:59 PM de 12/13/2017, Niklas Cassel escreveu:
> >> On Thu, Nov 30, 2017 at 03:28:43PM +0000, Lorenzo Pieralisi wrote:
> >>> Jingoo, Joao,
> >>>
> >>> I am expecting your testing on the series and ACKs on the dwc related
> >>> patches please, according to v4 review - I will mark them as needs
> >>> review/ACK waiting for you to chime in.
> >>>
> >>> v4 thread:
> >>>
> >>> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_patch_833882_&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=CQAV8rCgm2jd7m3iSWL5vBbGTqSc7yN3N7zeQDz-ZUY&s=mqyDi45qm4qE0jcm0KviYAoLHmMXMMIWEW-gAR0RKOw&e=
> >>>
> >> Hello Lorenzo, Jingoo, Joao,
> >>
> >> Tomorrow another 2 weeks has passed.
> >> V1 of this patch series was posted on 2017-10-13.
> > Sorry, I have been tight up with a debug session and not able to check this out.
> > Adding Gustavo in CC that is now also working in PCI software development.
> > I am going to check the code ASAP and we will test it as soon as the debug is
> > finished.
> >
> > Thanks.
> >
> >> I'm a bit worried that this patch series will not make it to linux-next
> >> in time for this patch series to be included in the 4.16 pull request.
> >>
> >> Here is the V5 patch series:
> >> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_project_linux-2Dpci_list_-3Fseries-3D14364&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=CQAV8rCgm2jd7m3iSWL5vBbGTqSc7yN3N7zeQDz-ZUY&s=qXtUHFXK7_nCndQob0I0qDByBdJsL7rRjZ9cx7c847U&e=
> >>
> >> Perhaps any maintainer of a designware based PCIe driver could
> >> help out and test this patch series?
> >>
> >> Regards,
> >> Niklas
> >>
> 
> 
