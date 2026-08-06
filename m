Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA893379C23;
	Thu,  6 Aug 2026 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786034842; cv=none; b=EZX+uSzJhOYwrKqP7mKxgKAjoLDruU7wk9GybKdWLkno1rT1trmlsls1ZO2yhdh3uvBdQFRKDWu9//7TXC9sJJDbrosbm903Jkp6h3uR0KkEl2XzPuf9VI/jYR/mDSfTac7DyR6MJPtE5Zy0+PperQAFXFDEakRfPa3ZPvGAKJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786034842; c=relaxed/simple;
	bh=eIpxCWvmePo4UsOrJFFseBBujnJMHKPh/O68Ug+C5Ro=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rmfeaFK+JoDB1XgZHqXuYTwsI1pdorLyTqKF/GmGz/5tWo0NVF+ArU1KEwHNS/Ch3A2LgVSTgIssSijSUIXd6rYBGu3Jef5oWWwYpsGObtdX0KRE3NYGIsTmvuOU01kVoPL1h/o8rwPJpjmqq4wl36iySCwJS2VPZ24HZJQrpqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497C91F000E9;
	Thu,  6 Aug 2026 16:47:09 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: linux-pci@vger.kernel.org, lpieralisi@kernel.org, 
 kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, mpillai@cadence.com, rdunlap@infradead.org, 
 18255117159@163.com, unicorn_wang@outlook.com, Aksh Garg <a-garg7@ti.com>
Cc: linux-kernel@vger.kernel.org, s-vadapalli@ti.com, danishanwar@ti.com
In-Reply-To: <20260805105014.3952686-1-a-garg7@ti.com>
References: <20260805105014.3952686-1-a-garg7@ti.com>
Subject: Re: [PATCH] PCI: cadence-plat: Fix host/endpoint dependencies
Message-Id: <178603482978.212439.12530601131931172218.b4-ty@b4>
Date: Thu, 06 Aug 2026 18:47:09 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Wed, 05 Aug 2026 16:20:14 +0530, Aksh Garg wrote:
> The cadence-plat driver has a single platform driver that can be built-in
> or a loadable module, but it calls two separate backend drivers depending
> on whether it is a host or endpoint.
> 
> If one of the mode is build as built-in and another as loadable module,
> we end up with a situation where the built-in pcie-cadence-plat driver
> tries to call the modular host or endpoint driver, which causes a link
> failure:
> 
> [...]

Applied, thanks!

[1/1] PCI: cadence-plat: Fix host/endpoint dependencies
      commit: e4486b0dc8b2496133f38451babd7e84e2f4a1fd

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


