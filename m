Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE2235F602;
	Wed, 23 Sep 2026 01:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127859; cv=none; b=E2Xj5WBfOSeSIg6aogMIx2KnIsBJpZhmdkh/HPyQr8GSW/A531ejK+mSaTOlAXv8ANuz3vruY8dIbWs9r0rjdlO1XX4fQhSJSWAuf46gSURN96pJxaiZx7XW07QAciNnjqEiPou15ff0FaIFv2oa/Ls0GIHspWrpM+kE5pOSc2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127859; c=relaxed/simple;
	bh=HaFkB2t7CsXolUIJTt5re5DlhuMWTNS24I2jnOPxOxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LP5XK31MFhLhrP9MPLlNLFiQ8N2X5rf1dy8b6EtZwsUrzGaPeTUmifEsIE3gG2nT6yYy3nSBhG9SpXtmEoNzGIXBhoSUvoJNtuWzciKDZHF5jF1t/+wuMym8jlkwV2VsJV3J5tgCBmADXG82INwty6jmf0jUfg9373mS1zAu/bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sURK5Brr; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sURK5Brr"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790127852; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HaFkB2t7CsXolUIJTt5re5DlhuMWTNS24I2jnOPxOxw=;
	b=sURK5BrrbcGD9mlILKRhE5XCESxptFzaOBLljuoGucC1DkrhgUpmr9obk9YYDPWLUgLaD7evAVvrXtnegF9Vw2cWO9z5mnD2GymG/ZqgQwsyBQfu2AWA1zYJluaM4gpAjYhGeMVPbvB28hIWnSt/j+J0bElQbU7ZjcZwKa67R5A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XBVFMGw_1790127850;
Received: from 30.178.83.70(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBVFMGw_1790127850 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Sep 2026 09:44:11 +0800
Message-ID: <97ec5743-b4be-47e3-865f-0e1121d1b607@linux.alibaba.com>
Date: Wed, 23 Sep 2026 09:44:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 3/4] PCI/ACPI: Centralize pcie_ports_native checking
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org, lukas@wunner.de,
 terry.bowman@amd.com, olof@lixom.net
References: <20260922204548.3884906-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260922204548.3884906-4-sathyanarayanan.kuppuswamy@linux.intel.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260922204548.3884906-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM.

Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>

Best Regards,
Guixin Liu
