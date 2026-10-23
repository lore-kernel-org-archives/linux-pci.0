Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779607;
	b=NMR7RV5GPgGcYG5oyYzSdDI9JQQeJQL1CwGe7XCmSs39oVl3Nqy22pwypppldxL+7SLM
	 vXs5e8dRUTuDf5x/Z6CNCzj2wwh2wNz6XMlt+vYmmEs1HQ/NnmY9/1XCvo8WDupuxcuHi
	 WrSl7J/3Yfu/UGmITWwMsDDABsNeJOz7UtHFLLbTcf5+Qg6N79txLjcjiVKAL5L5ea3Ny
	 tbw7XCygR5Z9gCMnZxE8CRnBXbS6mYTV3ebU+7cV4pAcq8MzONmdJyLutetTY4qjQ9KUZ
	 joVfmYb267eALSYlaeJah8ehEBUww0qKobKTXrZZfhOUGN02CBUYOahPDkT0h28swWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779607;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=n4JcfF8uWyN7U+HWj8jtqOevy4U9dtFdq/NbsoSQUcg=;
	b=Ve6ap5XLmtFuKfXwwNsdTJMyxb/xVLFljjcEzBZQatrGy9R/y2u0t80ACo5UWR8Io8Kj
	 AxYwvKWSikiDqOpfZyebpw8fqOF/PfmD/XbSga5gPPayqFt77+tcoQ1eR6VMBX4/ICnNH
	 RFWJFN4yffwlenrXLI6oicExy8dNBHx1HQ57pEe6x8AyN8Lmz1bTk7XjyArDxBTYE8KrQ
	 8zxCvpX3ttsxJBw8T1Wfr5kzrpylUwYE7fesqwpQXe2l63rQlNsDP3Z+29UT/iw4CT4eC
	 W+PyBhfqNIwJpr9xRuyQr2n3U03+oRUBYzWC2NXe1I9F2YS/X8auYt/7FaJChJ7DZPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c89ZcEzW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE29606A31A;
	Fri, 23 Oct 2026 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c89ZcEzW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CAD1F01828;
	Fri, 23 Oct 2026 18:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792779606;
	bh=n4JcfF8uWyN7U+HWj8jtqOevy4U9dtFdq/NbsoSQUcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=c89ZcEzWmZiP96A3AFYWNHl2c1DrQASv3EEK4Izx3Dv+XPxPoA02UwK86asvGkqOu
	 cotGlZOfS/MEEDBfxrQGq05S0i1WSW1M8MUmgdNy1MISN4YiRcOQ+jWU5lKl0i1Pga
	 1E4znn5j1Wgg1lOwixT81kdPsZvKmCEMyPGrXA/rV3caKSBmBuaRMNPp7ObjW4gmC+
	 W2pFfDBeQ8/QGFKoTbUoEEsX9kFoC9a9DjjSTv4SXTVVl506iTR8bnzupimMl0bAav
	 CeWgdZNbO+KMba8w2oVr6mbM46O1oFNIs41iVE8PB2D4T7/Pj+7ORWKSX/iwJUM6RZ
	 K9b9Nee8Uk80Q==
Date: Fri, 23 Oct 2026 13:20:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Anthony Ruhier <aruhier@mailbox.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] PCI: Disable LTR on Qualcomm WCN7850 [17cb:1107] to
 allow ASPM L1.2
Message-ID: <20261023182004.GA2796729@bhelgaas>
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
In-Reply-To: <20261023-quick-wcn7850-v1-1-9a139b9b2c8e@mailbox.org>

[+cc Qualcomm folks]

On Fri, Oct 23, 2026 at 07:39:35PM +0200, Anthony Ruhier wrote:
> The WCN7850 Wifi/BT card, found in several Snapdragon X laptops, never
> enters ASPM L1.2 when LTR is enabled. Its firmware reads the
> LTR_L1.2_THRESHOLD set at enumeration and reports an LTR value just
> below it, so the L1.2 entry condition is never met and the link stays in
> L1.1.

Here are the ASPM L1.2 entry conditions in PCIe r7.0, sec 5.5.1:

  The following rules define how the L1.1 and L1.2 substates are entered:
  
    - Both the Upstream and Downstream Ports must monitor the logical
      state of the CLKREQ# signal.
      ...

    - When in ASPM L1.0 and the ASPM L1.2 Enable bit is Set, the L1.2
      substate must be entered when CLKREQ# is deasserted and all of
      the following conditions are true:

      - The reported snooped LTR value last sent or received by this
	Port is greater than or equal to the value set by the
	LTR_L1.2_THRESHOLD Value and Scale fields, or there is no
	snoop service latency requirement.

      - The reported non-snooped LTR last sent or received by this
	Port value is greater than or equal to the value set by the
	LTR_L1.2_THRESHOLD Value and Scale fields, or there is no
	non-snoop service latency requirement.

By "firmware reports LTR value", do you mean that the WCN7850 sends an
LTR Message with snooped/non-snooped values just below
LTR_L1.2_THRESHOLD?

And since the reported LTR values are never greater than or equal to
LTR_L1.2_THRESHOLD, the link never enters L1.2?

If so that sounds like a clue that the firmware went to some lengths
to prevent L1.2 from being used, which is "interesting."

> Windows does not set LTR Mechanism Enable for this device (verified by
> dumping the ACPI tables), and the link idles in L1.2 normally.

I don't know that ASL not enabling LTR is definitive (lspci would be
more direct).  But it sounds like you've verified that the link is
actually in L1.2 when idle.

> Replicate the same behavior: clear PCI_EXP_DEVCTL2_LTR_EN for WCN7850 at
> enumeration and again on resume, as the LTR state is restored there.
> 
> On a Lenovo Yoga Slim 7x (X1E80100) this allows the link to reach L1.2
> and reduces idle power by about 70 mW.
> 
> Signed-off-by: Anthony Ruhier <aruhier@mailbox.org>
> ---
>  drivers/pci/quirks.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 1aa87a3ef9ed..374c505981a0 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3795,6 +3795,20 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_QCOM, 0x1103, quirk_no_bus_reset); /* WCN
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_QCOM, 0x1107, quirk_no_bus_reset); /* WCN7850 */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_QCOM, 0x0308, quirk_no_bus_reset); /* SDX62/SDX65 */
>  
> +/*
> + * The WCN7850 firmware reports an LTR just below the LTR_L1.2_THRESHOLD it
> + * sees at boot, preventing it to ever enter L1.2.
> + * With LTR disabled the link idles in L1.2, similar to what Windows does.
> + */
> +static void quirk_wcn7850_disable_ltr(struct pci_dev *pdev)
> +{
> +	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
> +				   PCI_EXP_DEVCTL2_LTR_EN);

I don't think we can guarantee that the PCI core ASPM support will
leave LTR disabled.  I don't see anything there that looks like "leave
PCI_EXP_DEVCTL2_LTR_EN unchanged."

> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_QCOM, 0x1107, quirk_wcn7850_disable_ltr);
> +DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_QCOM, 0x1107,
> +			       quirk_wcn7850_disable_ltr);
> +
>  /*
>   * Root port on some Cavium CN8xxx chips do not successfully complete a bus
>   * reset when used with certain child devices.  After the reset, config
> 
> ---
> base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
> change-id: 20261023-quick-wcn7850-a792968cc25f
> 
> Best regards,
> --  
> Anthony Ruhier <aruhier@mailbox.org>
> 
