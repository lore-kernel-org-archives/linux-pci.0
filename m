Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 26 Mar 2014 15:35:11 +0000
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Rob Herring <robherring2@gmail.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Rob Landley <rob@landley.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patches@apm.com" <patches@apm.com>,
	"jcm@redhat.com" <jcm@redhat.com>
Subject: Re: [PATCH v5 2/4] arm64: dts: APM X-Gene PCIe device tree nodes
Message-ID: <20140326153511.GR17163@e106497-lin.cambridge.arm.com>
References: <1395270762-6055-1-git-send-email-tinamdar@apm.com>
 <1395270762-6055-3-git-send-email-tinamdar@apm.com>
 <CAL_Jsq+XxAtUeNKFi0hH=ehb_fhFvkM0U1Zm_j1LdtQZbvSzfA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+XxAtUeNKFi0hH=ehb_fhFvkM0U1Zm_j1LdtQZbvSzfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 26, 2014 at 02:28:42PM +0000, Rob Herring wrote:
> On Wed, Mar 19, 2014 at 6:12 PM, Tanmay Inamdar <tinamdar@apm.com> wrote:
> > This patch adds the device tree nodes for APM X-Gene PCIe controller and
> > PCIe clock interface. Since X-Gene SOC supports maximum 5 ports, 5 dts
> > nodes are added.
> 
> [snip]
> 
> > +               pcie0: pcie@1f2b0000 {
> > +                       status = "disabled";
> > +                       device_type = "pci";
> > +                       compatible = "apm,xgene-storm-pcie", "apm,xgene-pcie";
> > +                       #interrupt-cells = <1>;
> > +                       #size-cells = <2>;
> > +                       #address-cells = <3>;
> > +                       reg = < 0x00 0x1f2b0000 0x0 0x00010000   /* Controller registers */
> > +                               0xe0 0xd0000000 0x0 0x00200000>; /* PCI config space */
> 
> Where is the right place for config space? This binding has it here
> and others have it in ranges. Given that config space type is defined
> for ranges, I would think that is the right place. But Liviu's patches
> do not process config space entries in ranges. Perhaps we need a
> config space resource populated in the bridge struct.

Rob,

Have a look at the discussion between Will and Arnd on the subject of virtual PCI
host controller for arm 32bit. My understanding is that config space is described
via reg entries.

See here: http://archive.arm.linux.org.uk/lurker/message/20140205.190947.b3c3e464.en.html

Best regards,
Liviu

> 
> Rob
> 
> 
> > +                       reg-names = "csr", "cfg";
> > +                       ranges = <0x01000000 0x00 0x00000000 0xe0 0x00000000 0x00 0x00010000   /* io */
> > +                                 0x02000000 0x00 0x10000000 0xe0 0x10000000 0x00 0x80000000>; /* mem */
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

