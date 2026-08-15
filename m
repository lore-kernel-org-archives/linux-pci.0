Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5119E36B909;
	Sat, 15 Aug 2026 06:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786774831; cv=none; b=KNhz1Tn3HC3ab1e23JtVp8PoUK/uB0FPWb8nbWGNWDUXO2748jIZ3JSbeKy4ByA+dFouSfahXfwN9sntpT04DHZPqLxnsF+XdH5qxQoRBWSGbwq/sIHZRwZPGTKhg29hloX0dTnBFBQpiU62OQD4zJJFIUzfmzMVEmJHUAwt6/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786774831; c=relaxed/simple;
	bh=g1tzY7y+UOcQJ/Em9Aq+cRK28Al0+gtGRSYOAhHlt7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oktuH3MoolclaYxbSeJSwW2EoHN7Q97LwJGK4/+qgkpe1J+j2LI7eSgWRF5ymJhW9ocVTlZOTxc7BOQaSyqwTiFfHOKjTG4jvqsOCyqqMHt41KsJ5A9guzhy+PRyNWKrl9nxNxy9IegCe1LahhgnD0MDsAyh9twLoMyQjMHpEVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ST1c7Q6b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ST1c7Q6b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40401F00A3A;
	Sat, 15 Aug 2026 06:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786774830;
	bh=yPE7J07vM2HbQ9FsVa2oiATDyMnTq5jGTSJYPsNWD8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ST1c7Q6bAPLLmi6M9WCwrFD2sqJpttUciaW82XDqq0oocttSV4GChUFudzaPDlfve
	 kQDMiBBLJJcNxiNfm2sS3DcvFHpteJHi2RDbtv2x93fgmoW8LBxmcqbdwMdcr0Frhh
	 JezaD1+eYQtJmBHs1Xt75m9qU0uSJ2mYhcj5xzYhL3ERaZvbYu953RbERauGu6z44+
	 X0xAn0MyV0pG16lIn5e1624F5sVmaJe8vzS9CeDdK4IXU69f3CExe2pPMYOOmmzcxt
	 HB782hP17FvBUclIKQJzpfOnAHgtWyuHOIyKF1KXtQs82yBw6fcDwwcucOVTvhUECO
	 nhm5lHwWknhEw==
Date: Sat, 15 Aug 2026 08:20:20 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dmaengine: dw-edma: Add DMA_SG support
Message-ID: <moh7mdm345nc7a35wl3wj25b2jj3yljw7opt4prhzei5in6ps2@lgqqbzolshqx>
References: <20260803-dma_multi_sg-v2-0-c12bb05e42d6@oss.qualcomm.com>
 <20260803-dma_multi_sg-v2-2-c12bb05e42d6@oss.qualcomm.com>
 <anTbNsOQ02V6umXf@SMW015318>
 <ye4bue5a2uq65d5befelyhs3cbezpjytbni4mtnge42ijmaqny@3bijtktlvyrj>
 <an89hXJm2wY8Owry@SMW015318>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <an89hXJm2wY8Owry@SMW015318>

On Fri, Aug 14, 2026 at 11:08:37AM -0500, Frank Li wrote:
> On Fri, Aug 14, 2026 at 03:58:48PM +0200, Manivannan Sadhasivam wrote:
> > On Thu, Aug 06, 2026 at 02:06:30PM -0500, Frank Li wrote:
> > > On Mon, Aug 03, 2026 at 04:01:44PM +0530, Sumit Kumar wrote:
> > > > [You don't often get email from sumit.kumar@oss.qualcomm.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > >
> > > > Synopsys DesignWare eDMA supports a linked-list mode where each list item
> > > > carries independent source and destination addresses, letting multiple
> > > > independent memory transfers be described in one linked list and submitted
> > > > to the hardware as a single DMA transaction. The IP processes list items
> > > > strictly in order, so paired scatter-gather entries are never reordered.
> > > >
> > > > Implement the DMA_SG capability by adding a new EDMA_XFER_DUAL_SG transfer
> > > > type and a corresponding struct dw_edma_dual_sg carrying the paired source
> > > > and destination SG lists. dw_edma_device_transfer() walks both lists in
> > > > lockstep, building a single hardware linked-list; a per-entry length
> > > > mismatch or premature list end fails the whole request.
> > >
> > > It is not as simple as it.  for example, if you want to transfer 9k data
> > > from src to dest
> > >
> > > src virtual addr 0x1004,        dest 0xA0001008
> > >
> > > when map_sg, src's sg maybe
> > >
> > > 0x1000  .. 4k   offset 4,
> > > 0x9000  .. 4k   offset 0
> > > 0xA000  .. 4k   offset 0
> > >
> > > or
> > > 0x1000 .. 8k  offset 4
> > > 0xA000 .. 4k  offset 0
> > >
> > > which totally depend on physical address allocation although most likely
> > > first case happen
> > >
> > > dest sg
> > > 0xA001000 .. 4k offset 8
> > > 0xA008000 .. 4k offset 0
> > > 0xA00E000 .. 4k offset 0
> > >
> > > descriptors
> > > 1 	transfer 4k-8
> > > 2       transfer tail 4 byte
> > > 3 	transfer 4k-8
> > > 4       transfer tail 4 byte
> > > ...
> > >
> > > the start address of src and dest is highly possible differences. So it
> > > is very hard to match your requirement, both sg's structure is the same.
> > >
> >
> > That's the API limitation, isn't it? The callers have to supply the same length
> > src/dst pairs to work with this API. But they don't necessarily need to use
> 
> Define API is memcpy, not memory to peripherail Or peripherail to memory
> 
> dmaengine_prep_dma_sg() - Prepare a memory-to-memory scatter-gather DMA descriptor.
> 
> Most memcpy user need call dma_map_sg() to get sg.  And most likely two
> virutal address offset to page is difference.
> 
> So most likely return failure by this API.
> 

I agreed that using MEMCPY semantics is wrong for this API. So it should be
changed to peripheral DMA.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
