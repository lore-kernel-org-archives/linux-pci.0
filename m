Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839690;
	b=l17UJGMEYsVL2EZBmAkN69im6bOUaDJ7bhmf9bS3l3W9lTba3lNOdPCgolmxiIzIw5HA
	 PfROdoDADczswrPOK2lRiPhmnOQ7QPQFVT6qbilqCfq/b9SsAW8MO1os++NduaZdloR7m
	 hNN/uq/6I+2MEgA1z0ltPOWKfZSdv3sD+qtuo1vQt8Ff3MkjOM/Bmrnp2PZBfOkZ0w2uR
	 MPUn/KA2/Cl22OL5CnKGTn5A0sSMKmPdhjwkO9bd0Nli4F7j5K2uCMGO4u8ufTorblBKf
	 7TH+OWort1Qb2oTuadnkbRUA0t5tVMWX3aUPEnEl2iOJvRiS12spsG02DPAGXBeZa1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839690;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=eyWOu1WuUUAiws0oDF5CqX3ZuoMFxLBuLN+S2LNKOls=;
	b=Dlb2vMjh/p+Nf6n79uEId5NHsJJTumVbdqh++rFaDh7cfRgcVPHfKVrDV0hrbRBIe8dI
	 Xl02vNjWbMn/f3yyxycH9bO5EeTAQFfOEGGTRW9nBvT+wjYrTeHFhqY169yWG1m/OyEL5
	 4vcsmZ+42l2rVjN2XcuWjHkV9A7d1AvYqGrRymvuI8vjbV16o3Y3Ior/dnEL+Rk8osbvf
	 TthB+T8hPrRN7hc9IGCuLVEhtLF68D9zV1DT0IvObnh3xwhi7jvgSSpQ7sSt065orXIGQ
	 w+vjpfioDy9WczZ/4GwudHiIx5Pn05vNeUoMEyvuqP2We2BjW10HB8chtIbGjDAAH9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DmLY/noi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91255606A32A;
	Mon, 16 Nov 2026 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmLY/noi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D0D1F000C4;
	Mon, 16 Nov 2026 14:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794839690;
	bh=eyWOu1WuUUAiws0oDF5CqX3ZuoMFxLBuLN+S2LNKOls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=DmLY/noip31/hQQ04YKMY86Tf1uda4HsWYWB4V/UcdmwcyvRXYWn5ZMjgHDQfh2G5
	 yWqEptfyP51PU0JsbeGYXdmHoI4Xgfi2eAnPtefZ/cQNYyuqI4G62BphBWHeTN43wo
	 1iCt753BWhvLRKahmt4G2EF+FO9mcavVUYsshGyTpaab/qjRvwwqSeh5o6mr1PAwGc
	 SVH2bj/YjiLAqf3mi5+AMtvUMW9mUO5wEY0vkt1fSsGazXD6uVYjm+Rcx2t/bV4Bla
	 1zkuSgAbQxAOsWXapaYN4baBORpZp3BRBfg7lYUjLQjEjFNyYn2yq33+czCjWfpCmK
	 Kei2FwFlgtKiA==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-coco@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/TSM: Move core code into its own directory
In-Reply-To: <20261116131959.GD1850935@nvidia.com>
References: <20261116075420.76205-1-aneesh.kumar@kernel.org>
 <20261116075420.76205-2-aneesh.kumar@kernel.org>
 <20261116130055.GB1850935@nvidia.com> <yq5ajymcyl2g.fsf@kernel.org>
 <20261116131959.GD1850935@nvidia.com>
Date: Mon, 16 Nov 2026 20:04:44 +0530
Message-ID: <yq5aecckyhdn.fsf@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Mon, Nov 16, 2026 at 06:45:03PM +0530, Aneesh Kumar K.V wrote:
>
>> The complete CCA patch series adds the following files:
>> 
>> attestation.c  core.c  ctlv_attestation_pci_gen.c  ctlv_attestation_pci_gen.h  internal.h  Makefile  spdm.c
>
> Why would any of this go under drivers/pci ?
>
> The whole point here is to make an 'attestation subsystem', so that
> all belongs under
>
>   drivers/attestation/
>

So the attestation evidence would be fetched via drivers/coco/tsm/ and
stored by drivers/pci/tsm.c:pci_tsm_evidence. I would expect
drivers/attestation/ to provide helpers, like other core kernel
components, allowing different subsystems to register as attestation
backends, with PCI/TSM being one of them.

If this is not how you foresee it working, we can defer this patch, and
I can carry it in my tree until the PCI attestation design is clear.

-aneesh
