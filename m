Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C1A1A9FAF;
	Wed, 29 Jul 2026 04:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785301137; cv=none; b=rcibTFb5H+i+XlWtHhba0SYw4R/tn4EARf8yRswz2QYfkk5Yh4ZKAeYWPQ0T2qThevhN3VJOETTMk2JdjeRFyVS1iDwhvLvcefEi9hr8SKh+glCepRACe8pfROxJUqslYW+tEoNBwcd/gaweraPSZp4wEC7gIHZKVFtOHLXA4v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785301137; c=relaxed/simple;
	bh=wCxfXvhAg7jx8zQQUZYYBwyWW4/VDFGZlGT2WwgPhuY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rD5TrM2ZxcWTJ4p6oxnZGKlvtrfvLJdICgLwkHuOT9EcurIr6EEwGjGUZZ54odILrEnMP6YgrCE0dCrPi4NZdh+/FlX+/ZqTkIZMD58L+iOhPj+8r6/BxuZIgUByvgxgdpRrgQjy5M5QGYrKvJ1T1SNshDFz/MyIMeJ/4xX3ttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006E71F000E9;
	Wed, 29 Jul 2026 04:58:52 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 stable+noautosel@kernel.org
In-Reply-To: <20260722-mhi-ep-flush-v3-0-d855e715264e@oss.qualcomm.com>
References: <20260722-mhi-ep-flush-v3-0-d855e715264e@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/3] bus: mhi: ep: Implement flush_async() callback
 to flush async read/write
Message-Id: <178530113260.852147.5240823277113848996.b4-ty@b4>
Date: Wed, 29 Jul 2026 06:58:52 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 22 Jul 2026 07:54:43 +0200, Manivannan Sadhasivam wrote:
> This series introduces a new mhi_cntrl->flush_async() callback to flush the
> async read/write operations performed by the MHI controller using offload
> mechanisms such as DMA.
> 
> The MHI EPF driver implements this callback by flushing the DMA wq. With this
> series, the MHI EP stack can guarnatee that the channel specific xfer_cb() won't
> be run after calling mhi_ep_remove() and mhi_ep_abort_transfer().
> 
> [...]

Applied, thanks!

[1/3] bus: mhi: ep: Add mhi_cntrl->flush_async() callback to flush the async read/write
      commit: d5a2ccf92c8ab3bcfadbae2f46349bf164c71eba
[2/3] bus: mhi: ep: Flush async transfers before notifying disconnect in mhi_ep_abort_transfer()
      commit: 9daf648da0049c99fd4f2dd06b7dc7d4a43c6d8e
[3/3] PCI: epf-mhi: Implement mhi_cntrl->flush_async() to flush DMA read/write
      commit: f502c0316c52b1f71fe544f99676805d90c554ba

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


