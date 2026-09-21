Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8739E48592E;
	Mon, 21 Sep 2026 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988609; cv=none; b=Hkp6SmefFg8cng+AWgnS4ysZPITe6pe8Vj/2Fe+k6UgRdYYsu4o68iDNHs+RMFSe5QJYvF/NmVaV7/Bhyz4rjLXW0bMLg/di+4HyaCiXyhNa3Jrz45fAE3byx/JyzUq7SY55tKumze37PT9tzqmYnPf2vLI6iA+Ofx+AufpoZAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988609; c=relaxed/simple;
	bh=ezU9jJ7MwFvgarT3S7gLFpCf2ozU1aFJ3fwy76l486A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpFh+/PUjGeoItWn4lucYnO/4md818BfW1D+FBs5PMW7EHgYUQoysBCiL72ChEHtin9pEkTRA25AlVf7Y2JHqmki4trOCoz23XvwpZohmugJ+hk1SH79aspxobQxMPG0k31RziGx46Qm5ZNT/0gm47OASQdUrp9PpNOxMXcOV5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6YiJMw6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6YiJMw6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9235D1F000FF;
	Mon, 21 Sep 2026 11:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789988603;
	bh=Li5iIHYzXEeTCCbpZpScuMu1gMxmua3kiHF7nAY7gSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k6YiJMw6Bf7VQeWmaIFvGtDr0Q1CP2K9zPn8eV5D/uOYZjCrlAqFSpIKCPnMw82ng
	 4sl3t4Z9/J2IpgoH5cxc4l52jn6CUYb4aPZQwcaGGmhDKFqBJ1i7SK7tDO9FvLHK8T
	 Tm69OGIGGqf4qCUjlvbOTj0pAZB0FIjBmv14TmQ6plBkUUmAPp0sU/g+Pj5cjR9efn
	 IIm9KGlIkHzdrr3zb4TiWCD2pdyymcHOQnJJ51fRgwuO5oT3VWps3oiu6qLRA5boex
	 kAS0AD58ciEv8r6eGOfoccVNIjz/kaMWXsamdWYCzOERK2rRGm+0dIrwbCOxVpeujR
	 JbAc+9J+WOJYA==
Date: Mon, 21 Sep 2026 13:03:14 +0200
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
Message-ID: <u2x4y5jochtvdrbzaofqpvf7pkufbljrogqy67renxhuubitbt@h5ogih6h2okx>
References: <20260915-pci-m2-bt-rework-v1-0-3c7d9cf9c010@oss.qualcomm.com>
 <20260915-pci-m2-bt-rework-v1-3-3c7d9cf9c010@oss.qualcomm.com>
 <CAMRc=MdJgXDUb-Uac0TRB8u1WUpLng51C4yMH6iMEMoK56tQYA@mail.gmail.com>
 <p2qiwwig7ap74puja6mgnz37lofljhexiapmpp6y3xmwkhs2dn@v2mxawoivkn4>
 <CAMRc=MdHy6M9cY-ZqMXP_F6yLuVuipDkZwHoBF0D9W3A5VkOSQ@mail.gmail.com>
 <CAMRc=McfFtRi_kwPh6Dfz6MwGEy_Q7ojFmJ3ibJ6V4PiEDPetw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McfFtRi_kwPh6Dfz6MwGEy_Q7ojFmJ3ibJ6V4PiEDPetw@mail.gmail.com>

On Mon, Sep 21, 2026 at 05:51:28AM -0400, Bartosz Golaszewski wrote:
> On Mon, 21 Sep 2026 11:08:58 +0200, Bartosz Golaszewski <brgl@kernel.org> said:
> > On Mon, 21 Sep 2026 09:58:27 +0200, Manivannan Sadhasivam <mani@kernel.org> said:
> >> On Wed, Sep 16, 2026 at 04:19:16AM -0500, Bartosz Golaszewski wrote:
> >>> On Tue, 15 Sep 2026 16:24:04 +0200, Manivannan Sadhasivam via B4 Relay
> >>> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> >>> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >>> >
> >>> > Currently, the driver instantiates the BT interface of the WCN6855 and
> >>> > WCN7850 combo modules by creating a devicetree node at runtime using an
> >>> > of_changeset, with the compatible passed through the PCI ID table. But this
> >>> > method of creating a devicetree node just for matching with the driver is
> >>> > not recommended.
> >>> >
> >>> > So create an auxiliary device for the BT interface instead. The serdev
> >>> > transport is still allocated here and handed over to the Bluetooth driver
> >>> > through the auxiliary device, along with the power sequencing target used
> >>> > to power up the controller. Also extend the provider match so that the
> >>> > auxiliary device created for this connector is matched as its power
> >>> > sequencing consumer.
> >>> >
> >>> > Since the runtime node creation is now gone, select AUXILIARY_BUS in
> >>> > place of OF_DYNAMIC.
> >>> >
> >>> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >>> > ---
> >>>
> >>> That's some nice stuff, thanks for doing it!
> >>>
> >>> It looks like there's no build-time dependency on this, only run-time? Can I
> >>> take it independently?
> >>>
> >>
> >> Yeah sure!
> >>
> >
> > Nevermind that, it still needs is_controllable().
> >
> 
> Patch 3/5 also needs the header patch 1/5 adds, so we'll need a different
> merge strategy here.
> 

Oops... I replied without checking the patch order and trusting my memory :/
But even without the dependencies, merging just the pwrseq driver will break the
functionality. So a better strategy would be to merge the series in a single go
to the Bluetooth tree.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
