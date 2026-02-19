Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F9F2C0F7F;
	Thu, 19 Feb 2026 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771500267; cv=none; b=LEOzC+4hevssFp2f5xEKY5F3hPjQGQRX4Cocz4BGt5S5+e/7Q8c242wQiJPuSb+mjVS+OaDRdhCTjelH8/rhVNZoRqvTSXmtzklgnEGFbf2d6B+n/B0TXt8oCwKbN3mAliHURul+BYHxW0jrTvH9qi1/r1brIJd5q35OJrxC/zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771500267; c=relaxed/simple;
	bh=kiWWMJPRnZszwBRPKCM3XhoHzxajw/7QqLZcR1h9gdc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCZN7w1PleqzQCUC3TKmNl1gvi53r3JXHi/U5iCRPqWyxfC/yK98b7QURH5rRz/gb6w9xZN9hPNDxn3DFZDsZFnbac3K0aq2Z9CsxzYHxLPz96fhCUUeGO6+ZxbJpiS1Mjh8n2xwO9sDX9iAcjuTS5EpWA67CprxwcCob6E78QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fGrcS4fvzzJ46ZK;
	Thu, 19 Feb 2026 19:24:08 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id E7DA440584;
	Thu, 19 Feb 2026 19:24:21 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Feb
 2026 11:24:20 +0000
Date: Thu, 19 Feb 2026 11:24:19 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <alistair23@gmail.com>, <bhelgaas@google.com>, <lukas@wunner.de>,
	<rust-for-linux@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alex.gaynor@gmail.com>,
	<benno.lossin@proton.me>, <boqun.feng@gmail.com>, <a.hindborg@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>,
	<ojeda@kernel.org>, <wilfred.mallawa@wdc.com>, <aliceryhl@google.com>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Message-ID: <20260219112419.00000903@huawei.com>
In-Reply-To: <20260217235604.GA1595019@nvidia.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
	<20260217235604.GA1595019@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Tue, 17 Feb 2026 19:56:04 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Feb 11, 2026 at 01:29:07PM +1000, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> > 
> > Security Protocols and Data Models (SPDM) [1] is used for authentication,
> > attestation and key exchange. SPDM is generally used over a range of
> > transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.
> >   
> > >From the kernels perspective SPDM is used to authenticate and attest devices.  
> > In this threat model a device is considered untrusted until it can be verified
> > by the kernel and userspace using SPDM. As such SPDM data is untrusted data
> > that can be mallicious.
> > 
> > The SPDM specification is also complex, with the 1.2.1 spec being almost 200
> > pages and the 1.3.0 spec being almost 250 pages long.
> > 
> > As such we have the kernel parsing untrusted responses from a complex
> > specification, which sounds like a possible exploit vector. This is the type
> > of place where Rust excels!  
> 
> I was arguing for exactly this at a recent conference, so I'm glad to
> see it. It is a great meaningful usecase for rust in the kernel.

FWIW I'm fully on board with this as well.  More than happy to see my C
code Lukas has been carrying go away in favor of the Rust :)
It'll also finally make me learn more than a trivial level of Rust.

Jonathan

