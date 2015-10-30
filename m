Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20151029232238.GB11994@localhost>
References: <1445596035-27733-1-git-send-email-lftan@altera.com>
	<20151027142644.GA8660@localhost>
	<CAFiDJ5_vCqh=uKkF2E_BQkJUv692r3yr26bBj8boK2DY_Dj+gA@mail.gmail.com>
	<CAErSpo5okE86k846hs28s4jvL59hmm+4az-dDsymzNayPCPCzw@mail.gmail.com>
	<CAFiDJ59wOUj-Mr3cyqQEz+P=8AkmRoy7XzUCmM33_e03Y2G_ZQ@mail.gmail.com>
	<20151029232238.GB11994@localhost>
Date: Fri, 30 Oct 2015 13:51:27 +0800
Message-ID: <CAFiDJ59QNqK6Np8Pp7JDV7Xr2mn3TEXpO2GPH12VYO4QOhtK+g@mail.gmail.com>
Subject: Re: [PATCH v12 0/6] Altera PCIe host controller driver with MSI support
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 30, 2015 at 7:22 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:

>> >>>
>> >>> I applied these to pci/host-altera for v4.4, thanks!
>> >>>
>> >>> I squashed these into three patches:
>> >>>
>> >>>   - add msi.h to Kbuild
>> >>>   - add Altera host driver (including DT binding and MAINTAINERS update)
>> >>>   - add Altera MSI driver (including DT binding and MAINTAINERS update)
>> >>>
>> >>> Since the convention is to add PCI ID #defines only when they are used in
>> >>> multiple places, I replaced PCI_VENDOR_ID_ALTERA with 0x1172 in the single
>> >>> place it is used.
>> >> Hi Bjorn
>> >>
>> >> Thanks for applied these.
>> >>
>> >> By the way, I can't see pci/host-altera branch in your pci.git tree
>> >> yet. It takes some time to appear there?
>> >
>> > Sorry, I forgot to push it.  It should be there now!
>> >
>> Yes, saw it now. It will merge to 'next' branch eventually?
>
> Yep, I just merged it to 'next' and pushed it.

Saw it. Thanks!

Regards
Ley Foon
