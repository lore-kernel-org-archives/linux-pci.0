Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6743AE1A9;
	Tue, 28 Jul 2026 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245950; cv=none; b=RoCjdkNG0pokV83hlgdI6v1Sqet1ecapoWXhm3l1681T7o0ykiLDoI+AptTRlS3P8WnSosknBASOqh3Dozs/mLEilEdoa8xvE/LdG2JBOXRYt6oiPa1XWSzJe5ZqR67+Z0AYnX0CX2nMl5yPSGjeDEt1jo4CzlfK1/qOhuNgmO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245950; c=relaxed/simple;
	bh=jmiUoKTvDMvPDyHn1DuDAArxWTGZWW6gVYu3pElwCVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQhAGj3tzl2nbCnwNt/s0+FAwBiAL1EUExZ29rtY6DPfvzED4zpOHB+N05mONgNnNGzvDnjPPRmoYWPY0wQpOVVk3m1zXbLNyGfIRmHXF47kTKeUNJt1n2TTlxf9Yeb+0BUdhYl35rELOyF3zJ/0MXfHnkU0SVlCnfo/fk5exD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+XN7ac6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+XN7ac6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777151F000E9;
	Tue, 28 Jul 2026 13:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785245947;
	bh=aI5SMR0pkwZxQk5sA1DFWQey3ShLOzud8TajucRDV0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N+XN7ac6XFx957dimqnDbEYF60qznyyVhXlNKufJO5vtl425VHE7FtRqxY2tXqD+4
	 st4beDheXCLrFs6LsAQVjDdc4EUyabuDH92GxdHpHdso5S03kpfZULx52UdM6A0PM7
	 znKu8a/rE6GAcdUBR2qQR4026GwIJmgwOeeAKIyvCc8mbOoUkylKN2hgfcfjgrCnwM
	 1GAL9spyysasroZjfd3o2fV/vWCJS0IXXoNiANchrhHkKVHTw8UyXVtJUXtJho1vuw
	 JrXrX++GDAzMbIvgi0fhyruwwdMYt9KRIhQDgDbWrUj/Nyv3a5LXPMYG1Rsi1Lyz8+
	 Mzcy3xyqNVhyw==
Date: Tue, 28 Jul 2026 15:38:57 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] PCI/pwrctrl: tc9563: Fix parsing the integrated
 Ethernet MAC Endpoint node
Message-ID: <elrj4hfxzrtn2hfldhvk4ychlbmxcrksmttg45a6nw2h3gulso@4nk3lrgo5rvu>
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com>
 <20260725-tc9563-fix-v1-2-ec4286e31331@oss.qualcomm.com>
 <5348ff47-910b-4614-a935-6e99ad3b066d@riscstar.com>
 <uavzur74w3w6d4acq4keoi42pcob4p3jez7e5p2aubw27k5geo@ccaewywqbz3b>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <uavzur74w3w6d4acq4keoi42pcob4p3jez7e5p2aubw27k5geo@ccaewywqbz3b>

On Tue, Jul 28, 2026 at 03:12:49PM +0200, Manivannan Sadhasivam wrote:
> On Mon, Jul 27, 2026 at 10:59:05AM -0500, Alex Elder wrote:
> > On 7/25/26 3:59 AM, Manivannan Sadhasivam via B4 Relay wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > 
> > > DSP3 has an integrated Ethernet MAC Endpoint which has its own set of
> > > config registers for configuring settings such as ASPM. The Endpoint
> > > device has 2 physical functions and those 2 functions share the same
> > > settings.
> > 
> > This was not clear from the code.  So this explanation alone
> > represents an improvement.
> > 
> > > Hence, parse the Endpoint node under DSP3 instead of parsing both the
> > > functions. The existing parsing logic also has one OOB issue as parsing
> > > both functions will result in accessing past the tc9563_pwrctrl->cfg array.
> > 
> > The issue you mention is that the array has exactly one entry
> > available for the Ethernet MAC endpoints, so parsing more than
> > one (if defined in devicetree) references a non-existent entry.
> > Right?
> > 
> 
> Yes.
> 
> > But this constraint only applies to power control.  There can be
> > multiple MAC nodes (for their PCI functions) defined.  And it
> > seems the pwrctl settings (if any) *must* be specified for
> > function 0 and if specified for any others, they are quietly
> > ignored.
> > 
> > Is that accurate?
> > 
> 
> Exactly. DT can define both functions, but since there is no per-function
> tuning, these properties cannot exist in both nodes, but only in function 0,
> which also corresponds to the Endpoint.
> 
> > If so I think the DT binding could explain and possibly enforce
> > that, but I won't insist on that...
> > 
> 
> It is being enforced in Patch 1.
> 

Sorry, the current enforcement is only for PHY related properties like Tx
Amplitude, DFE and N_FTS. I didn't limit ASPM properties in function 1 though.
Doesn't seem to be strictly needed as no one would configure per-function ASPM
settings in DT (mostly unlikely).

- Mani

-- 
மணிவண்ணன் சதாசிவம்
