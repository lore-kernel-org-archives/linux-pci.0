Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B34825DB;
	Tue, 22 Sep 2026 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100483; cv=none; b=Z1L9pUIkLJTaTsmjGdnf7wjqwPiV3+7xT95lfHAxmdo9Hj+JHt2hw1a+fVBmq8ucqy7bTtsWmYzl6x+OmkiFq2O6lAQ5vz032PvkhYHDNJP5xxU/gDS1XWDsEf8UpmSBaGae1OCVdQgEE3svtLoy3XRaieGLrp7aiTWssQKXapA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100483; c=relaxed/simple;
	bh=sziaRl8DH9oeu7BAzibbtxWV4XuPfFufnQy3wBNUh8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FR1Wc5juMrtD0Lh+Cb7Qj45De1+7zQTC+TMAUj8hNsVuaUU+Sm5EMX3vLCp0Ei/5hp1xQf9ZMwSI7K7Wu224X8xoK7/f4amI4OtvN3H2uivUa2SFllhlPX9N3/6avHpCcFMmN8n0l4shhGvP63Lumq1dHQZ13ptdPgMMJhtTvdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XulreWxD; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XulreWxD"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hq7P85BMKz8txm;
	Tue, 22 Sep 2026 20:07:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790100476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RaKFAHmXI7vtT5VTgEWEeXIFQqBaYJ+1PFKMoKFOdAA=;
	b=XulreWxDr7BSQ2g57ETcFHMnIC5a5+25szqD/50iKK3TD65ZIbiusjQouGR0MDFu/I9HeE
	SW+q/kGbpLX4glJ8q33Q5A78QK0a23R5ekoh4FFzt30NeSz6m8HmccN9GsRyJ7xuR8X0pp
	jmwwuibVEov/C50QDFiT+N2t/1nxFF7ioiyo+rlCfNwmmh5vovKxvG5PoAZSzRJXakSzOP
	TwsP8xaFSkwirAeM8zIMq60axcIEEzCWmn8ogOg5gTpe8NSOMQwB2be/qDiETN1Gmrwsce
	XPgy/GzcENQRQcPPS9/stDeDwrBF0DE6SUB82zKgmBgj8ZlL9qGcmnPzrCoGIg==
Message-ID: <61488ddc-b346-4ba3-b32a-e972a3bd75a4@mailbox.org>
Date: Tue, 22 Sep 2026 20:07:52 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: rcar-gen4: Fix device_node leak in
 rcar_gen4_pcie_host_msi_addr()
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>
References: <20260918091052.2825315-1-fuad.tabba@linux.dev>
 <95685b0e-21dd-4446-8fef-c5664cea4057@mailbox.org>
 <20260922063830.472642-1-fuad.tabba@linux.dev>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260922063830.472642-1-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 886995ffb021cb24019
X-MBO-RS-META: ebiyoia9aickktfd3uyz7yhiyimu1jgc

On 9/22/26 8:38 AM, Fuad Tabba wrote:

Hello Fuad,

> On Mon, 21 Sep 2026 22:47:30 +0200, Marek Vasut <marek.vasut@mailbox.org> wrote:
> 
> [...]
> 
>> I think you have to call of_node_put() on msi_node(), so what about this
>> instead ?
> 
> The __free(device_node) is that call: it puts msi_node on every return from the function, the success path included, so no goto is needed. It's the same scoped cleanup pci-imx6.c and pcie-rzg3s-host.c use for their device_node lookups.

Oh, this is very nice, TIL, thank you.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # Retronix 
R-Car V4H Sparrow Hawk

>> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> 
> [...]
> 
>> "
>>
>> Also, I think drivers/pci/controller/pcie-iproc.c
>> iproc_pcie_msi_enable() needs similar fix ?
> 
> I don't think so: iproc_pcie_msi_enable() already puts the node at out_put_node, on the steer failure and the success paths alike.

Could you maybe send similar simplification patch ?

Thank you !

-- 
Best regards,
Marek Vasut
