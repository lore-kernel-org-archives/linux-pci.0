Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8621340417;
	Tue, 13 Oct 2026 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912698; cv=none; b=j+tu/q6QfK83+6gfrjjXWS91No410qkg9RTtDqOPfJd58oQXwUI4ElnIk/SAiFPHwbxnuGKwReT/feqk56iZ/kUCtoTVCUe5DlKBdQPHHtzEOnIIhsNDda4yWJ5ezwz+W0zH0rjRgHGTK1GwGnrtOSW8ZAm4+/E5QBstCtLUmMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912698; c=relaxed/simple;
	bh=sECM7/KBFpScFHSC/sEOxRcyil3uarzd9RUU7Zeyc5o=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=k5ILDgFt9YCGXhmYFOStnLS2Ncio2cjuefEono9ZGtuDzHJko5ts/spfX9NOrpOGJq27ziNnlDnkdk2dJZt8+mpJm3GfMG1smYmVn8lZvfHVghpZyo0LEYxvwkFv3wqM3mFWzEA9U8UaCkpA1faSHdCckcBoWPDbl0Q0UrtgLhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8e7KvJH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8e7KvJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01E91F000FF;
	Tue, 13 Oct 2026 17:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912697;
	bh=XHKvPJxtOUe89VmDsqkmUm9POoFOuKBVafdlaQIcGVE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=A8e7KvJHDPjWetHiC45tXKu6DgRn2R9/Fi3zyt1eYV+vaIef17ec+TB7oamk9o2yP
	 Kz1eDq3I3e94inordlmeMtKpf99yPQTqbY9XzdTXCogYvZMSN+U5KAA1WiFvZ0FTTF
	 XriyxG0pVV4hG3FuCzekqqJgs2lLZElmtdb6XuYFNiJRh2n/9z9Fl25x558URDauly
	 SL+aZ6+aAs1c5qtijehAFuLHA8eZvQQyXv5yTS5espatyyTP/0zDacJ4WItNZL+++l
	 Nc0CG9w/98QYBpWpFPNGp2m0Jr+NVOPmaFUMMCLnLMGO4/TFr+9PeJt0n0P9ZBX+7B
	 5Fe/tJ+ax26EA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 08/10] PCI: dw-rockchip: Set broken L1SS resume flag
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Alexey Charkov <alchark@flipper.net>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-8-fbabcca9921b@collabora.com>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
 <20260908-rockchip-pcie-system-suspend-v6-8-fbabcca9921b@collabora.com>
Date: Tue, 13 Oct 2026 23:01:26 +0530
Message-Id: <179191268696.12828.12282510519182218823.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; i=mani@kernel.org;
 h=from:subject:message-id; bh=sECM7/KBFpScFHSC/sEOxRcyil3uarzd9RUU7Zeyc5o=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqzmrxbGKarqI/Q7fz3/e7A2/n23V+EU8Dis+QA
 DRqwIdT222JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas5q8QAKCRBVnxHm/pHO
 9StMB/9t742KOafibx5/hcaZnnnDfkKBK6ODJNOTNS+zB5XOmgSqbqLfEynB/EaXH7Z1IVSesF5
 JcO/kJVggvuUWjtG+Bz7pq3s/tWpHaBxVAXoWuoKPnzmZQUAxKIs9OySekQtCeEv2jIssn1+lTY
 KlTKniY+QRLln2AfEHM6pjaYKbkpeZS5bKg5jeWKpCBAZGmDgrP0xDuf9dtI0jPuHRFLj9glYb5
 F7nYF1s5WgEouqemlBHXoBFYsw76/UKAXjSO00Rp9rQo2/HndAffJbpqdn0wqbYG62fw9CxE/+E
 1Zj5tn15AtSsua4cVxmMS67MPLmYSJpc6j36ta1eNVRTUPvg
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-09-08 16:51 +0200, Sebastian Reichel wrote:
> Setup the broken_l1ss_resume flag, so that pci_suspend_retains_context()
> returns false on the Rockchip platform allowing PCIe peripheral device
> drivers to act upon.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 17530507e41b..47d9cab909bc 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -458,6 +458,21 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>  
> +static void rockchip_pcie_host_post_init(struct dw_pcie_rp *pp)
> +{
> +	/*
> +	 * During system suspend, the Rockchip RC driver effectively powers off
> +	 * the controller. If the link is in L1SS and the endpoint asserts
> +	 * CLKREQ# to exit L1SS, the time required to wake the system and
> +	 * restore the PHY/REFCLK may exceed the L1SS exit timing
> +	 * (L10_REFCLK_ON + T_COMMONMODE), resulting in Link Down (LDn) and a
> +	 * reset of the endpoint. Set this flag to indicate this limitation to
> +	 * client drivers so that they can avoid relying on device state being
> +	 * preserved during system suspend.
> +	 */

This comment is redundant, please drop.

- Mani

