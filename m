Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749064949FD;
	Wed, 21 Jan 2026 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769004777; cv=none; b=rHXHtyhFEnXJqinyViSqxQI7dDEz5+CkuQhZgG/ExyK98PObpyfDyFV9NqXmOA2F3CW7xVZkffBA8vS09Eac2Ca8Czutq3UH50B/4S64H08InGKPBgdIxckE62bG3kcnM6v52ZmDZD/AEdv3NamTeVghvisxBV0VhS6F0dEgNEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769004777; c=relaxed/simple;
	bh=6kktsMAIgzuppPfg+esgkLdDxkG9DSNPa9v/4DbGfoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaDQbCABu+/MVSlxhjf5VfGtwWJQsdrUgA+SEMVuVWNBk2S3c2g6uUA7eFNXfHNsfxCo2RANmYUK5JqlJMN3Q43vCqod5wXoWy6CRf/eJsJD2wcD/ABkK5XEXBawsDuJB+47erb3TPp9HN4xOIOgriT2yxCjzcT45AqvxpnW3+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoZKSiI5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoZKSiI5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CF8C116D0;
	Wed, 21 Jan 2026 14:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769004777;
	bh=6kktsMAIgzuppPfg+esgkLdDxkG9DSNPa9v/4DbGfoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HoZKSiI5sPvIK6dF7Xv3OPSskgpei2RJZfagCweLCO77aK3wmniw1s7UUH6dsFmKO
	 e7FAEf2XMMXkdkBAaJ8qU2NyjjMWy4YV/RFGJolWS6L2UMyz25dJencETKsNrmMo90
	 ODWDzeG735D+TrVU9NWfaNHyq3EiJRkQQJeIu/7zWxLmDr1iw8bCpNjFgmrra1eRIu
	 Hodbu0M9O8ANkGQ0F0ThoLrfE3F9AwkrZkZO4hwxvwXMhaUxYcqQS17WlfLclBuzOH
	 I9S2vWqPq2omPpZSgv/NjHqX6T/I4hrShWuZ9kbdATAtOh51RgXzkdDL8eLkG4A268
	 tY4lMlDddQI6g==
Date: Wed, 21 Jan 2026 19:42:44 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dwc: Remove duplicate
 dw_pcie_ep_hide_ext_capability() function
Message-ID: <z4drma35p6e7vjj36ilg3rkqebjl42c7iawg5dewfkpagxhx4w@fvw4jgbxcfso>
References: <20251224-remove_dw_pcie_ep_hide_ext_capability-v1-1-4302c9cdc316@oss.qualcomm.com>
 <aVPgL2AuAMpx76pI@ryzen>
 <aXCmuFA8JwmRofis@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXCmuFA8JwmRofis@ryzen>

On Wed, Jan 21, 2026 at 11:13:12AM +0100, Niklas Cassel wrote:
> On Tue, Dec 30, 2025 at 03:22:39PM +0100, Niklas Cassel wrote:
> > Hello Qiang Yu,
> > 
> > On Wed, Dec 24, 2025 at 02:10:46AM -0800, Qiang Yu wrote:
> > > Remove dw_pcie_ep_hide_ext_capability() and replace its usage with
> > > dw_pcie_remove_ext_capability(). Both functions serve the same purpose
> > > of hiding PCIe extended capabilities, but dw_pcie_remove_ext_capability()
> > > provides a cleaner API that doesn't require the caller to specify the
> > > previous capability ID.
> > > 
> > > Compile-tested only. Runtime testing on RK3588 hardware would be
> > > appreciated.
> > 
> > This patch does not appy on top of pci/controller/dwc
> > 
> > Anyway, I applied it manually, and tested, thus:
> > Tested-by: Niklas Cassel <cassel@kernel.org>
> 
> I just tried to apply this patch for pci/controller/dwc and right now,
> this patch does apply.
> 
> Mani, any chance to get this picked up?
> 

Qiang was supposed to submit a series addressing a few more issues pointed
by Bjorn. Since you reported that this patch didn't apply on top of
controller/dwc, I didn't apply it.

But now did, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
