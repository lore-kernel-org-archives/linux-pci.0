Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795474208;
	b=OWdfXJiX1W5kdnRSgogKcEC5wT1E5qBhv5lyRq3AesshGfjiaUucpfzliLQrF/w9awgZ
	 Q+blHckcVpwm/6LtaX9/oOXxBUfQV+B7GieKu38Gk0Vs4TEvYCA9G9Xwp+4rjqGBmTUnN
	 4f+6Tf1l4BzTUxV1PFRDc5IggouupAmqc7Md+lKBq/eiS95cpaA05CNPyTWxHCpUOrHT4
	 kjb7Fxv4e667B547x28h2nmKPZ2qiFNynasekpvpq8+fauT5KFl6haCuMzcLaTHeQQz9V
	 jHQoup2o/Ttqp5db1lRSqJZrkSb80i5fVpafjl3cku72GSta8ccZprMBE9yJLRayk4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795474208;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jrLGMV1iypmmgBwUgSTs/Q9UeBLgd52WAHRIrLOsZ3s=;
	b=xoaqalVJ7RaPmLG2OetAkv3mhaYxe2obLS2EsF23leVF1VbvTI9IIlfJU0Ha6Dm8umyF
	 q0en3XwmDilEBkUCb8lPGgbKj6eyzrcGvdrRF0+VujbQ9Sm6ytay9ZQfsFJDkDyMsSZGe
	 DED/k/lf6n6eGL9bsr2aTlR8dpNndGCwUqq22TgVyulILKm5+1hUzAp0hv8caO1QBtmml
	 J81BlkCe0T+jKw8slrszClmateVgpFKy6X8C9SR0rghz0HI0F1asnNiumXOvG+1zSuNTS
	 nSfYL6rlkLjKxtRQdlJBMjtjpWns5DKy7Qj6XOdM6744RIPxS+BndefoomS7dWsWutw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1Hv7jeC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1A7606A322;
	Mon, 23 Nov 2026 22:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1Hv7jeC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B061F000E0;
	Mon, 23 Nov 2026 22:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795474207;
	bh=jrLGMV1iypmmgBwUgSTs/Q9UeBLgd52WAHRIrLOsZ3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=R1Hv7jeCjg5uOZPsAyhEp4qR31IEr9kWF1mjYKnUXnLuRptH6X6UYFdjzXJdM2nUZ
	 zrLeT5Tn0Wc94fw4nd6v6a4SBF3YTlDMEdosOydRZG6s5Qi9rYoDwT9/zvXyi4xCTA
	 Hdnr7dQMmlGVeOaJHG0ZB6/iF/MqKWb4IoeDcgG0PgU+WFm/HUwJ+z3nOJRf3Uqmoi
	 yyyDw11q/L1uXtMMoaUmXH0G6+e0++nGO3mcROcxUlPiodck7pFAG5zgd8HNMQzIjP
	 QrAvy9Sw7aLnrFGPE+VR2Q0bYhh7zpT9xBxC+DVGqGBXLBemi47Fr90DvB4zEgBxV8
	 lCWgPAgXPEIEQ==
Date: Mon, 23 Nov 2026 16:50:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, lukas@wunner.de, mjrosato@linux.ibm.com,
	gbayer@linux.ibm.com, schnelle@linux.ibm.com,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Judy Brock <judy.brock@samsung.com>
Subject: Re: [PATCH v1] PCI: Ignore Immediate Readiness for Samsung a826
 device
Message-ID: <20261123225006.GA1117350@bhelgaas>
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
In-Reply-To: <20261123215308.1285-1-alifm@linux.ibm.com>

[+cc Kanchan, Nitesh, Judy (scraped from lore Samsung NVMe traffic)]

On Mon, Nov 23, 2026 at 01:53:08PM -0800, Farhan Ali wrote:
> The Samsung NVMe SSD Controller PM174x [144d:a826] advertises Immediate
> Readiness, so pcie_flr() doesn't wait after FLR, but the device isn't ready
> yet and config reads return ~0 after the reset. This happens with
> firmware version SNA6SNA6 or older.
> 
> This was seen on s390x with the nvme driver bound, by resetting the device
> via the sysfs reset attribute:
> 
>   # echo 1 > /sys/bus/pci/devices/200c:00:00.0/reset
> 
>   nvme 200c:00:00.0: Unable to change power state from D3cold to D0, device inaccessible
>   nvme nvme0: Disabling device after reset failure: -19
> 
> Ignore Immediate Readiness on this device too, so pcie_flr() waits.
> 
> Fixes: 10baa9b4df40 ("PCI: Drop unnecessary retries when restoring BARs")
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4a02fc80755d..11c3b45afe78 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5790,6 +5790,7 @@ static void quirk_no_imm_ready(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa80c, quirk_no_imm_ready);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa80d, quirk_no_imm_ready);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa80e, quirk_no_imm_ready);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa826, quirk_no_imm_ready);

We already have:

  996a59519af2 ("PCI: Ignore Immediate Readiness on Samsung PM9D3a NVMe")
  0f8b5d90d179 ("PCI: Ignore Immediate Readiness on Samsung 990 PRO and 990 EVO Plus NVMe")

I wonder if something like the below might be safer and avoid an
ongoing series of quirks.

The spec (PCIe r7.0, sec 7.5.1.1.4) says that when Immediate Readiness
is set, "the Function is guaranteed to be ready to successfully
complete valid Configuration Requests at any time" and "software is
exempt from all requirements to *delay configuration accesses*
following any type of reset."

I thought that meant Completions for config requests would always have
Successful Completion status, but I guess one could read it as "device
must respond with a Completion to an access immediately after reset,
even if the Completion is RRS."

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..c9f95852e83d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4457,15 +4457,13 @@ int pcie_flr(struct pci_dev *dev)
 
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
 
-	if (dev->imm_ready)
-		goto done;
-
 	/*
 	 * Per PCIe r4.0, sec 6.6.2, a device must complete an FLR within
 	 * 100ms, but may silently discard requests while the FLR is in
 	 * progress.  Wait 100ms before trying to access the device.
 	 */
-	msleep(100);
+	if (!dev->imm_ready)
+		msleep(100);
 
 	ret = pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
 done:
@@ -4534,16 +4532,14 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 
 	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
 
-	if (dev->imm_ready)
-		goto done;
-
 	/*
 	 * Per Advanced Capabilities for Conventional PCI ECN, 13 April 2006,
 	 * updated 27 July 2006; a device must complete an FLR within
 	 * 100ms, but may silently discard requests while the FLR is in
 	 * progress.  Wait 100ms before trying to access the device.
 	 */
-	msleep(100);
+	if (!dev->imm_ready)
+		msleep(100);
 
 	ret = pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
 done:
