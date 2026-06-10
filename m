Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278683B4E8A;
	Wed, 10 Jun 2026 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781087265; cv=none; b=kQRTYDqRh1IRnek6AZR7lHyF5EMzHLzo60lv2xUQ9q0D31+OtxIVmufMzZXObw98cvjiBuJymvDr6b1P1SY9zvpt6Z0E7lmfR6vPJneYDLHJbsm1rdRvJXlFMoLnLnWlI8mM87GmN4dX4wS/UykBzaTfoRF9dnoC3YYWeGYyoqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781087265; c=relaxed/simple;
	bh=gqSUj7BP8+cxE/tJWPUQ9h5a/jPgRCqt4stgniSIf98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzWf7sk2AYDSuBUVtvh+IJ4X3nhi+J8oxKLKfhmQo62TuY1V5QaJZ9XLyITehEMAytVAYYLk8Mqsc/BF1J5jmaLruwOzmtd9CdSrrNen8NtuCbHJYWWYpS90iWEeJTKAdgk4iRyH6czYmWzwMXRsPBjctwL9M6gfV0cjBECVRr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGu3zhh2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGu3zhh2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7B71F00893;
	Wed, 10 Jun 2026 10:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781087263;
	bh=1JDn7CbxH4NkFQTX1xElzM+90pkVv3Q0ucAERFYyNNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oGu3zhh2OG3sW8byiL4NJ6CQlf9ldAiGwdIcV924G4xpkRt3RwAbsxkuLh7dbwXjO
	 pBYpbn4rov/isiedEoYakwt/4vHmoj964vLfod9I6M/bic0ewaKckXmS4272RylyZk
	 Vb1KlUxXLLFYTwSimZ+0TyAK/L2vrxTt0mH+OQPBkpCbl+vGoxJtEHAbiTaIjZM4qY
	 p2eKDLOTAELQnxC88iPxjB7DXkoPSw4QYQ/y42Axo4u+jGmcVX3QJo940Lai4ihZTw
	 SGsq/DUdDCYm5WqP6C+8Oa3uJjjiXer8tAdHf6IQ4omjf1lNUnnMDFlesSnRbEN1tE
	 pOBI8IuAHjVmg==
Date: Wed, 10 Jun 2026 12:27:36 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, 
	"manivannan.sadhasivam@oss.qualcomm.com" <manivannan.sadhasivam@oss.qualcomm.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "Frank.Li@kernel.org" <Frank.Li@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH 1/2] dt-bindings: connector: pcie-m2-e: Add 3.3Vaux
 supply support
Message-ID: <ihrmgh6etb2n5zqjbrykfjjms4a6zgpzwjgrd3rvy24jufbss7@f4nfxrp7jksy>
References: <20260609033840.2006078-2-sherry.sun@oss.nxp.com>
 <20260609034408.BC69D1F00893@smtp.kernel.org>
 <20260609-unique-magnificent-eel-eb623f@quoll>
 <VI0PR04MB121140EFB8E614326D799503A921A2@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <mvxoynvocxcalxcwogbiovg5yurjczxqfu2fqkji33bunmlplz@zxqjsdjts65j>
 <VI0PR04MB12114DBDD65F25FB615EA8967921A2@VI0PR04MB12114.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI0PR04MB12114DBDD65F25FB615EA8967921A2@VI0PR04MB12114.eurprd04.prod.outlook.com>

On Wed, Jun 10, 2026 at 10:13:00AM +0000, Sherry Sun wrote:
> > On Wed, Jun 10, 2026 at 08:40:54AM +0000, Sherry Sun wrote:
> > > > On Tue, Jun 09, 2026 at 03:44:08AM +0000, sashiko-bot@kernel.org wrote:
> > > > > Thank you for your contribution! Sashiko AI review found 1
> > > > > potential
> > > > issue(s) to consider:
> > > > > - [Medium] The `vpcie3v3aux-supply` property describes a
> > > > > non-existent
> > > > hardware feature on the M.2 Key E connector to work around a
> > > > software policy.
> > > >
> > > > Feels valid. Describe which pin on M2 connector are you representing.
> > > >
> > >
> > > Refer to PCI Express M.2 Specification r5.1 sec3.1.1 Power Sources and
> > > Grounds.
> > >
> > > PCI Express M.2 Socket 1 utilizes a 3.3 V power source. The voltage
> > > source, 3.3 V, is expected to be available during the system’s
> > > stand-by/suspend state to support wake event processing on the
> > > communications card.
> > >
> > > But the current vpcie3v3-supply may be gated off during system suspend.
> > > So I  tried to add vpcie3v3aux-supply to let this 3.3 V power source
> > > always on for PCIe M.2 Key E connector. That means vpcie3v3aux-supply
> > > and vpcie3v3-supply actually refer to the same 3.3 V power source.
> > >
> > > @Mani, do you think this is reasonable? Or do you have any other
> > > better solutions? Thanks!
> > >
> > 
> > There is no Vaux defined in the M.2 spec. So you cannot define that supply in
> > the binding. You can define the custom Vaux supply as a fixed regulator in DT
> > and mark it always on so that it is keeps supplying 3.3v to the card.
> > 
> 
> Hi Mani, thanks for the suggestion, but adding an always on regulator may
> cause board power waste, current solution ensures the 3.3v regulator is
> only enabled when M.2 connector needs to work .
> 

What do you mean by 'need to work'? For getting the M.2 card to work, you
already have 3.3v supply. If you want the board to be always ON, then you need
to supply 3.3Vaux, which should be always ON too.

But who is turning off vpcie3v3-supply? M.2 connector driver or the platform?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
