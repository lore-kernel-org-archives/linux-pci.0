Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B510C2ED154;
	Fri, 27 Mar 2026 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621077; cv=none; b=iT+r7a7EP+GZMO3fG4+KIJMv1Cq8og0cpd9c9SIHTfgt6lCp9JrvsDzuWo66VH+OwiOMzAtbi/+VPm9FADXYTMoYHQYB75ARbZdYopwj2VzvHyhUnNTAMPZQUGELR1szt6PYFVxMhg2w+uo25CmYc0NJ9agt5icP7ZVZuUKj4Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621077; c=relaxed/simple;
	bh=tCfI5ViRKd25ZAkoswd7ai3JNE2ASmV6H4SeeBO1p7A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NBF5tt5sF5oKAz9LB6yxBTBtbYUlti+Sh0wff8TmP5YdCoWA0Nfv5WNZhWT6tyWQgdOOZLI8plkSq3JiU0+zYBYmVyJb9rF6RvRHavFr5e3WvKR3HqW2c8YPxV63NYhzT/QRoWg3wLW/bPRZ4vE8KeJpS5ekk0eRAcrxnjc5tpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYA2+A5K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYA2+A5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B768C19423;
	Fri, 27 Mar 2026 14:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774621077;
	bh=tCfI5ViRKd25ZAkoswd7ai3JNE2ASmV6H4SeeBO1p7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HYA2+A5K/FHbuvSJh8kHR4ylNmoJ+pnVoDO2riEtUGsnp1X0jYN5NxM42001Fxl0f
	 B/JneYXZHmmm7oFbzaUQEKXoMspbjx9ATL8g/CrFkXGI6KUm8ntOiTwUlteuQIcAxi
	 DauuUhQ57am/TxEs8tKLrOR4GPNWo0zoKT1yH2lEzzmB/2h8u/MQFWSBS+p+IKyvv8
	 7aPEa3VtHDJtx5b5u0MJ83HMvyKUwVl0aRo/v4AwrMvzUSiJXZrsK0z1lvMj47yRd4
	 Fe9RMsHQvPIbcqn09EJX1Koxc3eyApXZbKtDE20OLahv1e8NndaCmvmHst0eialdSr
	 vAcYZwi7M2ujA==
Date: Fri, 27 Mar 2026 09:17:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Tobias Heider <tobias.heider@canonical.com>,
	Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>, konradybcio@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
	kw@linux.com, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v1 1/1] arm64: dts: qcom: hamoa: Move PCIe PERST and Wake
 GPIOs to port nodes
Message-ID: <20260327141756.GA1381857@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAARv3RRqXxNePX=4RqnLu7OnfjQmStynsL9RCNY19EKQOTcnLQ@mail.gmail.com>

[->to: Bjorn A.]

