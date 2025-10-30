Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D932433BBB2;
	Thu, 30 Oct 2025 22:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761863678; cv=none; b=By7A+7TJnMLvXHLBEnIgeQvsr1e2izft9bqrV/d/16fzAH3h4eKeRjiECPbiTqmO0HdblboRjQmcc6dwKdO/nTwVqAVMnaCFX6qClK34PVEiTgduV9mHs1Y8FTXBrnoTWW+JFj6VUmJEfu13EqQPwkGU1C+XaOv/xws6f8QauzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761863678; c=relaxed/simple;
	bh=G4Yiz/LALEjDxLYZP+aL0NeqsH24ZRVAOIw1IXa6xOY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Xdt6hipc4k9y2gvQO+onIzeh0G0nM9ogZqECf4H1JRJ2iJvADZeFg5O1LrJmQoDFx+rqShz77p1YHj9GhAd+EWoFlauJ4cDFBMr1mqCwIjrFYfLNLaiHTwVpb5788K+iMkO63TJ1/EhVFWZvvc/gVscjtFbgs+jGrNiHVDNNfSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oga7oDxB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oga7oDxB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F8DC4CEF1;
	Thu, 30 Oct 2025 22:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761863677;
	bh=G4Yiz/LALEjDxLYZP+aL0NeqsH24ZRVAOIw1IXa6xOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Oga7oDxBFs1u1XLldAtpT5BGbwo7QQeT1r2/wZjcQ0MrAY7PzZ1xNKjp8G/HGGq8O
	 ySE/wkiz768TadltWtuu9YS6jVivgJ0JCcQi4zGfX1MyHC51MF/qlSwxym2H4ryTxD
	 s+YPoV/089EJmJB/zo/62MbxC0DNdeuAle9vZUuR6vdVnvzDbhF9tmg7Z/dnjwr63+
	 hUMdTLrvx4rAZmohl6vQtI9NTCFpXOkV+vtgqsqflv/FpoRppqMLJ3GpWkTVlZyILJ
	 5AGOLG+eKJXu2X5ZYIG0nQCN3g0GXhH0EjbTIzjh//kOH80pE73zFqo0W02rZoO1dZ
	 TYZJum+kJPStw==
Date: Thu, 30 Oct 2025 17:34:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linnaea Lavia <linnaea-von-lavia@live.com>
Cc: "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	regressions@lists.linux.dev, Yue Wang <yue.wang@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: PCIe probe failure on AmLogic A311D after 6.18-rc1
Message-ID: <20251030223436.GA1657470@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023164205.GA1299816@bhelgaas>

On Thu, Oct 23, 2025 at 11:42:05AM -0500, Bjorn Helgaas wrote:
> #regzbot ^introduced: v6.18-rc1

#regzbot report: https://lore.kernel.org/r/DM4PR05MB102707B8CDF84D776C39F22F2C7F0A@DM4PR05MB10270.namprd05.prod.outlook.com
#regzbot introduced: f3ac2ff14834

f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
