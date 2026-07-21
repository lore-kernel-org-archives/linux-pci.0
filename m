Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1BB353EE0;
	Tue, 21 Jul 2026 06:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784614597; cv=none; b=hz3ShifxQwj11xOMB9lgaPlILJTKbC0QJEhAf6KyPJaL94fEwjIy7iRyKUNJD/bjdOJbVSbLleqilyKi9k1GW6ScFa/WO+IXkFeAGhzRcSaYoWAlaRIXm0OAE91TGP7iqO9EF5NBYtVfhkjjEwMUvd16j3oqUV/rr8ERNzOgB/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784614597; c=relaxed/simple;
	bh=4sY465NWSwzqiWTdW7X0mX4+rz2Abo/1QgfDXYFtMGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaAqMYfQrwABWaSp5WX7L09VKPe7+7s3z8JIiOaW8DKyjCpOWsc0xfaHg+Y1YD/XoOLLr1FszLQ38M3qpxvK9KfFz7ExfBlqj+4qqlAZTnwVipJUZzvM6oCJHwc/OgK1oLKO9Ff9xXAjQByRa8Ms0OuywJ8x+zy2SipFKAX8DXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfuNRcYX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfuNRcYX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D191E1F000E9;
	Tue, 21 Jul 2026 06:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784614595;
	bh=PTn588y+YtF/kkI2+86cN1oYQblIbgof5q8GqN2Q5Tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hfuNRcYXY4vav7TsUn2QWb6Za1LbY9rNzNTBS/3l8hFDFNNVWXTRvGhcJzlrRtL8K
	 HXYWVjPu3kk0s2yKiTcbABNNo08j5M62SscJsSWMv/YQX7RmqHaeFIXup9P6hlrgFp
	 FuDflMHOexe8Xxf+/usZsHs0/j0TK2emGxvNUUpb18cy8M77ztGAurdx+M+s3Gtd+t
	 teHKobGXbJ2eFmCtefpJtcpw93Lct6WW6oAFxvzMzZqf46YR1DPJKS4ZZTSrWSqEkg
	 mRPNQ/fmDrjhjJEK/Lli/CGdrf9lZK0QRva8RQos/0tUXFn/O04SzKflOJmfkpzMHn
	 invJ9sr43p89Q==
Date: Tue, 21 Jul 2026 08:16:24 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
Cc: Frank Li <frank.li@nxp.com>, 
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hongxing Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v2] PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY
 power and reference clock control
Message-ID: <6oooulhpzzvmgdzwniwhmhrbhthernnbc2jy4j3x5yj5axj3qe@plst6pzx767f>
References: <20260708035928.580236-1-hongxing.zhu@oss.nxp.com>
 <20260708035928.580236-2-hongxing.zhu@oss.nxp.com>
 <afwyhy7npuvtecdbuzaytazbifu2ytb6admq4xbzbmxwx47vpq@wrc5dp62mtng>
 <GV2PR04MB1201914A80BB2BF78A10465748CC62@GV2PR04MB12019.eurprd04.prod.outlook.com>
 <GV2PR04MB12019C0F0554EC9A598512ABD8CC32@GV2PR04MB12019.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <GV2PR04MB12019C0F0554EC9A598512ABD8CC32@GV2PR04MB12019.eurprd04.prod.outlook.com>

