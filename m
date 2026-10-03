Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5257B2F260C;
	Sat,  3 Oct 2026 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791052227; cv=none; b=bAj7WMTihsFr1Sg2uO03CIndS+jHCB2tX6tSrakqIhHKZTGOMvkPoUzqGjPHkXUjB8mXCelzrzU85SRKQg1ptSYjBg+SQHzkbkG5jQuvpqzjh45MkHNQ4zT5l1KnSDxk/N5Gnf4+ThoT6DfMVOEQzcnVZuikZ1gqxwUzDDvyZOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791052227; c=relaxed/simple;
	bh=wUzlpKmzg3HGMKBMVxhSvRod0utWoklNlgwpnfPG6vQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqF1PFHHsBthTowMEGtd/5dL++LYKWARQ8ITFkW5KVjFyR9upzcVfriMAdZ2OgFAtsWdblVK1vVAQwNB48d4SjGQgz0gIdcNmhzRMqGph+IrsSm9GNsjO/OkE95nZOogOQMqLalm4EqC6Ap26E4/iF9DNLAbVUtUmLatuctOWDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xRbjFnvF; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=eMB+X7/e; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xRbjFnvF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eMB+X7/e"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hxvMy6r1xz8sxm;
	Sat, 03 Oct 2026 20:30:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791052223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wpte7tuxAV25co1FHUvlySd8uIu3IAyZNAMQ/PNAGT0=;
	b=xRbjFnvFiRYN9D9DqPITGhdYwu4QwHNs73PMowxn0k/hfEkMmS/ldPXdqrsTMbaSMzTmV7
	6MAnvf3NM3x6wykUkJ8cwLo0MBWZZoystU8E5nN2qNatZlWf8IL/bc6VbaadspgtcvGKq+
	DCLWdbW07I8GzYLJwn7irU2O3hEz3KunrA7a60FAGfJPrj3f3PKkiFoGPmJxketkTJqr32
	eWGprFsJhe3k6CpCOeorYSNU60l6Tsw4Yfby1pcW2NYhkiio8GjlhumEcRG0KOALu18nqT
	t9YK8DzdSjlo5q2yZ6r9y02Jg/Bdc/f3ay6f/zpRKXYeU6JOJkTHq23eIp7BaQ==
Message-ID: <faf845c0-c17b-48f0-b75d-7bed9b348c4b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791052220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wpte7tuxAV25co1FHUvlySd8uIu3IAyZNAMQ/PNAGT0=;
	b=eMB+X7/ezSPflDtc1xqY9owTIBSGjPYxBAoClx369CcsTKlEnR3P06ZndEmMV77aZWu3Rm
	PGAGGb/V+6ufms4WPVyiyB6HxMnBqYuhmFQrEROCgVzR/7nIsz01iZuZEaWSvll1Ul3Veb
	Rova4jv4U58DYlxM/vZ/onaJOKemnKyGFnlvsUeMZWg518QdO4/5aOpDl151eDotncqXs8
	lGa8I00RJUsFDXWTwv5eTmR0U/1CpqIh632rsuS8ONe2fr5Ja339oIpj+tdXycJRC4RYg5
	80eM3GKqAqRm2FbV3UZ2HUqiYK727hx8sBDKFD8pQoSbtwXh5Wf33+cw3tqU6A==
Date: Sat, 3 Oct 2026 19:46:35 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] PCI: rcar-gen4: Recover from link down and route
 Root Port interrupts
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
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260928165230.3397664-1-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: fna3qkntbk8srid91af44m8u677x6r5a
X-MBO-RS-ID: 887c1f66353010b9e8e

