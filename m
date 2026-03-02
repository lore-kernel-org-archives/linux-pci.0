Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96071390999;
	Mon,  2 Mar 2026 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772494443; cv=none; b=nc3ih00v7n2mjlk877ZV55NAICDgMxKvTVf1OSkxUwwl1uPQSA4HoQyghOFyJ4Qv+HFfwC67scoSWB/QrvHJNBUpTTfNrSEjvbWT04Cv+y1R486sjG3ipKKNvx06FMti/1TeDJ1pPSjs4OY8YHg2UD5iwD1gUCM4sXmaCd+V+zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772494443; c=relaxed/simple;
	bh=mL6f56HgyQO2Y7b3yScPWfCJ2EH+1ll0FYkWzkDjtPA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=c03tLBVQqLknP8C+kdGfQPu9OxUygamflp8zGBxbbJrqxBqs5U/L7Abiv9bVkqr8DY8mUmyQB2MjLFXdCBGeephFzhOzWhvpAvwe5llavzu8oiNZxJG6WTJfzeYPJB+T1CIX/3Ulb7f+UjmaNNrycIx5GyKyR1PO2lb7Pgo9BMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgwRz9mo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgwRz9mo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26C9C19423;
	Mon,  2 Mar 2026 23:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772494443;
	bh=mL6f56HgyQO2Y7b3yScPWfCJ2EH+1ll0FYkWzkDjtPA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hgwRz9mo1f6P8lEaYvZLYQSexkcYULCY412yJXRHh8WsDcaGflxIaqXD0rytVzK8U
	 kLKPoOZ3GddfXKEdvKKlTvkVEM8j9pOoHByDdtwVpCSS1W98FfjtLG1xKXbHTOCRxL
	 WealVtc3Z64TH/4TIfMdymDmXy5x+GxgLK8JvO8n6TP5bA3y91wNFOH+RGlliY5JPL
	 jbwxLv+ShytokK7eZASQT+naboVkF/HXkSY9Oydaz05uMydcoG1f5FBOTWpJvI2k24
	 Et35Y6XrUk+vK/GcChk3aRI832rESHc7C5ZTmnulO8I3UGiRmFv+65RDOPpJdrr1lw
	 wu8vURfkKyLUw==
Date: Mon, 2 Mar 2026 17:34:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	"kishon@kernel.org" <kishon@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"Frank.Li@nxp.com" <Frank.Li@nxp.com>,
	"den@valinux.co.jp" <den@valinux.co.jp>,
	"hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"cassel@kernel.org" <cassel@kernel.org>,
	"18255117159@163.com" <18255117159@163.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/9] PCI: tegra194: Drive CLKREQ signal low explicitly
Message-ID: <20260302233401.GA4036986@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b1f2d0f-b07d-4b14-ac19-78112ca84f05@nvidia.com>

On Fri, Feb 27, 2026 at 12:35:31PM +0000, Vidya Sagar wrote:
> On 24/02/26 00:15, Manikanta Maddireddy wrote:
> > From: Vidya Sagar <vidyas@nvidia.com>
> > 
> > Currently, the default setting is that CLKREQ signal of a Root Port
> > is internally overridden to '0' to enable REFCLK to flow out to the slot.
> > It is observed that one of the PCIe switches (case in point Broadcom PCIe
> > Gen4 switch) is propagating the CLKREQ signal of the root port to the
> > downstream side of the switch and expecting the endpoints to pull it low
> > so that it (PCIe switch) can give out the REFCLK although the Switch as
> > such doesn't support CLK-PM or ASPM-L1SS. So, as a workaround, this patch
> > drives the CLKREQ of the Root Port itself low to avoid link up issues
> > between PCIe switch downstream port and endpoints. This is not a wrong
> > thing to do after all the CLKREQ is anyway being overridden to '0'
> > internally and now it is just that the same is being propagated outside
> > also.

Inconsistent styling of "Root Port", "root port".  Spec uses
"CLKREQ#".

> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

> Reviewed-by: Vidya Sagar <vidyas@nvidia.com>

A Reviewed-by tag here seems a little weird since you're the source of
the patch.  I'm not sure what that would mean.
