Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35940 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752491AbeDJJ4L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Apr 2018 05:56:11 -0400
Date: Tue, 10 Apr 2018 10:56:02 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 6/9] PCI: dwc: Define maximum number of vectors
Message-ID: <20180410095602.GA27363@e107981-ln.cambridge.arm.com>
References: <cover.1523266508.git.gustavo.pimentel@synopsys.com>
 <bf7062c863f33b2951acc586b1f22d3497ee2f10.1523266508.git.gustavo.pimentel@synopsys.com>
 <20180409160356.GA14533@e107981-ln.cambridge.arm.com>
 <a75bab38-55b7-b788-5ab4-b777fad2b7ff@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a75bab38-55b7-b788-5ab4-b777fad2b7ff@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 10, 2018 at 08:59:30AM +0100, Gustavo Pimentel wrote:
> Hi Lorenzo,
> 
> On 09/04/2018 17:03, Lorenzo Pieralisi wrote:
> > On Mon, Apr 09, 2018 at 10:41:15AM +0100, Gustavo Pimentel wrote:
> >> Adds a callback that defines the maximum number of vectors that can be use
> >> by the Root Complex.
> >>
> >> Since this is a parameter associated to each SoC IP setting, makes sense to
> >> be configurable and easily visible to future modifications.
> >>
> >> The designware IP supports a maximum of 256 vectors.
> > 
> > I think that a DT property instead of a callback would have made more
> > sense - I struggle to see the point in defining a callback to initialize
> > a variable, this can be done in the generic dwc code (and a DT binding).
> 
> The addition of this callback was done in MSI-X patch series before I take over
> the PCIe Designware driver responsibility. However I remember a thread in which
> this subject was discussed (see [1]), maybe this could bring some light about
> the motive why is was done like this. If you don't agree I can do patch after
> this series only focusing on this topic in order to do like to suggested.
> 
> [1] -> https://www.spinics.net/lists/linux-pci/msg61835.html

Lucas has a point - it is fine to handle them as you do in this patch,
it does not make much sense to add a property for something that
strictly depends on the compatible string.

Thanks,
Lorenzo
