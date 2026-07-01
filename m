Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861C0224AF2;
	Wed,  1 Jul 2026 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782939161; cv=none; b=mylvh85PSTq9TELcvR2KzQslQdp6NOxsR2rN52nlc5UdKn4a4S3Fvt1J7j5SR/7+xsd+CdrU6FDktXLt+eiL3PZT+67kziUlfgM1ONxf27/UK0080sEwcMpOdNQuljTwz5EvpKOxb/pTvZKJ6kTQ8vZ+7VbAtTWWQAOokK+xCi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782939161; c=relaxed/simple;
	bh=x18UYCOnTafTkUw1henYF1Zm3Dti3RwUnI6LNphuT+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6uV6UCoFsVv3J8DbrMnFeBKQMIc2sM492+PjVshhfeMrsb9LhjrGqpF1cUpZuE5zBu9c87QKWCDkd3ujdXuLMITwBzacG3M/0BwiH5XFt1M0rLXQm2Y419XSVk4/5j92jG0nKYOOmBjeoWww9sCOoMxFyKYMeZGAjbh08GJF7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ec1fwqbX; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=D5cTYaIh; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ec1fwqbX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="D5cTYaIh"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4grBzN2zPsz9v0M;
	Wed,  1 Jul 2026 22:52:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782939152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0St7A+bM7xpXZZOVB/XPO0PsDqfIv4E00jty33/c8Y=;
	b=ec1fwqbXQwarcLEaXC8UsjFFr42kwtKI/ZS95BCs5NW7z3V9oPgeA2CdrRcFA0/5zA5xZx
	a/JerRdN9Mb2Y3WqxtVnqD5GYvfRAZKibc3pGmD8Q4EX/lNh9KFgwPA574ORw8xph6amrU
	opaWN17gl2DFROMjfQg1BW+R2cICggKF9dXRYBWmdRtapCXFpMeDu5msgd3N0bRucrB089
	NMZvqCWXqynapGcrdvcC5y+yyc4HodjQb6U25C7hhdxJNyYAbvTi/ZdH8ETOly/IxHsqDJ
	uAd/1yRX+V8DIzn8bqbTnx4pZFfAWDkhLIE6selrUn4XKb+JdL2vHMs3gpJ/WA==
Message-ID: <495cb1ae-f11b-4f92-85d4-59b2250db34e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782939150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0St7A+bM7xpXZZOVB/XPO0PsDqfIv4E00jty33/c8Y=;
	b=D5cTYaIh9L6fuPd7PYJvhu3auo30ngDcq+z9g7rp2mzq5wS8APc6fzEIv3EkKdcfRcpup2
	Xx3cSUaghqnvks8OwsYVpsv86178E6Tp949pL1VWkSGpQ+IbdkZk2PJWTEioYFMkDk7K2G
	7LTtjm4FCX2/Byb97P4aqHFZoapDaR8mrsjdbLSp3Tx0bBQsGms8NQmMpOPVE74d0K1+N9
	o7a94nkLEI7wT/mi+K7EGzNvrV/JXDFEANUuvm1YfDiPnVlGBPdwAIKl5mcQ29yDTrJqqm
	zbjkec22/4SbNy4mE/woiGHekzF90ttuGvuEDTVxV4ZhtPM3yqqf5onX4g1HQg==
Date: Wed, 1 Jul 2026 22:43:41 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] PCI: rcar-gen4: Configure AXIINTC if iMSI-RX not
 used
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260618220427.14325-1-marek.vasut+renesas@mailbox.org>
 <20260618220427.14325-2-marek.vasut+renesas@mailbox.org>
 <CAMuHMdV3tyZk8ckL-ihdbVcGV9tQumdntPc_nJB6HXEkZLytfw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMuHMdV3tyZk8ckL-ihdbVcGV9tQumdntPc_nJB6HXEkZLytfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ub6t7dpfuhwtpwyhgrnpcye9afenpdm9
X-MBO-RS-ID: c7dec5a8f8a3f8f14ef

On 6/30/26 8:04 PM, Geert Uytterhoeven wrote:

Hello Geert,

>> +static int rcar_gen4_pcie_host_msi_addr(struct dw_pcie_rp *pp, u32 *msi_addr)
>> +{
>> +       struct dw_pcie *dw = to_dw_pcie_from_pp(pp);
>> +       struct device_node *msi_node = NULL;
>> +       struct device *dev = dw->dev;
>> +       struct resource res;
>> +       u64 addr;
>> +       int ret;
>> +
>> +       /*
>> +        * Either the "msi-parent" or the "msi-map" phandle needs to exist
>> +        * to obtain the MSI node.
>> +        */
>> +       of_msi_xlate(dev, &msi_node, 0);
>> +       if (!msi_node)
>> +               return -ENODEV;
> 
> This is not backwards-compatible with existing DTBs.
> I noticed because PCIe is broken on Gray Hawk Single with R-Car V4M
> after this series.  Indeed, "[PATCH v2 4/4] arm64: dts: renesas:
> r8a779g0: Add GICv3 ITS and update PCIe nodes" only covers R-Car V4H,
> but not R-Car S4-8 and R-Car V4M.
Thank you for spotting this, and, this code is not supposed to be 
reached. It turns out, pp->use_imsi_rx is not assigned yet in the .init 
callback. I hope this is addressed in V3 with a new patch:

[PATCH v3 1/5] PCI: dwc: Determine whether iMSI is used before calling .init
