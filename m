Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6741633E37A;
	Sun,  4 Oct 2026 04:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791088913; cv=none; b=Su4bXOID/O0FBGFk5KIdDCImjCouVGzsS5KRKYATE4cVP0CRuZECqjJMDmSPmqc6oODMlS+FU4qauuZ+riUIq7s1En7ge5PpHm/weztGH+89s1up4X2reJWETJxi3GX8pDTxgxd9bdEadcB+L4bUzIuZNfhAern+p7gUfrLqx94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791088913; c=relaxed/simple;
	bh=L+jANw5Z589wY+Mc8+/1MyXCzG7hSTFqtOcs1xwyXLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lAiY6cZ7O12ooBLwGei2fZpG1yGpdzJ2j6c/XpoLHEVcnt/hcqzTaJSiRadrcj8rskMZyaJvkuuX8GiY9mQJ2J5Q+smkMJpVGsWQetz96ZvvNX5ka8bz3HQe0X9r0VmtMRrROnfQDKG/XcNjvBuvHe/PllV5PT7OyDAWvloxjl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=lUOvVe/a; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=B/I64Mfv; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lUOvVe/a";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="B/I64Mfv"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hy8xS4JsjzKnRy;
	Sun, 04 Oct 2026 06:41:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791088908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G19ibnZTze7Y60hikbKT8jD4/+e1+MSfLkPWZX7oams=;
	b=lUOvVe/aRBIG8hooB6nWMv10t8xE23pRl8amwVH1F+Xzod/oYqPyjiWOwzVCnLdolUYdgl
	oCHF56FArg8Oe3CFo3ACbnifDBGr5v1tfWrOesLHvshyC0OQC+nIHB2vqls1a1/4Q63l3D
	iB5ChxcGvGf9W++WsjyxO2EHv2R/+gKnGbefQpwRuR3gI2IDUuRcjR18FRlo72ttfjVyoF
	ZnPvDU6G7ZjYFtrKeSpVGr1Rfr0Gb6arbNth7+HPoUu2jZinj30uARsUR9edRBCgxbNkbQ
	DacLsBhkhqUImRiuxgGdvUGRkidGQXjpl9C8iMA3xC0ipoF1acoiLGZTbX9o7g==
Message-ID: <6937b9a8-697b-4b87-b31b-74d6eab8bfbe@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791088907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G19ibnZTze7Y60hikbKT8jD4/+e1+MSfLkPWZX7oams=;
	b=B/I64Mfv9TNrwVwGwwXZnU4o3dE4vntvmFDSzugNnT/UGA1C/MEdT4tb1ULAjn08w5pktA
	IaukEgFeIyhc9fvXwQvnhIXsYHlD7Giu5BnPzZcg7i0culBjfXmwDWPUSRPYwYwD4SZbxo
	Xc3g921UhQOj8BB9CuZ3inZQEVHKdFSLKqPxzQafRV7UOhuxxryD3OjSG41gsqbwO0texR
	nyee8zaToaP/TnLlJHObCZNBGKLS0N1VHLPiaOI6mYwAjdpmEEkqEY3IkX8+nOhquX3WOF
	EGpvnWGflRBpC+4Pe+aih7rbxkujmVZ9JCIGwlyKejBYs8ZJsowKOXm+fZtw8w==
Date: Sun, 4 Oct 2026 03:38:35 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] PCI: rcar-gen4: Recover the Root Port on link
 down
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
 <20260928165230.3397664-12-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260928165230.3397664-12-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 640fda1b65dcf665f0e
X-MBO-RS-META: 3abhhi88rjuaaeawu4z6tafjidpjutw1

On 9/28/26 6:52 PM, Koichiro Den wrote:
> On R-Car, the controller's reset requests (smlh_req_rst_not,
> link_req_rst_not) arrive on intreq_pcim_sub, the interrupt the MSIs are
> demultiplexed from, so DBI is read as soon as the link goes down. On
> R-Car S4 that is a hazard: DBI accesses issued within a few hundred
> microseconds of an unexpected link down do not complete and hang the
> host. In testing, the first Root Port config read after powering off
> the link partner hung unless delayed by ~300 us.
> 
> Check the APP reset status in the interrupt handler before DBI is
> touched. When a reset request is latched, flag the controller as
> needing reinitialization, which masks the sources, ack the request and
> schedule recovery work. The work calls pci_host_handle_link_down() on
> the Root Port, which runs the AER-style recovery and resets the
> controller through reset_root_port(); it holds a reference on the port,
> which can be removed through sysfs meanwhile. The check also reports a
> recovery already pending, whether started by another interrupt or left
> over from a failed reset, so the handler issues no further DBI accesses
> until a reset succeeds.
> 
> Arm the detection once enumeration is done, as the recovery needs the
> Root Port to exist. Only unmasked status bits are handled and pending
> latches are cleared when the sources are re-enabled, so requests
> recorded during probe or the reset itself do not trigger another
> recovery. Teardown only disarms the detection: MSI delivery has to keep
> working while devices are removed.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
