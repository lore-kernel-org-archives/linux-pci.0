Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565797;
	b=aKMZe/UAIekBiizqy6r1PjMJwVzWSrsl5dr2ba/ZIF3x8qhjAkb5hVGFGBFGHvEjXog1
	 0HTUoXB6SkO1pNJoao/gtcHtpZnpabcu3/WAZ7hMrIBXhr54gt4Fp35C9Z6nz7tDjTgI1
	 l8DOSn2lReYiDNodNfeSKmYon0GYxXawdbYoZxb7Utdup/hKV7wo2Cs7BjgdIwGO+AyNf
	 wH5V1gIvKMJ41Mlfy9OvwpQJL6g+KvXDtJgNMFTTOaA+OYJvv343xssAKyAgbaDp3oGTR
	 71N1vxC5nt6NB+aHpjx2HvKQ4A9nJ4R9J6fXVTzKOdXjHRryHGgt72qXKkEiNmambjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565797;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=b+cjXTXacKqjQoVu2yP1gE2lBgxggqGecWcEU5GIV10=;
	b=U8Ij1kABKr7zCoBtDa/us/7IPKscJfy2ohOlF0wKTE3pCbfyJm21pjBxF5R4rbVO528X
	 olbTWlhNPGGP5EZIi8AYY/lN6G62wZ+2yw7cn06RV4RsSCkCJ0idQfEwwqEEc41UzFrEm
	 RDnBUALfOBpvYdDvQcjtfZU0P1K19S229BNxpu/vXm3STzlSOsXUUtB81TkEZQAd7GO23
	 bgaeZR+cma2PDWnXR6qmwKk/cJHXJhI2C1vAIQFiqh9c8OBepPQXS02fKOMequ1xwXGIC
	 642k4dXPKl3iTneZIrpxIYpVfFE0oAZONIQgeYWEiX6TrQoz55vzdUnY1WbJJmFBAwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jrY5Hd5U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98914606A31E;
	Wed, 25 Nov 2026 00:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jrY5Hd5U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC091F000C4;
	Wed, 25 Nov 2026 00:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795565797;
	bh=b+cjXTXacKqjQoVu2yP1gE2lBgxggqGecWcEU5GIV10=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=jrY5Hd5URruuUZgxQNjwvADf0WKeB41oTtx2mN4kEoC4we14dWqO4aU9Jl0gMSi6k
	 bDB74C8PMAVD7Py1CfMUH/ywTZdYlk1MnZyY41HgGJK6T930ej1XjzfqBQlqON8A9X
	 r5cWkpLNNzHqzd5j1wU2KWAp8sV1a6HONBuMf0U2KDLpMhJIyd7ykMsR5SfmC+xfRX
	 b8DRGEx4RJSi4evwNi5i/1ky9Ea1JG0DSFn7C0tU4XWEO/b9VMGv21GpIdLmaLj//l
	 gGlJMSY1dp7XDheHWuhwtvDpfPm7CkSI17m+omPsdTryBYO7hTopLq9NfroTrBQYU2
	 2BZnYOBshQ19A==
Date: Tue, 24 Nov 2026 18:16:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gokulkrishna Sekar <gokulkrishnasr@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	mika.westerberg@linux.intel.com, linux-kernel@vger.kernel.org,
	Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: Re: [PATCH v3] PCI: Correct PCIe port type field encoding
Message-ID: <20261125001635.GA1196358@bhelgaas>
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
In-Reply-To: <20261124085038.17299-1-Gokulkrishna.Sekar@harman.com>

On Tue, Nov 24, 2026 at 08:50:38AM +0000, Gokulkrishna Sekar wrote:
> set_pcie_port_type() validates PCIe port topology and corrects
> invalid upstream/downstream port type information in the cached
> pcie_flags_reg value.
> 
> When performing these corrections, the code updates
> PCI_EXP_FLAGS_TYPE using PCI_EXP_TYPE_UPSTREAM or
> PCI_EXP_TYPE_DOWNSTREAM directly. The PCI_EXP_TYPE_* values are
> decoded port type numbers, not values encoded for the
> PCI_EXP_FLAGS_TYPE bitfield, so the corrected type is stored in the
> wrong bit position.
> 
> As a result, a device whose type has been corrected may subsequently
> be reported as PCI_EXP_TYPE_ENDPOINT instead of the intended
> upstream or downstream port type.
> 
> Use FIELD_MODIFY() to update PCI_EXP_FLAGS_TYPE so the corrected
> port type is encoded consistently with the format used in the PCI
> Express Capabilities Register.
> 
> Fixes: ca78410403dd ("PCI: Get rid of dev->has_secondary_link flag")
> Reported-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> Link: https://lore.kernel.org/all/20241213070241.3334854-1-gthiagarajan@marvell.com/
> Signed-off-by: Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>
> ---
> v3:
>  - Updated Link to lore.kernel.org

I already applied
https://patch.msgid.link/20261124084828.15318-1-Gokulkrishna.Sekar@harman.com,
which I think is the same except for the "v3" in the subject.

But I amended it to add Mika's Reviewed-by (thank you!)

> v2:
>  - Use FIELD_MODIFY() as suggested by Bjorn Helgaas
>  - Clarify impact by describing the resulting PCI_EXP_TYPE_ENDPOINT
>  - Add Fixes tag
>  - Add Link tag to previous discussion
>  - Add Reported-by
> 
>  drivers/pci/probe.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 9a178e0e5f7f..4c7e0ad1aa1a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1673,8 +1673,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  		 */
>  		if (pcie_downstream_port(parent)) {
>  			pci_info(pdev, "claims to be downstream port but is acting as upstream port, correcting type\n");
> -			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
> -			pdev->pcie_flags_reg |= PCI_EXP_TYPE_UPSTREAM;
> +			FIELD_MODIFY(PCI_EXP_FLAGS_TYPE, &pdev->pcie_flags_reg,
> +				     PCI_EXP_TYPE_UPSTREAM);
>  		}
>  	} else if (type == PCI_EXP_TYPE_UPSTREAM) {
>  		/*
> @@ -1684,8 +1684,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  		 */
>  		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
>  			pci_info(pdev, "claims to be upstream port but is acting as downstream port, correcting type\n");
> -			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
> -			pdev->pcie_flags_reg |= PCI_EXP_TYPE_DOWNSTREAM;
> +			FIELD_MODIFY(PCI_EXP_FLAGS_TYPE, &pdev->pcie_flags_reg,
> +				     PCI_EXP_TYPE_DOWNSTREAM);
>  		}
>  	}
>  }
> -- 
> 2.54.0
> 