On Mon, Jul 20, 2026 at 08:32:31AM +0000, Hongxing Zhu (OSS) wrote:
> > -----Original Message-----
> > From: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>
> > Sent: Friday, July 17, 2026 4:57 PM
> > To: Manivannan Sadhasivam <mani@kernel.org>; Hongxing Zhu (OSS)
> > <hongxing.zhu@oss.nxp.com>
> > Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de; lpieralisi@kernel.org;
> > kwilczynski@kernel.org; robh@kernel.org; bhelgaas@google.com;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com; linux-
> > pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; imx@lists.linux.dev;
> > linux-kernel@vger.kernel.org; Hongxing Zhu <hongxing.zhu@nxp.com>
> > Subject: RE: [PATCH v2] PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY
> > power and reference clock control
> > 
> > > -----Original Message-----
> > > From: Manivannan Sadhasivam <mani@kernel.org>
> > > Sent: Friday, July 17, 2026 12:35 AM
> > > To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>
> > > Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de;
> > > lpieralisi@kernel.org; kwilczynski@kernel.org; robh@kernel.org;
> > > bhelgaas@google.com; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > > festevam@gmail.com; linux- pci@vger.kernel.org;
> > > linux-arm-kernel@lists.infradead.org; imx@lists.linux.dev;
> > > linux-kernel@vger.kernel.org; Hongxing Zhu <hongxing.zhu@nxp.com>
> > > Subject: Re: [PATCH v2] PCI: imx6: Fix i.MX6Q/DL boot hang by
> > > separating PHY power and reference clock control
> > >
> > > On Wed, Jul 08, 2026 at 11:59:27AM +0800, hongxing.zhu@oss.nxp.com wrote:
> > > > From: Richard Zhu <hongxing.zhu@nxp.com>
> > > >
> > > > Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling
> > > > regulators") introduced a boot hang on i.MX6Q/DL variants by
> > > > changing the initialization sequence.
> > > >
> > > > The issue stems from coupling PHY power (TEST_PD) and reference
> > > > clock
> > > > (REF_CLK_EN) control in imx6q_pcie_enable_ref_clk(). When these are
> > > > managed together, the timing between PHY power-up and reference
> > > > clock enablement cannot be properly controlled, leading to
> > > > initialization failures.
> > > >
> > >
> > > What is the timing requirement here?
> > The timing requirement is that TEST_PD must be deasserted (cleared) before link
> > training starts.
> > 
> > Before commit 610fa91d9863:
> > - imx_pcie_assert_core_reset(): Assert TEST_PD and REF_CLK_EN
> > - imx_pcie_clk_enable(): Deassert TEST_PD and assert REF_CLK_EN
> > - Link training starts with TEST_PD properly cleared
> > 
> > After commit 610fa91d9863:
> > - imx_pcie_clk_enable(): Deassert TEST_PD and assert REF_CLK_EN
> > - imx_pcie_assert_core_reset(): Assert TEST_PD and assert REF_CLK_EN again
> > - Link training starts with TEST_PD still asserted (never cleared again)
> > 
> > This commit corrects the sequence, and makes sure the TEST_PD is cleared
> > before link training starts.
> > >
> > > > Fix this by separating the two concerns:
> > > >
> > > > - Move PHY power control (TEST_PD) to imx6q_pcie_core_reset() where it
> > > >   logically belongs with reset operations. This ensures PHY power state
> > > >   is managed as part of the core reset sequence.
> > > >
> > > > - Update imx6qp_pcie_core_reset() to call imx6q_pcie_core_reset() for
> > > >   shared PHY power management, avoiding code duplication.
> > > >
> > > > - Make imx6q_pcie_enable_ref_clk() responsible only for reference clock
> > > >   (REF_CLK_EN) control, simplifying its purpose.
> > > >
> > > > - Remove the 10us delay workaround from imx6q_pcie_enable_ref_clk() as
> > > >   proper sequencing is now handled by the core_reset functions.
> > > >
> > > > This refactoring ensures PHY power is controlled during reset
> > > > operations, fixing the boot hang while improving code maintainability.
> > > >
> > >
> > > This patch does too many things at once. Can't you split it and keep
> > > the minimal fix in one patch?
> > Okay, I'll split this into a patch series in v3.
> > Thanks.
> Hi Mani:
> I've attempted to split the changes as below:
> 1. Set/Clear TEST_PD in assert_core_reset()/deassert_core_reset()
> 2. Clean up imx6q_pcie_enable_ref_clk() to only manipulate the REF_CLK_EN bit
> 
> However, I found that patch 1 alone doesn't work correctly. Here's what happens:
> 
> With only patch 1 applied:
> - The board boots successfully, but fails to detect the remote endpoint device
> - Problem sequence:
>   Begin (TEST_PD asserted by default) 
>   → TEST_PD cleared + REF_CLK_EN asserted in clk_enable()
>   → TEST_PD asserted again in assert_core_reset()
>   → TEST_PD cleared in deassert_core_reset()
> 
> With both patches applied:
> - The board boots and detects the remote endpoint device successfully
> - Correct sequence:
>   Begin (TEST_PD asserted by default)
>   → REF_CLK_EN asserted in clk_enable() (TEST_PD remains untouched)
>   → TEST_PD asserted in assert_core_reset()
>   → TEST_PD cleared in deassert_core_reset()
> 
> The issue is that patch 1 relies on patch 2 to avoid prematurely clearing TEST_PD 
> in clk_enable(). Both changes are mandatory for the fix to work.
> 
> Given this dependency, would you prefer:
> - A two-patch series with the dependency clearly documented, or
> - A single combined patch since they cannot function independently.
> 

Hmm, then you should combine both in a single patch. But the commit message
should be accurate and properly describe what was causing issue, and why both
changes are necessary.

You should justify the delay removal also.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
