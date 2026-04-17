Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9592AD2C;
	Fri, 17 Apr 2026 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414519; cv=none; b=c4DaefbccgLq6qghueVjQUpKcH0ijDHITvAqxatdtEURyMez6BIXj2+wakOs7sT4xvdUVLbR3tuUIQQhxYuNc14SX5oFlSfN2L/xh0h6XDSWUvvk4ZxM46M/22dGoKsdFfQir1muMD5Ne6AKYS9wqqK7OfvWF+GQc/+kbfV/FXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414519; c=relaxed/simple;
	bh=N6lYzWv46/Lqdzv0E7wevZ82OTqz7Gclu3q4Do0nAdw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=nWMGgpt/d3bbJihgu5wiAGUlmhFfVsNhDaoKVqejitpuCzqck8EfHGxnD930O5SPyw3HsXsmKc1bcNMtsnhCrjZX8FGFvsFesUNS7npoq+LOPy9RsjoWaB5YOGOMu1GaCUpr1ClihsBPeeOnQ0FXhTzuBuuizb5YlRyzpMRMYAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=f144DM/a; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="f144DM/a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1776414515; x=1777019315; i=markus.elfring@web.de;
	bh=N6lYzWv46/Lqdzv0E7wevZ82OTqz7Gclu3q4Do0nAdw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=f144DM/aC3Yd4ZrslZNTZjuxmkwJ1+iKU9V9wHSUgtpuxcDgTOv0Ke9awwZQJ0jJ
	 TqtM/1efkiNtgMiU/0SSdS4NU//YRhK76UPGxrqEA1l8aWvZAAVtxdOPnti/NWxQJ
	 3+d8jsXncPbZIqMVWkF9lUsf1NeZcR4swkkifesiZE4jBrZOwNMvmODFV1SpSQn+G
	 auKR6UfhNeD1+rWrSpNAhld4TSATohMxYHGyLMLsZOLI8GRItamQswnMwkRXG4kMk
	 4TeYBH76gzBDBdzdCLZ/IlR1mwdS2giPZ6qseP2F1YtQn4axdeKb0h9UdPTJsaNuK
	 Ycz83TdCVxUr8f9cDw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzCA5-1vRKzm3ThD-013aZG; Fri, 17
 Apr 2026 10:02:21 +0200
Message-ID: <68c9f7fe-8bbd-49fc-b9f5-407e62dbba63@web.de>
Date: Fri, 17 Apr 2026 10:02:11 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Felix Gu <ustc.gu@gmail.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
 Yanghui Ou <ouyanghui@eswincomputing.com>,
 Yu Ning <ningyu@eswincomputing.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260416-eswin-v1-1-a4991725b5ca@gmail.com>
Subject: Re: [PATCH] PCI: eswin: Fix resource leak on dw_pcie_host_init()
 failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260416-eswin-v1-1-a4991725b5ca@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KHtSKF0wbfluoDjolZfxuUxWrE9/MMiMApUI5weLWikKbCgyR3D
 dhWnSFjJqBFu10eMrcw8K7dxTukZDGoO6lp+gcp7zwMdXIFOHrGvlElrghn3vHBJEN8uLWX
 BAjhyFeBMJbFPZ1uDf00GSylunybXMJ8GQPWgqb8mW6EVr/lxFLb+qVBWxISAaAIUwtuuHA
 qvNAessuZzi45RARZ1RKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g5G9QvHezrE=;Io7nFtrd15/WMRWwS/E1Wd45RzE
 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
 W9iWiiUeeacI8XZDm/PFrs8g==

> When dw_pcie_host_init() fails, the code jumps to err_init which
> only calls pm_runtime_put() but skips the clean up of port resources.

Thus use an other label?

See also:
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.0#n94
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst?h=v7.0#n34

Regards,
Markus
