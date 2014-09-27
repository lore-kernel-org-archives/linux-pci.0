Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20140926224752.GB22030@e106497-lin.cambridge.arm.com>
References: <1411498874-9864-1-git-send-email-Liviu.Dudau@arm.com>
 <1411498874-9864-9-git-send-email-Liviu.Dudau@arm.com> <CAL_Jsq+j40Xf208wCf4as3H=cDU=htJ-JWinB0DjpcORjatNXQ@mail.gmail.com>
 <20140926212052.GA6030@borg.dudau.co.uk> <CAL_JsqKJ6bfPuOofo4grVm3qW_WOpUzcS1juZvHxZdFyyF_19A@mail.gmail.com>
 <20140926224752.GB22030@e106497-lin.cambridge.arm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 27 Sep 2014 14:18:55 -0600
Message-ID: <CAErSpo5Q-gZaeV91+UeMjmnUt7jqGndDY6zfZqsDWJUNh+Gm6A@mail.gmail.com>
Subject: Re: [PATCH v12 08/12] PCI: OF: Introduce helper function for
 retrieving PCI domain numbers
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Rob Herring <robherring2@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh+dt@kernel.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Sinan Kaya <okaya@codeaurora.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Suravee Suthikulanit <suravee.suthikulpanit@amd.com>,
	linux-arch <linux-arch@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Device Tree ML <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yinghai]

On Fri, Sep 26, 2014 at 4:47 PM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> On Fri, Sep 26, 2014 at 10:53:26PM +0100, Rob Herring wrote:

>> I thought Bjorn already applied the series. Who's agreement are you
>> waiting for specifically.
>
> Looks like he only applied about 60% of the series.

I applied it all but Yinghai pointed out a problem with a patch in the
middle, so I dropped that patch and everything after it because I didn't
have time to work out whether the later patches depended on anything
in the one I dropped.

Bjorn
