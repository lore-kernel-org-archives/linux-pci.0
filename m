Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34321 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbbKBVIH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2015 16:08:07 -0500
Received: by lfgh9 with SMTP id h9so20882793lfg.1
        for <linux-pci@vger.kernel.org>; Mon, 02 Nov 2015 13:08:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151022180813.GA25693@localhost>
References: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
	<1444979960-24100-5-git-send-email-Minghuan.Lian@freescale.com>
	<20151021213612.GK1583@localhost>
	<CADRPPNSPP1m_7zNF6wEfw9+Bpe=Z_gUA81cSaV4SENVpR34YWQ@mail.gmail.com>
	<20151022180813.GA25693@localhost>
Date: Mon, 2 Nov 2015 15:08:04 -0600
Message-ID: <CADRPPNRQCrSukyjnS1yBck-jaNTWFOFJy3tomeD0HnXwc8WOBQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] PCI: layerscape: add PCIe support for LS1043a and LS2080a
From: Li Yang <leoli@freescale.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
	Jingoo Han <jg1.han@samsung.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 22, 2015 at 1:08 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Hi Leo,
>
> On Thu, Oct 22, 2015 at 12:38:48PM -0500, Li Yang wrote:
>> On Wed, Oct 21, 2015 at 4:36 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > On Fri, Oct 16, 2015 at 03:19:19PM +0800, Minghuan Lian wrote:
>> >> Both LS1043a and LS2080a are based on ARMv8 64-bit architecture
>> >> and have similar PCIe implementation. LUT is added to controller.
>> >> The patch removes the necessary fields from struct ls_pcie.
>> >>
>> >> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
>> >> ---
>> >> This patch is based on v4.3-rc4 and [PATCH v10 3/6]
>> >> PCI: designware: Add ARM64 support.
>>
>> Hi Bjorn,
>>
>> Are you also applying this patch
>> https://patchwork.ozlabs.org/patch/531184/ in this merge windows?
>> Because the new hardware can only work with the generic ARM64 support
>> added in the designware pcie driver.
>
> I'm reviewing that patch right now, and I do hope to apply it for
> v4.4.
>
> There was no cover letter for this series (Minghuan's Layerscape v4
> series), and I didn't see any mention of dependencies, so I applied it
> on top of v4.3-rc1.  Is that the wrong thing to do?  If it depends on
> the Zhou's v11 series, I can hold the Layerscape branch until after
> that.

I noticed that you have merged Zhou's latest patch.  Probably you can
also merge the Layerscape branch now.

Regards,
Leo
