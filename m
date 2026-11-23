Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795394769;
	b=qdxyq50CVFlsPgyJzaOzoO5By4lH6clvwuOzHyBsxNXYI1ozjh6wxlg+WjW9cXe6tyVc
	 L3uihB6CtE3g07ZiQ2W2WPFFhVi1i6woyuHcinS3vBxGpt1k81znQ8RAaCemRS6r/40ui
	 7KWWseRGNireURiCjaieF7cm86Bw76zV6DY5mfq1lVBdGEn2zG4LTNh+HCrolstN5AJcS
	 1QMDvqrigsUwzJWDhMri+NoNTQ1IeSp4pALr8sUrMXa82yekoimfBM8JxyX0MTtTJs7Ik
	 NyvZA8ngLs3PGo9eIOtvav+SiJADBjbWCxn9hTkH4G7asJ+QNah25z+UnTOGcqHt1JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795394769;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=tpcTWT12QaKXXVWE6xyenQXiX9YvMws8DucROyKoXMs=;
	b=lYCDTsMqyHto0f4tdp9YSP4wmrESkAQ6LFzjo5TB8cYvQWnpEmkV9HQf46mZpYL4c5Ui
	 1yF1YYbdDJK1oKBA126xxzUALtD840nNWgl8MDbhvxLCYE4CXVPNscA/qzP4GwT2335VC
	 jgYNRTiIvL6ESCFpaUSEWsobrqVjmDDY0vcY9hHYh5K96Hk3ioMvKRKbEFOjx46CdD9Q2
	 ecbVvX8SKvtYq+X6sMALfejQ+Rx0VNHnkMY2V7NKNzXrSw5d/q+WHz8ZSHZgMVkS4MFoU
	 IplqaYDoi1knfrv3vNsYNdKAPl9xYNYye/Zmx9GkNGZDysQIVztx97zqBJ7Y5jeY0gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5A8606A320;
	Mon, 23 Nov 2026 00:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CE81F000EB;
	Mon, 23 Nov 2026 00:46:04 +0000 (UTC)
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
Subject: Re: [PATCH] PCI: iproc: Fix MSI shutdown operations
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Eugen Hristev <ehristev@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Marc Zyngier <maz@kernel.org>, Vikram Prakash <vikramp@broadcom.com>, 
 Anup Patel <anup.patel@broadcom.com>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261029-iproc-shutdown-v1-1-05f828561116@kernel.org>
References: <20261029-iproc-shutdown-v1-1-05f828561116@kernel.org>
Date: Mon, 23 Nov 2026 01:45:57 +0100
Message-Id: <179539475780.13869.11962329009845614434.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2163;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=rk4nHtNJuQKpfhuulQzD/bItQ8HbmcUiDhVzjTF6j4g=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrA4zIkeT7py+2BT07S2Ivwjb1eYLTTQyC7cLFK
 PdvAczTUIWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawOMyAAKCRBVnxHm/pHO
 9UTAB/sHuBFC6pxVdZWQpn4k5VXEWSCN5z+WbzVzRCzVL6ffEJoo+H9O6/B5Dz4l796hCvBuak5
 svXe04eRyDSdRFEA7Qn3Fj8bMjgXaWT5hk46I5CRhZTI90kcoFKLYPkvPf5l4EEFOdnbQgeurtV
 oxMXTu4bQeq9kYR4uqqwPx7YVxGpSbhKEeMPe4gsZEi7n6OFsWHtqB6F6S6/h1+XT6D6XD4wBmo
 v5f/kJ49ipszBaDl3xk4RP8AEYIKvE4JP8mbXmVZPwHj2e6WZ+LluHtMZvuDCEPFiMxZzA8Z3fG
 yWjcFMO+y/l+qyA/RCZF47o6m73A9MbRGyiyszLjxHjGZl6X
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-29 09:25 +0200, Eugen Hristev wrote:
> On reboot, shutting down iPROC leaves MSI irqs enabled and not
> cleaned up. This can lead to IRQs being served after the iPROC
> was shutdown.
> Fix it by implementing an MSI shutdown procedure, and call it
> before the iPROC shutdown.
> 
> Assisted-by: Github Copilot

Not needed anymore.

> Fixes: 3bc2b2348835 ("PCI: iproc: Add iProc PCIe MSI support")
> Signed-off-by: Eugen Hristev <ehristev@kernel.org>
> ---
>  drivers/pci/controller/pcie-iproc-msi.c | 16 ++++++++++++++++
>  drivers/pci/controller/pcie-iproc.c     |  3 +++
>  drivers/pci/controller/pcie-iproc.h     |  4 ++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
> index 9ba242ab9596..1d19db67f314 100644
> --- a/drivers/pci/controller/pcie-iproc-msi.c
> +++ b/drivers/pci/controller/pcie-iproc-msi.c
> @@ -651,6 +651,22 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node)
>  }
>  EXPORT_SYMBOL(iproc_msi_init);
>  
> +void iproc_msi_shutdown(struct iproc_pcie *pcie)
> +{
> +	struct iproc_msi *msi = pcie->msi;
> +	unsigned int index;
> +
> +	if (!msi)
> +		return;
> +
> +	iproc_msi_disable(msi);
> +	iproc_msi_read_reg(msi, IPROC_MSI_CTRL, msi->nr_irqs - 1);

What is the purpose of this read?

> +
> +	for (index = 0; index < msi->nr_irqs; index++)
> +		disable_irq(msi->grps[index].gic_irq);

Sashiko raised a concern on this. Please check.

> +}
> +EXPORT_SYMBOL(iproc_msi_shutdown);
> +
>  void iproc_msi_exit(struct iproc_pcie *pcie)
>  {
>  	struct iproc_msi *msi = pcie->msi;
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index afb3aa38ac6b..6f3dc2f81a1c 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -756,8 +756,11 @@ static void iproc_pcie_perst_ctrl(struct iproc_pcie *pcie, bool assert)
>  
>  int iproc_pcie_shutdown(struct iproc_pcie *pcie)
>  {
> +	dev_dbg(pcie->dev, "quiescing MSI before PCIe reset\n");

Please remove these debug messages.

- Mani

