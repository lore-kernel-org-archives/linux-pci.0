Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0540E36CE16;
	Tue, 17 Feb 2026 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771345490; cv=none; b=uAwKQV9V/P8CtZsF1hjkIoGakJ3/mcd0GAnuNLe3arDmr9bCaMoAh/sEPK8X5xr3uLgeGh0GA5iwRACt5Sqn6830vrcMhUdzuyoRr/jOYG7kns90+ObvgedPPwTtuhYAbqFEJTyNJJdvgu93ydvXLrJcGYgSrMe6QOfyLlIpR7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771345490; c=relaxed/simple;
	bh=CxjI4EcPft0Rpldoj7YGuMkMsBYoUfDCaN28yBYqKzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QY2cWGMMqXF4pP8mxTBzKLWPG6wRHck5W5HuJpgyFJz0Xpu5cnE4PGP5cIAeMkXD7/uJyXewffsHr+wGU7KB2isWRIZP/ZvzBqURy7iyCCPxExHsy3nyVSEPkutHPbQRCS4yme44AyCRBofFDoyUUq18xCkD0u5G8lJnukTY6NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKoABufb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKoABufb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D7AC19421;
	Tue, 17 Feb 2026 16:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771345489;
	bh=CxjI4EcPft0Rpldoj7YGuMkMsBYoUfDCaN28yBYqKzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aKoABufbSEWKCTQU0W3hJxtxA0rlKoUjPTBPTbNcGYQCWMcE0uduOgyWQZHi+7kA9
	 3OnVoBJtRa7z8lDJQ6/EmkjYW8rPnHKPM8m6v8+ljvyIAfu44Bv9fn2oVtqgJid3j/
	 +fMSnV/kIITGZk31SDfD4q81evzlpcVbib088Fmb672lF6LagEbvnVC34QVPcaRgtR
	 7p4c7zEVehgLWX8j2XJLlAOsJ9EuaM/ch6QXEjVW5yQvqDvqwQ8Loroiv1DgDp9a9W
	 R5Ut4Il7FrUD+jWM1FmHk4ycbG+5sA7HwKLyL11Ll4Pzl7ooR5BDo8llWYhjmxLkXu
	 Dz4WFiTmIhGhw==
Date: Tue, 17 Feb 2026 21:54:43 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: Re: [PATCH 0/2] PCI/pwrctrl: A couple of fixes
Message-ID: <sq6wub733a7lwmwpjsxp6cxnl3zchzn632b6ni342f4g63rlz3@poxbx7d5vc4y>
References: <20260217-pwrctrl-fixes-7-0-v1-0-b5671e58934f@oss.qualcomm.com>
 <20260217160608.GA3377925@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260217160608.GA3377925@bhelgaas>

On Tue, Feb 17, 2026 at 10:06:08AM -0600, Bjorn Helgaas wrote:
> On Tue, Feb 17, 2026 at 03:48:45PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > Hi,
> > 
> > This series fixes a couple of issues introduced in the recent pwrctrl rework
> > for v7.0. Both issues are due to some incorrect assumptions on deciding when to
> > create pwrctrl devices. First issue is due to assuming that all OF graph nodes
> > require pwrctrl and another one is due to assuming that all PCI child nodes are
> > PCI devices.
> > 
> > Both issues are fixed by changing the pwrctrl device creation logic in
> > pwrctrl/core.
> > 
> > Testing
> > =======
> > 
> > This series is tested on Lenovo Thinkpad T14s.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> > Manivannan Sadhasivam (2):
> >       PCI/pwrctrl: Ensure that the remote endpoint node parent has the supply requirement
> >       PCI/pwrctrl: Only create pwrctrl device if the device node is of type "pci"
> > 
> >  drivers/pci/pwrctrl/core.c | 51 ++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 38 insertions(+), 13 deletions(-)
> > ---
> > base-commit: 1c2b4a4c2bcb950f182eeeb33d94b565607608cf
> > change-id: 20260217-pwrctrl-fixes-7-0-b90eb30bbfe7
> 
> Are these v7.0 material?  I assume the pwrctrl changes merged for v7.0
> were tested but maybe not on this platform or this DT structure?
> 

Yes!

> Is there a functional regression from v6.19 to v7.0 that would justify
> including these in v7.0?

Atleast patch 1 is a fix for the regression on IPQ platform, but patch 2 is
required for an upcoming support.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
