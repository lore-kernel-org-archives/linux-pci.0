Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766652248A0;
	Mon, 16 Mar 2026 03:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773631604; cv=none; b=Y/i4yIWyBdPPjbvOpAVG6CD32ldkqihMWlkj/Ih6P1WwQqQi6iQmtcBHezFeDlK6HGvKfWV2qo876mkCbdppGGLngyXiCh2yLkvas8me8CeFd2u9IAZyUwKYYd4N/oExmxbm/XnfwUr+kKcUO8D9K53fvselWdN7BPEbZLIOdXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773631604; c=relaxed/simple;
	bh=sgdALoR0VYscVtPqY92tNwojFsvFl1BLlsT4yLskaU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7ipek+5pSjmpZZTNpF3cufruTDLG2QYKz/uTqPMkaVnPveC6MTecn8C3QUhY07lcbTAVwNWzvrB7+rmy3WKKovmbbxcQ9SE34y5mvKqRcG2KoJnxmNnP1M+duFolEzo/SaZ9BcU+SS2GKH44xOJEQlQWwQcD/Xyfa9/ETr/j8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5/tRw39; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5/tRw39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B6DC19425;
	Mon, 16 Mar 2026 03:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773631604;
	bh=sgdALoR0VYscVtPqY92tNwojFsvFl1BLlsT4yLskaU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5/tRw39AugTN2V0Fr4z2IF0YErZQoenEo9A99d06iJsE/DjvSHMPQugrkjU6xtwF
	 sCGazZxdL1qdS/i9dYd3UVwvrUJkWTeY8cdzaTlcO8sdSDUFX1d7aRxnc3xmPPHlER
	 gQhoMwxnx2Pm2Ej3X5I4lS9HygrF4BpuqwUT7PEnlRFwshSWcKtkDKZrqovw7/I/Uu
	 ssNFJvED0M32sPrgjXwAsXjfMLZlv/w4bd8K1KyRJoiJshkiOMF+oyWVXE+xOkXYQn
	 kM1V3j0Ju+CfdtIfdMg9Ozse3YjK3CsJ26z0OBNa4FKbnhry/7rnV7Yq6MWB+UOhXo
	 RfPMKilGGHhPA==
Date: Mon, 16 Mar 2026 08:56:33 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, 
	Jon Hunter <jonathanh@nvidia.com>, "kishon@kernel.org" <kishon@kernel.org>, 
	"arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"Frank.Li@nxp.com" <Frank.Li@nxp.com>, "den@valinux.co.jp" <den@valinux.co.jp>, 
	"hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>, 
	Vidya Sagar <vidyas@nvidia.com>, "cassel@kernel.org" <cassel@kernel.org>, 
	"18255117159@163.com" <18255117159@163.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/9] PCI: tegra194: Drive CLKREQ# signal low explicitly
Message-ID: <js7ev7dxc4zzal7lt6r632gtsm2dlcotncqgpgyytdritnismy@t62pcftuj3nk>
References: <20260303065758.2364340-1-mmaddireddy@nvidia.com>
 <20260303065758.2364340-2-mmaddireddy@nvidia.com>
 <vtylufhul43vacnq6gxvoyshtiesl2is5rmfgxw2ijlzntyvch@sbt7dhufem6q>
 <2ec931b6-a287-419e-821e-35420c12378d@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ec931b6-a287-419e-821e-35420c12378d@nvidia.com>

On Sun, Mar 15, 2026 at 10:46:08PM +0530, Manikanta Maddireddy wrote:
> 
> 
> On 05/03/26 4:28 pm, Manivannan Sadhasivam wrote:
> > On Tue, Mar 03, 2026 at 12:27:50PM +0530, Manikanta Maddireddy wrote:
> > > From: Vidya Sagar <vidyas@nvidia.com>
> > > 
> > > Currently, the default setting is that CLKREQ# signal of a Root Port
> > > is internally overridden to '0' to enable REFCLK to flow out to the slot.
> > > It is observed that one of the PCIe switches (case in point Broadcom PCIe
> > > Gen4 switch) is propagating the CLKREQ# signal of the Root Port to the
> > > downstream side of the switch and expecting the Endpoint devices to pull
> > > it low so that it (PCIe switch) can give out the REFCLK although the Switch
> > > as such doesn't support CLK-PM or ASPM-L1SS. So, as a workaround, this
> > > patch drives the CLKREQ# of the Root Port itself low to avoid link up
> > > issues between PCIe switch downstream port and Endpoint devices. This is
> > 
> > Is the CLKREQ# signal shared with the switch and the endpoint devices
> > connected to its downstream port also?
> > 
> Yes, this is the observation.
> 
> > > not a wrong thing to do after all the CLKREQ# is anyway being overridden
> > > to '0' internally and now it is just that the same is being propagated
> > > outside also.
> > > 
> > 
> > What do you mean by 'propagating outside'?
> > 
> > And what is the difference between APPL_PINMUX_CLKREQ_OVERRIDE and
> > APPL_PINMUX_CLKREQ_DEFAULT_VALUE?
> > 
> > - Mani
> APPL_PINMUX_CLKREQ_OVERRIDE: This overrides CLKREQ# input PAD to PCIe
> controller.
> APPL_PINMUX_CLKREQ_OVERRIDE: This overrides CLKREQ# output PAD to low.
> Propagating outside means driving CLKREQ# pin as low.
> 

From the commit message, it looks like APPL_PINMUX_CLKREQ_OVERRIDE itself
drivers the CLKREQ# signal to low (0), so it is not clear to me what this new
APPL_PINMUX_CLKREQ_DEFAULT_VALUE setting does.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
