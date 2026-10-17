Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D43C108E;
	Sat, 17 Oct 2026 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792226286; cv=none; b=GhFrazP9QBsdhmj6j8TS2rb9GfSpnlFLzxvsJzc38MidMytwwRQsKBMq8akYoX9gq0I8bv/FEKq7WsOxmtqUYb1xAj9HhkuQ6SE7vW0WcSTKQiVKtJTlLMY6/SoBEcxlqBSqpZCTx643MY7tM0AvwAk+RjgNPoij5f9JquTRkFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792226286; c=relaxed/simple;
	bh=QJtMS5sA/0eccIApwx6kBheVqzNsxLqXKYqzhi54xMU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dEK1y4Ya9vGe6rUvmzhJdcwnsdptFxoE0gfyv638qcAV7l/VnCB6ezWPvbarEu2B/OXI21AjbWTQEWOHlQLXUJTcPTrKiETAJFXoXR2wsaRCbchds1AfGb3/AuhzMHHtAYlL1hjRfiCKQPgD3pcU6twKQwbKTQ7YFd+aeqJE8/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJnGjoyf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJnGjoyf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B121F000C4;
	Sat, 17 Oct 2026 08:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792226285;
	bh=x1QxSP1pvDZOL/OB1iuOEP91tr8j31MeSCxfZlGiqtM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XJnGjoyfjDwyctXlNEcJvNmzG6GXMH42gWT/81vT6XEZGTmfjAdjFlsz1EE9K9Cs9
	 KI4t9sBZcwzxSC1HN5VrvscApPN5tJflyEC29PpY+rFDLzacLZgDUJ6mbJh72+8seB
	 WKvwJ8rsXqFpSL3MXO3cfnCdYKMUR0XlEJLr5htKxZkxh/XGm3bVG9gpWphl/Ao3Y+
	 s8dxvUC2LsVGTRyrJbjp1UTq1VQf4pdHXrxSNCIVAJscMbX2jpx8Dm9K+JRWPuWkUu
	 dXD1aw/QO+v70a1U8tW/nFcaTw0EeHobObTYteUAYXJRCKgJWJHf+M+JOT5vB9YLeZ
	 zGs3cZSgn+GfA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, kwilczynski@kernel.org, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Manikanta Maddireddy <mmaddireddy@nvidia.com>, phucduc.bui@gmail.com
Cc: Vidya Sagar <vidyas@nvidia.com>, Niklas Cassel <cassel@kernel.org>, 
 linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261012094815.28160-1-phucduc.bui@gmail.com>
References: <20261012094815.28160-1-phucduc.bui@gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: tegra194: Use dev_err_probe() for PERST#
 GPIO
Message-Id: <179222626482.13667.12606800727936191501.b4-ty@b4>
Date: Sat, 17 Oct 2026 14:07:44 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=446;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=XDE54Hdr7d9mMbkvLLDG7TjzglfiCOGWOCOT5ZGX9bw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq0zPnYCJ5s9AcxR3/GnRjVMJioO1TPbkW/xrMe
 ayItdbnuhOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCatMz5wAKCRBVnxHm/pHO
 9Te1B/4jxR6FqlSZkWWSqmQzAQE+Lb/6vxPqpZ2vTHyeJ+ZtPK8aEV+qAN/6FlrhC7N68vMiSD2
 B8uTYhNCjyoyh+HUW+YFuVvxjhmWCXi1z/+ByaxPY5F4eWtGI0ZsZJ/hQ98ALTirmo8lS0chojl
 sAcV+HKKk7yM9mj5EhpD006OHImcaxbD+Wdc3yH285a6hc7FW+biK02YCIYcRsOwWEFuLs5jzZg
 Yn7mmPjjCblSPX6pXlJC/sajnUBafj248AiNyaugl33W/rR5DldNLVXjXPTF60aXlGFcfB8HR3A
 rxLUYfX5c47D9OteQbkpmw8obAfDx1ClS9nCAzgZHvZIa5zt
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Mon, 12 Oct 2026 16:48:14 +0700, phucduc.bui@gmail.com wrote:
> PCI: tegra194: Use dev_err_probe() for PERST# GPIO

Applied, thanks!

[1/2] PCI: tegra194: Use dev_err_probe() for PERST# GPIO
      commit: d9b0c9ec352a5c8f037607bb938b6410ecf0dd54
[2/2] PCI: tegra194: Propagate REFCLK select GPIO errors
      commit: a439b860c96071e17d8877d28d0effdd42f60413

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


