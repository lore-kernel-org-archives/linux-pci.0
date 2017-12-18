Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 18 Dec 2017 15:57:27 +0000
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
Message-ID: <20171218155726.GB8157@red-moon>
References: <20171120133222.27771-1-niklas.cassel@axis.com>
 <20171120133222.27771-2-niklas.cassel@axis.com>
 <20171130152843.GC12096@red-moon>
 <20171213135953.GA30833@axis.com>
 <ff784f40-a629-b9cb-0d85-d1356eb69a38@synopsys.com>
 <ac5ceb21-b547-427c-f5fc-a3deb6398c99@synopsys.com>
 <20171214122229.GB27348@e107981-ln.cambridge.arm.com>
 <816956be-90ff-be0e-748f-39c64e4e7833@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <816956be-90ff-be0e-748f-39c64e4e7833@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gustavo,

On Thu, Dec 14, 2017 at 12:38:04PM +0000, Gustavo Pimentel wrote:
> Ok. I will compile and test it now.

Have you managed to retrieve the patches and test them ?

Thank you,
Lorenzo

> Thanks.
> 
> 
> On 14/12/2017 12:22, Lorenzo Pieralisi wrote:
> > On Thu, Dec 14, 2017 at 12:16:38PM +0000, Gustavo Pimentel wrote:
> >> Hi Niklas and Lorenzo,
> >>
> >> I'm going to work on PCI software development now as told by Joao and I will
> >> test your code now.
> >>
> >> I was retrieving the patches through the patchwork
> >> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_project_linux-2Dpci_list_-3Fsubmitter-3D65580&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=paO6WYeoTil-HWIJVBhwaWcIZP7r95MZNRzKMN6kprU&s=yjtNhJKPJdsHD_A52xWSD2g_YNHuLhO1YADKsPaPsio&e= and I
> >> notice that its missing the patch 13 and 17, is this right?
> > No, you just have to refine the filter, I marked the DT bindings as
> > ready to be applied that's why they do not show up (and by the way
> > you can test the series even without those two patches - that are just
> > DT bindings).
> >
> > Thanks,
> > Lorenzo
> >
> >> If not, can you give me both patches location?
> >>
> >> Thanks.
> >>
> >>
> >> On 13/12/2017 17:21, Joao Pinto wrote:
> >>> Hi Niklas,
> >>>
> >>> ??s 1:59 PM de 12/13/2017, Niklas Cassel escreveu:
> >>>> On Thu, Nov 30, 2017 at 03:28:43PM +0000, Lorenzo Pieralisi wrote:
> >>>>> Jingoo, Joao,
> >>>>>
> >>>>> I am expecting your testing on the series and ACKs on the dwc related
> >>>>> patches please, according to v4 review - I will mark them as needs
> >>>>> review/ACK waiting for you to chime in.
> >>>>>
> >>>>> v4 thread:
> >>>>>
> >>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_patch_833882_&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=CQAV8rCgm2jd7m3iSWL5vBbGTqSc7yN3N7zeQDz-ZUY&s=mqyDi45qm4qE0jcm0KviYAoLHmMXMMIWEW-gAR0RKOw&e=
> >>>>>
> >>>> Hello Lorenzo, Jingoo, Joao,
> >>>>
> >>>> Tomorrow another 2 weeks has passed.
> >>>> V1 of this patch series was posted on 2017-10-13.
> >>> Sorry, I have been tight up with a debug session and not able to check this out.
> >>> Adding Gustavo in CC that is now also working in PCI software development.
> >>> I am going to check the code ASAP and we will test it as soon as the debug is
> >>> finished.
> >>>
> >>> Thanks.
> >>>
> >>>> I'm a bit worried that this patch series will not make it to linux-next
> >>>> in time for this patch series to be included in the 4.16 pull request.
> >>>>
> >>>> Here is the V5 patch series:
> >>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__patchwork.ozlabs.org_project_linux-2Dpci_list_-3Fseries-3D14364&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=CQAV8rCgm2jd7m3iSWL5vBbGTqSc7yN3N7zeQDz-ZUY&s=qXtUHFXK7_nCndQob0I0qDByBdJsL7rRjZ9cx7c847U&e=
> >>>>
> >>>> Perhaps any maintainer of a designware based PCIe driver could
> >>>> help out and test this patch series?
> >>>>
> >>>> Regards,
> >>>> Niklas
> >>>>
> >>
> 
> 
