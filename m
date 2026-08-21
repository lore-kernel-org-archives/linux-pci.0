Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82E63F39DD;
	Fri, 21 Aug 2026 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787339419; cv=none; b=MhcPRWOnhq1itOYc4tmCOuIBV4jhNpNO404FE+EIrldW3ISip8JWN/M05+t2vs0c3gQWDPiQ3klKOoaECU3LdUrlSJzFPai5Fh76Y3ySS0Z6XvsraE5KX07A21wRYyXY0GbAPR/RWBqLRHbtY+R26+CNMz/q5+W2fxLFAEHRyg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787339419; c=relaxed/simple;
	bh=x96j4PE1amliU9uJgpxEg/tkPcJpsv8Uj1KL5vzRhck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PniFUZvDQzAKj1PjkYLKRbZl/UJvraGKOs+cUYKySmQ5wWBvLhsqUYLQLNYpyCyPchXEaRq0I8uiLxt+Oi8N41EtlRyKo5dngIVTKlnSbbjpBt4hefy+Nq7IQQQASPYcc2RE+uoL6D8IGVu2+EJn3IlINlrnu1cj58e+JRJ1xhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3z0gFia; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3z0gFia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3F41F0155E;
	Fri, 21 Aug 2026 19:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787339414;
	bh=1pPt6f3/fmRUDLXlP30zeK9EEfdFOpkz8XR46MaK/FE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O3z0gFiaVlzn82OJtB3W1DRxuOl3UxLHQzDfWI/CSbPtPpnineSGsyYmHuijgT53W
	 U610WCMsfizg0Dq/qK65PSlzLLn1tCjI1G7IQrJxtpb3WsagdNbq9qSXIkDZP40lf5
	 uucBF/Uuz3IPKaCrrxOwd18peeLHQQ4+YoPAGvQQRJD63BR9m7sJqINcs2VzWUtVAf
	 2wIH8r2xnp5zaKEgQzzQKyTr49vK6gvtIe5ymc3ikchGxj5LSyNQpsaiFQcMuw2rcJ
	 +NSc3qPZg2l8XxEivJ8JLrMcK4+F0hcuJI7TMHItQjzLSHhUdZs6Oy9g1qjGeyRiGU
	 9pnDyCeRXe+GQ==
Date: Fri, 21 Aug 2026 14:10:11 -0500
From: Rob Herring <robh@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: bhelgaas@google.com, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	mohdayaa@qti.qualcomm.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	daniel@riscstar.com, krzk+dt@kernel.org, arnd@arndb.de,
	lbiancon@qti.qualcomm.com
Subject: Re: [PATCH 1/2] dt-bindings: misc: introduce pci1179,0220.yaml
Message-ID: <20260821191011.GA4061718-robh@kernel.org>
References: <20260813222943.1655453-1-elder@riscstar.com>
 <20260813222943.1655453-2-elder@riscstar.com>
 <178682676059.2183315.4478974489132403040.robh@kernel.org>
 <e98e8996-1ae8-47be-8854-55a004530c85@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e98e8996-1ae8-47be-8854-55a004530c85@riscstar.com>

On Thu, Aug 20, 2026 at 12:18:45PM -0500, Alex Elder wrote:
> On 8/15/26 3:46 PM, Rob Herring (Arm) wrote:
> > 
> > On Thu, 13 Aug 2026 17:29:41 -0500, Alex Elder wrote:
> > > Define the binding for the Toshiba TC9564 PCI endpoint function device.
> > > The third downstream PCIe switch port within this chip has an embedded
> > > PCIe controller, and that implements two of these PCIe functions.
> > > 
> > > Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> > > Signed-off-by: Alex Elder <elder@riscstar.com>
> > > ---
> > >   .../bindings/misc/pci1179,0220.yaml           | 150 ++++++++++++++++++
> > >   MAINTAINERS                                   |   6 +
> > >   2 files changed, 156 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/misc/pci1179,0220.yaml
> > > 
> > 
> > My bot found errors running 'make dt_binding_check' on your patch:
> 
> I don't see these errors, so I'm probably running an old version
> of something?  I'll try to sort it out.  Sorry about that.

Are you setting DT_SCHEMA_FILES? If so, read the rest of the msg that 
was cut. :)

You can also now do 'make misc/pci1179,0220.yaml' which checks your 
example against all schemas rather than against only your schema.

Rob
