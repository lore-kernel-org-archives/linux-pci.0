Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0BA1A6806
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 06:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346039; cv=none; b=BBr5YqYauQG8Bv3/a+XdFaM+bxTjHfZ6id/NVPNJZRt7tAGU7sh7d6atd2jlInQ5QuW/poSxzlaWDAEI6snwJOnmkAG6nmNnBWjnByPDoLdb9YPohJaQtLg9XYXfstVknq9633SdPtZrUuncJF1Bbqc/KUl+E28v0DcNN10EOKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346039; c=relaxed/simple;
	bh=nJ9v9XwbPhPdVWQw9eQekLm+UPnHl2HudupAyIcNWHI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dsEP7oPh3aekjvQiGRqJLCJXaJkZwURGnJ/LttvXGhbHV1HjOF7ThCTRZRwa3gUuzeZ4/XW0Dp31UIqBCBbV26Fs6sfj9S2AlJKTmj5QZ7k3UQB42Y//08DgeIpoEWgEZ4kPohcy6F3PoVpbfM06/KFnuMBzvMovwPNuuvRp9tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUQ4q3DD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUQ4q3DD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B341F000E9;
	Thu, 21 May 2026 06:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779346038;
	bh=163PEeCrqlqjLcmKTErXTMyOjJ4UUJkSt8Nypf2EDXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MUQ4q3DDX9eeiuNWOoHYVCNHcdWWsyVedbyN1kfpBaDODAdkppkV0lp49O8u3fTl1
	 +SHye8o82pd2E4v+SFzOMx25gOO2LTHGXrsMfLaFJhEMWPl3XXZ/wynlz0CsD/pAwr
	 eGHH6cUfC59QE+Jg+0vQzhv+JFIbVgy4Mt5JCJqkz3vFPT1B8c8MZRSPgYfrZU4QVC
	 xyVMjlkaaEokhnTkaZKBVwcwir63cnPN7Azgz5qeH6/bsp6nTcdzg2eIyZw+slsJrl
	 k0gTgAKYUw9BoDSMzW7JUIf0XFrn2xj9eAjk4r5vvVERtUD0lwPgIKetRmxmQSoFu+
	 mo6jBU+xREwcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] PCI: endpoint: Add DMA auxiliary resource metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260521063405.2842644-3-den@valinux.co.jp>
References: <20260521063405.2842644-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 06:47:17 +0000
Message-Id: <20260521064718.19B341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The API documentation directs PCI endpoint functions (consumers)=
 to use `dma_get_slave_channel()` for DMA channel reservation, which is a p=
rivate DMA provider API.
--

commit fb7a94c1ad6642e611ce882efa5fdd2085b38067
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: Add DMA auxiliary resource metadata

This commit extends EPC auxiliary resource metadata to allow endpoint
functions to discover controller-owned DMA registers and descriptor memory.

> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h

[ ... ]

> @@ -99,6 +122,26 @@ struct pci_epc_aux_resource {

[ ... ]

> +		/* PCI_EPC_AUX_DMA_DESC_MEM */
> +		struct {
> +			enum pci_epc_aux_dma_dir dir;
> +			u16 hw_ch;
> +			/*
> +			 * Local DMAengine channel for ownership reservation.
> +			 * Consumers may reserve it with dma_get_slave_channel()
> +			 * while delegating @hw_ch to a peer.
> +			 */

[Severity: Medium]
Is it intended for consumers to call dma_get_slave_channel() here?

The function dma_get_slave_channel() is a private DMA provider API
declared in drivers/dma/dmaengine.h. Since PCI endpoint functions act as
DMA consumers, they shouldn't access this header or call this function
without violating subsystem isolation or causing build failures.

Is there a consumer-facing DMA API that should be recommended instead?

> +			struct dma_chan *dma_chan;
> +		} dma_desc;
>  	} u;
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521063405.2842=
644-1-den@valinux.co.jp?part=3D2
