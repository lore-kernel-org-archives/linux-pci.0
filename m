Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC2414883F;
	Fri, 14 Aug 2026 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715942; cv=none; b=LheQ9n2gc659qDh03lqaCjxzrkZEC5Q1Rk1gEzIEZUbnwLdSQDkNZpOyvC9fsgDJzwbCNPOreDXMhlO+ImT91Ok0X0HPyRTAVNOd3ENV4zgXTt+/5JymSH20Qqtk1EXlDI9nznsDBxVVrSaNwx374kXQVDIldDVEomNKaCxTP5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715942; c=relaxed/simple;
	bh=7PFhye8VRUBjy6LOyYDfsOK00U7TUS4JwpDlrBFMbRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qxz4CLOyWYKqhblLJv47xXl5r8ChRZFdsi1ERRNI1Z2+yuOfisW5Pagu2mUdC2RxW5CogNPXaHj9TcdlcmQGglwmVFjLXYLpXgW8gJAS/Kd9LkZOyZ8wCM2fC0f3B9SmV5LQ36Q8RQFsUXbdUN2wt6N6MrO7wv4WjQSavs9ujb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxRQbI2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxRQbI2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146EB1F000E9;
	Fri, 14 Aug 2026 13:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786715940;
	bh=sAnqX8NIR8uxSY/uxEI7i3Lm2Ex9D5/7ReWwF0MgyEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dxRQbI2HAPcW2ipcS3K2SwL+HuYmE5U4dU0SfHBknVKwlvyO8dxaQjVbAXLgWhV0d
	 RUFtN77k5OKtuewexNYXkLBwFg96wgEXngs52ow9uXktYy/Bspv74tv3TqkmqVFoTd
	 q6+AbAdoVSPoz9HYxyVEskYHLX5O39FWZMbuaW/gCEpPF2GH+T/96k7hywm152kh2/
	 CfZoty2zXslI8IenB/i8nJg1ZZGNAJNeTLcRrAd282rnLvn8H1hzJKvZXUm2w36ZM+
	 58G7Mpw+YmpuySQOlt1Y2oakSnsHrGEozoc/0xVb2pABtI5xtNjxVhhAP4UuN2WxDD
	 zEHeM6ZuG8qFQ==
Date: Fri, 14 Aug 2026 15:58:48 +0200
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
Message-ID: <ye4bue5a2uq65d5befelyhs3cbezpjytbni4mtnge42ijmaqny@3bijtktlvyrj>
References: <20260803-dma_multi_sg-v2-0-c12bb05e42d6@oss.qualcomm.com>
 <20260803-dma_multi_sg-v2-2-c12bb05e42d6@oss.qualcomm.com>
 <anTbNsOQ02V6umXf@SMW015318>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anTbNsOQ02V6umXf@SMW015318>

On Thu, Aug 06, 2026 at 02:06:30PM -0500, Frank Li wrote:
> On Mon, Aug 03, 2026 at 04:01:44PM +0530, Sumit Kumar wrote:
> > [You don't often get email from sumit.kumar@oss.qualcomm.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Synopsys DesignWare eDMA supports a linked-list mode where each list item
> > carries independent source and destination addresses, letting multiple
> > independent memory transfers be described in one linked list and submitted
> > to the hardware as a single DMA transaction. The IP processes list items
> > strictly in order, so paired scatter-gather entries are never reordered.
> >
> > Implement the DMA_SG capability by adding a new EDMA_XFER_DUAL_SG transfer
> > type and a corresponding struct dw_edma_dual_sg carrying the paired source
> > and destination SG lists. dw_edma_device_transfer() walks both lists in
> > lockstep, building a single hardware linked-list; a per-entry length
> > mismatch or premature list end fails the whole request.
> 
> It is not as simple as it.  for example, if you want to transfer 9k data
> from src to dest
> 
> src virtual addr 0x1004,        dest 0xA0001008
> 
> when map_sg, src's sg maybe
> 
> 0x1000  .. 4k   offset 4,
> 0x9000  .. 4k   offset 0
> 0xA000  .. 4k   offset 0
> 
> or
> 0x1000 .. 8k  offset 4
> 0xA000 .. 4k  offset 0
> 
> which totally depend on physical address allocation although most likely
> first case happen
> 
> dest sg
> 0xA001000 .. 4k offset 8
> 0xA008000 .. 4k offset 0
> 0xA00E000 .. 4k offset 0
> 
> descriptors
> 1 	transfer 4k-8
> 2       transfer tail 4 byte
> 3 	transfer 4k-8
> 4       transfer tail 4 byte
> ...
> 
> the start address of src and dest is highly possible differences. So it
> is very hard to match your requirement, both sg's structure is the same.
> 

That's the API limitation, isn't it? The callers have to supply the same length
src/dst pairs to work with this API. But they don't necessarily need to use
dma_map_sg() which can provide fragmented mappings as you described. They can
use dma_map_single() or even the bus addresses directly as the MHI client is
already doing.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
