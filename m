Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107112;
	b=4WuWEEtWvea0o5R423cgodchSyYlwqD0pI1BjdcVCwOP/97WB0lsMWY7Z48Gs14FJx23
	 VXQyenHLQi8Wl4/c6WvQD3cpmwD5a/O/JbWYniNvFDMTWCP5Z/pKH4aF9+zO7XZrteqex
	 Oa/UA2L64CGu0EMxfwr5a7wctajHE+6lzbtQGUDKzrfU8niIpecg0bF9xZZuFlgPJCAKA
	 5lr314jtH5YwSzPox7F5arCxzGV/SrseOsfSF5tsjzXha4oaXVXPuHtvEcu3V5f+Quhxs
	 gA9YMx8faN5eVaW0WdFvh7Igzf75/FEjjLDTgn22gzv1mTd6iSH697aSzLxD59QHjnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107112;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=S1W3vj7Uq94wVrX/Lq/+NitQiEZyxkt2m/8k6adxiTs=;
	b=D1VuizanRoOJtLKgQ5AJPQcwRNTieUAykkor0rhUI20V0dUuP84vvAC8dQfj82mggxJK
	 7GJdv7PYGz551v78ncqvHdwiO6hv2zB18fJ2pFUkKGnMuRCTxO0WvMLoBoeLJpWzCyS48
	 fVtOGUK9y08q30H/iWx/XVjiyWS49IU6iXLczoS4CWVdzfICPA38xTWM4WPAoHCttywUs
	 3ZYs1KNdUWOTnnFqHxhN1/WTBZqUdxFussJOIIRdXkHidttXELzhpQan/XDiVF7COhPYN
	 qsJyjoXLOynDPJofWTRXQfHMUbduScSywUKe1aVN8w5nJuGVbC5vC6m0plLvCv5TuSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28075606A320;
	Tue, 27 Oct 2026 13:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7B01F01828;
	Tue, 27 Oct 2026 13:18:27 +0000 (UTC)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] PCI: rzg3s-host: Fix NVMe resume errors after s2idle
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org, 
 kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, linux-pci@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261005110224.17160-1-ovidiu.panait.rb@renesas.com>
References: <20261005110224.17160-1-ovidiu.panait.rb@renesas.com>
Date: Tue, 27 Oct 2026 18:48:19 +0530
Message-Id: <179310709974.16692.1197178939539578162.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2532;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=OFbVCbpecaAx01zPKDHqteptC9SazpzmX4CfIyPRIT4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq4KSe1yfPkIlyyeJ6mqhtSbqyq7u/PVEcRcEKj
 8t7NhoVyZGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauCkngAKCRBVnxHm/pHO
 9XASB/0U1wA0WIJsrqTRuFtGIj0sAn9OOnQFldTAGUTkM+sYBko721xmb9qm0wWvwb+4YQNRmRE
 mg0XcTwjWY2p2IfIvlZRXNAfyoFM5i+yHCquA+4XdF9GXtUaVrI34HHeWMmjpn3MmZ5aXH53Ooj
 8lRsSt/XWUlOmXSd6iyO+CbJG/APPxFw9eETRJeVXn/VdRtgUipadGBlTzHUyr9Zjzol7fpOwI1
 cXmJ0WEG8R3eBVTAxP1ZtBENKhEyn9DFbivPvnKtgGjV+9ntEHFKqDGWBG/cFqpKqgTdLLc9Ch0
 dzhLoEWe+rZ5GuSnLpKQziUi3Ne/EQ2pjkQQL2WE617FFwTx
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-05 11:02 +0000, Ovidiu Panait wrote:
> On the Renesas RZ/V2H platform, when ASPM is enabled, resuming from s2idle
> with an NVMe SSD connected fails with:
> 
>   nvme nvme0: I/O tag 27 (001b) opcode 0x9 (Admin Cmd) QID 0 timeout, reset controller
>   nvme nvme0: Disabling device after reset failure: -19
> 
> This happens because during s2idle, when ASPM is enabled, nvme_suspend()
> does not shut the drive down. It leaves it in D0, puts it in its lowest
> NVMe power state, so that resume only has to restore the previous power
> state instead of a full reinitialization. This assumes the drive keeps
> its context over the suspend.
> 
> However, rzg3s_pcie_suspend_noirq() doesn't take this into account and
> it always powers down the controller and asserts the controller resets,
> including PERST#. That resets the drive, and the command the NVMe driver
> sends on resume never completes.
> 
> To fix this, similar to the dwc driver, use
> pci_host_common_d3cold_possible() to check if the controller should be
> powered down and keep the controller running otherwise. Do this only for
> s2idle, as deep sleep could power off the SoC and neither the power domain
> nor the driver will restore the controller clocks and resets on resume.
> 
> Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> ---
> Note: this fix depends on the following series:
> https://lore.kernel.org/all/20261002110935.2004349-1-claudiu.beznea@kernel.org/
> 
>  drivers/pci/controller/pcie-rzg3s-host.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index eea215818633..9fc1a5a4bed8 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -2272,6 +2272,14 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
>  static int rzg3s_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
> +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
> +	bool pme_capable;
> +
> +	if (!pm_suspend_via_firmware() &&

For checking S2R, you need to use:
	
	if (pm_suspend_target_state != PM_SUSPEND_MEM)

> +	    !pci_host_common_d3cold_possible(bridge, &pme_capable)) {
> +		device_set_awake_path(dev);

Why? To keep power domain ON? This is not justified in the commit message.

- Mani


