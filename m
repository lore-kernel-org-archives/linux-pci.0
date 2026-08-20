Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A03213D886;
	Thu, 20 Aug 2026 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787214061; cv=none; b=m9qy0AigSF+xy0DRqQR7YKOKB8YTvHCC6toiAxtqQe6FiRc32CQmbpWnQr8Yhy8WHKh4Bs+N+SChnVX8ZWcsZXrkebe7lpmoCT9rp9z2A5zI8M/tViLZzLLi0KHVMmnWCxyZIOAIJTULUJNRaiAmd85fHYu4nCKbbTlaPRKOtvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787214061; c=relaxed/simple;
	bh=bQk6Vvo9g9aA1oQw3jfbDp1+S0kU5ouLhDleeB105+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kOoQ55nZqo4jgz+SJcsDFMi1l44G//GnoEP16n4Xl9S9o0siZfpVZii20yQ8+qeZtPw0Me7Gawtcq6uDfJ4y8i0FbQuONiVLU07h8LSuJG0hqATZRGCQcLVH8EQRO3m0kHx4yvSdUcpl3VQcXqPMqozTZ+ZAC8yLfCo0FELSeeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=MpLPoKGi; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MpLPoKGi"
Received: from smtp102.mailbox.org (unknown [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hQbx42CyQzMlCB;
	Thu, 20 Aug 2026 10:20:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1787214056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sy61kznsRxHN5+G/lJEJpMZqjNBSVdqfXj06Y/Dfszw=;
	b=MpLPoKGiKqOsbSdlqFUAUln4z6o4sYiOKBv3YTniMwFeMAoTrTnqVeQtlwUp9YKhrVaNnO
	Hk1yMAD1MGkr4fVSv3xoCkldQR5q3wL6lX8ad5TA7vhuBKAAbo2PoL5PumQKS//5TykHGf
	tCWC+kd7jAgEXewc3TV19HWj4rO/rJmdTm8yCMVW4uEh6BJ+IvmaCgA8Ckt9RrzDtEdGjh
	jbx8i9E63Tsi1f5SH+8TVeHTM/7XoVxFtRJsfFcXaRE7nRqL46gwH1ZNvT+s7GS2IropRD
	yna3a9ty+7z7+oHlXL4QgbF2F9sB6eL6gCPAEimdJDQ5vVg6dgr+W/9bCkWoiw==
Message-ID: <e31abf53-89bf-4581-8e0a-9f0ae0affd74@mailbox.org>
Date: Thu, 20 Aug 2026 10:20:51 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] PCI: dwc: Add .post_deinit counterpart to endpoint
 .pre_init callback
To: Koichiro Den <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260820035944.163472-1-marek.vasut+renesas@mailbox.org>
 <5vjlarzjb2luxfzri4ykpjbkhevfbmufbefdvzafi2oo2q4j33@wwizukzejsys>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <5vjlarzjb2luxfzri4ykpjbkhevfbmufbefdvzafi2oo2q4j33@wwizukzejsys>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: denauh33szwefofgu3uhd1z11geka88p
X-MBO-RS-ID: c7f698cea72f34a646f

Hello Den-san,

On 8/20/26 10:09 AM, Koichiro Den wrote:
> On Thu, Aug 20, 2026 at 05:57:55AM +0200, Marek Vasut wrote:
>> In case the .pre_init() callback fails, it is mandatory to correctly
> 
> I think this should be "If .pre_init() succeeds but subsequent initialization
> fails,". Otherwise LGTM.

This is fixed in V3, thank you.

> I did some quick tests on an S4 Spider, covering the normal path and several
> injected failure paths. I don't have V4H hardware, though.
> Please feel free to pick up either or both tags if that helps.
> 
> Reviewed-by: Koichiro Den <den@valinux.co.jp>
> Tested-by: Koichiro Den <den@valinux.co.jp>

I am only following the code execution paths in the endpoint case .

My endpoint setup for V4H is still pending assembly, I finally have the 
oculink adapters and cable here, but I did not assemble it yet. I still 
need to find out how to handle clocking, whether one V4H PCIe controller 
(clock source) has to send the PCIe clock to the other V4H PCIe 
controller (clock sink) which would require board modification, or 
whether I can manage the oculink RC-to-EP setup without board modification.

Thank you for your help with testing on the S4 !

-- 
Best regards,
Marek Vasut
