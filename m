Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C03345EAD;
	Sat,  3 Oct 2026 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791052229; cv=none; b=qblfz+Py3LpJWtx8Kpd7osqSzb4aS5hC7S9gAX1GewEkXtU77AtDaUt9SshzpskbXf0PKqamtAwEVoKWTruA5FOcaCQQg7G4cU0ydpwX5soDyJ5QihWcEFeY14EIWCv3BM5cZwLgiyVi4tqeEbn6laf+EyLQZHRfrrAGh84nJQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791052229; c=relaxed/simple;
	bh=4DDED3zIzc+7RBVcH2Fte2jeu8/DJz/VTtW1wirbE7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D04zgL5NASRrLITMT+s7lVe2qzoRaeGSuaM/dTF3Yv5isc+VGKzrThEQhRQ6J1G9f4uVIWMLdi1DNXeSUaWON4QRjyDCcqWkYeoOJnbOPspFQbIn4eRJWprG8BB1Cq1swN3U3Z5eLcC9g/q0Br+9ouEay+NuzoV+HSns5p4DfqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=UyTp9Y8+; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wUADzkjK; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UyTp9Y8+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wUADzkjK"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hxvN21Hgwz8v0B;
	Sat, 03 Oct 2026 20:30:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791052226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XWzyX5wKENt/CbH0T2GGbHbSs43L4PYrG2+4MnK15g=;
	b=UyTp9Y8+K1jktQEoxF+aaR1XBPl251cZBoX5hex6AdbHBIETz40H/qG2XR7F/n5uHSWWBR
	z9SNN5EBrCX5D/yt3sBeVsRJqH7QT92rxd8vTSTcq+8S4Eq0ps/TKuxrAdJkUFkI03yz+s
	XcAagj4ZipZBtB0JVxQdSmq90rTEbeAJI7mpzlQjucD03igXLzrPC3pcaoctc0+AVuYH3Y
	WUsKZ6+A6YUc9qaCrCswEk0WsBOdO2srqETySjwv3yIwJh3XVe95aGjWcHSnU/cLJ+tIXp
	WciyScJhFn+ikPsGO8tfy0K/NBmoy78r7BWoqrwtYDuDPDNVO5lhgl/DPk518w==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=wUADzkjK;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <d675e0ba-10f3-4503-bc2e-61977f4a5875@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791052224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XWzyX5wKENt/CbH0T2GGbHbSs43L4PYrG2+4MnK15g=;
	b=wUADzkjKQvNUkIxSloR+zZBkRA/e0KH/N5LBigIHb8+fTeLF5yASDsJ1lrJwFjQfJXvEyH
	cdeEwc162WID+c/6u5Kmmqx6XfSsEIs7bkJPGjosdIuByZfxyLKJu9/ZRCg8a1QDHkOYhK
	T8v8XwZUlRGKV9xNtSjrGMp12GHZ8YD5vq7oE+aCOVWcFXUAT4aBqEIMMsxTURbdB0W1f8
	6YD3lL/qPL+IlXH6IU48J4aotYfmeAY0LPlqvKkrOS6ggNeju/lvonqPFcUMDUnZ5I1nR+
	wHWl+/Bc/nAdlBNSnuQ/xeh+ysOxULrDbKNPvi2hnudEnx/Mc0ORdLXCTshYbg==
Date: Sat, 3 Oct 2026 20:29:55 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] PCI: rcar-gen4: Check live link status in
 link_up()
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
 <20260928165230.3397664-3-den@valinux.co.jp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260928165230.3397664-3-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 3myrmbc5yt3ys84udweakafq3q1dhd8j
X-MBO-RS-ID: 502345ab8c6074d3f58
X-Rspamd-Queue-Id: 4hxvN21Hgwz8v0B

On 9/28/26 6:52 PM, Koichiro Den wrote:
> rcar_gen4_pcie_link_up() checks link state using SMLH_LINK_UP and
> RDLH_LINK_UP in PCIEINTSTS0. However, these bits do not reflect the live
> link state. On an R-Car S4, after taking down the endpoint, a link-down
> interrupt saw PCIEINTSTS0 = 0x20a000c5 with both bits still set. Even
> after resetting the controller with the LTSSM back in Polling, they read
> 0xa000c5, still set.
> 
> As a result, dw_pcie_link_up() keeps reporting the link as up after it
> has gone down. That defeats the check in dw_pcie_other_conf_map_bus(),
> which is supposed to stop config accesses to downstream devices while
> the link is down, so such accesses go out on the dead link and stall the
> host. It also makes the callback useless for the link-down recovery
> added later, which has to wait for the link to actually come back after
> resetting the controller.
> 
> Keep the APP link-up event check from Figure 104.5 of the R-Car S4
> reference manual, but also require PORT_DEBUG1 to report the link up and
> not in training. The callback then rejects a downed link even if the APP
> link-up events remain latched.
> 
> Clear the APP latches before enabling LTSSM to discard events from a
> previous start, and only read them in .link_up(). RC startup uses
> dw_pcie_wait_for_link() to poll the combined condition.
> 
> Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

I apologize for the late reply.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # R-Car V4H

Since next 20261002 now contains commit

f29719b5064c ("PCI: dwc: Align register macros with Synopsys documentation")

This will need the following slight adjustment:

"s@PCIE_PORT_DEBUG@PORT_LINK_DEBUG@g"

"
-       val = dw_pcie_readl_dbi(dw, PCIE_PORT_DEBUG1);
-       return (val & PCIE_PORT_DEBUG1_LINK_UP) &&
-              !(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING);
+       val = dw_pcie_readl_dbi(dw, PORT_LINK_DEBUG1);
+       return (val & PORT_LINK_DEBUG1_LINK_UP) &&
+              !(val & PORT_LINK_DEBUG1_LINK_IN_TRAINING);
"

Thank you for your help !
