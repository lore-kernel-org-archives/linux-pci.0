Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 23 Jun 2014 11:02:49 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Marek Vasut <marex@denx.de>,
	Russell King <linux@arm.linux.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jg1.han@samsung.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ABRAHAM, KISHON VIJAY" <kishon@ti.com>,
	Richard Zhu <r65037@freescale.com>,
	Rob Herring <robh+dt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Grant Likely <grant.likely@linaro.org>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 0/8] Add Keystone PCIe controller driver
Message-ID: <20140623053249.GD2666@pratyush-vbox>
References: <1402426287-31157-1-git-send-email-m-karicheri2@ti.com>
 <53A453D1.4040308@ti.com>
 <53A46B49.3040009@ti.com>
 <14956334.eDhb2zObBc@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <14956334.eDhb2zObBc@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 21, 2014 at 03:05:30AM +0800, Arnd Bergmann wrote:
> On Friday 20 June 2014 13:11:37 Santosh Shilimkar wrote:

> > > 
> > Arnd suggestion was to have the version 3.65 code in generic place since
> > its IP specific and just in case some other vendor using the same version
> > can leverage the code.

Sorry, I do not follow PCIe mailing list these days, doing something else
now. So coming to this topic a bit delayed.

> > 
> > Concern here seems toe really those name of the files. I can't think of
> > any other appropriate name. 
> 
> We should definitely keep the version in the DT "compatible" strings
> wherever we know it. Regarding a better file name, I have no idea.

In my opinion, we do not need any of dw-v3_65 files, as code in these
files will not be usable by other vendors.

Anything which is implemented in application space, will not be same
across all IP users. For example, MSI0_IRQ_ENABLE_SET has been defined
at offset 0x108 in keystone PCIe application space.Other vendor may
not have this register at the same offset. Moreover, other vendors are
not even obliged to implement MSI Enable signals in same way, so
internal bit definition of the register may change.
      
Therefore code is not reusable if all register offset and bit
definitions are not same across vendors. So, in case of DW driver none
of the code which are accessed using va_app_base should go to common
area.

Regards
Pratyush

> 
> 	Arnd
