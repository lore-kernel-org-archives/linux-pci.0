Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A813D1AAA;
	Fri, 14 Aug 2026 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719173; cv=none; b=c3vHQCEJuxRCrpxbOCR9/NEVQqfVMXgiwQ83VYVLh3KlHENxk2om7yFYUgmpo52UJvE/TzzpJjAS46h3Ao2WHw5o5mEdSOBoeAY/FDdB0YjahKc+Yh66own2w3duvZXGHf6olUKd8L4clhL/FituZq+DXlzBsjX1WsYlxEJGdKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719173; c=relaxed/simple;
	bh=+8hCoy02E9M3+N2jXmI1PS+N/MV2aF6PyRS/6bojc3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKsRWxC4W7X/FEZSumFGxEHUv5C1aGHxCEo9XWZLzF4JSCVXFTW/AvXhbg8cD+iQp0oa8qkrg5qah97V6WsY0MELk3ehqGXBN5+JDyavcPHVRuPDuTTozcU35DfinUZZqddYau5fOq6uJ/wjW6qA9SlLFLx4l17xuzwwj9PE7PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdOeMpzC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdOeMpzC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BD41F00A3A;
	Fri, 14 Aug 2026 14:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786719165;
	bh=xtaIYrrbuuPmS1X5l4NPbwZWw3QqW7a/MCWvV52tja4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DdOeMpzCmQ+L6pChQmEE7IijAtags2g6YOlmPFP9StfaortT10ZeyR7fIg0gX2xho
	 tnY9n2IRSfhCavU4zbkDtJPIqrOnZbC8+PVqvX/Tev1vbo/R2Bzt3ry0vy3YdEm8iq
	 8RNpEo/U/N2LivKNQBj4nqU7Nhm1hVPTwdJWH7yP+56rhmpkOnCG9Rhdel7pm66eqD
	 CuQKnn6L6yTiv8CZvYncSMWnuMqBZFdorjAfMzIJs4Q0HD4IgZExv4BZHEcEJMNUtj
	 S9nB+FPtWeCUmyMfjk7UiLdwVe3wFjq5UegAKAO+qDrCDmREPnYaoHEfBuk203oVPv
	 d9Gd7uolrsNBA==
Date: Fri, 14 Aug 2026 16:52:35 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/5] PCI: epf-mhi: Add batched DMA read support
Message-ID: <szx7jctqp4h6yhgvhwmiqfjtsemwlu3iardtntp4nfc22u3bfi@ux5ioixmfdnh>
References: <20260803-dma_multi_sg-v2-0-c12bb05e42d6@oss.qualcomm.com>
 <20260803-dma_multi_sg-v2-4-c12bb05e42d6@oss.qualcomm.com>
 <anTARsISvCPUA9_v@SMW015318>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anTARsISvCPUA9_v@SMW015318>

On Thu, Aug 06, 2026 at 12:11:34PM -0500, Frank Li wrote:

[...]

> > +       config.direction = DMA_DEV_TO_MEM;
> > +       ret = dmaengine_slave_config(chan, &config);
> > +       if (ret) {
> > +               dev_err(dev, "Failed to configure DMA channel for %u-buffer batch read: %d\n",
> > +                       num_buffers, ret);
> > +               goto err_unmap;
> > +       }
> > +
> > +       desc = dmaengine_prep_dma_sg(chan, dst_sg, num_buffers,
> > +                                    src_sg, num_buffers,
> > +                                    DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> 
> Although both side memory address, but as previous discussion, which is not
> memcpy, still memory to IO space transfer.
> 

I agree, it is peripheral DMA nevertheless.

> Maybe enhence device_prep_peripheral_dma_vec(). Actually eDMA still split
> it to small trunk and linked together.
> 

By enhance you mean keeping the semantics of device_prep_peripheral_dma_vec()
API? I don't know how it helps because we would most likely end up with two
vector arguments and duplicating scatter-gather lists.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
