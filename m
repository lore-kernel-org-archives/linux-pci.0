Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1589D44F56D;
	Mon, 21 Sep 2026 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977517; cv=none; b=BexfL4RM9aWC36UZaYoC+wkAGfbU74Oswc2U4YBR48qea0g7Fz3lFyY/Spg3mxhSiPc7tsRhwAP+puK7VD3weo8psGihypO6vNPiDrqBefQrp1RTVKNM0NODh4uBuH1dJ4EpiyMBmI2lyadFI2FjQozCYRUq1uCDExk8JDFwgWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977517; c=relaxed/simple;
	bh=EUfSpRHBF3fPSX0w9+7hQaeikTQIYwpee7jsi20JUL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdZWei1kaOu8fkW6My/fmNRuPZ3Irsqi6g4qSeLkDkzuihdZwKsc+PpDgH7d4e+14EpcDI3H4Yo8A1n6qpdpaiuKNNQbu40s3bE9w5lIilmV5cqmpJwGjAbQqx4AbjiS2cAXE+qLYnLVptIW2wK+TT4/zp8RKoayS1+d+/SbD28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJQcs/Ti; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJQcs/Ti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149951F000FF;
	Mon, 21 Sep 2026 07:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789977516;
	bh=oAyAx8t+7fJPyP33W2CjPs2RDHxeq3KJ8H7frGEAPfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HJQcs/Tiqvkf8RqWovy/B2NlzULMBtQX+gPSH8bJ0Hyhs/ryNy6scPa1frf8WDJ59
	 2Mq+o5MsC9NXcvtYn8mryTl2Azl0q3uMDoTZlZAbfa5ZbqMdYVF9U3eDQcpsom+G/V
	 dkho3HgKiD1BoXy3vKE9V+C1DTiVuSAVIGAK0LFkARBiMM9rTiYEfMqAgaSxcMnYsq
	 2g9Q3RQ0rZbb3hDGccvJeuFI+iZfPbFoghG3J9VWRtPjcgLrsFGpTTW0jWT14cdmi5
	 VH3yiCO0Nt5QKdkVlsHeVnPoeQwFhW/VUj4qoo9MHbwGpO404Yjo5OBi+klPhQkinM
	 Ro0jpnPfyPzyA==
Date: Mon, 21 Sep 2026 09:58:27 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Rahul Samana <rahul.samana@oss.qualcomm.com>, Wei Deng <wei.deng@oss.qualcomm.com>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Amitkumar Karwar <amitkumar.karwar@nxp.com>, Neeraj Kale <neeraj.sanjaykale@nxp.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 3/5] power: sequencing: pcie-m2: Create auxiliary device
 for the M.2 BT interface
Message-ID: <p2qiwwig7ap74puja6mgnz37lofljhexiapmpp6y3xmwkhs2dn@v2mxawoivkn4>
References: <20260915-pci-m2-bt-rework-v1-0-3c7d9cf9c010@oss.qualcomm.com>
 <20260915-pci-m2-bt-rework-v1-3-3c7d9cf9c010@oss.qualcomm.com>
 <CAMRc=MdJgXDUb-Uac0TRB8u1WUpLng51C4yMH6iMEMoK56tQYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdJgXDUb-Uac0TRB8u1WUpLng51C4yMH6iMEMoK56tQYA@mail.gmail.com>

On Wed, Sep 16, 2026 at 04:19:16AM -0500, Bartosz Golaszewski wrote:
> On Tue, 15 Sep 2026 16:24:04 +0200, Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >
> > Currently, the driver instantiates the BT interface of the WCN6855 and
> > WCN7850 combo modules by creating a devicetree node at runtime using an
> > of_changeset, with the compatible passed through the PCI ID table. But this
> > method of creating a devicetree node just for matching with the driver is
> > not recommended.
> >
> > So create an auxiliary device for the BT interface instead. The serdev
> > transport is still allocated here and handed over to the Bluetooth driver
> > through the auxiliary device, along with the power sequencing target used
> > to power up the controller. Also extend the provider match so that the
> > auxiliary device created for this connector is matched as its power
> > sequencing consumer.
> >
> > Since the runtime node creation is now gone, select AUXILIARY_BUS in
> > place of OF_DYNAMIC.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> 
> That's some nice stuff, thanks for doing it!
> 
> It looks like there's no build-time dependency on this, only run-time? Can I
> take it independently?
> 

Yeah sure!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