On 9/28/26 6:52 PM, Koichiro Den wrote:
> Hi,
> 
> This series improves error handling on the R-Car Gen4 PCIe host
> controller (tested on R-Car S4 Spider, r8a779f0). It fixes unexpected
> link-down handling so the host doesn't hang, and wires up missing Root
> Port interrupts (AER, PME, bandwidth notifications) so port services
> actually work.
> 
> A few hardware quirks made this tricky:
> 
> 1. PCIEINTSTS0 link-up bits don't track the actual link state. The
>     driver never noticed when the link dropped and kept trying config
>     accesses on the dead link. Patch 2 combines the APP link-up event
>     check from Figure 104.5 with the PORT_DEBUG1 live link check. Startup
>     clears the APP latches before enabling LTSSM, and the DWC core polls
>     the combined condition on the RC side.
> 
> 2. On S4, a DBI access immediately after an unexpected link down can
>     hang the host. Commit 0056d29f8c1b ("PCI: rcar-gen4: Assure reset
>     occurs before DBI access") describes an SError on V4H after reset
>     deassertion, but whether the S4 hang shares the same underlying cause
>     has not been verified.
> 
>     Adding a delay before the DBI access avoided the hang in my tests,
>     but that alone would not provide link-down recovery. Also, the reset
>     request shares intreq_pcim_sub with iMSI-RX, while AER arrives on
>     another IRQ. Delaying AER dispatch alone would therefore leave the
>     MSI handler exposed, and both paths would still need coordination
>     with the controller reset.
> 
>     The driver handles the reset request itself and schedules
>     pci_host_handle_link_down(), as the rockchip and qcom drivers do.
>     This also provides recovery with older DTs that have no "aer"
>     interrupt, without relying on AER to initiate it. The reset callback
>     shares the reset sequence used at probe, including the reset-status
>     readback and delay added by 0056d29f8c1b.
> 
> 3. Root Port interrupts only trigger APP status bits on platform IRQs.
>     The controller appears to lack SII2MSI, so Root Port MSIs never reach
>     the GIC ITS. The Root Port's INTx is routed to intreq_pcim_sub as
>     well, which the driver holds, so port services can't request it
>     either. This series works around it by hiding Root Port MSI caps
>     across the board and emulating INTx using a virtual IRQ domain, fed
>     by the "aer" IRQ and intreq_pcim_sub.
> 
> Patch 1 is only loosely related: it adds Renesas to the RAS DES VSEC
> list so the DWC debugfs error injection works on R-Car. I used it to
> test the Root Port AER path (see below) and included it here for that
> reason. Happy to send it separately if preferred.
> 
> Based on next-20260925. The driver patches build on 7fc9907223d6 ("PCI:
> rcar-gen4: Add Application/Local register reset control") in pci/next,
> and the DTS patch is for renesas-devel, which already has b43aa6a6ebe8
> ("arm64: dts: renesas: r8a779f0: Add GICv3 ITS and update PCIe nodes");
> configurations b and c below use that DT.
> 
> Note: backward compatibility with older DTs is kept. Without the "aer"
>        interrupt, only Root Port AER remains unavailable. See the Testing
>        section below.
> 
> Retesting with v2
> -----------------
> 
> Setup: R-Car S4 Spider (RC) linked to another S4 Spider running the
>         pci-epf-test endpoint. pci_endpoint_test is bound on the RC side.
> 
>    1. Link down / recovery. On the EP side, toggle the endpoint controller
>       off and on. The short pause keeps the endpoint away long enough for
>       the RC to notice, but brings it back within the reset window so
>       recovery can succeed. Adopted the test approach from [1]:
> 
>       # cd /sys/kernel/config/pci_ep
>       # echo 0 > controllers/e65d0000.pcie-ep/start
>       # sleep 0.1
>       # echo 1 > controllers/e65d0000.pcie-ep/start
> 
>       Expected on the RC dmesg:
>         pcieport 0000:00:00.0: Recovering Root Port due to Link Down
>         pcieport 0000:00:00.0: Root Port has been reset
>         pcieport 0000:00:00.0: AER: device recovery successful
> 
>       and the "msi" (intreq_pcim_sub) interrupt count going up in
>       /proc/interrupts. Without this series nothing shows up here: the
>       link comes back on its own once the endpoint returns, but the RC
>       never notices the outage and the endpoint is left unconfigured
>       (see 4). Config accesses issued while the link is down hang the
>       host.
> 
>       [1] https://lore.kernel.org/r/abFMa6DCGGLUHddA@fedora/
> 
>    2. Bandwidth notification. On the RC, retrain the link:
> 
>       # setpci -s 00:00.0 CAP_EXP+0x10.w=0x0c23
> 
>       Expected:
>       - the virtual Root Port IRQ (rcar-gen4-rp in /proc/interrupts,
>         shared by PCIe PME, aerdrv and PCIe bwctrl) fires once
>       - bwctrl clears LnkSta.LBMS
>         (setpci -s 00:00.0 CAP_EXP+0x12.w reads 0x2024 again).
> 
>       Before the series LnkSta read 0xe024 afterwards, LBMS and LABS
>       stuck.
> 
>    3. Root Port AER. On the RC, inject an LCRC error with the DWC debugfs
>       (patch 1) and issue one config read so a TLP actually goes out:
> 
>       # cd /sys/kernel/debug/dwc_pcie_e65d0000.pcie/rasdes_err_inj
>       # echo 1 > rx_lcrc            # error detected by the Root Port
>       # setpci -s 01:00.0 VENDOR_ID.w
>       # echo 1 > tx_lcrc            # error detected by the endpoint,
>       # setpci -s 01:00.0 VENDOR_ID.w    # reported back with ERR_COR
> 
>       Expected on the RC dmesg, respectively:
>        pcieport 0000:00:00.0: PCIe Bus Error: severity=Correctable
>        pcieport 0000:00:00.0:   [ 6] BadTLP | Receiver | Data Link Layer
> 
>        pcieport 0000:00:00.0: AER: Correctable Error message received from 0000:01:00.0
>        pci-endpoint-test 0000:01:00.0: PCIe Bus Error: severity=Correctable
>        pci-endpoint-test 0000:01:00.0:   [ 6] BadTLP | Receiver | Data Link Layer
> 
>       plus the virtual Root Port IRQ count and aer_rootport_total_err_cor
>       going up by one each time. The link stays up throughout, the DLL
>       retry recovers the TLP. Before the series nothing is reported.
> 
>    4. Regression check. Run pci_endpoint_test after step 1. PASS/FAIL/SKIP
>       counts match a run without step 1.
> 
> Configurations:
> 
>    a. Without this series**
>    b. GIC ITS, DT with the new "aer" interrupt (this series)
>    c. GIC ITS, DT without "aer" (b43aa6a6ebe8 ("arm64: dts: renesas:
>       r8a779f0: Add GICv3 ITS and update PCIe nodes") or later)
>    d. iMSI-RX, DT before b43aa6a6ebe8 (no msi-parent, no "aer")
> 
> Result:
>               recovery   bwctrl/PME   RP AER    pcitest
>    ---------------------------------------------------------
>    a.           none         no         no      all FAIL
>    b.            ok          ok         ok      no change
>    c.            ok          ok         n/a*    no change
>    d.            ok          ok         n/a*    no change
> 
>    *  Root Port AER needs the "aer" interrupt; without it the behaviour is
>       unchanged from before the series.
>    ** Only patch 1 applied on top of the base, so the same debugfs error
>       injection could be used for the comparison. pci_endpoint_test fails
>       across the board there because nothing restores the endpoint after
>       the toggle.
This is one awesome cover letter.