On Tue, Mar 24, 2026 at 08:14:39PM +0100, Tobias Heider wrote:
> On Tue, Mar 24, 2026 at 7:07 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > On Thu, Mar 19, 2026 at 02:50:37PM +0100, Tobias Heider wrote:
> > > On Thu, Mar 19, 2026 at 6:39 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > > On Wed, Mar 18, 2026 at 09:42:56PM -0500, Bjorn Andersson wrote:
> > > > > On Mon, Mar 16, 2026 at 08:50:12AM +0530, Manivannan Sadhasivam wrote:
> > > > > > On Sun, Mar 15, 2026 at 09:53:33PM -0500, Bjorn Andersson wrote:
> > > > > > > On Sat, Mar 14, 2026 at 07:50:50PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > > On Fri, Mar 13, 2026 at 11:45:42AM -0500, Bjorn Helgaas wrote:
> > > > > > > > > On Fri, Mar 13, 2026 at 05:46:18PM +0800, Ziyue Zhang wrote:
> > > > > > > > > > Commit 960609b22be5 ("arm64: dts: qcom: hamoa: Move PHY, PERST, and Wake
> > > > > > > > > > GPIOs to PCIe port nodes and add port Nodes for all PCIe ports") did not
> > > > > > > > > > convert all Hamoa‑based platforms to the new method of defining PERST and
> > > > > > > > > > Wake GPIOs in the PCIe root port nodes.
> > > > > > > > > >
> > > > > > > > > > Without the change PCIe probe will fail. The probe failure happens because
> > > > > > > > > > the PHY stays in the controller node while the PERST/Wake GPIOs were moved
> > > > > > > > > > to the port nodes.
> > > > > > > > > >
> > > > > > > > > > This fixes probe failures seen on the following platforms:
> > > > > > > > > >  - x1-hp-omnibook-x14
> > > > > > > > > >  - x1-microsoft-denali
> > > > > > > > > >  - x1e80100-lenovo-yoga-slim7x
> > > > > > > > > >  - x1e80100-medion-sprchrgd-14-s1
> > > > > > > > > >  - x1p42100-lenovo-thinkbook-16
> > > > > > > > > >  - x1-asus-zenbook-a14
> > > > > > > > > >  - x1-crd
> > > > > > > > > >  - x1-dell-thena
> > > > > > > > > >
> > > > > > > > > > Fixes: 960609b22be5 ("arm64: dts: qcom: hamoa: Move PHY, PERST, and Wake GPIOs to PCIe port nodes and add port Nodes for all PCIe ports")
> > > > > > > > >
> > > > > > > > > Are you saying that DTs in the field broke because of some kernel
> > > > > > > > > change?  That's not supposed to happen.  Even though PHY, PERST, and
> > > > > > > > > Wake GPIOs should be described in Root Port nodes instead of the Root
> > > > > > > > > Complex node in *future* DTs, the kernel is still supposed to accept
> > > > > > > > > the old style with them described in the Root Complex node.
> > > > > > > > >
> > > > > > > >
> > > > > > > > This is not related to the driver change. The driver correctly parses all Root
> > > > > > > > Port properties either in the Root Complex node (old binding) or Root Port node
> > > > > > > > (new binding). But commit 960609b22be5, left converting mentioned board DTS to
> > > > > > > > the new binding, leaving those affected platforms in a half baked state i.e.,
> > > > > > > > some properties in RC node and some in Root Port node. Driver cannot parse such
> > > > > > > > combinations, so it fails correctly so.
> > > > > > > >
> > > > > > >
> > > > > > > Are you saying that above listed machines has broken PCIe support in
> > > > > > > v7.0-rc?
> > > > > > >
> > > > > >
> > > > > > I haven't verified it, but I'm pretty sure PCIe is broken on these platforms.
> > > > > >
> > > > >
> > > > > In line with Bjorn's request, we shouldn't have to guess.
> > > > >
> > > > > > > It seems this is a (partial) revert of 960609b22be5, is this actually
> > > > > > > fixing that change, or is it only applicable once some other changes are
> > > > > > > applied?
> > > > > > >
> > > > > >
> > > > > > This change is fixing the issue in the respective board DTS and is a standalone
> > > > > > fix on top of v7.0-rc1.
> > > > > >
> > > > >
> > > > > So 960609b22be5 was broken when I merged it?
> > > > >
> > > >
> > > > Broken on the machines mentioned in the commit message, not for all Hamoa
> > > > platforms.
> > > >
> > > > > The commit message says that the commit was incomplete, in that it
> > > > > didn't fully convert from the old to the new style, so it sounds like
> > > > > the offending commit was incomplete - but I believe the offending commit
> > > > > was a workaround for the new solution not being in place and this commit
> > > > > mostly reverts the changes in the offending commit.
> > > > >
> > > >
> > > > So 960609b22be5 was supposed to move all the platforms from old PCIe binding to
> > > > new for greater good, but it apparently decided to do so only for a subset of
> > > > the platforms for some reason which  don't know. But the problem arises due to
> > > > 960609b22be5 changing the hamoa.dtsi to the new binding which also warrants the
> > > > platform DTS to also be changed to the new binding. If we only have either dtsi
> > > > or dts converted and not both to the new binding, the driver will get confused
> > > > and fail. And this is what exactly happended for below machines:
> > > >
> > > >  - x1-hp-omnibook-x14
> > > >  - x1-microsoft-denali
> > > >  - x1e80100-lenovo-yoga-slim7x
> > > >  - x1e80100-medion-sprchrgd-14-s1
> > > >  - x1p42100-lenovo-thinkbook-16
> > > >  - x1-asus-zenbook-a14
> > > >  - x1-crd
> > > >  - x1-dell-thena
> > >
> > > I can confirm the breakage for (some of) the listed devices on Ubuntu.
> > > We are experimenting with 7.0-rcs ahead of our 26.04 release.
> > >
> > > I'll try to collect some test feedback for the fix.
> > > I'd certainly appreciate this being included as an rc fix since
> > > currently half of
> > > the x1 laptop devices are broken.
> > >
> >
> > Thanks for the report. We will try to get this patch into v7.0-rcS.
> >
> > It'd be appreciated if you can test this patch and give your tested-by tag.
> >
> > - Mani
> 
> Thank you!
> 
> Tested it myself and I have rolled this out to my ubuntu-concept testing repo.
> I have tested the CRD and got user feedback that it works on at least an
> Omnibook (where we first saw the regression without the patch) and Lenovo Yoga.
> Potentially more but not everyone provides feedback when things don't break.
> 
> Tested-by: Tobias Heider <tobias.heider@canonical.com>

I don't see this patch upstream yet.  It's a fix for 960609b22be5
("arm64: dts: qcom: hamoa: Move PHY, PERST, and Wake GPIOs to PCIe
port nodes and add port Nodes for all PCIe ports"), which looks like
it was merged by Bjorn A., so I assume the fix will go the same route?

Just want to make sure it's not waiting on me :)
