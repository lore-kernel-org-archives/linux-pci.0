Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56E37478;
	Sat, 26 Sep 2026 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790412559; cv=none; b=jGMP3M4URTQhD+k5c+3bwEFleB7GzBe6yUGDn3QIXsVmFJo3T9lVJau4OXYvK/h7f0zJxOVaURijg4R/wqxnpMX5dj5SmZqrcD4g2R1cto36OI7xta3ieaWQPdFm9pfZbyjj4ht3yVYAgj3fENKSBNJXwL70QGr1X2BIPdunfaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790412559; c=relaxed/simple;
	bh=z2Y2BYaLt4DQXbLx6S/OQNCYizRiWRx0Wa2mXGLaif4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prcv/OZpM3FFTlDVlhmme168Dbl9b72Rm/Snkcl3f3fRxwOxvBFQ8+sruWUuKYOwN/nNWqhfsT84ybPvvjPDvE+BhxYx+v7B89FFMtrFiH+wBoT5UA/M1i7NjKg7MP2zA+ooaVCiirW6pH0f5WebEeDznElTRHjj+PoLurASNPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjNtj4VZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjNtj4VZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1831F000FF;
	Sat, 26 Sep 2026 08:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790412558;
	bh=uzhsfGFro+u+wLnkktG3mmK5Fb3Rm5c/4uVwSXwXcXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HjNtj4VZiGyoV3iD3U21Lcv86RGkT7ycywPtTwek0rq+SsVB4S9QMMz2qwfmifwhl
	 cF4y60iTTlTtzNtVat5gPZ/QGnoYaJgMzdixm1y6kTSW8bnkZfcAKHvYuxPz1LaNyU
	 WidkIrwv+N57PyaFk95Ardt5ts+bxzTNV1Gd0j3s5S0pDsSryNUoWnCqYzazEA8SjG
	 TiFPNAd+Uo8US8WLjlHlW9fAniJXcGzpuMAFW7vLJIRynAxrC6AVzSjoMmI+9F03J2
	 7aNil5IetD3ETf5nSYM89bI4s8Wn5y5fTY+nhO0BuTCFuUlvMqKpZbBDwuME0UHFl7
	 auorkI18U/z6g==
Date: Sat, 26 Sep 2026 10:49:04 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>, 
	Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, dmaengine@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/5] PCI: epf-mhi: Add batched DMA read support
Message-ID: <ep3rjgc4idxt2ta53cebdzpqvyvvm2rnpxbo2ka3sqcmgqwdb2@cwi6gixldtxg>
References: <20260803-dma_multi_sg-v2-0-c12bb05e42d6@oss.qualcomm.com>
 <20260803-dma_multi_sg-v2-4-c12bb05e42d6@oss.qualcomm.com>
 <anTARsISvCPUA9_v@SMW015318>
 <szx7jctqp4h6yhgvhwmiqfjtsemwlu3iardtntp4nfc22u3bfi@ux5ioixmfdnh>
 <90fcc9ff-4ba6-4e16-a322-17ad8e4a51e7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90fcc9ff-4ba6-4e16-a322-17ad8e4a51e7@oss.qualcomm.com>

On Tue, Sep 15, 2026 at 10:42:39AM +0530, Sumit Kumar wrote:
> 
> 
> On 8/14/2026 8:22 PM, Manivannan Sadhasivam wrote:
> > On Thu, Aug 06, 2026 at 12:11:34PM -0500, Frank Li wrote:
> > 
> > [...]
> > 
> > > > +       config.direction = DMA_DEV_TO_MEM;
> > > > +       ret = dmaengine_slave_config(chan, &config);
> > > > +       if (ret) {
> > > > +               dev_err(dev, "Failed to configure DMA channel for %u-buffer batch read: %d\n",
> > > > +                       num_buffers, ret);
> > > > +               goto err_unmap;
> > > > +       }
> > > > +
> > > > +       desc = dmaengine_prep_dma_sg(chan, dst_sg, num_buffers,
> > > > +                                    src_sg, num_buffers,
> > > > +                                    DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> > > Although both side memory address, but as previous discussion, which is not
> > > memcpy, still memory to IO space transfer.
> > > 
> > I agree, it is peripheral DMA nevertheless.
> > 
> > > Maybe enhence device_prep_peripheral_dma_vec(). Actually eDMA still split
> > > it to small trunk and linked together.
> > > 
> > By enhance you mean keeping the semantics of device_prep_peripheral_dma_vec()
> > API? I don't know how it helps because we would most likely end up with two
> > vector arguments and duplicating scatter-gather lists.
> Frank can you comment on this.

Frank, ping!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
