Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB68A395ACD;
	Sun, 18 Oct 2026 04:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792296743; cv=none; b=qv7FnKRiJiXbYh24N7E2wYnUrcccBnvIb2XxhETtxUqoEZL0Dgpj6tNMs7ujhJq91yBdZ+yRXRz1eaUtDQOAG4boB7FZrz+GRo/cZFiDmddrYlLHXnZK8SaPkpHG5H02SDhKis44YPaS87kBCbzY6lIz2pF4+bGZGIqA2a50RLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792296743; c=relaxed/simple;
	bh=H2sL6HZ9sE0wdtOfdCzEeuyadbft6hRB3ATs1YVqBwE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=EzFG9groaqQWaSs2VUiSSCPDjIQ8ZYWhRAsSbsLaW3WthfDhcicBpM9I33b/ug/MBTZHsV3zPatPVpdTgDElbIA1MPIXKSvTto7TWXsX2BfucyYlPp0cXkpGJfhUOSotE5ek8cXV+YeEZpz1HZnZ0HQA1MM+tkmTaxMTuNQTV6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E1E1F000C4;
	Sun, 18 Oct 2026 04:12:15 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] PCI: iproc: Use __free(device_node) in
 iproc_pcie_msi_enable()
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 bcm-kernel-feedback-list@broadcom.com, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
 Fuad Tabba <tabba@google.com>
In-Reply-To: <20260923180703.3901185-1-fuad.tabba@linux.dev>
References: <20260923180703.3901185-1-fuad.tabba@linux.dev>
Date: Sun, 18 Oct 2026 09:41:55 +0530
Message-Id: <179229671563.2114.2272123769233816365.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1867;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=H2sL6HZ9sE0wdtOfdCzEeuyadbft6hRB3ATs1YVqBwE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq1EcZK6RW9ejgLO0zl6/VgNWTO4L2u6DM/5NdR
 +m21AEPwEmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCatRHGQAKCRBVnxHm/pHO
 9cpsB/95DoVcVPw2Ij9pv78PDFwsg9nPxegf3WyFHYlmA8MMRe54BxqtNxT7auJLKs6O3B3vUft
 lZpEiRrdCAjfXR7JKiAXmzx3v84zoGgoE/VMyW1DyfjLAavo5wS2ZiV6W8ttsqiXce89RH8thEN
 W5rlPvWvAapBPtGUuNtSCKVfA4WTYPZ5j1GyZRZe+O4ROqQXNI1H42EAOHVNXCaKnibHUD2x60L
 JgLWrzjyfwYfBRrnwT3YiFxINI9ihnlaC1BjhoZHNhFFi7o/NEHVQGFXfmf+ZVcpKDRI2tUWuTa
 zw8EUyN++dIJjpcfQDGPGM6XeIVPt6/b9tRxBGgA9iqoAJyi
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-09-23 19:07 +0100, Fuad Tabba wrote:
> Declare msi_node with __free(device_node) and drop the out_put_node
> label and its goto: the scoped cleanup puts the MSI controller node on
> every return, as the label did.
> 
> No functional change intended.
> 
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Link: https://lore.kernel.org/linux-pci/61488ddc-b346-4ba3-b32a-e972a3bd75a4@mailbox.org/
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> ---
> 
> Notes:
>     Changes since v1:
>     - Declare msi_node immediately before of_msi_xlate() rather than at the
>       top of the function (Jonathan).
>     - Kept Marek's Reviewed-by, since the generated code is unchanged.
> 
>  drivers/pci/controller/pcie-iproc.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index afb3aa38ac6bb..bf455f2a9d9a9 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -1338,13 +1338,13 @@ static int iproc_pcie_msi_steer(struct iproc_pcie *pcie,
>  
>  static int iproc_pcie_msi_enable(struct iproc_pcie *pcie)
>  {
> -	struct device_node *msi_node = NULL;
>  	int ret;
>  
>  	/*
>  	 * Either the "msi-parent" or the "msi-map" phandle needs to exist
>  	 * for us to obtain the MSI node.
>  	 */
> +	struct device_node *msi_node __free(device_node) = NULL;

As per cleanup.h:

"Given that the "__free(...) = NULL" pattern for variables defined at
the top of the function poses this potential interdependency problem
the recommendation is to always define and assign variables in one
statement and not group variable definitions at the top of the
function when __free() is used."

- Mani

