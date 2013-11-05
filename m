Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout10.yourhostingaccount.com ([65.254.253.86]:56414 "EHLO
	mailout10.yourhostingaccount.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755203Ab3KESKg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2013 13:10:36 -0500
Message-ID: <52792C5E.6030008@writeme.com>
Date: Tue, 05 Nov 2013 12:35:26 -0500
From: Sinan Akman <sinan@writeme.com>
MIME-Version: 1.0
To: Tim Harvey <tharvey@gateworks.com>
CC: Zhu Richard-R65037 <r65037@freescale.com>,
	=?windows-1252?Q?Marek_V?= =?windows-1252?Q?a=9Aut?=
	<marex@denx.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Pratyush Anand <pratyush.anand@st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Jingoo Han <jg1.han@samsung.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
References: <1379319655-20210-1-git-send-email-xobs@kosagi.com> <1379319655-20210-4-git-send-email-xobs@kosagi.com> <CAJ+vNU36neHP77dVnqSP=+oMxaU=-6PxWQ8Afni-tTRjNTkM_A@mail.gmail.com> <0E83723C55F66F43A6041464FE31119D40FC99@039-SN2MPN1-011.039d.mgd.msft.net> <CAJ+vNU13FA5s7tt-yEnBYNSBV+FHmHqZNoykFq8aF=O=TvqTnA@mail.gmail.com> <0E83723C55F66F43A6041464FE31119D40FD55@039-SN2MPN1-011.039d.mgd.msft.net> <CAJ+vNU2ifxfprYsgcQs+Kkgu37+diXHJS6DEqs4d51+U3F4sLQ@mail.gmail.com>
In-Reply-To: <CAJ+vNU2ifxfprYsgcQs+Kkgu37+diXHJS6DEqs4d51+U3F4sLQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/18/2013 11:34 AM, Tim Harvey wrote:
> On Fri, Oct 18, 2013 at 12:45 AM, Zhu Richard-R65037
> [...]
> How about with the upstream driver?  I have 'my own driver' as well
> (based on Freescale's BSP) which works, but I'm very interested in
> getting this upstream driver to work so we don't have to keep
> maintaining our own drivers.  Can you please test with this upstream
> driver?

   Tim, Sean what is the status of this patch ? Is it part of any tree 
already ? I'd like to test few things.

   Thanks

   Sinan Akman
