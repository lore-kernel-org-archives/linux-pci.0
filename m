Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795786151;
	b=LprnQJffkYm+859bDgTM7MXOLMSHWP43h+JuZ3g5A3DDuvvN1LmoB/j1nP7VXncdCozB
	 DoDhCW12JARyYIT1neQFFCcpIUBRd9PoVNmd4hw4c7QyAukw7XoMsVd2E9+JIV2GmGtU/
	 pLJOmafNRC2JOUC6lbiHMAsimQGYI+Li0zrpWvxhc4df2397MbsNiZ5XIJtiKbjXu2Fdp
	 W/DP/AnawwnzdcZwnUjPp19UURzPlmCY40g4IkwMKogyr6Bp5AnnRWnSeaZOD7B42F8pY
	 cUKRujFB6T4tmzoz8V3Rgiv9I0qbn8lswcW6zlZUIj8GHAlRuuZwj5llnT8KYVXoyMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795786151;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sVqYPOVlwwpegfi3MjROpaZBJinf/L2AAxP09m2QgAg=;
	b=owbuFL7mB8X84X4BtpVFElAdhqT+frUSHUCbTPppOVl4Bo4hrp0eCtpsPdvlubk7AFF2
	 C1V8V2dVhRk+MdZyunkFgC8FpYGYnEbxXvqotGMMAhocJz4c+NwmB1xC5T/hM9O7BA7Hc
	 Rbf4d5H+HW/L6es22cpsSJ5FM4VffN09I7dpbGkyGyd2WYjhFZ92vltSJi2VBazz0kxX+
	 1HM1xxb/y7s086qaXh5SA5hVJMD/VbCvCX9HSto8x8b0WJZH3lUrtsnNmnS0f9jtlg1FP
	 1n+iPKBgP5h2/0qm5f5c2ASQAB2FQVIx2a59MVHda815/BiZ/Lvr8Vjev8if800YD3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jok/TNcy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AC3606A31C;
	Fri, 27 Nov 2026 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jok/TNcy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EA51F0092A;
	Fri, 27 Nov 2026 13:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795786151;
	bh=sVqYPOVlwwpegfi3MjROpaZBJinf/L2AAxP09m2QgAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jok/TNcyrOYzHD0Syfb4ndGvs2TSIcgJeSoLwX1Ko4fLqPvYc2wUKM0TnKrzNKDJT
	 QS+4yppD6w/fEFJVTTLyVhDh/jhfeDgRmI62/IJ71RWkD0qRW+RlCbzP7ZlxaaWTYz
	 1eYECZlVnDWHhmVU9Wf2YkqX5G9EZqgTiFhbENfb65TzVlxoKFOJdkME74ChBu2SbO
	 7iq1v28Z/zxW2XSFdw+7p+il+q2qkENbAM5JqQYQ4Pp9CZvQp//042m5d7ilhIdkFb
	 KZvMs7YDsPfuwCTxJMuse7Gf5d6VpR39eK4cSHXjmD1FGjv66CF435Hm8NZVpXwFJl
	 OmqUQIT+4/DHQ==
Date: Fri, 27 Nov 2026 14:29:07 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anju Zheng <zaj01616726@alibaba-inc.com>
Subject: Re: [PATCH RFC] PCI: Add warning about possible danger for
 pcie_bus_perf mode
Message-ID: <awmFo6EvAqQB6tp_@ryzen>
References: <20261125155829.77269-1-feng.tang@linux.alibaba.com>
 <awfv0WKc6iblVA9E@infradead.org>
 <awmEjs8VnJO5XIXd@U-2FWC9VHC-2323.local>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awmEjs8VnJO5XIXd@U-2FWC9VHC-2323.local>

On Fri, Nov 27, 2026 at 09:24:30PM +0800, Feng Tang wrote:
> @@ -6423,3 +6423,24 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
>  #endif
> +
> +/*
> + * Some commercial NVMe controllers do not honor their Max_Read_Request_Size:
> + * they issue Memory Read Requests larger than the MRRS the kernel programmed
> + * (under pci=pcie_bus_perf the kernel sets MRRS == MPS).  In PERFORMANCE mode
> + * the upstream Root Port may be left with a larger MPS than the device, so it
> + * may reply CplD packets with length larger than the device's MPS.  The device
> + * then reports them as Malformed TLPs, raising PCIe RAS error or Machine Check
> + * Error(for x86).
> + *
> + * Flag such devices so that later on pcie_write_mps() can force the corresponding
> + * root port's MPS down to match the device, keeping CplD packet length within
> + * the device's MPS.
> + *
> + * This only affects PCIE_BUS_PERFORMANCE mode.
> + */
> +static void quirk_broken_mrrs(struct pci_dev *dev)
> +{
> +	dev->broken_mrrs = 1;
> +}
> +DECLARE_PCI_FIXUP_HEADER(0x144d, 0xa80a, quirk_broken_mrrs);

Please use PCI_VENDOR_ID_SAMSUNG instead of magic value 0x144d.


Kind regards,
Niklas
