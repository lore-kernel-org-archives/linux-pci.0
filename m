Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899D534FF40
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 19:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777490918; cv=none; b=Esy28eC3vLn1miIUXL+GfQ0Y2gNWYKIQa92GUB42c8maGInyg/iMns6FPUDg0S4Rc3tDQ752PcXY38SRGeumThluhkZwBd8FYI4tyzv4gVyrb52nIkn94tW10viibSPJ+iwKBtJpsYoIq6wu6O1+1DIM/PtZukoQ3oMQsRet7jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777490918; c=relaxed/simple;
	bh=eqzwpTs7dPy5Y0/8RD0ETiVPjc5zDq1ma63fLvsRBxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rxKPnQcMvmrr8tMhYcuBzlUKOO7BW2kBQyCN6+Hj1Hjtlpke0zK5jRhy1dsbIOKX490ZuR9aFAsiLg3egiN5ZW6IK6oskAvzlKgBy2tQhEOaiYjYeKqKuptuxuydURhj1Dloocz8YhaG8KhrUw001VewuT4EWy3GXusdEwmchKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=AAmWghp0; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AAmWghp0"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g5S5Y1Kzdz9vHf;
	Wed, 29 Apr 2026 21:28:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777490913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qov7Ba9GTXvMP2ykU1Rpza2EZYScZvMyMtvqzU8u0AA=;
	b=AAmWghp0tF8FJQX0p3AWRD3mhXyv1hgoc6x98ONXzLgJVLrNNHdy0muHr7LVSXLPyohfxb
	/mM3N35mdr6bfL4VTUQf0BkPysBrL3Ise86XnYlfmh7mDotU6/xcxCmOH7h8JnlN/3p1Gx
	i6aOkEPm9tZZf9rChSFAdSmoj0iR1zFJS80MHsqoBohJ/pwfQ7CJ6L7stWiqONqRBbIHCR
	28n2ew2V0mAHM8R7EMkguI8xrr9tgaSMJ6Rt3gYiohlgQu5Ikv7WOrCTfAe+mcsfo7XKWV
	mXhaCrnXNeaoQEET/x6IwKNhyYRPPTWDQKDIz2sWFGlRjB81nRxyXomK6eY2iA==
Message-ID: <cdfd074e-f91b-4de8-b3c1-11021d34a332@mailbox.org>
Date: Wed, 29 Apr 2026 21:28:30 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: rcar: Fix up MAINTAINERS entry
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Koichiro Den <den@valinux.co.jp>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20260429183023.GA305888@bhelgaas>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260429183023.GA305888@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ycywi5pgyectzz6b6pki1kbx4id3qruu
X-MBO-RS-ID: b434208afc370290433

On 4/29/26 8:30 PM, Bjorn Helgaas wrote:
> On Tue, Apr 28, 2026 at 07:19:54AM +0200, Marek Vasut wrote:
>> Use up to date address. No functional change.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Applied to pci/for-linus for v7.1, thanks!
> 
> I made the subject line "MAINTAINERS: Update Marek Vasut email for
> PCIe R-Car" to make it more specific.
Thank you. I've now sent matching change to linux-iio , with equally 
updated subject.
