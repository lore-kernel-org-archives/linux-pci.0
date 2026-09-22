Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4770350129B;
	Tue, 22 Sep 2026 21:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113507; cv=none; b=htYBADYVFBEgkN40N8chonu9wIL6laRwt7V/aD3IKkIn+Vym+wcCId3rxDZ8gFTX1271Q+Bq0xoeH4SFg0Q5HwjK8DZ8rLctKqOqmOeX3IqzMjPqRx1bTrWoeEUzSGFEo7Qk6eF2Qoj8LrV9XFs1N1/Kv5UDrPoxkdCgPVJWmDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113507; c=relaxed/simple;
	bh=nBw710jscx1SJt2ZNzlnrVm1hVeF7Ka+v9aQJRciorI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZ9PXv18zlwK2VEvutwus55l8mS206RmHJvDhaDIC2lVnnlwFL4G4Lv6Ev84C+btBd8PoKI5MYyXUUPk/58P+LJyH/0euB4/Z7fseipRZ1YFuIbVyHv5zrp7Y9iPzH28xRvFXJAfhATPVZuCZZiyxch1Q5u8IwJF4guPPm8weQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=lRF1JCXk; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lRF1JCXk"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hqDCP4jNVzKmSq;
	Tue, 22 Sep 2026 23:44:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790113489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3omKxETwtZPQxv84xQTyPPhI/xYVu/M+CN0JCwD5X0=;
	b=lRF1JCXkPdwK/KxloIF+yCoOCCxuoKEPu1Ex+BLaB+VfCfgdrLc8IlavA2hby7qgGddcWB
	YFsY30Fr4SaPhFCyCKVeOkD7KZDVptMj1IunemwnPdBfQttDO4dL7ieATxF17A0Pvj/TDt
	jhNzenmaTWH07Ckw+4K6yGWZmbzxYpkBeq89yJgV6x2e3OA//6AJ0VAoGO0rR3SJfyMCP6
	WvLChYJJSRW3SrU5YTv5QmgDLQauH6ff62rxNAAZpvd86EmiMXiAKbI1Z5BYhMBouaAJKr
	d8DetUz80XR4/VIVd9lkgLCt5uJof+tJc7M4ZNQzKHCldXj4nvPEV+JYESiDDw==
Message-ID: <e9a60e4a-95ac-4e49-a16d-a8eca2196d4a@mailbox.org>
Date: Tue, 22 Sep 2026 23:44:02 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 07/11] PCI: rcar-gen4: Recover the Root Port on link down
To: Koichiro Den <den@valinux.co.jp>,
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
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-8-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260918032038.2216471-8-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: my53mxhmq7kqk69qt5idoj1s8eypejck
X-MBO-RS-ID: a165d33bb362d234e9a

On 9/18/26 5:20 AM, Koichiro Den wrote:
> On R-Car, intreq_pcim_sub carries both the integrated MSI receiver and
> the controller's reset requests (smlh_req_rst_not, link_req_rst_not), so
> the generic DesignWare chained handler reads the MSI status from DBI as
> soon as the link goes down. On R-Car S4 that is a hazard: DBI accesses
> issued within a few hundred microseconds of an unexpected link down do
> not complete and hang the host. In testing, the first Root Port config
> read after powering off the link partner hung unless delayed by ~300 us.

Out of curiosity, do they trigger SError, and does the firmware (TFA) 
trap/fix those up in EL3?

> Use the pre-MSI callback to check the APP reset status before DBI is
> touched. When a reset request is latched, mask the sources, ack the
> request and schedule recovery work. The work calls
> pci_host_handle_link_down(), which runs the AER-style recovery and
> resets the controller through reset_root_port(). If the reset fails, the
> sources stay masked so nothing touches the unrecovered controller.
> 
> Only unmasked status bits are handled and pending latches are cleared
> when re-arming, so requests recorded during probe or the reset itself do
> not trigger another recovery. Teardown only disables link-down
> detection: MSI delivery has to keep working while devices are removed.
> 
> When iMSI-RX is not used (external MSI controller or pci=nomsi), the
> DesignWare core does not request intreq_pcim_sub, so request it in the
> driver.

Would it make sense to request the line unconditionally, to simplify the 
driver(s) ?

I also have to wonder, is this specific to R-Car or could it be this is 
a generic property of the DWC controller and this should go into the DWC 
core ?

Thank you for your help !
