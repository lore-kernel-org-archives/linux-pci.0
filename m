Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC70E4BFE9D;
	Thu, 10 Sep 2026 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037616; cv=none; b=jdcktTC+BIveBZKKKD5kszr8geseUpIZWygpCtRqzjVpdZlZzkRAbgl/ud+CU3kAjL70QlF5qkRkJjuXiOfQ9pRMrnlhmp0G9LRn1YQrVKhsEFpZ30eqL5V+tOd0B38njdOx6sLi1XtXbyqPScV/8uTX8XSZmHl3ZTjfxWYXZKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037616; c=relaxed/simple;
	bh=1RVl23lmdHHQr8Jb0PysgwfN8XsmX+/uV8AZNwAQOA0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=agbpUxzmBCi9Rn5HFyZKU5kVM6rbHAgGBPDwNlF0Wl9dT06sqscS2R/HI1PIa5ZdqvsYzJUS0H9coi7iZ4As+70tyxrQ6J16EcR9SznrL/vpSALiyxClSqSwtFWKc22lyv0M8P3VR60pqzgdQ/uhKbZ/u2JCRT19QYdP6R3V6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC271F000FF;
	Thu, 10 Sep 2026 10:53:28 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Ryder Lee <ryder.lee@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 aquapinn@qq.com
Cc: zhengping.zhang@airoha.com, lei.dong@airoha.com, hui.ma@airoha.com, 
 upstream@airoha.com
In-Reply-To: <tencent_5E7D6E7FB25B4CD732F08547C11F5DA24808@qq.com>
References: <tencent_5E7D6E7FB25B4CD732F08547C11F5DA24808@qq.com>
Subject: Re: [PATCH] PCI: mediatek: Find INTx controller by property
Message-Id: <178903760879.9481.17080662701221363046.b4-ty@b4>
Date: Thu, 10 Sep 2026 12:53:28 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 05 Aug 2026 14:05:07 +0800, aquapinn@qq.com wrote:
> All existing DTS users already name the INTx child node
> "interrupt-controller". Use of_get_child_by_name() to find it instead
> of assuming it is the first child node.

Applied, thanks!

[1/1] PCI: mediatek: Find INTx controller by property
      commit: 52cbf88730b743745404b3fa5a3fc8b480768276

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


