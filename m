Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AE14A99CF;
	Fri, 11 Sep 2026 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147090; cv=none; b=e8IKbmYgRItt1qsYwM8mic4o7dJc9xdAjNxRQkMiddNesGEv9ygO/OO4HoLFtJjtXrEIQerNspefLnIitYgGn2EzrCiC0UBeSqoEz/G1HOtofYcOwJn9VBOpT9v10s5K0Ki1/lkczfHtTrYu/7UJFbIY+6jlz718FpYBBkX00RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147090; c=relaxed/simple;
	bh=zKUMKrASgkid4sZE4XHGazly8P6BIiP8uvoqbldK8q8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dO1RlR2tuhyuyM9ZvLBhhxh5XBid6nbhWsAx60eZ07HPbVI8lQW5YaxGEVPZygSkDVj4/OU/+sQUj/HbosUeWtkr8P52asOualdhwdyfoTbvWL2DwjAsSLa6cHKm28X1JKh/uocXw80HWTLLCEDxuLN+gIO5AlICWHqn5Mmn6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOctJEUN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOctJEUN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2021F000FF;
	Fri, 11 Sep 2026 17:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789147088;
	bh=BiMS/bzN218uVxMjPWQUVYFg4XO3qw5jGV0pgdNd/6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=EOctJEUNrMyP6akxzbwkzsqcM66c8tMEa6G49mp7eF2KRpiE78EVu+zVbRjqcN6Xw
	 CB9evm6Z0nbjVK8ZsaBlg5dDILWoIlR5wY9fJeZw3FJWUfJ46yN9qTSJHr+eUmWQ5y
	 9xVh5Kq/wMY+YSWLiWq+8wU6jcMnuyDXw4R8QGL4XY8zjmznOQx9ru/8mnbEczTBmS
	 UT1tYaJHaSDgNXOGUTS18zzaYhp2dU8KvWQbJieDNZPCqF0GyWFELyoDFGpuZIq6WX
	 KApp42Hg8Vs9pxcJKRjPYw+ZZXFbN6M7pqewJ0MitfmgSeD5NeqUKaHuBYcC01aTt8
	 cpDgzXZd9aLig==
Date: Fri, 11 Sep 2026 12:18:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: qcom: Block accesses to downstream devices on
 link down
Message-ID: <20260911171807.GA402207@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ienbx5wjdzhgtdtbmuqcc76ovzy5d4wid7x4nhq5e4bco6u4il@264db3obw2qq>

On Fri, Sep 11, 2026 at 08:17:29AM +0200, Manivannan Sadhasivam wrote:
> On Tue, Sep 08, 2026 at 06:00:30PM -0500, Bjorn Helgaas wrote:
> > On Wed, Aug 19, 2026 at 11:36:54PM -0700, Qiang Yu wrote:
> > > After a PCIe link goes down, software may still access the BAR
> > > (MMIO) space or configuration space of devices behind that link
> > > before recovery has run. As the link is down, these accesses
> > > never complete, resulting in a storm of Completion Timeout AERs.
> > 
> > What is special about qcom here?  It seems like the Completion
> > Timeouts and AER interrupts should happen with every PCIe
> > controller.
> 
> The special behavior which is common across many (not all) ARM SoCs
> is that they don't synthesize all-one response for completion
> timeouts, unlike RCs in x86 machines. Rather, they return AXI error
> response, resulting in CPU treating them as SError, in-addition to
> AER storm.
> 
> Commit message missed mentioning SError though.

I don't know how SError works, but this sounds like a pretty big open
issue with respect to RAS.  I don't think we want a kernel panic
because a device failed to respond to a config or MMIO access, e.g.,
if a card or Thunderbolt cable got unplugged.

> > Is this mitigating an issue that will still happen on other
> > controllers and should be solved elsewhere, e.g., by changing the
> > software that accesses the BAR to look for the error responses it
> > gets when the Completion Timeout happens?
> 
> That would be too late as we don't get a proper error response.
> That's why this patch is used.
> 
> > The patch refers to the ECAM blocker (which I assume affects
> > config accesses) and doesn't mention MMIO.  Is the SLV_AXI stuff
> > for MMIO?
> 
> ECAM blocker is a Qcom's custom implementation which prevents the
> config access to go out of the link and terminate the request
> properly. And yes, it doesn't affect MMIO like BAR.

The commit log implies that the patch blocks both config and MMIO
accesses: "software may access MMIO or config space ... Use ECAM
blocker to drop these accesses."  If the ECAM blocker only affects
config accesses, we need to reword that description.

If this patch doesn't affect MMIO accesses, I assume they will still
fail and lead to SError?  I'm a little dubious about the utility of
this because I assume most runtime driver accesses will be to MMIO
space, not config space.

I assume this is also racy: any config access that happens in the
window between the link going down and the ECAM blocker being enabled
will still fail and result in SError, right?

> > Assume the root port leads to a switch, and the switch has two
> > links to downstream devices.  If one of the switch downstream
> > links goes down, is this going to kill the device on the other
> > link that is still up?
> 
> ECAM blocker is only enabled when the PCIe link to the Root Port
> goes down. We don't get LDn interrupt when the switch downstream
> link goes down. In that case, the switch should synthesize the error
> response if the CPU tries to access the unavailable device.

For config or MMIO reads targeting a device below a switch, if the
link to the device is down, I think the switch will return an
Unsupported Request completion without data (PCIe r7.0, sec 2.3.1.1).

The PCIe spec doesn't prescribe whether RC synthesizes data to
complete the read, but x86 RCs typically synthesize ~0 data.  I guess
some arm64 RCs assert SError instead of completing the read.

IIUC, if the link from the RP goes down, we'll take the LDn interrupt,
enable ECAM blocker, and future config reads would return ~0.  But if
a link below a switch goes down, there's no LDn interrupt and it
sounds like future config reads would result in a UR Cpl and SError.
