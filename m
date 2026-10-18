Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8353FC5B7;
	Sun, 18 Oct 2026 04:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792297622; cv=none; b=aQNX6WMPeFDA8wyxubPJookvcB35mAKt7bCd6MS3N0YNI4IV9D1agBBaZbr3wC1On9MjYWgMbeM9Q5CpOOVCq8de2C5GYNEuJYVQ2F0l15YfjRCQCUVq2+AFIFBafHI/tD5jT16KPPXu3uLrLv4NjWrnWcWaa92DO7Qwo2G/Ikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792297622; c=relaxed/simple;
	bh=+JZBFoP6UNzCFMG8ksizQMfuFaGhbvgaHgjE0pQtPfU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=TtvXAP13t5/52RQS2feQwu5wru8MyQmY26mJ//m4Zdkxs+sfGHYzsihLraO7bEE+QE5s3Bl6xpFigwq21Epo+7N99OHePbXTTL7exzAu+IQ+xo+9vYfbDvGjwlJstmBbTM/3laLvPd0bzh5CXaKmkK/KwMCySsvQTfAQP5OGgeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97A91F000C6;
	Sun, 18 Oct 2026 04:26:54 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] PCI: spacemit: Ignore link partner PERST on K1
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Encrow Thorne <encrow.thorne@linux.spacemit.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, linux-pci@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260924-spacemit-k1-pcie-fix-v1-1-002b5c1ba9fc@linux.spacemit.com>
References: <20260924-spacemit-k1-pcie-fix-v1-1-002b5c1ba9fc@linux.spacemit.com>
Date: Sun, 18 Oct 2026 09:56:35 +0530
Message-Id: <179229759512.2114.3306580489141327360.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=+JZBFoP6UNzCFMG8ksizQMfuFaGhbvgaHgjE0pQtPfU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq1EqICXdhzjUEDQMjpvZ3wE8aqjI6trQnPERXd
 f3BCRP+uG+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCatRKiAAKCRBVnxHm/pHO
 9RhIB/0UnDR/cESj/ARcD4ltFPWMso/Y5xVbiFQY1/4b25i2qjtVDRbpD7lI1LAgivEOE5F0p2J
 f4YHBCbHjrJOTHsTWR6Ytqe4LD2d4Os3j19iUkzQRmEGw+tIeHY8pAhTeOk57zdKRAXt7DMqgYw
 srp8+/o8jR9O6VbQN/GCaPSOCoxscKPxbUuYJYCISRR428OYkmUWOKEPZ6/a2zASB09HG2JI1ac
 Qd74hdQr3HJGVUIprrUFwQUfHMgSRIAjQidIWMV7mXJ6TnIScvP7G33ipEunr7F2KSuk9Ocgtr3
 4NxELV3NJebnOqeLgHZVZ5663Q9mEYHelv4z6u+iA5xndgYT
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-09-24 10:04 +0800, Encrow Thorne wrote:
> The K1 PCIe controller and PHY are affected by the PERST signal from
> the link partner during initialization. With some devices connected,
> this can prevent host initialization from progressing and cause the
> system to hang while probing the PCIe controller.
> 
> Set PCIE_IGNORE_PERSTN before accessing the DBI registers. When set,
> this bit makes both the PCIe controller and PHY ignore the PERST
> signal from the link partner.
> 
> This allows host initialization to complete without being affected by
> the link partner's PERST state.
> 
> Signed-off-by: Encrow Thorne <encrow.thorne@linux.spacemit.com>
> ---
>  drivers/pci/controller/dwc/pcie-spacemit-k1.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> index 0564c46e2f48..98f067e1ba81 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> @@ -44,6 +44,7 @@
>  
>  #define PCIE_CONTROL_LOGIC			0x0004
>  #define PCIE_SOFT_RESET			BIT(0)
> +#define PCIE_IGNORE_PERSTN			BIT(2)
>  
>  struct k1_pcie {
>  	struct dw_pcie pci;
> @@ -137,6 +138,13 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * When set to 1, the PCIe controller and PHY ignore the PERST signal
> +	 * from the link partner in both RC and EP modes.
> +	 */

What? PERST# is an output signal to RC and input to Endpoint. PERST# is not
controlled by the Endpoint, but only by the RC/host.

- Mani

