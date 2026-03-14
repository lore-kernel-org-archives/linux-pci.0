Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102A8239E76;
	Sat, 14 Mar 2026 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773498069; cv=none; b=iICgfNVpefuLu2pl/a2qOqYmRk41B4Wg0OdeRyYYdSzL4qJVdcI7LMf9PusDMKNffO0Ijd+F7SMIhuCpLS5EmGUrgB2rNm7sa1pNuJF5w2EEgIU8emc7F+GoeP/eS534a0+gnqX6VArIONmtxSuio9xUbGMpp/1WlFCl3RNn4rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773498069; c=relaxed/simple;
	bh=YdVf07ou5a2k64Dde6YPstlshLKg9I/2efrQvGdUQpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJif83SR8xjc2ReriBEXdwlr39pe44wazh31IkbNPjpYa9j7dsZzwIoLdQ/3mGFDkS0uScYnVI20TzeXIYRbIHQPzmj+a6s8lg8m08W0xgb0YyAR3HnsJdyjWsKZ6mcUm1zCJvnVlWnOdeSbDcM0q+gd7c0v/l/XB2+xP6MhHpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6sqYRo+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6sqYRo+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2560C116C6;
	Sat, 14 Mar 2026 14:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773498068;
	bh=YdVf07ou5a2k64Dde6YPstlshLKg9I/2efrQvGdUQpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6sqYRo+OmrrdWF3NQFAgx4mE/BObaNhmv+978Slt6FXdRWuUfDqoGz0LqPxY4ygA
	 IYYFWzOcoZHqgdu6/+PBxzus+2qRBhdkYJ2v0LnzajnLHrmTwOPAEUysX2vGdJMOxo
	 u4sdVBnB5cIkeBQTjUW1m3aQMUyqVi0GHU3s1KnTrJ4ujUILAYZKOYSntrGCy8OWW0
	 bLqMaoWptbo+TESpD2gnkNjFCJMCwP+6pjrocwJtoeRmNe1Jz7/VaWk7K0EYqvY/Lf
	 e3m8fItzg1l4H/1m9s7iJy09kIZNyVFmfi3MEqBgmGLVSmGWXK5v+dkvbuYZluZOIS
	 hMhEOdCy4hnRA==
Date: Sat, 14 Mar 2026 19:50:50 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>, andersson@kernel.org, 
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org, 
	neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, 
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v1 1/1] arm64: dts: qcom: hamoa: Move PCIe PERST and Wake
 GPIOs to port nodes
Message-ID: <en5a7jrgpbn4bsmw5qwprugb2qmjkqw2x5eey6jxxu63634duz@b43rhcsqkj3o>
References: <20260313094618.1361418-1-ziyue.zhang@oss.qualcomm.com>
 <20260313164542.GA1405513@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313164542.GA1405513@bhelgaas>

On Fri, Mar 13, 2026 at 11:45:42AM -0500, Bjorn Helgaas wrote:
> On Fri, Mar 13, 2026 at 05:46:18PM +0800, Ziyue Zhang wrote:
> > Commit 960609b22be5 ("arm64: dts: qcom: hamoa: Move PHY, PERST, and Wake
> > GPIOs to PCIe port nodes and add port Nodes for all PCIe ports") did not
> > convert all Hamoa‑based platforms to the new method of defining PERST and
> > Wake GPIOs in the PCIe root port nodes.
> > 
> > Without the change PCIe probe will fail. The probe failure happens because
> > the PHY stays in the controller node while the PERST/Wake GPIOs were moved
> > to the port nodes.
> > 
> > This fixes probe failures seen on the following platforms:
> >  - x1-hp-omnibook-x14
> >  - x1-microsoft-denali
> >  - x1e80100-lenovo-yoga-slim7x
> >  - x1e80100-medion-sprchrgd-14-s1
> >  - x1p42100-lenovo-thinkbook-16
> >  - x1-asus-zenbook-a14
> >  - x1-crd
> >  - x1-dell-thena
> > 
> > Fixes: 960609b22be5 ("arm64: dts: qcom: hamoa: Move PHY, PERST, and Wake GPIOs to PCIe port nodes and add port Nodes for all PCIe ports")
> 
> Are you saying that DTs in the field broke because of some kernel
> change?  That's not supposed to happen.  Even though PHY, PERST, and
> Wake GPIOs should be described in Root Port nodes instead of the Root
> Complex node in *future* DTs, the kernel is still supposed to accept
> the old style with them described in the Root Complex node.
> 

This is not related to the driver change. The driver correctly parses all Root
Port properties either in the Root Complex node (old binding) or Root Port node
(new binding). But commit 960609b22be5, left converting mentioned board DTS to
the new binding, leaving those affected platforms in a half baked state i.e.,
some properties in RC node and some in Root Port node. Driver cannot parse such
combinations, so it fails correctly so.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
