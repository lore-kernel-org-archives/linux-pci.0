Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:12342 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218Ab3FKEsU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jun 2013 00:48:20 -0400
From: Jay Agarwal <jagarwal@nvidia.com>
To: 'Thierry Reding' <thierry.reding@gmail.com>,
	Stephen Warren <swarren@wwwdotorg.org>
CC: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	"olof@lixom.net" <olof@lixom.net>, Hiroshi Doyu <hdoyu@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	"mturquette@linaro.org" <mturquette@linaro.org>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Juha Tukkinen <jtukkinen@nvidia.com>,
	Krishna Thota <kthota@nvidia.com>
Date: Tue, 11 Jun 2013 10:17:52 +0530
Subject: RE: [PATCH V4 2/4] ARM: tegra: pcie: Add tegra3 support
Message-ID: <C79B248886DD134989C8FF6B096A91AB91B616BEEE@BGMAIL01.nvidia.com>
References: <1370445221-17696-1-git-send-email-jagarwal@nvidia.com>
 <51AF68F1.8080307@wwwdotorg.org> <20130610200906.GD25859@mithrandir>
In-Reply-To: <20130610200906.GD25859@mithrandir>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> * PGP Signed by an unknown key
> 
> On Wed, Jun 05, 2013 at 10:36:01AM -0600, Stephen Warren wrote:
> > On 06/05/2013 09:13 AM, Jay Agarwal wrote:
> > > - Make private data structure for each SoC
> > > - Add required Tegra30 clocks and regulators
> > > - Add Tegra30 specific code in enable controller
> > > - Added Tegra30 specific properties in pci binding document
> >
> > It's a bit odd to send an updated version of just some of the patches;
> > reposting a whole series is much easier for the person applying the
> > patches. However, hopefully Thierry can handle it in this case.
> 
> Yes, I think I can handle it. It might be good to have Jay look at the final
> patches when I'm done, though, to make sure I haven't forgotten anything.
> 
Yes, please let me know whenever you have integrated my patches to your repo, so that I can sync, review & verify again.
