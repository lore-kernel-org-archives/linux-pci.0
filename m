Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA3A3EAC98;
	Fri, 11 Sep 2026 06:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789107458; cv=none; b=RN+zE4bGl8cRVnuwU3cmQ6Xc3BvWoGb6oo5K9lWKVA96VADQ8/X/a1fRKejmD/v2LJVYhJMW2w0H+UwzIk3/kYntLvFj8LC11u2JRYHcn/Gfv3l/nszrNVmeqDNkvAiUkdYKim8TWPtpRPt0tz6Eo0Ie6F+xvSPP2ohV+bCXbic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789107458; c=relaxed/simple;
	bh=kGvwmlUtCVLw2GjwUOgq92UHLW64lnCn5wEvlKqsIkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KV5mJfVong4MTOy0nV5qfj3d2bGIUrLOrjfiUmIDonxrJd3+EhEjcApyhDrHwpuiyZvOvDhYMe4hq9uB7Wz/S9F2P/3f/uI2fdS3jQMiVVuiIv9Hj7rjzQwvx4SGMTbFUcv99BcO8gkJeZ4LDI4tp8V+zL+Xg+EHK7ASLJI2ucw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RH1xTYyy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RH1xTYyy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F4A1F000FF;
	Fri, 11 Sep 2026 06:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789107456;
	bh=4rQNW4Q7dZXR6lSvf9CKYNDWCU7jmgsBkJiqF/EERA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RH1xTYyym429diPvVIFeLSdU28fqnkzhGSrxtUtvg8RHsNinO+HPwDftvp4cY8mK8
	 n/nr+17c+lIou/kZK5FE2VQH+AVSKWkniyTzrESkGGT9JmPZKWZi2cUDQ5C+luKSdL
	 8IDEXZpWaJi3u2X4JwGcZDYT9uucJ60ITrztAIG07mxNdPtPfYC5uYqbVrSsOcJbDf
	 Aoco9tuwjaXjOrOEY41vjaSkfNvs2pXYZTtNfYTIWfhiGETCwVtfIEPl/n386rIppM
	 BmKczL1lOs+w0WCEOWCAXS/Q9wA2NZc7I62iz+8AavW4Avr2lj2RzchoYjKkFJT138
	 YppctMIPMy/bQ==
Date: Fri, 11 Sep 2026 08:17:29 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: qcom: Block accesses to downstream devices on
 link down
Message-ID: <ienbx5wjdzhgtdtbmuqcc76ovzy5d4wid7x4nhq5e4bco6u4il@264db3obw2qq>
References: <20260819-ecam_blocker-v2-1-e7a8fdc1c5cb@oss.qualcomm.com>
 <20260908230030.GA2776580@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908230030.GA2776580@bhelgaas>

On Tue, Sep 08, 2026 at 06:00:30PM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 19, 2026 at 11:36:54PM -0700, Qiang Yu wrote:
> > After a PCIe link goes down, software may still access the BAR (MMIO)
> > space or configuration space of devices behind that link before recovery
> > has run. As the link is down, these accesses never complete, resulting in
> > a storm of Completion Timeout AERs.
> 
> What is special about qcom here?  It seems like the Completion
> Timeouts and AER interrupts should happen with every PCIe controller.
> 

The special behavior which is common across many (not all) ARM SoCs is that they
don't synthesize all-one response for completion timeouts, unlike RCs in x86
machines. Rather, they return AXI error response, resulting in CPU treating
them as SError, in-addition to AER storm.

Commit message missed mentioning SError though.

> Is this mitigating an issue that will still happen on other
> controllers and should be solved elsewhere, e.g., by changing the
> software that accesses the BAR to look for the error responses it gets
> when the Completion Timeout happens?
> 

That would be too late as we don't get a proper error response. That's why this
patch is used.

> The patch refers to the ECAM blocker (which I assume affects config
> accesses) and doesn't mention MMIO.  Is the SLV_AXI stuff for MMIO?
> 

ECAM blocker is a Qcom's custom implementation which prevents the config access
to go out of the link and terminate the request properly. And yes, it doesn't
affect MMIO like BAR.

> Assume the root port leads to a switch, and the switch has two links
> to downstream devices.  If one of the switch downstream links goes
> down, is this going to kill the device on the other link that is still
> up?
> 

ECAM blocker is only enabled when the PCIe link to the Root Port goes down. We
don't get LDn interrupt when the switch downstream link goes down. In that case,
the switch should synthesize the error response if the CPU tries to access the
unavailable device.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
