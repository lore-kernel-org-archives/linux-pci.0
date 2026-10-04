Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBBA18B0A;
	Sun,  4 Oct 2026 01:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791076688; cv=none; b=Ft94pcXQPZ9yRRWy/87pG4mkA/D80zNz9Zm+JemQS4bYGaKJ9uWiMMqs3sNhVKtWRf3P9iUqGI2QuEQTT+MVp9f32B+CJUZj6qmd6/HQ4b6wjHE0ABRxyDI+mh0RnHmQt+rXY+EYdj8ZmLOgwdweoOdgCEyB4zha/dhfcSWMyDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791076688; c=relaxed/simple;
	bh=qrncizePYbEsgy8zFPgYt6ErINLLEBzOAa3+8EAnUk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWCYJdedn/d9dUwjkaYucFasYVQFp2SG+gSfPR8DuovIqjeNR7SCa0isV4saR01KSdpG5Jn8oYjoWlbTYnrBATNG0cbP9mh2bHqAHwPwAZMzROOaHCX62rxRMuLQ+EJfoIkppBFDGbLPor7Ks9Au17pcVZNjxn9sLBQ0CjwLmmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=i+nyCphD; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="i+nyCphD"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hy4QM3811zMlFg;
	Sun, 04 Oct 2026 03:18:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791076683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mUIFxBkjdyKHEbIJD48ETN5921rZHK83t7OeJCeUqt0=;
	b=i+nyCphDIx2LXAjxxVkie8mawFECJfmK5Em5uppvu+0PWyKTsh5bBNfQy1WyIvkjzJGOWB
	4gRT3UqdAClS1QwYbEGz8DZU5rKBUuFEaamhYsVugkXPaeMtGqA6LWPs3aK8M2Zu/R3iP2
	zXSdGjAf/ZcQVkdmp0G2+UM2J1tFZKT8x2LJQAC1QzrUIplJMIp5YODe8JqFDawUvDbRVO
	G1gGRVPL2ZvxIrxR1kVzNrK47YtrQfEbFeb2L+nG+nh2PDp/X0xLE7BkdFJE71YK0zCBfD
	cgRp3RwWBol4qZFccJs9UQYIV7+9KGBfLzXCFlL0QOgmV/i5AdMl6KG4rlgHXQ==
Message-ID: <da9c10df-63af-4cf8-ad3a-084dd249cf21@mailbox.org>
Date: Sun, 4 Oct 2026 02:53:27 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/15] PCI: rcar-gen4: Take over the iMSI-RX interrupt
To: Koichiro Den <den@valinux.co.jp>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa
 <wilfred.mallawa@wdc.com>, Serge Semin <fancer.lancer@gmail.com>,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-11-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260928165230.3397664-11-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 842ff4ad273350811a2
X-MBO-RS-META: 3pxq4rme9r589mxm8itiyz7e4j54a4e9

On 9/28/26 6:52 PM, Koichiro Den wrote:

[...]

> @@ -724,6 +773,9 @@ static void rcar_gen4_pcie_quiesce_irqs(struct rcar_gen4_pcie *rcar)
>   		rcar->reinit_pending = true;
>   		rcar_gen4_pcie_app_irq_sync_locked(rcar);
>   	}
> +
> +	/* The MSI status lives in DBI; keep the handler away during the reset. */

Would it make sense to add lockdep_assert_held(&rcar->reset_lock) here, 
to make it clear that this IRQ disable is protected by the reset lock ?

> +	disable_irq(rcar->msi_irq);
>   }
>   
>   static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
> @@ -733,6 +785,8 @@ static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
>   		rcar->reinit_pending = !recovered;
>   		rcar_gen4_pcie_app_irq_sync_locked(rcar);
>   	}
> +

Would it make sense to add lockdep_assert_held(&rcar->reset_lock) here, 
to make it clear that this IRQ enable is protected by the reset lock ?

> +	enable_irq(rcar->msi_irq);
>   }
>   
>   /*
> @@ -804,11 +858,17 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
>   
>   	ret = rcar_gen4_pcie_host_setup(pp);
>   	if (ret)
> -		goto err;
> +		goto err_deinit;
> +
> +	ret = rcar_gen4_pcie_msi_irq_init(rcar);

Would it make sense to acquire the IRQ a bit earlier, so you could avoid 
rcar_gen4_pcie_host_perst_assert(pp, true); in the fail path ?

I think if the MSI acquisition fails, perst signal would pulse (rapid 
sequence of deassert and assert), and that could be avoided.

> +	if (ret)
> +		goto err_assert_perst;
>   
>   	return 0;
>   
> -err:
> +err_assert_perst:
> +	rcar_gen4_pcie_host_perst_assert(pp, true);
> +err_deinit:
>   	rcar->drvdata->deinit(rcar);
>   	return ret;
>   }
> @@ -818,6 +878,9 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie_rp *pp)
>   	struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
>   	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
>   
> +	/* Stop the handler before asserting reset and disabling the clocks. */
> +	free_irq(rcar->msi_irq, rcar);
> +
>   	rcar_gen4_pcie_host_perst_assert(pp, true);
>   	rcar->drvdata->deinit(rcar);
Shouldn't the IRQ be released only after reset is asserted and clock are 
stopped , otherwise it might accidentally fire and cause unhandled IRQ 
event ?
